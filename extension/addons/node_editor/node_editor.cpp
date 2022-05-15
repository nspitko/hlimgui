#include "../../utils.h"
#include "../../lib/imgui-node-editor/imgui_node_editor.h"

namespace NodeEditor = ax::NodeEditor;


//------------------------------------------------------------------------------
// Editor Context management
//------------------------------------------------------------------------------
HL_PRIM void HL_NAME(nodeeditor_set_current_editor)(NodeEditor::EditorContext* ctx)
{
	NodeEditor::SetCurrentEditor( ctx );
}

HL_PRIM NodeEditor::EditorContext* HL_NAME(nodeeditor_get_current_editor)()
{
	return NodeEditor::GetCurrentEditor();
}

HL_PRIM NodeEditor::EditorContext* HL_NAME(nodeeditor_create_editor)()
{
	return NodeEditor::CreateEditor();
}

HL_PRIM void HL_NAME(nodeeditor_destroy_editor)(NodeEditor::EditorContext* ctx)
{
	NodeEditor::DestroyEditor( ctx );
}

//------------------------------------------------------------------------------
// Style
//------------------------------------------------------------------------------
HL_PRIM NodeEditor::Style* HL_NAME(nodeeditor_get_style)()
{
	return &NodeEditor::GetStyle();
}

HL_PRIM void HL_NAME(nodeeditor_set_style)( NodeEditor::Style *hlStyle )
{
	if (hlStyle != nullptr)
	{
		NodeEditor::GetStyle() = *hlStyle;
	}
}

// Cursed code to call C-side constructor to a style we allocated in HL
HL_PRIM void HL_NAME(nodeeditor_init_style)(NodeEditor::Style* hlStyle)
{
	if (hlStyle != nullptr)
	{
		new (hlStyle)NodeEditor::Style();
	}
}

HL_PRIM vbyte* HL_NAME(nodeeditor_get_style_color_name)( NodeEditor::StyleColor colorIndex )
{
	return getVByteFromCStr( NodeEditor::GetStyleColorName(colorIndex) );
}

HL_PRIM void HL_NAME(nodeeditor_push_style_var)(NodeEditor::StyleVar varIndex, float value )
{
	NodeEditor::PushStyleVar( varIndex, value );
}

HL_PRIM void HL_NAME(nodeeditor_push_style_var2)(NodeEditor::StyleVar varIndex, vimvec2* val)
{
	NodeEditor::PushStyleVar(varIndex, getImVec2(val));
}

HL_PRIM void HL_NAME(nodeeditor_push_style_var3)(NodeEditor::StyleVar varIndex, vimvec4* val)
{
	NodeEditor::PushStyleVar(varIndex, getImVec4(val));
}

HL_PRIM void HL_NAME(nodeeditor_pop_style_var)( int* count )
{
	NodeEditor::PopStyleVar( convertPtr(count, 1) );
}

HL_PRIM void HL_NAME(nodeeditor_push_style_color)(NodeEditor::StyleColor varIndex, vimvec4* color )
{
	NodeEditor::PushStyleColor( varIndex,  getImVec4(color) );
}

HL_PRIM void HL_NAME(nodeeditor_pop_style_color)( int* count )
{
	NodeEditor::PopStyleColor( convertPtr(count, 1) );
}


//------------------------------------------------------------------------------
// Creation
//------------------------------------------------------------------------------

HL_PRIM void HL_NAME(nodeeditor_begin)( vstring* id, vimvec2 *size )
{
	NodeEditor::Begin( convertString(id), getImVec2(size) );
}

HL_PRIM void HL_NAME(nodeeditor_end)()
{
	NodeEditor::End();
}

//------------------------------------------------------------------------------

HL_PRIM void HL_NAME(nodeeditor_begin_node)( NodeEditor::NodeId id )
{
	NodeEditor::BeginNode( id );
}

HL_PRIM void HL_NAME(nodeeditor_end_node)()
{
	NodeEditor::EndNode();
}

//------------------------------------------------------------------------------

HL_PRIM void HL_NAME(nodeeditor_begin_pin)( NodeEditor::PinId id, NodeEditor::PinKind kind )
{
	NodeEditor::BeginPin( id, kind );
}

HL_PRIM void HL_NAME(nodeeditor_end_pin)()
{
	NodeEditor::EndPin();
}

HL_PRIM void HL_NAME(nodeeditor_pin_rect)( vimvec2 *a, vimvec2 *b)
{
	NodeEditor::PinRect( getImVec2(a), getImVec2(b) );
}

HL_PRIM void HL_NAME(nodeeditor_pin_pivot_rect)( vimvec2 *a, vimvec2 *b)
{
	NodeEditor::PinPivotRect( getImVec2(a), getImVec2(b) );
}

HL_PRIM void HL_NAME(nodeeditor_pin_pivot_size)( vimvec2 *size)
{
	NodeEditor::PinPivotSize( getImVec2(size) );
}

HL_PRIM void HL_NAME(nodeeditor_pin_pivot_scale)( vimvec2 *scale)
{
	NodeEditor::PinPivotScale( getImVec2(scale) );
}

HL_PRIM void HL_NAME(nodeeditor_pin_pivot_alignment)( vimvec2 *alignment)
{
	NodeEditor::PinPivotAlignment( getImVec2(alignment) );
}

//------------------------------------------------------------------------------

HL_PRIM void HL_NAME(nodeeditor_group)( vimvec2 *size )
{
	NodeEditor::Group( *size->v() );
}

HL_PRIM bool HL_NAME(nodeeditor_begin_group_hint)( NodeEditor::NodeId nodeId )
{
	return NodeEditor::BeginGroupHint( nodeId );
}

HL_PRIM vimvec2 *HL_NAME(nodeeditor_get_group_min)( )
{
	return NodeEditor::GetGroupMin();
}

HL_PRIM vimvec2 *HL_NAME(nodeeditor_get_group_max)( )
{
	return NodeEditor::GetGroupMax();
}

HL_PRIM ImDrawList *HL_NAME(nodeeditor_get_hint_foreground_draw_list)( )
{
	return NodeEditor::GetHintForegroundDrawList( );
}

HL_PRIM ImDrawList *HL_NAME(nodeeditor_get_hint_background_draw_list)( )
{
	return NodeEditor::GetHintBackgroundDrawList( );
}

HL_PRIM void HL_NAME(nodeeditor_end_group_hint)(  )
{
	NodeEditor::EndGroupHint( );
}

//------------------------------------------------------------------------------

HL_PRIM ImDrawList *HL_NAME(nodeeditor_get_node_background_draw_list)( NodeEditor::NodeId nodeId )
{
	return NodeEditor::GetNodeBackgroundDrawList( nodeId );
}

HL_PRIM bool HL_NAME(nodeeditor_link)( NodeEditor::LinkId linkId, NodeEditor::PinId startPinId, NodeEditor::PinId endPinId, vimvec4 *color, float *thickness )
{
	return NodeEditor::Link( linkId, startPinId, endPinId, getImVec4( color, ImVec4(1,1,1,1 ) ), convertPtr( thickness, 1.0F ) );
}

HL_PRIM void HL_NAME(nodeeditor_flow)( NodeEditor::LinkId linkId, NodeEditor::FlowDirection *direction )
{
	NodeEditor::Flow( linkId, convertPtr( direction, NodeEditor::FlowDirection::Forward ) );
}

//------------------------------------------------------------------------------

HL_PRIM bool HL_NAME(nodeeditor_begin_create)( vimvec4 *color, float *thickness )
{
	return NodeEditor::BeginCreate( getImVec4( color, ImVec4(1,1,1,1 ) ), convertPtr( thickness, 1.0F ) );
}

HL_PRIM bool HL_NAME(nodeeditor_query_new_link)( NodeEditor::PinId *startPinId, NodeEditor::PinId *endPinId )
{
	return NodeEditor::QueryNewLink( startPinId, endPinId );
}

HL_PRIM bool HL_NAME(nodeeditor_query_new_link2)(  NodeEditor::PinId *startPinId, NodeEditor::PinId *endPinId, vimvec4 *color, float *thickness )
{
	return NodeEditor::QueryNewLink( startPinId, endPinId, getImVec4( color, ImVec4(1,1,1,1 ) ), convertPtr( thickness, 1.0F )  );
}

HL_PRIM bool HL_NAME(nodeeditor_query_new_node)( NodeEditor::PinId *pinId )
{
	return NodeEditor::QueryNewNode( pinId );
}

HL_PRIM bool HL_NAME(nodeeditor_query_new_node2)( NodeEditor::PinId *pinId, vimvec4 *color, float *thickness )
{
	return NodeEditor::QueryNewNode( pinId, getImVec4( color, ImVec4(1,1,1,1 ) ), convertPtr( thickness, 1.0F ) );
}

HL_PRIM bool HL_NAME(nodeeditor_accept_new_item)( )
{
	return NodeEditor::AcceptNewItem( );
}

HL_PRIM bool HL_NAME(nodeeditor_accept_new_item2)(vimvec4 *color, float *thickness )
{
	return NodeEditor::AcceptNewItem(getImVec4( color, ImVec4(1,1,1,1 ) ), convertPtr( thickness, 1.0F ) );
}

HL_PRIM void HL_NAME(nodeeditor_reject_new_item)( )
{
	NodeEditor::RejectNewItem( );
}

HL_PRIM void HL_NAME(nodeeditor_reject_new_item2)(vimvec4 *color, float *thickness )
{
	NodeEditor::RejectNewItem(getImVec4( color, ImVec4(1,1,1,1 ) ), convertPtr( thickness, 1.0F ) );
}

HL_PRIM void HL_NAME(nodeeditor_end_create)()
{
	NodeEditor::EndCreate();
}

//------------------------------------------------------------------------------

HL_PRIM bool HL_NAME(nodeeditor_begin_delete)()
{
	return NodeEditor::BeginDelete();
}

HL_PRIM bool HL_NAME(nodeeditor_query_deleted_link)( NodeEditor::LinkId *linkId, NodeEditor::PinId *startId, NodeEditor::PinId *endId )
{
	return NodeEditor::QueryDeletedLink( linkId, startId, endId );
}

HL_PRIM bool HL_NAME(nodeeditor_query_deleted_node)( NodeEditor::NodeId *nodeId )
{
	return NodeEditor::QueryDeletedNode( nodeId );
}

HL_PRIM bool HL_NAME(nodeeditor_accept_deleted_item)( bool *delete_dependencies )
{
	return NodeEditor::AcceptDeletedItem( convertPtr( delete_dependencies, true ) );
}

HL_PRIM void HL_NAME(nodeeditor_reject_deleted_item)( )
{
	NodeEditor::RejectDeletedItem();
}

HL_PRIM void HL_NAME(nodeeditor_end_delete)( )
{
	NodeEditor::EndDelete();
}

//------------------------------------------------------------------------------

HL_PRIM void HL_NAME(nodeeditor_set_node_position)( NodeEditor::NodeId nodeId, vimvec2 *editorPosition )
{
	NodeEditor::SetNodePosition( nodeId, getImVec2( editorPosition ) );
}

HL_PRIM void HL_NAME(nodeeditor_set_group_size)( NodeEditor::NodeId nodeId, vimvec2 *size )
{
	NodeEditor::SetGroupSize( nodeId, getImVec2( size ) );
}

HL_PRIM vimvec2 *HL_NAME(nodeeditor_get_node_position)( NodeEditor::NodeId nodeId )
{
	return NodeEditor::GetNodePosition( nodeId );
}

HL_PRIM vimvec2 *HL_NAME(nodeeditor_get_node_size)( NodeEditor::NodeId nodeId )
{
	return NodeEditor::GetNodeSize( nodeId );
}

HL_PRIM void HL_NAME(nodeeditor_center_node_on_screen)( NodeEditor::NodeId nodeId )
{
	NodeEditor::CenterNodeOnScreen( nodeId );
}

HL_PRIM void HL_NAME(nodeeditor_set_node_zposition)( NodeEditor::NodeId nodeId, float z )
{
	NodeEditor::SetNodeZPosition( nodeId, z );
}

HL_PRIM float HL_NAME(nodeeditor_get_node_zposition)( NodeEditor::NodeId nodeId )
{
	return NodeEditor::GetNodeZPosition( nodeId );
}

//------------------------------------------------------------------------------

HL_PRIM void HL_NAME(nodeeditor_restore_node_state)( NodeEditor::NodeId nodeId )
{
	NodeEditor::RestoreNodeState( nodeId );
}


HL_PRIM void HL_NAME(nodeeditor_suspend)( )
{
	NodeEditor::Suspend();
}

HL_PRIM void HL_NAME(nodeeditor_resume)( )
{
	NodeEditor::Resume();
}

HL_PRIM bool HL_NAME(nodeeditor_is_suspended)( )
{
	return NodeEditor::IsSuspended();
}

HL_PRIM bool HL_NAME(nodeeditor_is_active)( )
{
	return NodeEditor::IsActive();
}

//------------------------------------------------------------------------------

HL_PRIM bool HL_NAME(nodeeditor_has_selection_changed)()
{
	return NodeEditor::HasSelectionChanged();
}

HL_PRIM int HL_NAME(nodeeditor_get_selected_object_count)()
{
	return NodeEditor::GetSelectedObjectCount();
}

HL_PRIM varray *HL_NAME(nodeeditor_get_selected_nodes)()
{
	// This looks stupid because it is. My hands are tied.
	int allocSize = NodeEditor::GetSelectedObjectCount();
	NodeEditor::NodeId *selectedNodes = new NodeEditor::NodeId[allocSize];

	int actualSize = NodeEditor::GetSelectedNodes( selectedNodes, allocSize );

	varray* hlArray = hl_alloc_array( &hlt_i64, actualSize );
	NodeEditor::NodeId *hlPtr = hl_aptr(hlArray, NodeEditor::NodeId);

	memcpy( hlPtr, selectedNodes, actualSize * sizeof( NodeEditor::NodeId ) );

	delete selectedNodes;

	return hlArray;
}

HL_PRIM varray *HL_NAME(nodeeditor_get_selected_links)()
{
	// This looks stupid because it is. My hands are tied.
	int allocSize = NodeEditor::GetSelectedObjectCount();
	NodeEditor::LinkId *selectedLinks = new NodeEditor::LinkId[allocSize];

	int actualSize = NodeEditor::GetSelectedLinks( selectedLinks, allocSize );

	varray* hlArray = hl_alloc_array( &hlt_i64, actualSize );
	NodeEditor::LinkId *hlPtr = hl_aptr(hlArray, NodeEditor::LinkId);

	memcpy( hlPtr, selectedLinks, actualSize * sizeof( NodeEditor::LinkId ) );

	delete selectedLinks;

	return hlArray;
}


HL_PRIM bool HL_NAME(nodeeditor_is_node_selected)( NodeEditor::NodeId nodeId )
{
	return NodeEditor::IsNodeSelected( nodeId );
}

HL_PRIM bool HL_NAME(nodeeditor_is_link_selected)( NodeEditor::LinkId linkId )
{
	return NodeEditor::IsLinkSelected( linkId );
}

HL_PRIM void HL_NAME(nodeeditor_clear_selection)()
{
	NodeEditor::ClearSelection();
}

HL_PRIM void HL_NAME(nodeeditor_select_node)( NodeEditor::NodeId nodeId, bool *append)
{
	NodeEditor::SelectNode( nodeId, convertPtr(append, false ) );
}

HL_PRIM void HL_NAME(nodeeditor_select_link)( NodeEditor::LinkId linkId, bool *append)
{
	NodeEditor::SelectLink( linkId, convertPtr(append, false ) );
}

HL_PRIM void HL_NAME(nodeeditor_deselect_node)( NodeEditor::NodeId nodeId)
{
	NodeEditor::DeselectNode( nodeId );
}

HL_PRIM void HL_NAME(nodeeditor_deselect_link)( NodeEditor::LinkId linkId)
{
	NodeEditor::DeselectLink( linkId );
}

//------------------------------------------------------------------------------


HL_PRIM bool HL_NAME(nodeeditor_delete_node)( NodeEditor::NodeId nodeId )
{
	return NodeEditor::DeleteNode( nodeId );
}

HL_PRIM bool HL_NAME(nodeeditor_delete_link)( NodeEditor::LinkId linkId )
{
	return NodeEditor::DeleteLink( linkId );
}

//------------------------------------------------------------------------------

HL_PRIM bool HL_NAME(nodeeditor_has_any_links)( NodeEditor::NodeId nodeId )
{
	return NodeEditor::HasAnyLinks( nodeId );
}

HL_PRIM bool HL_NAME(nodeeditor_has_any_links2)( NodeEditor::PinId pinId )
{
	return NodeEditor::HasAnyLinks( pinId );
}

HL_PRIM int HL_NAME(nodeeditor_break_links)( NodeEditor::NodeId nodeId )
{
	return NodeEditor::BreakLinks( nodeId );
}

HL_PRIM int HL_NAME(nodeeditor_break_links2)( NodeEditor::PinId pinId )
{
	return NodeEditor::BreakLinks( pinId );
}

//------------------------------------------------------------------------------

HL_PRIM void HL_NAME(nodeeditor_navigate_to_content)( float *duration )
{
	NodeEditor::NavigateToContent( convertPtr( duration, -1 ) );
}

HL_PRIM void HL_NAME(nodeeditor_navigate_to_selection)( bool *zoomIn, float *duration )
{
	NodeEditor::NavigateToSelection( convertPtr( zoomIn, false ), convertPtr( duration, -1 ) );
}

//------------------------------------------------------------------------------

HL_PRIM bool HL_NAME(nodeeditor_show_node_context_menu)( NodeEditor::NodeId *nodeId  )
{
	return NodeEditor::ShowNodeContextMenu( nodeId );
}

HL_PRIM bool HL_NAME(nodeeditor_show_pin_context_menu)( NodeEditor::PinId *pinId  )
{
	return NodeEditor::ShowPinContextMenu( pinId );
}

HL_PRIM bool HL_NAME(nodeeditor_show_link_context_menu)( NodeEditor::LinkId *linkId  )
{
	return NodeEditor::ShowLinkContextMenu( linkId );
}

HL_PRIM bool HL_NAME(nodeeditor_show_background_context_menu)( )
{
	return NodeEditor::ShowBackgroundContextMenu( );
}

//------------------------------------------------------------------------------

HL_PRIM void HL_NAME(nodeeditor_enable_shortcuts)( bool enable )
{
	return NodeEditor::EnableShortcuts( enable );
}

HL_PRIM bool HL_NAME(nodeeditor_are_shortcuts_enabled)( )
{
	return NodeEditor::AreShortcutsEnabled( );
}

//------------------------------------------------------------------------------

// @todo shortcuts

//------------------------------------------------------------------------------

HL_PRIM int HL_NAME(nodeeditor_get_hovered_node)()
{
	return (int)NodeEditor::GetHoveredNode().Get();
}

HL_PRIM int HL_NAME(nodeeditor_get_hovered_pin)()
{
	return (int)NodeEditor::GetHoveredPin().Get();
}

HL_PRIM int HL_NAME(nodeeditor_get_hovered_link)()
{
	return (int)NodeEditor::GetHoveredLink().Get();
}

//

HL_PRIM int HL_NAME(nodeeditor_get_double_clicked_node)()
{
	return (int)NodeEditor::GetDoubleClickedNode().Get();
}

HL_PRIM int HL_NAME(nodeeditor_get_double_clicked_pin)()
{
	return (int)NodeEditor::GetDoubleClickedPin().Get();
}

HL_PRIM int HL_NAME(nodeeditor_get_double_clicked_link)()
{
	return (int)NodeEditor::GetDoubleClickedLink().Get();
}

HL_PRIM bool HL_NAME(nodeeditor_is_background_clicked)()
{
	return NodeEditor::IsBackgroundClicked();
}

HL_PRIM bool HL_NAME(nodeeditor_is_background_double_clicked)()
{
	return NodeEditor::IsBackgroundDoubleClicked();
}

//------------------------------------------------------------------------------

HL_PRIM bool HL_NAME(nodeeditor_get_link_pins)( NodeEditor::LinkId linkId, NodeEditor::PinId *startPinId, NodeEditor::PinId *endPinId )
{
	return NodeEditor::GetLinkPins( linkId, startPinId, endPinId );
}

HL_PRIM bool HL_NAME(nodeeditor_pin_had_any_links)( NodeEditor::PinId pinId )
{
	return NodeEditor::PinHadAnyLinks( pinId );
}

//------------------------------------------------------------------------------


HL_PRIM float HL_NAME(nodeeditor_get_current_zoom)(  )
{
	return NodeEditor::GetCurrentZoom();
}

HL_PRIM vimvec2 *HL_NAME(nodeeditor_get_screen_size)(  )
{
	return NodeEditor::GetScreenSize();
}

HL_PRIM vimvec2 *HL_NAME(nodeeditor_screen_to_canvas)( vimvec2 *pos )
{
	return NodeEditor::ScreenToCanvas( getImVec2( pos ) );
}

HL_PRIM vimvec2 *HL_NAME(nodeeditor_canvas_to_screen)( vimvec2 *pos )
{
	return NodeEditor::CanvasToScreen( getImVec2( pos ) );
}

//------------------------------------------------------------------------------

HL_PRIM int HL_NAME(nodeeditor_get_node_count)( )
{
	return NodeEditor::GetNodeCount();
}

//------------------------------------------------------------------------------


// Types
#define _TNODECTX _ABSTRACT(imnecontext)
#define _TNODEID _ABSTRACT(imnenodeid)

#define _TDRAWLIST _ABSTRACT(imdrawlist)

DEFINE_PRIM(_VOID, nodeeditor_set_current_editor, _TNODECTX);
DEFINE_PRIM(_TNODECTX, nodeeditor_get_current_editor, _NO_ARG );
DEFINE_PRIM(_TNODECTX, nodeeditor_create_editor, _NO_ARG );
DEFINE_PRIM(_VOID, nodeeditor_destroy_editor, _TNODECTX );
//
DEFINE_PRIM(_STRUCT, nodeeditor_get_style, _NO_ARG );
DEFINE_PRIM(_VOID, nodeeditor_set_style, _STRUCT );
DEFINE_PRIM(_VOID, nodeeditor_init_style, _STRUCT );
DEFINE_PRIM(_VOID, nodeeditor_push_style_var, _I32 _F32 );
DEFINE_PRIM(_VOID, nodeeditor_push_style_var2, _I32 _IMVEC2 );
DEFINE_PRIM(_VOID, nodeeditor_push_style_var3, _I32 _IMVEC4 );
DEFINE_PRIM(_VOID, nodeeditor_pop_style_var, _REF(_I32) );
DEFINE_PRIM(_VOID, nodeeditor_push_style_color, _I32 _IMVEC4 );
DEFINE_PRIM(_VOID, nodeeditor_pop_style_color, _REF(_I32) );
//
DEFINE_PRIM(_VOID, nodeeditor_begin, _STRING _IMVEC2);
DEFINE_PRIM(_VOID, nodeeditor_end, _NO_ARG);
DEFINE_PRIM(_VOID, nodeeditor_begin_node, _I64);
DEFINE_PRIM(_VOID, nodeeditor_end_node, _NO_ARG);
DEFINE_PRIM(_VOID, nodeeditor_begin_pin, _I64 _I32);
DEFINE_PRIM(_VOID, nodeeditor_end_pin, _NO_ARG);
DEFINE_PRIM(_VOID, nodeeditor_pin_rect, _IMVEC2 _IMVEC2);
DEFINE_PRIM(_VOID, nodeeditor_pin_pivot_rect, _IMVEC2 _IMVEC2);
DEFINE_PRIM(_VOID, nodeeditor_pin_pivot_size, _IMVEC2);
DEFINE_PRIM(_VOID, nodeeditor_pin_pivot_scale, _IMVEC2);
DEFINE_PRIM(_VOID, nodeeditor_pin_pivot_alignment, _IMVEC2);
DEFINE_PRIM(_VOID, nodeeditor_group, _IMVEC2 );
//
DEFINE_PRIM(_BOOL, nodeeditor_begin_group_hint, _I64 );
DEFINE_PRIM(_IMVEC2, nodeeditor_get_group_min, _NO_ARG );
DEFINE_PRIM(_IMVEC2, nodeeditor_get_group_max, _NO_ARG );
DEFINE_PRIM(_TDRAWLIST, nodeeditor_get_hint_foreground_draw_list, _NO_ARG );
DEFINE_PRIM(_TDRAWLIST, nodeeditor_get_hint_background_draw_list, _NO_ARG );
DEFINE_PRIM(_VOID, nodeeditor_end_group_hint, _NO_ARG );
//
DEFINE_PRIM(_TDRAWLIST, nodeeditor_get_node_background_draw_list, _I64 );
//
DEFINE_PRIM(_BOOL, nodeeditor_link, _I64 _I64 _I64 _IMVEC4 _REF(_F32) );
//
DEFINE_PRIM(_VOID, nodeeditor_flow, _I64 _REF(_I32) );
//
DEFINE_PRIM(_BOOL, nodeeditor_begin_create, _IMVEC4 _REF(_F32) );
DEFINE_PRIM(_BOOL, nodeeditor_query_new_link, _REF(_I64) _REF(_I64) );
DEFINE_PRIM(_BOOL, nodeeditor_query_new_link2, _REF(_I64) _REF(_I64) _IMVEC4 _REF(_F32) );
DEFINE_PRIM(_BOOL, nodeeditor_query_new_node, _REF(_I64) );
DEFINE_PRIM(_BOOL, nodeeditor_query_new_node2, _REF(_I64) _IMVEC4 _REF(_F32) );
DEFINE_PRIM(_BOOL, nodeeditor_accept_new_item, _NO_ARG );
DEFINE_PRIM(_BOOL, nodeeditor_accept_new_item2, _IMVEC4 _REF(_F32) );
DEFINE_PRIM(_BOOL, nodeeditor_reject_new_item, _NO_ARG );
DEFINE_PRIM(_BOOL, nodeeditor_reject_new_item2, _IMVEC4 _REF(_F32) );
DEFINE_PRIM(_VOID, nodeeditor_end_create, _NO_ARG );
//
DEFINE_PRIM(_BOOL, nodeeditor_begin_delete, _NO_ARG );
DEFINE_PRIM(_BOOL, nodeeditor_query_deleted_link, _REF(_I64) _REF(_I64) _REF(_I64) );
DEFINE_PRIM(_BOOL, nodeeditor_query_deleted_node, _REF(_I64) );
DEFINE_PRIM(_BOOL, nodeeditor_accept_deleted_item, _REF(_BOOL) );
DEFINE_PRIM(_VOID, nodeeditor_reject_deleted_item, _NO_ARG );
DEFINE_PRIM(_VOID, nodeeditor_end_delete, _NO_ARG );
//
DEFINE_PRIM(_VOID, nodeeditor_set_node_position, _I64 _IMVEC2 );
DEFINE_PRIM(_IMVEC2, nodeeditor_get_node_position, _I64 );
DEFINE_PRIM(_VOID, nodeeditor_set_group_size, _I64 _IMVEC2 );
DEFINE_PRIM(_IMVEC2, nodeeditor_get_node_size, _I64 );
DEFINE_PRIM(_VOID, nodeeditor_center_node_on_screen, _I64 );
DEFINE_PRIM(_VOID, nodeeditor_set_node_zposition, _I64 _F32 );
DEFINE_PRIM(_F32, nodeeditor_get_node_zposition, _I64 );
//
DEFINE_PRIM(_VOID, nodeeditor_restore_node_state, _I64 );
//
DEFINE_PRIM(_VOID, nodeeditor_suspend, _NO_ARG );
DEFINE_PRIM(_VOID, nodeeditor_resume, _NO_ARG );
DEFINE_PRIM(_BOOL, nodeeditor_is_suspended, _NO_ARG );
DEFINE_PRIM(_BOOL, nodeeditor_is_active, _NO_ARG );
//
DEFINE_PRIM(_BOOL, nodeeditor_has_selection_changed, _NO_ARG );
DEFINE_PRIM(_I32, nodeeditor_get_selected_object_count, _NO_ARG );
DEFINE_PRIM(_ARR, nodeeditor_get_selected_nodes, _NO_ARG );
DEFINE_PRIM(_ARR, nodeeditor_get_selected_links, _NO_ARG );
DEFINE_PRIM(_BOOL, nodeeditor_is_node_selected, _I64 );
DEFINE_PRIM(_BOOL, nodeeditor_is_link_selected, _I64 );
DEFINE_PRIM(_VOID, nodeeditor_clear_selection, _NO_ARG );
DEFINE_PRIM(_VOID, nodeeditor_select_node, _I64 _REF(_BOOL) );
DEFINE_PRIM(_VOID, nodeeditor_select_link, _I64 _REF(_BOOL) );
DEFINE_PRIM(_VOID, nodeeditor_deselect_node, _I64 );
DEFINE_PRIM(_VOID, nodeeditor_deselect_link, _I64 );
//
DEFINE_PRIM(_BOOL, nodeeditor_delete_node, _I64 );
DEFINE_PRIM(_BOOL, nodeeditor_delete_link, _I64 );
//
DEFINE_PRIM(_BOOL, nodeeditor_has_any_links, _I64 );
DEFINE_PRIM(_BOOL, nodeeditor_has_any_links2, _I64 );
DEFINE_PRIM(_I32, nodeeditor_break_links, _I64 );
DEFINE_PRIM(_I32, nodeeditor_break_links2, _I64 );
//
DEFINE_PRIM(_VOID, nodeeditor_navigate_to_content, _REF(_F32) );
DEFINE_PRIM(_VOID, nodeeditor_navigate_to_selection, _REF(_BOOL) _REF(_F32) );
//
DEFINE_PRIM(_BOOL, nodeeditor_show_node_context_menu, _REF(_I64) );
DEFINE_PRIM(_BOOL, nodeeditor_show_pin_context_menu, _REF(_I64) );
DEFINE_PRIM(_BOOL, nodeeditor_show_link_context_menu, _REF(_I64) );
DEFINE_PRIM(_BOOL, nodeeditor_show_background_context_menu, _NO_ARG );
//
DEFINE_PRIM(_VOID, nodeeditor_enable_shortcuts, _BOOL );
DEFINE_PRIM(_BOOL, nodeeditor_are_shortcuts_enabled, _NO_ARG );
//
// @todo shortcuts
//
DEFINE_PRIM(_F32, nodeeditor_get_current_zoom, _NO_ARG );
DEFINE_PRIM(_I64, nodeeditor_get_hovered_node, _NO_ARG );
DEFINE_PRIM(_I64, nodeeditor_get_hovered_pin, _NO_ARG );
DEFINE_PRIM(_I64, nodeeditor_get_hovered_link, _NO_ARG );
DEFINE_PRIM(_I64, nodeeditor_get_double_clicked_node, _NO_ARG );
DEFINE_PRIM(_I64, nodeeditor_get_double_clicked_pin, _NO_ARG );
DEFINE_PRIM(_I64, nodeeditor_get_double_clicked_link, _NO_ARG );
DEFINE_PRIM(_BOOL, nodeeditor_is_background_clicked, _NO_ARG );
DEFINE_PRIM(_BOOL, nodeeditor_is_background_double_clicked, _NO_ARG );
//
DEFINE_PRIM(_BOOL, nodeeditor_get_link_pins, _I64 _REF(_I64) _REF(_I64) );
DEFINE_PRIM(_BOOL, nodeeditor_pin_had_any_links, _I64 );
//
DEFINE_PRIM(_IMVEC2, nodeeditor_get_screen_size, _NO_ARG );
DEFINE_PRIM(_IMVEC2, nodeeditor_screen_to_canvas, _IMVEC2 );
DEFINE_PRIM(_IMVEC2, nodeeditor_canvas_to_screen, _IMVEC2 );
//
DEFINE_PRIM(_I32, nodeeditor_get_node_count, _NO_ARG );
//DEFINE_PRIM(_I32, get_ordered_node_ids, _NO_ARG );