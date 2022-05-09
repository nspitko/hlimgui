package imgui;

import h2d.Tile;
import imgui.types.Renderer;
import imgui.types.ImFontAtlas;
#if heaps

import h3d.mat.Texture;
import imgui.ImGui;
import hxd.Key;

class ImGuiDrawableBuffers {

	public static final instance = new ImGuiDrawableBuffers();

	public var vertex_buffers(default, null) : Array<h3d.Buffer> = [];
	public var index_buffers(default, null) : Array<h3d.Indexes> = [];
	public var commands: Array<Dynamic> = []; // hl.NativeArray<RenderCommand> See https://github.com/HaxeFoundation/hashlink/issues/461
	public var bufferCount: Int;

	var noTexture: Texture;
	
	private var initialized : Bool;
	public var font_texture : Texture;
	#if hlimgui_cursor
	public var cursor_map: Map<ImGuiMouseCursor, hxd.Cursor> = [];
	#end

	public function initialize() {
		if (this.initialized) {
			return;
		}
		
		ImGui.provideTypes();
		ImGui.createContext();
		ImGui.setRenderCallback(renderDrawList);
		
		var fonts = ImGui.getFontAtlas();
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
			var indexCount = data.indexBufferSize>>1;
			if (vertexCount == 0) continue;
			
			// create or reuse vertex buffer
			if (i == this.vertex_buffers.length) {
				this.vertex_buffers[i] = new h3d.Buffer(vertexCount, vertexStride, [RawFormat, Dynamic]);
				this.index_buffers[i] = new h3d.Indexes(indexCount);
			} else {
				if (this.vertex_buffers[i].vertices < vertexCount) {
					this.vertex_buffers[i].dispose();
					this.vertex_buffers[i] = new h3d.Buffer(vertexCount, vertexStride, [RawFormat, Dynamic]);
				}
				if (this.index_buffers[i].count < indexCount) {
					this.index_buffers[i].dispose();
					this.index_buffers[i] = new h3d.Indexes(indexCount);
				}
			}
			this.vertex_buffers[i].uploadBytes(data.vertexBuffer.toBytes(data.vertexBufferSize), 0, vertexCount);
			this.index_buffers[i].uploadBytes(data.indexBuffer.toBytes(data.indexBufferSize), 0, indexCount);
			this.commands[i] = data.commands.sub(0, data.commandCount);
			bufferCount++;
		}
	}
	
	public function draw(ctx: h2d.RenderContext, obj: h2d.Drawable) {
		var e = ctx.engine;
		for (i in 0...bufferCount) {
			var cmdList: hl.NativeArray<RenderCommand> = commands[i];
			for (cmd in cmdList) {
				if (cmd.elemCount > 0 && ctx.beginDrawObject(obj, cmd.textureID == null ? noTexture : cmd.textureID)) {
					e.setRenderZone(cmd.clipLeft, cmd.clipTop, cmd.clipWidth, cmd.clipHeight);
					e.renderIndexed(vertex_buffers[i], index_buffers[i], Std.int(cmd.indexOffset / 3), Std.int(cmd.elemCount / 3));
				}
			}
		}
		e.setRenderZone();
	}
}

class ImGuiDrawable extends h2d.Drawable {

	var empty_tile : h2d.Tile;
	var mouse_down = [false, false];
	var mouse_x : Float;
	var mouse_y : Float;
	var mouse_delta : Float;
	var keycode_map : Map<Int,Int>;
	var wheel_inverted : Bool;
	#if hlimgui_cursor
	var cursorMap:Map<ImGuiMouseCursor, hxd.Cursor> = [];
	#end
	private var scene_size : {width: Int, height:Int};

	public function new(?parent) {
		super(parent);
		ImGuiDrawableBuffers.instance.initialize();

		var scene = getScene();
		ImGui.setDisplaySize(scene.width, scene.height);
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
			Key.LSHIFT => ImGuiKey.ModShift,
			Key.RSHIFT => ImGuiKey.ModShift,
			Key.LALT => ImGuiKey.ModAlt,
			Key.RALT => ImGuiKey.ModAlt,
			Key.LCTRL => ImGuiKey.ModCtrl,
			Key.RCTRL => ImGuiKey.ModCtrl,
		];

		// Add letters
		for( ko in 0...26)
			keycode_map[Key.A + ko] = ImGuiKey.A + ko;

		this.empty_tile = h2d.Tile.fromColor(0xFFFFFF);

		scene.addEventListener(onEvent);
		#if hlimgui_cursor
		hxd.System.setCursor = updateCursor;
		#end

		this.mouse_x = scene.mouseX;
		this.mouse_y = scene.mouseY;
		this.wheel_inverted = false;
	}

	public function dispose() {
		ImGuiDrawableBuffers.instance.dispose();
	}

	public function update(dt:Float) {
		ImGui.setEvents(dt, this.mouse_x, this.mouse_y, this.mouse_delta, mouse_down[0], mouse_down[1]);
		this.mouse_delta = 0;

		var scene = getScene();
		if (scene.width != this.scene_size.width || scene.height != this.scene_size.height) {
			ImGui.setDisplaySize(scene.width, scene.height);
			this.scene_size = {width: scene.width, height:scene.width};
		}
		#if hlimgui_cursor
		// Somewhat hacky solution to enforce a cursor: But that's what we can do.
		var cursor = ImGuiDrawableBuffers.instance.cursor_map[ImGui.getMouseCursor()];
		if (cursor != null) @:privateAccess scene.events.defaultCursor = cursor;
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

	private function onEvent(event: hxd.Event) {
		switch (event.kind) {
			case EMove:
				this.mouse_x = event.relX;
				this.mouse_y = event.relY;
			case EPush:
				if (event.button < 2) {
					this.mouse_down[event.button] = true;
					if (ImGui.wantCaptureMouse()) {
						event.propagate = false;
					}
				}
			case ERelease:
				if (event.button < 2) {
					this.mouse_down[event.button] = false;
					if (ImGui.wantCaptureMouse()) {
						event.propagate = false;
					}
				}
			case EWheel:
				this.mouse_delta = event.wheelDelta;
				if (!this.wheel_inverted) {
					this.mouse_delta = -this.mouse_delta;
					if (ImGui.wantCaptureMouse()) {
						event.propagate = false;
					}
				}
			case EKeyDown:
				if (this.keycode_map.exists(event.keyCode)) {
					ImGui.addKeyEvent(this.keycode_map[event.keyCode], true);
					if (ImGui.wantCaptureKeyboard()) {
						event.propagate = false;
					}
				}
			case EKeyUp:
				if (this.keycode_map.exists(event.keyCode)) {
					ImGui.addKeyEvent(this.keycode_map[event.keyCode], false);
					if (ImGui.wantCaptureKeyboard()) {
						event.propagate = false;
					}
				}
			case ETextInput:
				ImGui.addKeyChar(event.charCode);
				if (ImGui.wantCaptureKeyboard()) {
					event.propagate = false;
				}
			default:
		}
	}

	override function draw(ctx:h2d.RenderContext) {
		ImGuiDrawableBuffers.instance.draw(ctx, this);
	}
}

#end