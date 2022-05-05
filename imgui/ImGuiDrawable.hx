package imgui;

import imgui.types.ImFontAtlas;
#if heaps

import h3d.mat.Texture;
import imgui.ImGui;
import hxd.Key;

class ImGuiDrawableBuffers {

	public static final instance = new ImGuiDrawableBuffers();

	public var vertex_buffers(default, null) : Array<h3d.Buffer> = [];
	public var index_buffers(default, null) : Array<{
		texture_id:ImTextureID,
		vertex_buffer_id:Int,
		clip_rect:{x:Int, y:Int, width:Int, height:Int},
		buffer:h3d.Indexes}> = [];

	private var initialized : Bool;
	public var font_texture : Texture;
	#if hlimgui_cursor
	public var cursor_map: Map<ImGuiMouseCursor, hxd.Cursor> = [];
	#end

	public function initialize() {
		if (this.initialized) {
			return;
		}
		
		ImGui.createContext();
		ImGui.setRenderCallback(renderDrawListsFromExternal);
		
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

		this.initialized = true;
	}

	public function dispose() {
		for (index_buffer in this.index_buffers) {
			index_buffer.buffer.dispose();
		}
		this.index_buffers = [];

		for (vertex_buffer in this.vertex_buffers) {
			vertex_buffer.dispose();
		}
		this.vertex_buffers = [];

		this.initialized = false;
	}

	private function new() {
		this.initialized = false;
	}

	private function renderDrawList(draw_list:{cmd_list:hl.NativeArray<Dynamic>}) {
		var vertex_buffer_index = 0;
		var index_buffer_index = 0;

		for (cmd_index in 0...draw_list.cmd_list.length) {
			var draw_item = draw_list.cmd_list[cmd_index];

			var ext_vertex_buffer:hl.Bytes = draw_item.vertex_buffer;
			var vertex_stride = 8;
			var nb_vertices = Std.int(draw_item.vertex_buffer_size/(vertex_stride*4));

			// create or reuse vertex buffer
			if (vertex_buffer_index >= this.vertex_buffers.length) {
				this.vertex_buffers[vertex_buffer_index] = new h3d.Buffer(nb_vertices, vertex_stride, [RawFormat, Dynamic]);
			} else if (this.vertex_buffers[vertex_buffer_index].vertices < nb_vertices) {
				this.vertex_buffers[vertex_buffer_index].dispose();
				this.vertex_buffers[vertex_buffer_index] = new h3d.Buffer(nb_vertices, vertex_stride, [RawFormat, Dynamic]);
			}

			// update vertex buffer data
			this.vertex_buffers[vertex_buffer_index].uploadBytes(ext_vertex_buffer.toBytes(draw_item.vertex_buffer_size), 0, nb_vertices);

			var draw_objects:hl.NativeArray<Dynamic> = draw_item.draw_objects;

			// read cmd buffers
			for (draw_object_index in 0...draw_objects.length) {
				var draw_object = draw_objects[draw_object_index];

				var ext_index_buffer:hl.Bytes = draw_object.index_buffer;
				var nb_indices = Std.int(draw_object.index_buffer_size/2);

				// Some plugins generate empty buffers. Skip these.
				if( nb_indices == 0 )
					continue;

				var clip_rect = {
					x: draw_object.clip_left,
					y: draw_object.clip_top,
					width: draw_object.clip_width,
					height: draw_object.clip_height
				}

				// create or reuse index buffer
				if (index_buffer_index >= this.index_buffers.length) {
					this.index_buffers[index_buffer_index] = {
						buffer: new h3d.Indexes(nb_indices),
						vertex_buffer_id: vertex_buffer_index,
						clip_rect: clip_rect,
						texture_id: draw_object.texture_id};
				} else if (this.index_buffers[index_buffer_index].buffer.count != nb_indices) {
					this.index_buffers[index_buffer_index].buffer.dispose();
					this.index_buffers[index_buffer_index] = {
						buffer: new h3d.Indexes(nb_indices),
						vertex_buffer_id: vertex_buffer_index,
						clip_rect: clip_rect,
						texture_id: draw_object.texture_id
					};
				} else {
					var index_buffer = this.index_buffers[index_buffer_index];
					index_buffer.vertex_buffer_id = vertex_buffer_index;
					index_buffer.texture_id = draw_object.texture_id;
					index_buffer.clip_rect = clip_rect;
				}

				// update index buffer data

				this.index_buffers[index_buffer_index].buffer.uploadBytes(ext_index_buffer.toBytes(draw_object.index_buffer_size), 0, nb_indices);

				index_buffer_index++;
 			}

			vertex_buffer_index++;
		}

		// remove unused buffers
		if (index_buffer_index < this.index_buffers.length) {
			for (i in index_buffer_index...this.index_buffers.length) {
				this.index_buffers[i].buffer.dispose();
			}
			this.index_buffers.resize(index_buffer_index);
		}
		if (vertex_buffer_index < this.vertex_buffers.length) {
			for (i in vertex_buffer_index...this.vertex_buffers.length) {
				this.vertex_buffers[i].dispose();
			}
			this.vertex_buffers.resize(vertex_buffer_index);
		}
	}

    private static function renderDrawListsFromExternal(draw_list:{cmd_list:hl.NativeArray<Dynamic>}) {
		instance.renderDrawList(draw_list);
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
		var vertex_buffers = ImGuiDrawableBuffers.instance.vertex_buffers;
		var index_buffers = ImGuiDrawableBuffers.instance.index_buffers;

		for (i in 0...index_buffers.length) {
			var index_buffer = index_buffers[i];
			if (ctx.beginDrawObject(this,  index_buffer.texture_id == null ? this.empty_tile.getTexture() : index_buffer.texture_id)) {
				var clip_rect = index_buffer.clip_rect;
				ctx.engine.setRenderZone(clip_rect.x, clip_rect.y, clip_rect.width, clip_rect.height);
				ctx.engine.renderIndexed(vertex_buffers[index_buffer.vertex_buffer_id], index_buffer.buffer);
			}
		}

		ctx.engine.setRenderZone();
	}
}

#end