#include "utils.h"

#define _TFONTATLAS _ABSTRACT(imfontatlas)
#define _TFONT _ABSTRACT(imfont)
#define F_NAME(n) HL_NAME(imfontatlas_##n)
#define DEFINE_FPRIM(t,name,args) DEFINE_PRIM(t,imfontatlas_##name,_TFONTATLAS args)

HL_PRIM ImFontAtlas* HL_NAME(get_font_atlas)()
{
	return ImGui::GetIO().Fonts;
}

HL_PRIM ImFont* F_NAME(add_font)(ImFontAtlas* fonts, ImFontConfig* font_cfg)
{
	return fonts->AddFont(font_cfg);
}

HL_PRIM ImFont* F_NAME(add_font_default)(ImFontAtlas* fonts, ImFontConfig* font_cfg)
{
	return fonts->AddFontDefault(font_cfg);
}

HL_PRIM ImFont* F_NAME(add_font_from_file_ttf)(ImFontAtlas* fonts, vstring* filename, float size_pixels, ImFontConfig* font_cfg, varray* glyph_ranges)
{
	return fonts->AddFontFromFileTTF(convertString(filename), size_pixels, font_cfg, convertArray(glyph_ranges, ImWchar));
}

HL_PRIM ImFont* F_NAME(add_font_from_memory_ttf)(ImFontAtlas* fonts, vbyte* font_data, int font_size, float size_pixels, ImFontConfig* font_cfg, varray* glyph_ranges)
{
	// Because font_data is allocated on GC, we want to ensure font builder won't free it.
	if (font_cfg == nullptr) {
		ImFontConfig cfg = ImFontConfig();
		cfg.FontDataOwnedByAtlas = false;
		return fonts->AddFontFromMemoryTTF(font_data, font_size, size_pixels, &cfg, convertArray(glyph_ranges, ImWchar));
	} else {
		font_cfg->FontDataOwnedByAtlas = false;
		return fonts->AddFontFromMemoryTTF(font_data, font_size, size_pixels, font_cfg, convertArray(glyph_ranges, ImWchar));
	}
}

// TODO: AddFontFromMemoryCompressedTTF
// TODO: AddFontFromMemoryCompressedBase85TTF

HL_PRIM void F_NAME(clear_input_data)(ImFontAtlas* fonts)
{
	fonts->ClearInputData();
}

HL_PRIM void F_NAME(clear_tex_data)(ImFontAtlas* fonts)
{
	fonts->ClearTexData();
}

HL_PRIM void F_NAME(clear_fonts)(ImFontAtlas* fonts)
{
	fonts->ClearFonts();
}

HL_PRIM void F_NAME(clear)(ImFontAtlas* fonts)
{
	fonts->Clear();
}

HL_PRIM bool F_NAME(build)(ImFontAtlas* fonts)
{
	return fonts->Build();
}

typedef struct {
	hl_type* t;
	vbyte* buffer;
	int width;
	int height;
	int bytesPerPixel;
} vtexdata;
#define _TEXDATA _OBJ(_BYTES _I32 _I32 _I32)

HL_PRIM void F_NAME(get_tex_data_as_alpha8)(ImFontAtlas* fonts, vtexdata* output)
{
	unsigned char* pixels;
	
	fonts->GetTexDataAsAlpha8(&pixels, &output->width, &output->height, &output->bytesPerPixel);
	output->buffer = hl_copy_bytes(pixels, output->width * output->height * output->bytesPerPixel);
}

HL_PRIM void F_NAME(get_tex_data_as_rgba32)(ImFontAtlas* fonts, vtexdata* output)
{
	unsigned char* pixels;
	
	fonts->GetTexDataAsRGBA32(&pixels, &output->width, &output->height, &output->bytesPerPixel);
	output->buffer = hl_copy_bytes(pixels, output->width * output->height * output->bytesPerPixel);
}

HL_PRIM bool F_NAME(is_built)(ImFontAtlas* fonts)
{
	return fonts->IsBuilt();
}

HL_PRIM void F_NAME(set_tex_id)(ImFontAtlas* fonts, ImTextureID id)
{
	fonts->SetTexID(id);
}

// TODO: GetGlyphRangesX();
// BLOCKED: hl.h doesn't expose hlt_i16 type to properly allocate the glyph range that would be compatible.
// varray* ranges_to_array(ImWchar* ranges)
// {
// 	int len = 0;
// 	ImWchar* ptr = ranges;
// 	while (ptr++) len++;
// 	varray* output = hl_alloc_array(hlt_i16, len);
// 	int* outPtr = hl_aptr(output, int);
// 	while (ranges) *(outPtr++) = (int)*(ranges++);
// 	return output;
// }

// HL_PRIM varray* F_NAME(get_glyph_ranges_default)(ImFontAtlas* fonts)
// {
// 	return ranges_to_array(fonts->GetGlyphRangesDefault);
// }

HL_PRIM int F_NAME(add_custom_rect_regular)(ImFontAtlas* fonts, int width, int height)
{
	return fonts->AddCustomRectRegular(width, height);
}

HL_PRIM int F_NAME(add_custom_rect_font_glyph)(ImFontAtlas* fonts, ImFont* font, ImWchar id, int width, int height, float advance_x, vimvec2* offset)
{
	return fonts->AddCustomRectFontGlyph(font, id, width, height, advance_x, offset != nullptr ? *offset->v() : ImVec2(0, 0));
}

HL_PRIM ImFontAtlasCustomRect* F_NAME(get_custom_rect_by_index)(ImFontAtlas* fonts, int index)
{
	return fonts->GetCustomRectByIndex(index);
}

HL_PRIM void F_NAME(calc_custom_rect_uv)(ImFontAtlas* fonts, ImFontAtlasCustomRect* rect, vimvec2* out_uv_min, vimvec2* out_uv_max)
{
	return fonts->CalcCustomRectUV(rect, out_uv_min->v(), out_uv_max->v());
}

typedef struct {
	hl_type* t;
	vimvec2* offset;
	vimvec2* size;
	vimvec4* uv_border; // xy = min, zw = max
	vimvec4* uv_fill; // xy = min, zw = max
} vcursordata;
#define _CURSORDATA _OBJ(_IMVEC2 _IMVEC2 _IMVEC4 _IMVEC4)

HL_PRIM bool F_NAME(get_mouse_cursor_tex_data)(ImFontAtlas* fonts, ImGuiMouseCursor cursor, vcursordata* output)
{
	return fonts->GetMouseCursorTexData(cursor, output->offset->v(), output->size->v(), output->uv_border->vmin(), output->uv_fill->vmin());
}

HL_PRIM void HL_NAME(push_font)(ImFont *font)
{
	ImGui::PushFont( font );
}

HL_PRIM void HL_NAME(pop_font)()
{
	ImGui::PopFont();
}

HL_PRIM ImFont* HL_NAME(get_font)()
{
	return ImGui::GetFont();
}

HL_PRIM void HL_NAME(imfontconfig_init)(ImFontConfig* cfg)
{
	new (cfg)ImFontConfig();
}

DEFINE_PRIM(_TFONTATLAS, get_font_atlas, _NO_ARG);
DEFINE_FPRIM(_TFONT, add_font, _STRUCT);
DEFINE_FPRIM(_TFONT, add_font_default, _STRUCT);
DEFINE_FPRIM(_TFONT, add_font_from_file_ttf, _STRING _F32 _STRUCT _ARR);
DEFINE_FPRIM(_TFONT, add_font_from_memory_ttf, _BYTES _I32 _F32 _STRUCT _ARR);
// DEFINE_FPRIM(_TFONT, add_font_from_memory_compressed_ttf, _BYTES _I32 _F32 _STRUCT _ARR);
// DEFINE_FPRIM(_TFONT, add_font_from_memory_compressed_base85_ttf, _BYTES _I32 _F32 _STRUCT _ARR);
DEFINE_FPRIM(_VOID, clear_input_data, _NO_ARG);
DEFINE_FPRIM(_VOID, clear_tex_data, _NO_ARG);
DEFINE_FPRIM(_VOID, clear_fonts, _NO_ARG);
DEFINE_FPRIM(_VOID, clear, _NO_ARG);
DEFINE_FPRIM(_BOOL, build, _NO_ARG);
DEFINE_FPRIM(_VOID, get_tex_data_as_alpha8, _TEXDATA);
DEFINE_FPRIM(_VOID, get_tex_data_as_rgba32, _TEXDATA);
DEFINE_FPRIM(_BOOL, is_built, _NO_ARG);
DEFINE_FPRIM(_VOID, set_tex_id, _IMTEXID);
// GetGlyphRangesX
DEFINE_FPRIM(_I32, add_custom_rect_regular, _I32 _I32);
DEFINE_FPRIM(_I32, add_custom_rect_font_glyph, _TFONT _I16 _I32 _I32 _F32 _IMVEC2);
DEFINE_FPRIM(_STRUCT, get_custom_rect_by_index, _I32);
DEFINE_FPRIM(_VOID, calc_custom_rect_uv, _STRUCT _IMVEC2 _IMVEC2);
DEFINE_FPRIM(_BOOL, get_mouse_cursor_tex_data, _I32 _CURSORDATA);

DEFINE_PRIM(_VOID, push_font, _TFONT);
DEFINE_PRIM(_VOID, pop_font, _NO_ARG );
DEFINE_PRIM(_TFONT, get_font, _NO_ARG);
DEFINE_PRIM(_VOID, imfontconfig_init, _STRUCT);