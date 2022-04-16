#include "utils.h"

HL_PRIM ImGuiStyle* HL_NAME(get_style)()
{
	return &ImGui::GetStyle();
}

HL_PRIM void HL_NAME(set_style)(ImGuiStyle* hl_style)
{
	if (hl_style != nullptr)
	{
		ImGui::GetStyle() = *hl_style;
	}
}

HL_PRIM void HL_NAME(init_style)(ImGuiStyle* hl_style)
{
	if (hl_style != nullptr) new (hl_style)ImGuiStyle();
}

HL_PRIM void HL_NAME(style_scale_all_sizes)(ImGuiStyle* hl_style, float scaleFactor )
{
	hl_style->ScaleAllSizes( scaleFactor );
}

HL_PRIM void HL_NAME(style_colors_dark)(ImGuiStyle* hl_style)
{
	ImGui::StyleColorsDark(hl_style);
}

HL_PRIM void HL_NAME(style_colors_classic)(ImGuiStyle* hl_style)
{
	ImGui::StyleColorsClassic(hl_style);
}

HL_PRIM void HL_NAME(style_colors_light)(ImGuiStyle* hl_style)
{
	ImGui::StyleColorsLight(hl_style);
}

DEFINE_PRIM(_STRUCT, get_style, _NO_ARG);
DEFINE_PRIM(_VOID, set_style, _STRUCT);
DEFINE_PRIM(_VOID, init_style, _STRUCT);
DEFINE_PRIM(_VOID, style_scale_all_sizes, _STRUCT _F32);
DEFINE_PRIM(_VOID, style_colors_dark, _STRUCT);
DEFINE_PRIM(_VOID, style_colors_classic, _STRUCT);
DEFINE_PRIM(_VOID, style_colors_light, _STRUCT);
