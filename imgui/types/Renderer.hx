package imgui.types;

import imgui.ImGui;
import hl.Bytes;

class RenderList {
	
	public var lists: hl.NativeArray<RenderData>;
	public var size: Int;
	
	function new() {
		lists = new hl.NativeArray(0);
	}
}

class RenderData {
	public var vertexBuffer: Bytes;
	public var vertexBufferSize: Int;
	public var indexBuffer: Bytes;
	public var indexBufferSize: Int;
	public var commands: hl.NativeArray<RenderCommand>;
	public var commandCount: Int;
	
	function new() {}
}

class RenderCommand {
	public var textureID: ImTextureID;
	public var indexOffset: Int;
	public var elemCount: Int;
	
	public var clipLeft: Int;
	public var clipTop: Int;
	public var clipWidth: Int;
	public var clipHeight: Int;
	
	function new() {}
}