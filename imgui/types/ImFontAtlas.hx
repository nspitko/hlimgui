package imgui.types;

import imgui.ImGui;
import hl.NativeArray;
import hl.Bytes;
import imgui.types.Pointers;

@:keep
@:build(imgui._ImGuiInternalMacro.buildFlatStruct())
@:struct class ImFontConfig {
	@:noCompletion var FontData: Bytes;                    // TTF/OTF data
	var FontDataSize: Int;                  // TTF/OTF data size
	var FontDataOwnedByAtlas: Bool;         // Force-set to false when adding from memory because GC.
	var FontNo: Int;                        // Index of font within TTF/OTF file
	var SizePixels: Single;                 // Size in pixels for rasterizer (more or less maps to the resulting font height).
	var OversampleH: Int;                   // Rasterize at higher quality for sub-pixel positioning. Note the difference between 2 and 3 is minimal so you can reduce this to 2 to save memory. Read https://github.com/nothings/stb/blob/master/tests/oversample/README.md for details.
	var OversampleV: Int;                   // Rasterize at higher quality for sub-pixel positioning. This is not really useful as we don't use sub-pixel positions on the Y axis.
	var PixelSnapH: Bool;                   // Align every glyph to pixel boundary. Useful e.g. if you are merging a non-pixel aligned font with the default font. If enabled, you can set OversampleH/V to 1.
	@:flatten var GlyphExtraSpacing: ImVec2S;// Extra spacing (in pixels) between glyphs. Only X axis is supported for now.
	@:flatten var GlyphOffset: ImVec2S;      // Offset all glyphs from this font input.
	@:noCompletion var GlyphRanges: Bytes;  // Pointer to a user-provided list of Unicode range (2 value per range, values are inclusive, zero-terminated list). THE ARRAY DATA NEEDS TO PERSIST AS LONG AS THE FONT IS ALIVE.
	var GlyphMinAdvanceX: Single;           // Minimum AdvanceX for glyphs, set Min to align font icons, set both Min/Max to enforce mono-space font
	var GlyphMaxAdvanceY: Single;           // Maximum AdvanceX for glyphs
	var MergeMode: Bool;                    // Merge into previous ImFont, so you can combine multiple inputs font into one ImFont (e.g. ASCII font + icons + Japanese glyphs). You may want to use GlyphOffset.y when merge font of different heights.
	var FontBuilderFlags: Int;              // Settings for custom font builder. THIS IS BUILDER IMPLEMENTATION DEPENDENT. Leave as zero if unsure.
	var RasterizerMultiply: Single;         // Brighten (>1.0f) or darken (<1.0f) font output. Brightening small fonts may be a good workaround to make them more readable.
	var EllipsisChar: hl.UI16;              // Explicitly specify unicode codepoint of ellipsis character. When fonts are being merged first specified ellipsis will be used.

	public function new() {
		init(this);
	}
	
	// Helper methods for some quick configs
	public inline function setOversample(h: Int = 3, v: Int = 1) {
		this.OversampleH = h;
		this.OversampleV = v;
		return this;
	}
	public inline function setPixelSnapH(v: Bool = true) {
		this.PixelSnapH = v;
		return this;
	}
	public inline function setMergeMode(v: Bool = true) {
		this.MergeMode = v;
		return this;
	}
	
	@:hlNative("hlimgui", "imfontconfig_init")
	static function init(cfg: ImFontConfig) {}

}
/** An output storage for ImFontAtlas.getTexDataAsX methods. **/
@:keep
class ImFontTexData {
	public var buffer: Bytes;
	public var width: Int;
	public var height: Int;
	public var bytesPerPixel: Int;
	
	public function new() {}
}

/**
	An output storage for ImFontAtlas.getMouseCursorTexData method.
	
	ImGui bundled cursor consist of cursor outline and fill, both are monochrome same color.
	
	In order to properly render the cursor, do the following:
	
	NOTE: This is how ImGui renders it, for some rerason `uvFill` and `uvBorder` are flipped!
	
	* Shadow color is black with 18.82% (0x30) alpha.
	* Border color is black.
	* Fill color is white.
	* Full size of the cursor is `size + [2,0]` to account for shadow.
	
	0. If you render on-screen, offset the drawing position by `-offset` to properly position the cursor pivot.
	1. Draw `uvFill` offset by [1,0] with shadow color
	2. Draw `uvFill` offset by [2,0] with shadow color
	3. Draw `uvFill` with border color
	4. Draw `uvBorder` with fill color
	
**/
@:keep
class ImCursorData {
	public var offset: ImVec2;
	public var size: ImVec2;
	public var uvBorder: ImVec4; // xy = min, zw = max
	public var uvFill: ImVec4; // xy = min, zw = max
	
	public function new() {
		offset = ImVec2.get();
		size = ImVec2.get();
		uvBorder = ImVec4.get();
		uvFill = ImVec4.get();
	}
}

@:keep
@:struct class ImFontAtlasCustomRect {
	
	public var width: hl.UI16;
	public var height: hl.UI16;
	public var x: hl.UI16;
	public var y: hl.UI16;
	public var glyphId: Int;
	public var glyphAdvanceX: Single;
	public var glyphOffsetX: Single; // ImVec2
	public var glyphOffsetY: Single; // ImVec2
	public var font: ImFont;
	
	public inline function isPacked(): Bool { return x != 0xffff; }
}

@:hlNative("hlimgui", "imfontatlas_")
abstract ImFontAtlas(ImFontAtlasPtr) from ImFontAtlasPtr to ImFontAtlasPtr
{
	inline function new(ptr: ImFontAtlasPtr) { this = ptr; }
	
	public function addFont(config: ImFontConfig): ImFont { return null; }
	public function addFontDefault(?config: ImFontConfig): ImFont { return null; }
	public function addFontFromFileTTF(filename: String, size_pixels: Single, ?font_cfg: ImFontConfig, ?glyph_ranges: hl.NativeArray<hl.UI16>): ImFont { return null; }
	public function addFontFromMemoryTTF(font_data: Bytes, font_size: Int, size_pixels: Single, ?font_cfg: ImFontConfig, ?glyph_ranges: hl.NativeArray<hl.UI16>): ImFont { return null; }
	
	public function clearInputData() {}
	public function clearTexData() {}
	public function clearFonts() {}
	public function clear() {}
	public function build(): Bool { return false; }
	
	public function getTexDataAsAlpha8(output: ImFontTexData) {}
	public function getTexDataAsRGBA32(output: ImFontTexData) {}
	public function isBuilt(): Bool { return false; }
	public function setTexId(id: ImTextureID) {}
	
	// GetGlyphRangesX
	
	public function addCustomRectRegular(width: Int, height: Int): Int { return 0; }
	public function addCustomRectFontGlyph(font: ImFontPtr, id: hl.UI16, width: Int, height: Int, advance_x: Single, offset: ImVec2 = null): Int { return 0; }
	public function getCustomRectByIndex(index: Int): ImFontAtlasCustomRect { return null; }
	
	public function calcCustomRectUV(rect: ImFontAtlasCustomRect, uv_min: ImVec2, uv_max: ImVec2) {}
	public function getMouseCursorTexData(cursor: ImGuiMouseCursor, output: ImCursorData): Bool { return false; }
	
}