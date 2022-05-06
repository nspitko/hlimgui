#include "utils.h"

HL_PRIM bool HL_NAME(is_window_appearing)()
{
	return ImGui::IsWindowAppearing();
}

HL_PRIM bool HL_NAME(is_window_collapsed)()
{
	return ImGui::IsWindowCollapsed();
}

HL_PRIM bool HL_NAME(is_window_focused)(ImGuiFocusedFlags* flags)
{
	return ImGui::IsWindowFocused(convertPtr(flags, 0));
}

HL_PRIM bool HL_NAME(is_window_hovered)(ImGuiFocusedFlags* flags)
{
	return ImGui::IsWindowHovered(convertPtr(flags, 0));
}

HL_PRIM float HL_NAME(get_window_dpi_scale)() {
	return ImGui::GetWindowDpiScale();
}

HL_PRIM vimvec2* HL_NAME(get_window_pos)()
{
	return ImGui::GetWindowPos();
}

HL_PRIM vimvec2* HL_NAME(get_window_size)()
{
	return ImGui::GetWindowSize();
}

HL_PRIM float HL_NAME(get_window_width)()
{
	return ImGui::GetWindowWidth();
}

HL_PRIM float HL_NAME(get_window_height)()
{
	return ImGui::GetWindowHeight();
}

HL_PRIM void HL_NAME(set_next_window_pos)(vimvec2* pos, ImGuiCond* cond, vimvec2* pivot)
{
	ImGui::SetNextWindowPos(pos, convertPtr(cond, 0), getImVec2(pivot));
}

HL_PRIM void HL_NAME(set_next_window_size)(vimvec2* size, ImGuiCond* cond)
{
	ImGui::SetNextWindowSize(size, convertPtr(cond, 0));
}

HL_PRIM void HL_NAME(set_next_window_size_constraints)(vimvec2* size_min, vimvec2* size_max)
{
	ImGui::SetNextWindowSizeConstraints(size_min, size_max);
}

HL_PRIM void HL_NAME(set_next_window_content_size)(vimvec2* size)
{
	ImGui::SetNextWindowContentSize(size);
}

HL_PRIM void HL_NAME(set_next_window_collapsed)(bool collapsed, ImGuiCond* cond)
{
	ImGui::SetNextWindowCollapsed(collapsed, convertPtr(cond, 0));
}

HL_PRIM void HL_NAME(set_next_window_focus)()
{
	ImGui::SetNextWindowFocus();
}

HL_PRIM void HL_NAME(set_next_window_bg_alpha)(float alpha)
{
	ImGui::SetNextWindowBgAlpha(alpha);
}

HL_PRIM void HL_NAME(set_window_pos)(vimvec2* pos, ImGuiCond* cond)
{
	ImGui::SetWindowPos(pos, convertPtr(cond, 0));
}

HL_PRIM void HL_NAME(set_window_size)(vimvec2* size, ImGuiCond* cond)
{
	ImGui::SetWindowSize(size, convertPtr(cond, 0));
}

HL_PRIM void HL_NAME(set_window_collapsed)(bool collapsed, ImGuiCond* cond)
{
	ImGui::SetWindowCollapsed(collapsed, convertPtr(cond, 0));
}

HL_PRIM void HL_NAME(set_window_focus)()
{
	ImGui::SetWindowFocus();
}

HL_PRIM void HL_NAME(set_window_font_scale)(float scale)
{
	ImGui::SetWindowFontScale(scale);
}

HL_PRIM void HL_NAME(set_window_pos2)(vstring* name, vimvec2* pos, ImGuiCond* cond)
{
	ImGui::SetWindowPos(convertString(name), pos, convertPtr(cond, 0));
}

HL_PRIM void HL_NAME(set_window_size2)(vstring* name, vimvec2* size, ImGuiCond* cond)
{
	ImGui::SetWindowSize(convertString(name), size, convertPtr(cond, 0));
}

HL_PRIM void HL_NAME(set_window_collapsed2)(vstring* name, bool collapsed, ImGuiCond* cond)
{
	ImGui::SetWindowCollapsed(convertString(name), collapsed, convertPtr(cond, 0));
}

HL_PRIM void HL_NAME(set_window_focus2)(vstring* name)
{
	ImGui::SetWindowFocus(convertString(name));
}

DEFINE_PRIM(_BOOL, is_window_appearing, _NO_ARG);
DEFINE_PRIM(_BOOL, is_window_collapsed, _NO_ARG);
DEFINE_PRIM(_BOOL, is_window_focused, _REF(_I32));
DEFINE_PRIM(_BOOL, is_window_hovered, _REF(_I32));
DEFINE_PRIM(_F32, get_window_dpi_scale, _NO_ARG);
DEFINE_PRIM(_IMVEC2, get_window_pos, _NO_ARG);
DEFINE_PRIM(_IMVEC2, get_window_size, _NO_ARG);
DEFINE_PRIM(_F32, get_window_width, _NO_ARG);
DEFINE_PRIM(_F32, get_window_height, _NO_ARG);
DEFINE_PRIM(_VOID, set_next_window_pos, _IMVEC2 _REF(_I32) _IMVEC2);
DEFINE_PRIM(_VOID, set_next_window_size, _IMVEC2 _REF(_I32));
DEFINE_PRIM(_VOID, set_next_window_size_constraints, _IMVEC2 _IMVEC2);
DEFINE_PRIM(_VOID, set_next_window_content_size, _IMVEC2);
DEFINE_PRIM(_VOID, set_next_window_collapsed, _BOOL _REF(_I32));
DEFINE_PRIM(_VOID, set_next_window_focus, _NO_ARG);
DEFINE_PRIM(_VOID, set_next_window_bg_alpha, _F32);
DEFINE_PRIM(_VOID, set_window_pos, _IMVEC2 _REF(_I32));
DEFINE_PRIM(_VOID, set_window_size, _IMVEC2 _REF(_I32));
DEFINE_PRIM(_VOID, set_window_collapsed, _BOOL _REF(_I32));
DEFINE_PRIM(_VOID, set_window_focus, _NO_ARG);
DEFINE_PRIM(_VOID, set_window_font_scale, _F32);
DEFINE_PRIM(_VOID, set_window_pos2, _STRING _IMVEC2 _REF(_I32));
DEFINE_PRIM(_VOID, set_window_size2, _STRING _IMVEC2 _REF(_I32));
DEFINE_PRIM(_VOID, set_window_collapsed2, _STRING _BOOL _REF(_I32));
DEFINE_PRIM(_VOID, set_window_focus2, _STRING);

