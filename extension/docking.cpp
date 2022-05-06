#include "utils.h"
#include "lib/imgui/imgui_internal.h"

HL_PRIM void HL_NAME(dock_space)( ImGuiID id, vimvec2* size, ImGuiDockNodeFlags* flags )
{
	ImGui::DockSpace(id, getImVec2(size), convertPtr(flags, 0));
}

HL_PRIM void HL_NAME(set_next_window_dock_id)( ImGuiID id, ImGuiCond* cond )
{
	ImGui::SetNextWindowDockID(id, convertPtr(cond, 0));
}

HL_PRIM ImGuiID HL_NAME(get_window_dock_id)()
{
	return ImGui::GetWindowDockID();
}

HL_PRIM bool HL_NAME(is_window_docked)()
{
	return ImGui::IsWindowDocked();
}

// Dockbuilder functions (currently only defined in imgui_internal.h; API is not stable)
HL_PRIM void HL_NAME(dock_builder_dock_window)( vstring* window_name, ImGuiID node_id )
{
	ImGui::DockBuilderDockWindow(convertString(window_name), node_id );
}

HL_PRIM ImGuiDockNode *HL_NAME(dock_builder_get_node)( ImGuiID node_id )
{
	return ImGui::DockBuilderGetNode( node_id );
}

HL_PRIM ImGuiDockNode *HL_NAME(dock_builder_get_central_node)( ImGuiID node_id )
{
	return ImGui::DockBuilderGetCentralNode( node_id );
}

HL_PRIM ImGuiID HL_NAME(dock_builder_add_node)( ImGuiID node_id, ImGuiDockNodeFlags flags )
{
	return ImGui::DockBuilderAddNode(node_id, flags );
}

HL_PRIM void HL_NAME(dock_builder_remove_node)( ImGuiID node_id )
{
	ImGui::DockBuilderRemoveNode(node_id );
}

HL_PRIM void HL_NAME(dock_builder_remove_node_docked_windows)( ImGuiID node_id, bool clear_settings_refs )
{
	ImGui::DockBuilderRemoveNodeDockedWindows(node_id );
}

HL_PRIM void HL_NAME(dock_builder_remove_node_child_nodes)( ImGuiID node_id )
{
	ImGui::DockBuilderRemoveNodeChildNodes(node_id );
}

HL_PRIM void HL_NAME(dock_builder_set_node_pos)( ImGuiID node_id, vimvec2* pos )
{
	ImGui::DockBuilderSetNodePos(node_id, pos);
}

HL_PRIM void HL_NAME(dock_builder_set_node_size)( ImGuiID node_id, vimvec2* size )
{
	ImGui::DockBuilderSetNodeSize(node_id, size);
}

HL_PRIM ImGuiID HL_NAME(dock_builder_split_node)( ImGuiID node_id, ImGuiDir split_dir, float size_ratio_for_node_at_dir, ImGuiID* out_id_at_dir, ImGuiID* out_id_at_opposite_dir )
{
	return ImGui::DockBuilderSplitNode(node_id, split_dir, size_ratio_for_node_at_dir, out_id_at_dir, out_id_at_opposite_dir );
}

/* @todo; need to work out conversion for ImVector of const char* from varray*... seems low pri?
HL_PRIM void  HL_NAME(dock_builder_copy_dock_space)(ImGuiID src_dockspace_id, ImGuiID dst_dockspace_id )
{
	ImGui::DockBuilderCopyDockSpace(src_dockspace_id, dst_dockspace_id );
}

HL_PRIM void  HL_NAME(dock_builder_copy_node)(ImGuiID src_node_id, ImGuiID dst_node_id )
{
	ImGui::DockBuilderCopyNode(src_node_id, dst_node_id );
}
*/

HL_PRIM void  HL_NAME(dock_builder_copy_window_settings)( vstring* src_name, vstring* dst_name )
{
	ImGui::DockBuilderCopyWindowSettings(convertString( src_name ), convertString( dst_name ) );
}

HL_PRIM void  HL_NAME(dock_builder_finish)( ImGuiID node_id )
{
	ImGui::DockBuilderFinish( node_id );
}

#define _TDOCKNODE _ABSTRACT(imguidocknode)

DEFINE_PRIM(_VOID, dock_space, _I32 _IMVEC2 _REF(_I32));
DEFINE_PRIM(_VOID, set_next_window_dock_id, _I32 _REF(_I32));
DEFINE_PRIM(_I32, get_window_dock_id, _NO_ARG );
DEFINE_PRIM(_BOOL, is_window_docked, _NO_ARG );
//
DEFINE_PRIM(_VOID, dock_builder_dock_window, _STRING _I32 );
DEFINE_PRIM(_TDOCKNODE, dock_builder_get_node, _I32 );
DEFINE_PRIM(_TDOCKNODE, dock_builder_get_central_node, _I32 );
DEFINE_PRIM(_I32, dock_builder_add_node, _I32 _I32 );
DEFINE_PRIM(_VOID, dock_builder_remove_node, _I32 );
DEFINE_PRIM(_VOID, dock_builder_remove_node_docked_windows, _I32 _BOOL );
DEFINE_PRIM(_VOID, dock_builder_remove_node_child_nodes, _I32 );
DEFINE_PRIM(_VOID, dock_builder_set_node_pos, _I32 _IMVEC2 );
DEFINE_PRIM(_VOID, dock_builder_set_node_size, _I32 _IMVEC2 );
DEFINE_PRIM(_I32, dock_builder_split_node, _I32 _I32 _F32 _REF(_I32) _REF(_I32) );
//DEFINE_PRIM(_VOID, dock_builder_copy_dock_space, _I32 _I32 );
//DEFINE_PRIM(_VOID, dock_builder_copy_node, _I32 _I32 );
DEFINE_PRIM(_VOID, dock_builder_copy_window_settings, _STRING _STRING );
DEFINE_PRIM(_VOID, dock_builder_finish, _I32 );