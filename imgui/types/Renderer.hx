package imgui.types;

import imgui.ImGui;
import hl.Bytes;

@:keep
class RenderList {
	
	public var lists: hl.NativeArray<RenderData>;
	public var size: Int;
	
	function new() {
		lists = new hl.NativeArray(0);
	}
}

@:keep
class RenderData {
	public var vertexBuffer: Bytes;
	public var vertexBufferSize: Int;
	public var indexBuffer: Bytes;
	public var indexBufferSize: Int;
	public var commands: hl.NativeArray<RenderCommand>;
	public var commandCount: Int;
	
	function new() {}
}

@:keep
class RenderCommand {
	public var textureID: ImTextureID;
	public var indexOffset: Int;
	public var elemCount: Int;
	
	public var clipLeft: Int;
	public var clipTop: Int;
	public var clipWidth: Int;
	public var clipHeight: Int;
	
	/** If present - instead of regular draw call invoke the callback. **/
	public var callback: RenderCommandCallback;
	public var callbackData: Dynamic;
	
	function new() {}
}

#if heaps
class RenderCommandCallbackData {
	public var ctx: h2d.RenderContext;
	public var obj: h2d.Drawable;
	
	function new() {}
}
#else
typedef RenderCommandCallbackData = Dynamic;
#end
// TODO: Make RenderData == ImDrawList
// parentList: RenderData, command: RenderCommand, data: RenderCommandCallbackData
// Avoid recursion by using Dynamic
typedef RenderCommandCallback = (parentList: Dynamic, command: Dynamic, data: Dynamic)->Void;