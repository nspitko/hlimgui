#define HL_NAME(n) hlimgui_##n

#include <hl.h>
#include "imgui/imgui.h"
#include "utils.h"

HL_PRIM void HL_NAME(dock_space)(int id, vdynamic* size, ImGuiDockNodeFlags* flags)
{
	ImGui::DockSpace(ImGuiID(id), getImVec2(size), convertPtr(flags, 0));
}

HL_PRIM void HL_NAME(set_next_window_dock_id)(int id, ImGuiCond* cond)
{
	ImGui::SetNextWindowDockID(ImGuiID(id), convertPtr(cond, 0));
}

HL_PRIM ImGuiID HL_NAME(get_window_dock_id)()
{
	return ImGui::GetWindowDockID();
}

HL_PRIM bool HL_NAME(is_window_docked)()
{
	return ImGui::IsWindowDocked();
}

DEFINE_PRIM(_VOID, dock_space, _I32 _DYN _REF(_I32));
DEFINE_PRIM(_VOID, set_next_window_dock_id, _I32 _REF(_I32));
DEFINE_PRIM(_I32, get_window_dock_id, _NO_ARG );
DEFINE_PRIM(_BOOL, is_window_docked, _NO_ARG );