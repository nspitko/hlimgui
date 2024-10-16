package imgui;

import imgui.types.Renderer;
import imgui.types.ImFontAtlas;
#if heaps

import h2d.Tile;
import h3d.mat.Texture;
import imgui.ImGui;
import hxd.Key;

class ImGuiDrawableBuffers {

	public static final instance = new ImGuiDrawableBuffers();

	public var vertex_buffers(default, null) : Array<h3d.Buffer> = [];
	public var index_buffers(default, null) : Array<h3d.Indexes> = [];
	public var commands: Array<RenderData> = []; // hl.NativeArray<RenderCommand> See https://github.com/HaxeFoundation/hashlink/issues/461
	public var bufferCount: Int;

	var noTexture: Texture;

	var commandData: RenderCommandCallbackData = @:privateAccess new RenderCommandCallbackData();

	private var initialized : Bool;
	public var font_texture : Texture;
	#if hlimgui_cursor
	public var cursor_map: Map<ImGuiMouseCursor, hxd.Cursor> = [];
	#end

	public function initialize( addDefaultFont: Bool = true) {
		if (this.initialized) {
			return;
		}

		ImGui.provideTypes();
		ImGui.createContext();
		ImGui.setRenderCallback(renderDrawList);

		var io = ImGui.getIO();
		var fonts = io.Fonts;

		if( addDefaultFont )
		{
			var font_info = new ImFontTexData();
			fonts.addFontDefault();
			fonts.getTexDataAsRGBA32(font_info);
			fonts.clearTexData();

			// create font texture
			var texture_size = font_info.width * font_info.height * 4;
			var font_pixels = new hxd.Pixels(font_info.width,
				font_info.height,
				font_info.buffer.toBytes(texture_size),
				hxd.PixelFormat.RGBA
			);
			font_texture = Texture.fromPixels(font_pixels);
			fonts.setTexId(font_texture);
		}

		#if hlimgui_cursor
		var cur = new ImCursorData();
		for (i in 0...ImGuiMouseCursor.COUNT) {
			if (fonts.getMouseCursorTexData(i, cur)) {
				var width = Std.int(cur.size.x);
				var height = Std.int(cur.size.y);
				var fillX = Std.int(cur.uvFill.x * font_pixels.width);
				var fillY = Std.int(cur.uvFill.y * font_pixels.height);
				var borderX = Std.int(cur.uvBorder.x * font_pixels.width);
				var borderY = Std.int(cur.uvBorder.y * font_pixels.height);
				var cursorBitmap = new hxd.BitmapData(width+2, height);
				for (y in 0...height) for (x in 0...width) {
					// 4. Draw `uvBorder` with fill color
					if ((font_pixels.getPixel(x + borderX, y + borderY) & 0xff000000) != 0) {
						cursorBitmap.setPixel(x, y, 0xffffffff);
					} else if ((font_pixels.getPixel(x + fillX, y + fillY) & 0xff000000) != 0) {
						// 3. Draw `uvFill` with border color
						cursorBitmap.setPixel(x,y, 0xff000000);
						// 1. Draw `uvFill` offset by [1,0] with shadow color
						if (cursorBitmap.getPixel(x + 1, y) == 0x30000000)
							cursorBitmap.setPixel(x + 1, y, 0x57000000); // In case previous pixel was casting shadow - do rough shadow blending.
						else
							cursorBitmap.setPixel(x + 1, y, 0x30000000);
						// 2. Draw `uvFill` offset by [2,0] with shadow color
						cursorBitmap.setPixel(x + 2, y, 0x30000000);
					}
				}
				cursor_map[i] = hxd.Cursor.Custom(new hxd.Cursor.CustomCursor([cursorBitmap], 0, Std.int(cur.offset.x), Std.int(cur.offset.y)));
			}
		}
		#end

		noTexture = Tile.fromColor(0xffffff).getTexture();
		this.initialized = true;
	}

	public function dispose() {
		for (index_buffer in this.index_buffers) {
			index_buffer.dispose();
		}
		this.index_buffers = [];

		for (vertex_buffer in this.vertex_buffers) {
			vertex_buffer.dispose();
		}
		this.vertex_buffers = [];
		this.commands = [];

		this.initialized = false;
	}

	private function new() {
		this.initialized = false;
	}

	private function renderDrawList(renderList: RenderList) {
		bufferCount = 0;

		for (i in 0...renderList.size) {
			var data = renderList.lists[i];

			final vertexStride = 8;
			var vertexCount = Std.int(data.vertexBufferSize / (vertexStride * 4)); // data.vertexBufferSize>>5;
			var indexCount = data.indexBufferSize>>2;
			// if (vertexCount == 0) continue;

			// create or reuse vertex buffer
			if (i == this.vertex_buffers.length) {
				#if hlimgui_heaps_old_buffer_alloc
				this.vertex_buffers[i] = new h3d.Buffer(vertexCount, vertexStride, [RawFormat, Dynamic]);
				#else
				this.vertex_buffers[i] = new h3d.Buffer(vertexCount, hxd.BufferFormat.H2D, [Dynamic]);
				#end
				this.index_buffers[i] = new h3d.Indexes(indexCount, true);
			} else {
				if (this.vertex_buffers[i].vertices < vertexCount) {
					this.vertex_buffers[i].dispose();
					#if hlimgui_heaps_old_buffer_alloc
					this.vertex_buffers[i] = new h3d.Buffer(vertexCount, vertexStride, [RawFormat, Dynamic]);
					#else
					this.vertex_buffers[i] = new h3d.Buffer(vertexCount, hxd.BufferFormat.H2D, [Dynamic]);
					#end
				}
				if (this.index_buffers[i].count < indexCount) {
					this.index_buffers[i].dispose();
					this.index_buffers[i] = new h3d.Indexes(indexCount, true);
				}
			}
			this.vertex_buffers[i].uploadBytes(data.vertexBuffer.toBytes(data.vertexBufferSize), 0, vertexCount);
			this.index_buffers[i].uploadBytes(data.indexBuffer.toBytes(data.indexBufferSize), 0, indexCount);
			this.commands[i] = data;//data.commands.sub(0, data.commandCount);
			bufferCount++;
		}
	}

	public function draw(ctx: h2d.RenderContext, obj: h2d.Drawable) {
		var e = ctx.engine;
		commandData.ctx = ctx;
		commandData.obj = obj;
		for (i in 0...bufferCount) {
			var data = commands[i];
			var cmdList = data.commands;
			for (j in 0...data.commandCount) {
				var cmd = cmdList[j];
				if (cmd.callback != null) {
					e.setRenderZone(); // Makre sure to reset clip rect.
					cmd.callback(data, cmd, commandData);
				} else if (cmd.elemCount > 0 && ctx.beginDrawObject(obj, cmd.textureID == null ? noTexture : cmd.textureID)) {
					e.setRenderZone(cmd.clipLeft, cmd.clipTop, cmd.clipWidth, cmd.clipHeight);
					e.renderIndexed(vertex_buffers[i], index_buffers[i], Std.int(cmd.indexOffset / 3), Std.int(cmd.elemCount / 3));
				}
			}
		}

		e.setRenderZone();
	}

	/**
		A helper method to set the `smooth` flag to `true` and render subsequent contents using bilinear filtering.

		Usage:
		```haxe
		imDrawList.addCallback(ImGuiDrawableBuffers.setSmoothCommand);
		```
	**/
	public static function setSmoothCommand(data: RenderData, command: RenderCommand, data: RenderCommandCallbackData) {
		data.obj.smooth = true;
	}

	/**
		A helper method to reset the `smooth` flag to use the default smooth value.

		Usage:
		```haxe
		imDrawList.addCallback(ImGuiDrawableBuffers.setSmoothCommand);
		```
	**/
	public static function resetSmoothCommand(data: RenderData, command: RenderCommand, data: RenderCommandCallbackData) {
		data.obj.smooth = null;
	}

	/**
		A helper method to reset the `smooth` flag to `false` and render subsequent contents using nearest neighbor filtering.

		Usage:
		```haxe
		imDrawList.addCallback(ImGuiDrawableBuffers.setSmoothCommand);
		```
	**/
	public static function setNearestCommand(data: RenderData, command: RenderCommand, data: RenderCommandCallbackData) {
		data.obj.smooth = false;
	}
}

class ImGuiDrawable extends h2d.Drawable {
	var keycode_map : Map<Int,Int>;
	var wheel_inverted : Bool;
	#if hlimgui_cursor
	var cursorMap:Map<ImGuiMouseCursor, hxd.Cursor> = [];
	#end
	private var scene_size : {width: Int, height:Int};

	public function new(?parent, ?addDefaultFont = true) {
		super(parent);
		ImGuiDrawableBuffers.instance.initialize( addDefaultFont );

		var scene = getScene();
		var io = ImGui.getIO();
		io.DisplaySize.x = scene.width;
		io.DisplaySize.y = scene.height;
		this.scene_size = {width: scene.width, height:scene.height};

		this.keycode_map = [
			Key.TAB => ImGuiKey.Tab,
			Key.LEFT => ImGuiKey.LeftArrow,
			Key.RIGHT => ImGuiKey.RightArrow,
			Key.UP => ImGuiKey.UpArrow,
			Key.DOWN => ImGuiKey.DownArrow,
			Key.PGUP => ImGuiKey.PageUp,
			Key.PGDOWN => ImGuiKey.PageDown,
			Key.HOME => ImGuiKey.Home,
			Key.END => ImGuiKey.End,
			Key.INSERT => ImGuiKey.Insert,
			Key.DELETE => ImGuiKey.Delete,
			Key.BACKSPACE => ImGuiKey.Backspace,
			Key.SPACE => ImGuiKey.Space,
			Key.ENTER => ImGuiKey.Enter,
			Key.ESCAPE => ImGuiKey.Escape,
			Key.NUMPAD_ENTER => ImGuiKey.KeyPadEnter,
			Key.LSHIFT => ImGuiKey.LeftShift,
			Key.RSHIFT => ImGuiKey.RightShift,
			Key.LALT => ImGuiKey.LeftAlt,
			Key.RALT => ImGuiKey.RightAlt,
			Key.LCTRL => ImGuiKey.LeftCtrl,
			Key.RCTRL => ImGuiKey.RightCtrl,
		];

		// Add letters
		for( ko in 0...26)
			keycode_map[Key.A + ko] = ImGuiKey.A + ko;

		#if !multidriver
		scene.addEventListener(onEvent);
		#end

		#if hlimgui_cursor
		hxd.System.setCursor = updateCursor;
		#end

		this.wheel_inverted = false;
	}

	public function dispose() {
		ImGuiDrawableBuffers.instance.dispose();
	}

	public function update(dt:Float) {
		var io = ImGui.getIO();

		io.DeltaTime = dt;

		var scene = getScene();
		if (scene.width != this.scene_size.width || scene.height != this.scene_size.height) {
			io.DisplaySize.x = scene.width;
			io.DisplaySize.y = scene.height;

			this.scene_size = {width: scene.width, height:scene.width};
		}
		#if hlimgui_cursor
		// Somewhat hacky solution to enforce a cursor: But that's what we can do.
		var cursor = ImGuiDrawableBuffers.instance.cursor_map[ImGui.getMouseCursor()];
		if (cursor != null) @:privateAccess scene.events.defaultCursor = cursor;
		#end

		// Update modifier states
		#if !multidriver
		io.addKeyEvent( ImGuiKey.ModShift, Key.isDown( Key.SHIFT ) );
		io.addKeyEvent( ImGuiKey.ModAlt, Key.isDown( Key.ALT ) );
		io.addKeyEvent( ImGuiKey.ModCtrl, Key.isDown( Key.CTRL ) );
		//ImGui.addKeyEvent( ImGuiKey.ModSuper, Key.isDown( Key.SUPER ) ); // Unsupported currently.
		#end


		#if ( multidriver && hlsdl && globalmouse )
		var x=0;
		var y=0;
		sdl.Sdl.getGlobalMouseState(x, y);
		io.addMousePosEvent( x, y );
		#end

	}

	#if hlimgui_cursor
	function updateCursor(cursor:hxd.Cursor) {
		switch (ImGui.getMouseCursor()) {
			case None: hxd.System.setNativeCursor(Hide);
			case Arrow: hxd.System.setNativeCursor(cursor);
			case TextInput: hxd.System.setNativeCursor(TextInput);
			case ResizeAll: hxd.System.setNativeCursor(Move);
			case Hand: hxd.System.setNativeCursor(Button);
			// case ResizeNS:
			// case ResizeEW:
			// case ResizeNESW:
			// case ResizeNWSE:
			// case NotAllowed:
			case expected:
				var cur = ImGuiDrawableBuffers.instance.cursor_map[expected];
				if (cur != null) cursor = cur;
				hxd.System.setNativeCursor(cursor);
		}
	}
	#end

	#if multidriver
	// When in multidriver mode, mouse cooridnates operate in absoluate space instead of relative.
	// Adjust the event accordingly
	public function onMultiWindowEvent( window: hxd.Window, originalEvent: hxd.Event, viewport: ImGuiViewport )
	{
		var event = new hxd.Event( originalEvent.kind, originalEvent.relX, originalEvent.relY );
		event.button = originalEvent.button;
		event.wheelDelta = originalEvent.wheelDelta;
		event.keyCode = originalEvent.keyCode;
		event.charCode = originalEvent.charCode;

		@:privateAccess
		{
			var x = 0;
			var y = 0;
			sdl.Window.winGetPosition( window.window.win, x, y );
			event.relX += x;
			event.relY += y;
		}
		onEvent( event );

		if( viewport != null )
		{
			switch( event.kind )
			{
				case EMove:
					var io = ImGui.getIO();
					if ( ( io.BackendFlags & ImGuiBackendFlags.HasMouseHoveredViewport ) != 0 )
						io.addMouseViewportEvent( viewport.ID );
				default:
			}
		}
	}
	#end

	private function onEvent(event: hxd.Event) {
		var io = ImGui.getIO();
		switch (event.kind) {
			#if !( multidriver && hlsdl && globalmouse )
			case EMove:
				io.addMousePosEvent( event.relX, event.relY );
			#end

			case EPush:
				io.addMouseButtonEvent(event.button, true);

				if (io.WantCaptureMouse) {
					event.propagate = false;
				}
			case ERelease:
				io.addMouseButtonEvent(event.button, false);

				if (io.WantCaptureMouse) {
					event.propagate = false;
				}

			case EWheel:
				io.addMouseWheelEvent( 0, this.wheel_inverted ? event.wheelDelta : -event.wheelDelta );

				if (io.WantCaptureMouse) {
					event.propagate = false;
				}

			case EKeyDown:
				if (this.keycode_map.exists(event.keyCode)) {
					io.addKeyEvent(this.keycode_map[event.keyCode], true);
					if (io.WantCaptureKeyboard) {
						event.propagate = false;
					}

					// In multidriver, we don't use heaps' input system so we need to manage key mods ourself
					#if multidriver
					updateModifiers(event.keyCode, true);
					#end
				}
			case EKeyUp:
				if (this.keycode_map.exists(event.keyCode)) {
					io.addKeyEvent(this.keycode_map[event.keyCode], false);
					if (io.WantCaptureKeyboard) {
						event.propagate = false;
					}

					#if multidriver
					updateModifiers(event.keyCode, false);
					#end
				}
			case ETextInput:
				io.addInputCharacter(event.charCode);
				if (io.WantCaptureKeyboard) {
					event.propagate = false;
				}
			#if multidriver
			// It looks goofy to hide these behind multidriver, but the normal model listens for heaps
			// stack events, not window events. Focus events mean something completely different in
			// that context. That said, I don't know if it actually does anything.
			case EFocus:
				io.addFocusEvent( true );
			case EFocusLost:
				io.addFocusEvent( false );
			#end
			default:
		}
	}

	function updateModifiers( code: Int, down: Bool )
	{
		var io = ImGui.getIO();
		switch( code )
		{
			case Key.LCTRL | Key.RCTRL:
				io.addKeyEvent( ImGuiKey.ModCtrl, down );
			case Key.LALT | Key.RALT:
				io.addKeyEvent( ImGuiKey.ModAlt, down );
			case Key.LSHIFT | Key.RSHIFT:
				io.addKeyEvent( ImGuiKey.ModShift, down );
		}

	}

	override function draw(ctx:h2d.RenderContext) {
		ImGuiDrawableBuffers.instance.draw(ctx, this);
	}
}

#end