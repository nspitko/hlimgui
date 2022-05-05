package imgui.types;

import imgui.types.Pointers;

@:hlNative("hlimgui")
abstract ImFont(ImFontPtr) from ImFontPtr to ImFontPtr
{
	public inline function new(ptr: ImFontPtr) { this = ptr; }
	
	// TODO: Expose API
}
