#include "utils.h"

HL_PRIM void HL_NAME(separator)()
{
	ImGui::Separator();
}

HL_PRIM void HL_NAME(same_line)(float* offset_from_start_x, float* spacing)
{
	ImGui::SameLine(offset_from_start_x != nullptr ? *offset_from_start_x : 0.0f, spacing != nullptr ? *spacing : -1.0f);
}

HL_PRIM void HL_NAME(new_line)()
{
	ImGui::NewLine();
}

HL_PRIM void HL_NAME(spacing)()
{
	ImGui::Spacing();
}

HL_PRIM void HL_NAME(dummy)(vimvec2* size)
{
	ImGui::Dummy(size);
}

HL_PRIM void HL_NAME(indent)(float* indent_w)
{
	ImGui::Indent(indent_w != nullptr ? *indent_w : 0.0f);
}

HL_PRIM void HL_NAME(unindent)(float* indent_w)
{
	ImGui::Unindent(indent_w != nullptr ? *indent_w : 0.0f);
}

HL_PRIM void HL_NAME(begin_group)()
{
	ImGui::BeginGroup();
}

HL_PRIM void HL_NAME(end_group)()
{
	ImGui::EndGroup();
}

HL_PRIM vimvec2* HL_NAME(get_cursor_pos)()
{
	return ImGui::GetCursorPos();
}

HL_PRIM float HL_NAME(get_cursor_pos_x)()
{
	return ImGui::GetCursorPosX();
}

HL_PRIM float HL_NAME(get_cursor_pos_y)()
{
	return ImGui::GetCursorPosY();
}

HL_PRIM void HL_NAME(set_cursor_pos)(vimvec2* local_pos)
{
	ImGui::SetCursorPos(local_pos);
}

HL_PRIM void HL_NAME(set_cursor_pos_x)(float local_x)
{
	ImGui::SetCursorPosX(local_x);
}

HL_PRIM void HL_NAME(set_cursor_pos_y)(float local_y)
{
	ImGui::SetCursorPosY(local_y);
}

HL_PRIM vimvec2* HL_NAME(get_cursor_start_pos)()
{
	return ImGui::GetCursorStartPos();
}

HL_PRIM vimvec2* HL_NAME(get_cursor_screen_pos)()
{
	return ImGui::GetCursorScreenPos();
}

HL_PRIM void HL_NAME(set_cursor_screen_pos)(vimvec2* pos)
{
	ImGui::SetCursorScreenPos(pos);
}

HL_PRIM void HL_NAME(align_text_to_frame_padding)()
{
	ImGui::AlignTextToFramePadding();
}

HL_PRIM float HL_NAME(get_text_line_height)()
{
	return ImGui::GetTextLineHeight();
}

HL_PRIM float HL_NAME(get_text_line_height_with_spacing)()
{
	return ImGui::GetTextLineHeightWithSpacing();
}

HL_PRIM float HL_NAME(get_frame_height)()
{
	return ImGui::GetFrameHeight();
}

HL_PRIM float HL_NAME(get_frame_height_with_spacing)()
{
	return ImGui::GetFrameHeightWithSpacing();
}

DEFINE_PRIM(_VOID, separator, _NO_ARG);
DEFINE_PRIM(_VOID, same_line, _REF(_F32) _REF(_F32));
DEFINE_PRIM(_VOID, new_line, _NO_ARG);
DEFINE_PRIM(_VOID, spacing, _NO_ARG);
DEFINE_PRIM(_VOID, dummy, _IMVEC2);
DEFINE_PRIM(_VOID, indent, _REF(_F32));
DEFINE_PRIM(_VOID, unindent, _REF(_F32));
DEFINE_PRIM(_VOID, begin_group, _NO_ARG);
DEFINE_PRIM(_VOID, end_group, _NO_ARG);
DEFINE_PRIM(_IMVEC2, get_cursor_pos, _NO_ARG);
DEFINE_PRIM(_F32, get_cursor_pos_x, _NO_ARG);
DEFINE_PRIM(_F32, get_cursor_pos_y, _NO_ARG);
DEFINE_PRIM(_VOID, set_cursor_pos, _IMVEC2);
DEFINE_PRIM(_VOID, set_cursor_pos_x, _F32);
DEFINE_PRIM(_VOID, set_cursor_pos_y, _F32);
DEFINE_PRIM(_IMVEC2, get_cursor_start_pos, _NO_ARG);
DEFINE_PRIM(_IMVEC2, get_cursor_screen_pos, _NO_ARG);
DEFINE_PRIM(_VOID, set_cursor_screen_pos, _IMVEC2);
DEFINE_PRIM(_VOID, align_text_to_frame_padding, _NO_ARG);
DEFINE_PRIM(_F32, get_text_line_height, _NO_ARG);
DEFINE_PRIM(_F32, get_text_line_height_with_spacing, _NO_ARG);
DEFINE_PRIM(_F32, get_frame_height, _NO_ARG);
DEFINE_PRIM(_F32, get_frame_height_with_spacing, _NO_ARG);
