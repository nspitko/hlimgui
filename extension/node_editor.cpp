#define HL_NAME(n) hlimgui_##n

#include <hl.h>
#include "utils.h"
#include "lib/imgui-node-editor/imgui_node_editor.h"

namespace NodeEditor = ax::NodeEditor;

//------------------------------------------------------------------------------
// Pointer management
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Editor Context management
//------------------------------------------------------------------------------
HL_PRIM void HL_NAME(set_current_editor)(NodeEditor::EditorContext* ctx)
{
	NodeEditor::SetCurrentEditor( ctx );
}

HL_PRIM NodeEditor::EditorContext* HL_NAME(get_current_editor)()
{
	return NodeEditor::GetCurrentEditor();
}

HL_PRIM NodeEditor::EditorContext* HL_NAME(create_editor)()
{
	return NodeEditor::CreateEditor();
}

HL_PRIM void HL_NAME(destroy_editor)(NodeEditor::EditorContext* ctx)
{
	NodeEditor::DestroyEditor( ctx );
}

//------------------------------------------------------------------------------
// Style
//------------------------------------------------------------------------------
HL_PRIM NodeEditor::Style* HL_NAME(ne_get_style)()
{
	return &NodeEditor::GetStyle();
}

HL_PRIM vbyte* HL_NAME(ne_get_style_color_name)( NodeEditor::StyleColor colorIndex )
{
	return getVByteFromCStr( NodeEditor::GetStyleColorName(colorIndex) );
}

HL_PRIM void HL_NAME(ne_push_style_var)(NodeEditor::StyleVar varIndex, float value )
{
	NodeEditor::PushStyleVar( varIndex, value );
}

HL_PRIM void HL_NAME(ne_push_style_var2)(NodeEditor::StyleVar varIndex, vdynamic* val)
{
	NodeEditor::PushStyleVar(varIndex, getImVec2(val));
}

HL_PRIM void HL_NAME(ne_push_style_var3)(NodeEditor::StyleVar varIndex, vdynamic* val)
{
	NodeEditor::PushStyleVar(varIndex, getImVec4(val));
}

HL_PRIM void HL_NAME(ne_pop_style_var)( int* count )
{
	NodeEditor::PopStyleVar( convertPtr(count, 1) );
}

//------------------------------------------------------------------------------
// Creation
//------------------------------------------------------------------------------

HL_PRIM void HL_NAME(ne_begin)( vstring* id, vdynamic *size )
{
	NodeEditor::Begin( convertString(id), getImVec2(size) );
}

HL_PRIM void HL_NAME(ne_end)()
{
	NodeEditor::End();
}

//------------------------------------------------------------------------------

HL_PRIM void HL_NAME(begin_node)( int id )
{
	NodeEditor::BeginNode( id );
}

HL_PRIM void HL_NAME(end_node)()
{
	NodeEditor::EndNode();
}

//------------------------------------------------------------------------------

HL_PRIM void HL_NAME(begin_pin)( int id, NodeEditor::PinKind kind )
{
	NodeEditor::BeginPin( id, kind );
}

HL_PRIM void HL_NAME(end_pin)()
{
	NodeEditor::EndPin();
}

HL_PRIM void HL_NAME(pin_rect)( vdynamic *a, vdynamic *b)
{
	NodeEditor::PinRect( getImVec2(a), getImVec2(b) );
}

HL_PRIM void HL_NAME(pin_pivot_rect)( vdynamic *a, vdynamic *b)
{
	NodeEditor::PinPivotRect( getImVec2(a), getImVec2(b) );
}

HL_PRIM void HL_NAME(pin_pivot_size)( vdynamic *size)
{
	NodeEditor::PinPivotSize( getImVec2(size) );
}

HL_PRIM void HL_NAME(pin_pivot_scale)( vdynamic *scale)
{
	NodeEditor::PinPivotScale( getImVec2(scale) );
}

HL_PRIM void HL_NAME(pin_pivot_alignment)( vdynamic *alignment)
{
	NodeEditor::PinPivotAlignment( getImVec2(alignment) );
}

//------------------------------------------------------------------------------

HL_PRIM void HL_NAME(group)( vdynamic *size )
{
	NodeEditor::Group( getImVec2(size) );
}

HL_PRIM bool HL_NAME(begin_group_hint)( NodeEditor::NodeId nodeId )
{
	return NodeEditor::BeginGroupHint( nodeId );
}

HL_PRIM vdynamic *HL_NAME(get_group_min)( )
{
	return getHLFromImVec2( NodeEditor::GetGroupMin() );
}

HL_PRIM vdynamic *HL_NAME(get_group_max)( )
{
	return getHLFromImVec2( NodeEditor::GetGroupMax() );
}

HL_PRIM ImDrawList *HL_NAME(get_hint_foreground_draw_list)( )
{
	return NodeEditor::GetHintForegroundDrawList( );
}

HL_PRIM ImDrawList *HL_NAME(get_hint_background_draw_list)( )
{
	return NodeEditor::GetHintBackgroundDrawList( );
}

HL_PRIM void HL_NAME(end_group_hint)(  )
{
	NodeEditor::EndGroupHint( );
}

//------------------------------------------------------------------------------

HL_PRIM ImDrawList *HL_NAME(get_node_background_draw_list)( NodeEditor::NodeId nodeId )
{
	return NodeEditor::GetNodeBackgroundDrawList( nodeId );
}

HL_PRIM bool HL_NAME(link)( NodeEditor::LinkId linkId, NodeEditor::PinId startPinId, NodeEditor::PinId endPinId, vdynamic *color, float *thickness )
{
	return NodeEditor::Link( linkId, startPinId, endPinId, getImVec4( color, ImVec4(1,1,1,1 ) ), convertPtr( thickness, 1.0F ) );
}

HL_PRIM void HL_NAME(flow)( NodeEditor::LinkId linkId, NodeEditor::FlowDirection *direction )
{
	NodeEditor::Flow( linkId, convertPtr( direction, NodeEditor::FlowDirection::Forward ) );
}

//------------------------------------------------------------------------------

HL_PRIM bool HL_NAME(begin_create)( vdynamic *color, float *thickness )
{
	return NodeEditor::BeginCreate( getImVec4( color, ImVec4(1,1,1,1 ) ), convertPtr( thickness, 1.0F ) );
}

//HL_PRIM bool HL_NAME(query_new_link)( int *startPinId, int *endPinId )
HL_PRIM bool HL_NAME(query_new_link)( NodeEditor::PinId *startPinId, NodeEditor::PinId *endPinId )
{
	return NodeEditor::QueryNewLink( startPinId, endPinId );
}

HL_PRIM bool HL_NAME(query_new_link2)(  NodeEditor::PinId *startPinId, NodeEditor::PinId *endPinId, vdynamic *color, float *thickness )
{
	return NodeEditor::QueryNewLink( startPinId, endPinId, getImVec4( color, ImVec4(1,1,1,1 ) ), convertPtr( thickness, 1.0F )  );
}

HL_PRIM bool HL_NAME(query_new_node)( NodeEditor::PinId *pinId )
{
	return NodeEditor::QueryNewNode( pinId );
}

HL_PRIM bool HL_NAME(query_new_node2)( NodeEditor::PinId *pinId, vdynamic *color, float *thickness )
{
	return NodeEditor::QueryNewNode( pinId, getImVec4( color, ImVec4(1,1,1,1 ) ), convertPtr( thickness, 1.0F ) );
}

HL_PRIM bool HL_NAME(accept_new_item)( )
{
	return NodeEditor::AcceptNewItem( );
}

HL_PRIM bool HL_NAME(accept_new_item2)(vdynamic *color, float *thickness )
{
	return NodeEditor::AcceptNewItem(getImVec4( color, ImVec4(1,1,1,1 ) ), convertPtr( thickness, 1.0F ) );
}

HL_PRIM void HL_NAME(reject_new_item)( )
{
	NodeEditor::RejectNewItem( );
}

HL_PRIM void HL_NAME(reject_new_item2)(vdynamic *color, float *thickness )
{
	NodeEditor::RejectNewItem(getImVec4( color, ImVec4(1,1,1,1 ) ), convertPtr( thickness, 1.0F ) );
}

HL_PRIM void HL_NAME(end_create)()
{
	NodeEditor::EndCreate();
}

//------------------------------------------------------------------------------

HL_PRIM bool HL_NAME(begin_delete)()
{
	return NodeEditor::BeginDelete();
}

HL_PRIM bool HL_NAME(query_deleted_link)( NodeEditor::LinkId *linkId, NodeEditor::PinId *startId, NodeEditor::PinId *endId )
{
	return NodeEditor::QueryDeletedLink( linkId, startId, endId );
}

HL_PRIM bool HL_NAME(query_deleted_node)( NodeEditor::NodeId *nodeId )
{
	return NodeEditor::QueryDeletedNode( nodeId );
}

HL_PRIM bool HL_NAME(accept_deleted_item)( bool *delete_dependencies )
{
	return NodeEditor::AcceptDeletedItem( convertPtr( delete_dependencies, true ) );
}

HL_PRIM void HL_NAME(reject_deleted_item)( )
{
	NodeEditor::RejectDeletedItem();
}

HL_PRIM void HL_NAME(end_delete)( )
{
	NodeEditor::EndDelete();
}

//------------------------------------------------------------------------------

HL_PRIM void HL_NAME(set_node_position)( NodeEditor::NodeId nodeId, vdynamic *editorPosition )
{
	NodeEditor::SetNodePosition( nodeId, getImVec2( editorPosition ) );
}

HL_PRIM void HL_NAME(set_group_size)( NodeEditor::NodeId nodeId, vdynamic *size )
{
	NodeEditor::SetGroupSize( nodeId, getImVec2( size ) );
}

HL_PRIM vdynamic *HL_NAME(get_node_position)( NodeEditor::NodeId nodeId )
{
	return getHLFromImVec2( NodeEditor::GetNodePosition( nodeId ) );
}

HL_PRIM vdynamic *HL_NAME(get_node_size)( NodeEditor::NodeId nodeId )
{
	return getHLFromImVec2( NodeEditor::GetNodeSize( nodeId ) );
}

HL_PRIM void HL_NAME(center_node_on_screen)( NodeEditor::NodeId nodeId )
{
	NodeEditor::CenterNodeOnScreen( nodeId );
}

HL_PRIM void HL_NAME(set_node_zposition)( NodeEditor::NodeId nodeId, float z )
{
	NodeEditor::SetNodeZPosition( nodeId, z );
}

HL_PRIM float HL_NAME(get_node_zposition)( NodeEditor::NodeId nodeId )
{
	return NodeEditor::GetNodeZPosition( nodeId );
}

//------------------------------------------------------------------------------

HL_PRIM void HL_NAME(restore_node_state)( NodeEditor::NodeId nodeId )
{
	NodeEditor::RestoreNodeState( nodeId );
}


HL_PRIM void HL_NAME(suspend)( )
{
	NodeEditor::Suspend();
}

HL_PRIM void HL_NAME(resume)( )
{
	NodeEditor::Resume();
}

HL_PRIM bool HL_NAME(is_suspended)( )
{
	return NodeEditor::IsSuspended();
}

HL_PRIM bool HL_NAME(is_active)( )
{
	return NodeEditor::IsActive();
}

//------------------------------------------------------------------------------

HL_PRIM bool HL_NAME(has_selection_changed)()
{
	return NodeEditor::HasSelectionChanged();
}

HL_PRIM int HL_NAME(get_selected_object_count)()
{
	return NodeEditor::GetSelectedObjectCount();
}

HL_PRIM varray *HL_NAME(get_selected_nodes)()
{
	// This looks stupid because it is. My hands are tied.
	int allocSize = NodeEditor::GetSelectedObjectCount();
	NodeEditor::NodeId *selectedNodes = new NodeEditor::NodeId[allocSize];

	int actualSize = NodeEditor::GetSelectedNodes( selectedNodes, allocSize );

	varray* hlArray = hl_alloc_array( &hlt_i32, actualSize );
	NodeEditor::NodeId *hlPtr = hl_aptr(hlArray, NodeEditor::NodeId);

	memcpy( hlPtr, selectedNodes, actualSize * sizeof( NodeEditor::NodeId ) );

	delete selectedNodes;

	return hlArray;
}

HL_PRIM varray *HL_NAME(get_selected_links)()
{
	// This looks stupid because it is. My hands are tied.
	int allocSize = NodeEditor::GetSelectedObjectCount();
	NodeEditor::LinkId *selectedLinks = new NodeEditor::LinkId[allocSize];

	int actualSize = NodeEditor::GetSelectedLinks( selectedLinks, allocSize );

	varray* hlArray = hl_alloc_array( &hlt_i32, actualSize );
	NodeEditor::LinkId *hlPtr = hl_aptr(hlArray, NodeEditor::LinkId);

	memcpy( hlPtr, selectedLinks, actualSize * sizeof( NodeEditor::LinkId ) );

	delete selectedLinks;

	return hlArray;
}


HL_PRIM bool HL_NAME(is_node_selected)( NodeEditor::NodeId nodeId )
{
	return NodeEditor::IsNodeSelected( nodeId );
}

HL_PRIM bool HL_NAME(is_link_selected)( NodeEditor::LinkId linkId )
{
	return NodeEditor::IsLinkSelected( linkId );
}

HL_PRIM void HL_NAME(clear_selection)()
{
	NodeEditor::ClearSelection();
}

HL_PRIM void HL_NAME(select_node)( NodeEditor::NodeId nodeId, bool *append)
{
	NodeEditor::SelectNode( nodeId, convertPtr(append, false ) );
}

HL_PRIM void HL_NAME(select_link)( NodeEditor::LinkId linkId, bool *append)
{
	NodeEditor::SelectLink( linkId, convertPtr(append, false ) );
}

HL_PRIM void HL_NAME(deselect_node)( NodeEditor::NodeId nodeId)
{
	NodeEditor::DeselectNode( nodeId );
}

HL_PRIM void HL_NAME(deselect_link)( NodeEditor::LinkId linkId)
{
	NodeEditor::DeselectLink( linkId );
}

//------------------------------------------------------------------------------


HL_PRIM bool HL_NAME(delete_node)( NodeEditor::NodeId nodeId )
{
	return NodeEditor::DeleteNode( nodeId );
}

HL_PRIM bool HL_NAME(delete_link)( NodeEditor::LinkId linkId )
{
	return NodeEditor::DeleteLink( linkId );
}

//------------------------------------------------------------------------------

HL_PRIM bool HL_NAME(has_any_links)( NodeEditor::NodeId nodeId )
{
	return NodeEditor::HasAnyLinks( nodeId );
}

HL_PRIM bool HL_NAME(has_any_links2)( NodeEditor::PinId pinId )
{
	return NodeEditor::HasAnyLinks( pinId );
}

HL_PRIM int HL_NAME(break_links)( NodeEditor::NodeId nodeId )
{
	return NodeEditor::BreakLinks( nodeId );
}

HL_PRIM int HL_NAME(break_links2)( NodeEditor::PinId pinId )
{
	return NodeEditor::BreakLinks( pinId );
}

//------------------------------------------------------------------------------

HL_PRIM void HL_NAME(navigate_to_content)( float *duration )
{
	NodeEditor::NavigateToContent( convertPtr( duration, -1 ) );
}

HL_PRIM void HL_NAME(navigate_to_selection)( bool *zoomIn, float *duration )
{
	NodeEditor::NavigateToSelection( convertPtr( zoomIn, false ), convertPtr( duration, -1 ) );
}

//------------------------------------------------------------------------------

HL_PRIM bool HL_NAME(show_node_context_menu)( NodeEditor::NodeId *nodeId  )
{
	return NodeEditor::ShowNodeContextMenu( nodeId );
}

HL_PRIM bool HL_NAME(show_pin_context_menu)( NodeEditor::PinId *pinId  )
{
	return NodeEditor::ShowPinContextMenu( pinId );
}

HL_PRIM bool HL_NAME(show_link_context_menu)( NodeEditor::LinkId *linkId  )
{
	return NodeEditor::ShowLinkContextMenu( linkId );
}

HL_PRIM bool HL_NAME(show_background_context_menu)( )
{
	return NodeEditor::ShowBackgroundContextMenu( );
}

//------------------------------------------------------------------------------

HL_PRIM void HL_NAME(enable_shortcuts)( bool enable )
{
	return NodeEditor::EnableShortcuts( enable );
}

HL_PRIM bool HL_NAME(are_shortcuts_enabled)( )
{
	return NodeEditor::AreShortcutsEnabled( );
}

//------------------------------------------------------------------------------

// @todo shortcuts

//------------------------------------------------------------------------------

HL_PRIM int HL_NAME(get_hovered_node)()
{
	return (int)NodeEditor::GetHoveredNode().Get();
}

HL_PRIM int HL_NAME(get_hovered_pin)()
{
	return (int)NodeEditor::GetHoveredPin().Get();
}

HL_PRIM int HL_NAME(get_hovered_link)()
{
	return (int)NodeEditor::GetHoveredLink().Get();
}

//

HL_PRIM int HL_NAME(get_double_clicked_node)()
{
	return (int)NodeEditor::GetDoubleClickedNode().Get();
}

HL_PRIM int HL_NAME(get_double_clicked_pin)()
{
	return (int)NodeEditor::GetDoubleClickedPin().Get();
}

HL_PRIM int HL_NAME(get_double_clicked_link)()
{
	return (int)NodeEditor::GetDoubleClickedLink().Get();
}

HL_PRIM bool HL_NAME(is_background_clicked)()
{
	return NodeEditor::IsBackgroundClicked();
}

HL_PRIM bool HL_NAME(is_background_double_clicked)()
{
	return NodeEditor::IsBackgroundDoubleClicked();
}

//------------------------------------------------------------------------------

HL_PRIM bool HL_NAME(get_link_pins)( NodeEditor::LinkId linkId, NodeEditor::PinId *startPinId, NodeEditor::PinId *endPinId )
{
	return NodeEditor::GetLinkPins( linkId, startPinId, endPinId );
}

HL_PRIM bool HL_NAME(pin_had_any_links)( NodeEditor::PinId pinId )
{
	return NodeEditor::PinHadAnyLinks( pinId );
}

//------------------------------------------------------------------------------


HL_PRIM float HL_NAME(get_current_zoom)(  )
{
	return NodeEditor::GetCurrentZoom();
}

HL_PRIM vdynamic *HL_NAME(get_screen_size)(  )
{
	return getHLFromImVec2( NodeEditor::GetScreenSize() );
}

HL_PRIM vdynamic *HL_NAME(screen_to_canvas)( vdynamic *pos )
{
	return getHLFromImVec2( NodeEditor::ScreenToCanvas( getImVec2( pos ) ) );
}

HL_PRIM vdynamic *HL_NAME(canvas_to_screen)( vdynamic *pos )
{
	return getHLFromImVec2( NodeEditor::CanvasToScreen( getImVec2( pos ) ) );
}

//------------------------------------------------------------------------------

HL_PRIM int HL_NAME(get_node_count)( )
{
	return NodeEditor::GetNodeCount();
}

//------------------------------------------------------------------------------


// Types
#define _TNODECTX _ABSTRACT(imnecontext)
#define _TNODESTYLE _ABSTRACT(imnenodestyle)
#define _TNODEID _ABSTRACT(imnenodeid)

#define _TDRAWLIST _ABSTRACT(imdrawlist)

DEFINE_PRIM(_VOID, set_current_editor, _TNODECTX);
DEFINE_PRIM(_TNODECTX, get_current_editor, _NO_ARG );
DEFINE_PRIM(_TNODECTX, create_editor, _NO_ARG );
DEFINE_PRIM(_VOID, destroy_editor, _TNODECTX );
//
// @todo style
//
DEFINE_PRIM(_VOID, ne_begin, _STRING _DYN);
DEFINE_PRIM(_VOID, ne_end, _NO_ARG);
DEFINE_PRIM(_VOID, begin_node, _I32);
DEFINE_PRIM(_VOID, end_node, _NO_ARG);
DEFINE_PRIM(_VOID, begin_pin, _I32 _I32);
DEFINE_PRIM(_VOID, end_pin, _NO_ARG);
DEFINE_PRIM(_VOID, pin_rect, _DYN _DYN);
DEFINE_PRIM(_VOID, pin_pivot_rect, _DYN _DYN);
DEFINE_PRIM(_VOID, pin_pivot_size, _DYN);
DEFINE_PRIM(_VOID, pin_pivot_scale, _DYN);
DEFINE_PRIM(_VOID, pin_pivot_alignment, _DYN);
DEFINE_PRIM(_VOID, group, _DYN );
//
DEFINE_PRIM(_BOOL, begin_group_hint, _I32 );
DEFINE_PRIM(_DYN, get_group_min, _NO_ARG );
DEFINE_PRIM(_DYN, get_group_max, _NO_ARG );
DEFINE_PRIM(_TDRAWLIST, get_hint_foreground_draw_list, _NO_ARG );
DEFINE_PRIM(_TDRAWLIST, get_hint_background_draw_list, _NO_ARG );
DEFINE_PRIM(_VOID, end_group_hint, _NO_ARG );
//
DEFINE_PRIM(_TDRAWLIST, get_node_background_draw_list, _I32 );
//
DEFINE_PRIM(_BOOL, link, _I32 _I32 _I32 _DYN _REF(_F32) );
//
DEFINE_PRIM(_VOID, flow, _I32 _REF(_I32) );
//
DEFINE_PRIM(_BOOL, begin_create, _DYN _REF(_F32) );
DEFINE_PRIM(_BOOL, query_new_link, _REF(_I32) _REF(_I32) );
DEFINE_PRIM(_BOOL, query_new_link2, _REF(_I32) _REF(_I32) _DYN _REF(_F32) );
DEFINE_PRIM(_BOOL, query_new_node, _REF(_I32) );
DEFINE_PRIM(_BOOL, query_new_node2, _REF(_I32) _DYN _REF(_F32) );
DEFINE_PRIM(_BOOL, accept_new_item, _NO_ARG );
DEFINE_PRIM(_BOOL, accept_new_item2, _DYN _REF(_F32) );
DEFINE_PRIM(_BOOL, reject_new_item, _NO_ARG );
DEFINE_PRIM(_BOOL, reject_new_item2, _DYN _REF(_F32) );
DEFINE_PRIM(_VOID, end_create, _NO_ARG );
//
DEFINE_PRIM(_BOOL, begin_delete, _NO_ARG );
DEFINE_PRIM(_BOOL, query_deleted_link, _REF(_I32) _REF(_I32) _REF(_I32) );
DEFINE_PRIM(_BOOL, query_deleted_node, _REF(_I32) );
DEFINE_PRIM(_BOOL, accept_deleted_item, _REF(_BOOL) );
DEFINE_PRIM(_VOID, reject_deleted_item, _NO_ARG );
DEFINE_PRIM(_VOID, end_delete, _NO_ARG );
//
DEFINE_PRIM(_VOID, set_node_position, _I32 _DYN );
DEFINE_PRIM(_DYN, get_node_position, _I32 );
DEFINE_PRIM(_VOID, set_group_size, _I32 _DYN );
DEFINE_PRIM(_DYN, get_node_size, _I32 );
DEFINE_PRIM(_VOID, center_node_on_screen, _I32 );
DEFINE_PRIM(_VOID, set_node_zposition, _I32 _F32 );
DEFINE_PRIM(_F32, get_node_zposition, _I32 );
//
DEFINE_PRIM(_VOID, restore_node_state, _I32 );
//
DEFINE_PRIM(_VOID, suspend, _NO_ARG );
DEFINE_PRIM(_VOID, resume, _NO_ARG );
DEFINE_PRIM(_BOOL, is_suspended, _NO_ARG );
DEFINE_PRIM(_BOOL, is_active, _NO_ARG );
//
DEFINE_PRIM(_BOOL, has_selection_changed, _NO_ARG );
DEFINE_PRIM(_I32, get_selected_object_count, _NO_ARG );
DEFINE_PRIM(_ARR, get_selected_nodes, _NO_ARG );
DEFINE_PRIM(_ARR, get_selected_links, _NO_ARG );
DEFINE_PRIM(_BOOL, is_node_selected, _I32 );
DEFINE_PRIM(_BOOL, is_link_selected, _I32 );
DEFINE_PRIM(_VOID, clear_selection, _NO_ARG );
DEFINE_PRIM(_VOID, select_node, _I32 _REF(_BOOL) );
DEFINE_PRIM(_VOID, select_link, _I32 _REF(_BOOL) );
DEFINE_PRIM(_VOID, deselect_node, _I32 );
DEFINE_PRIM(_VOID, deselect_link, _I32 );
//
DEFINE_PRIM(_BOOL, delete_node, _I32 );
DEFINE_PRIM(_BOOL, delete_link, _I32 );
//
DEFINE_PRIM(_BOOL, has_any_links, _I32 );
DEFINE_PRIM(_BOOL, has_any_links2, _I32 );
DEFINE_PRIM(_I32, break_links, _I32 );
DEFINE_PRIM(_I32, break_links2, _I32 );
//
DEFINE_PRIM(_VOID, navigate_to_content, _REF(_F32) );
DEFINE_PRIM(_VOID, navigate_to_selection, _REF(_BOOL) _REF(_F32) );
//
DEFINE_PRIM(_BOOL, show_node_context_menu, _REF(_I32) );
DEFINE_PRIM(_BOOL, show_pin_context_menu, _REF(_I32) );
DEFINE_PRIM(_BOOL, show_link_context_menu, _REF(_I32) );
DEFINE_PRIM(_BOOL, show_background_context_menu, _NO_ARG );
//
DEFINE_PRIM(_VOID, enable_shortcuts, _BOOL );
DEFINE_PRIM(_BOOL, are_shortcuts_enabled, _NO_ARG );
//
// @todo shortcuts
//
DEFINE_PRIM(_F32, get_current_zoom, _NO_ARG );
DEFINE_PRIM(_I32, get_hovered_node, _NO_ARG );
DEFINE_PRIM(_I32, get_hovered_pin, _NO_ARG );
DEFINE_PRIM(_I32, get_hovered_link, _NO_ARG );
DEFINE_PRIM(_I32, get_double_clicked_node, _NO_ARG );
DEFINE_PRIM(_I32, get_double_clicked_pin, _NO_ARG );
DEFINE_PRIM(_I32, get_double_clicked_link, _NO_ARG );
DEFINE_PRIM(_BOOL, is_background_clicked, _NO_ARG );
DEFINE_PRIM(_BOOL, is_background_double_clicked, _NO_ARG );
//
DEFINE_PRIM(_BOOL, get_link_pins, _I32 _REF(_I32) _REF(_I32) );
DEFINE_PRIM(_BOOL, pin_had_any_links, _I32 );
//
DEFINE_PRIM(_DYN, get_screen_size, _NO_ARG );
DEFINE_PRIM(_DYN, screen_to_canvas, _DYN );
DEFINE_PRIM(_DYN, canvas_to_screen, _DYN );
//
DEFINE_PRIM(_I32, get_node_count, _NO_ARG );
//DEFINE_PRIM(_I32, get_ordered_node_ids, _NO_ARG );