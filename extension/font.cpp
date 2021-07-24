#define HL_NAME(n) hlimgui_##n

#include <hl.h>
#include "imgui/imgui.h"
#include "utils.h"


HL_PRIM ImFont *HL_NAME(imgui_add_font_from_file_ttf)(vstring* filename, float size)
{
    return ImGui::GetIO().Fonts->AddFontFromFileTTF( convertString( filename ), size );
}

HL_PRIM vdynamic *HL_NAME(get_tex_data_as_rgba32)(vstring* filename, float size)
{
	unsigned char* pixels;
	int width, height;
	ImGuiIO& io = ImGui::GetIO();

	io.Fonts->GetTexDataAsRGBA32(&pixels, &width, &height);

	IM_ASSERT( width != 0 && height != 0 && "Invalid texture generated, bad font?");

	vbyte* buffer = hl_copy_bytes(pixels, width*height*4);

	vdynamic* font_info = (vdynamic*)hl_alloc_dynobj();
	hl_dyn_setp(font_info, hl_hash_utf8("buffer"), &hlt_bytes, buffer);
	hl_dyn_seti(font_info, hl_hash_utf8("width"), &hlt_i32, width);
	hl_dyn_seti(font_info, hl_hash_utf8("height"), &hlt_i32, height);

	io.Fonts->ClearTexData();

	return font_info;
}

HL_PRIM void HL_NAME(imgui_push_font)(ImFont *font)
{
    ImGui::PushFont( font );
}

HL_PRIM void HL_NAME(pop_font)()
{
    ImGui::PopFont();
}

#define _TFONT _ABSTRACT(imfont)

DEFINE_PRIM(_TFONT, imgui_add_font_from_file_ttf, _STRING _F32);
DEFINE_PRIM(_DYN, get_tex_data_as_rgba32, _NO_ARG);
DEFINE_PRIM(_VOID, imgui_push_font, _TFONT);
DEFINE_PRIM(_VOID, pop_font, _NO_ARG );
