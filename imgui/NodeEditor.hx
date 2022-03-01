package imgui;

import imgui.ImGui.ExtDynamic;
import imgui.ImGui.ImVec2;
import imgui.ImGui.ImVec4;
import imgui.ImGui.ImDrawList;

private typedef ImDrawListPtr = hl.Abstract<"imdrawlist">;

typedef EditorContext = hl.Abstract<"imnecontext">;


@:enum abstract PinKind(Int) from Int to Int {
	var Input : Int = 0;
	var Output : Int = 1;
}

@:enum abstract FlowDirection(Int) from Int to Int {
	var Forward : Int = 0;
	var Backward : Int = 1;
}

typedef NodeId = Int;
typedef PinId = Int;
typedef LinkId = Int;

@:hlNative("hlimgui")
class NodeEditor
{
	// Context
	public static function setCurrentEditor( context: EditorContext ) : Void {}
	public static function getCurrentEditor( ) : EditorContext { return null; }
	public static function createEditor() : EditorContext { return null; }
	public static function destroyEditor( context: EditorContext ) : Void { }

	// Item
	public static inline function begin(name : String, size : ImVec2 = null) { ne_begin(name, size); }
	public static inline function end() { ne_end(); }

	public static function beginNode(nodeId : NodeId ) : Void { }
	public static function endNode() : Void { }

	public static function beginPin(pinId : PinId, kind : PinKind) : Void { }
	public static function pinRect(a : ExtDynamic<ImVec2>, a : ExtDynamic<ImVec2>) : Void { }
	public static function pinPivotRect(a : ExtDynamic<ImVec2>, a : ExtDynamic<ImVec2>) : Void { }
	public static function pinPivotSize(size : ExtDynamic<ImVec2> ) : Void { }
	public static function pinPivotScale(scale : ExtDynamic<ImVec2> ) : Void { }
	public static function pinPivotAlignment(alignment : ExtDynamic<ImVec2> ) : Void { }
	public static function endPin() : Void { }

	// group
	public static function group( size : ExtDynamic<ImVec2> = null ) : Void { }
	public static function beginGroupHint( nodeId: NodeId ) : Bool { return false; }
	public static function getGroupMin() : ExtDynamic<ImVec2> { return null; }
	public static function getGroupMax() : ExtDynamic<ImVec2> { return null; }
	public static inline function getHintForegroundDrawList() : ImDrawList { return new ImDrawList( get_hint_foreground_draw_list() ); }
	public static inline function getHintBackgroundDrawList() : ImDrawList { return new ImDrawList( get_hint_background_draw_list() ); }
	public static function endGroupHint() : Void { }

	public static inline function getNodeBackgroundDrawList( nodeId: NodeId ) : ImDrawList { return new ImDrawList( get_node_background_draw_list( nodeId ) ); }

	public static function link( linkId: LinkId, startId: PinId, endId: PinId, color: ExtDynamic<ImVec4> = null, thickness: Single = 0 ) : Bool { return false; }
	public static function flow( linkId: LinkId, direction: FlowDirection = FlowDirection.Forward ): Void  { }

	// Create
	public static function beginCreate( color: ExtDynamic<ImVec4> = null, thickness: Single = 1.0 ) : Bool { return false; }
	public static function queryNewLink( startPinId: hl.Ref<PinId>, endPinId: hl.Ref<PinId> ) : Bool { return false; }
	public static function queryNewLink2( startPinId: hl.Ref<PinId>, endPinId: hl.Ref<PinId>, color: ExtDynamic<ImVec4>, thickness: Single = 1.0 ) : Bool { return false; }
	public static function queryNewNode( startNodeId: hl.Ref<NodeId> ) : Bool { return false; }
	public static function queryNewNode2( startNodeId: hl.Ref<NodeId>, color: ExtDynamic<ImVec4>, thickness: Single = 1.0 ) : Bool { return false; }
	public static function acceptNewItem() : Bool { return false; }
	public static function acceptNewItem2( color: ExtDynamic<ImVec4> = null , thickness: Single = 1.0 ) : Bool { return false; }
	public static function rejectNewItem() : Bool { return false; }
	public static function rejectNewItem2( color: ExtDynamic<ImVec4> = null , thickness: Single = 1.0 ) : Bool { return false; }
	public static function endCreate() : Void { }

	// Delete
	public static function beginDelete() : Bool { return false; }
	public static function queryDeletedLink( linkId: hl.Ref<LinkId>, startId: hl.Ref<PinId>, endId:  hl.Ref<PinId>) : Bool { return false; }
	public static function queryDeletedNode( nodeID: hl.Ref<NodeId>) : Bool { return false; }
	public static function acceptDeletedItem( deleteDependencies: Bool = true ) : Bool { return false; }
	public static function rejectDeletedItem() : Void {}
	public static function endDelete() : Void {}

	// Status
	public static function setNodePosition( nodeId: NodeId, position: ExtDynamic<ImVec2> ) : Void {}
	public static function getNodePosition( nodeId: NodeId ) : ExtDynamic<ImVec2> { return null; }
	public static function getNodeSize( nodeId: NodeId ) : ExtDynamic<ImVec2> { return null; }
	public static function setGroupSize( nodeId: NodeId, size: ExtDynamic<ImVec4> ) : Void {}
	public static function centerNodeOnScreen( nodeId: NodeId ) : Void {}
	public static function setNodeZPosition( nodeId: NodeId, z: Single ) : Void {}
	public static function getNodeZPosition( nodeId: NodeId ) : Single { return 0; }
	//
	public static function restoreNodeState( nodeId: NodeId ) : Void {}
	//
	public static function suspend() : Void {}
	public static function resume() : Void {}
	public static function isSuspended() : Bool { return false; }
	public static function isActive() : Bool { return false; }
	//
	public static function hasSelectionChanged() : Bool { return false; }
	public static function getSelectedObjectCount() : Int { return 0; }
	public static function getSelectedNodes() : hl.NativeArray<NodeId> { return null; }
	public static function getSelectedLinks() : hl.NativeArray<LinkId> { return null; }
	public static function isNodeSelected( nodeId: NodeId ) : Bool { return false; }
	public static function isLinkSelected( linkId: NodeId ) : Bool { return false; }
	public static function clearSelection( ) : Void {}
	public static function selectNode( nodeId: NodeId, append: Bool = false ) : Void {}
	public static function selectLink( linkId: LinkId, append: Bool = false ) : Void {}
	public static function deselectNode( nodeId: NodeId ) : Void {}
	public static function deselectLink( linkId: LinkId ) : Void {}
	//
	public static function deleteNode( nodeId: NodeId ) : Bool { return false; }
	public static function deleteLink( linkId: LinkId ) : Bool { return false; }
	//
	public static function hasAnyLinks( nodeId: NodeId ) : Bool { return false; }
	public static function hasAnyLinks2( pinId: PinId ) : Bool { return false; }
	public static function breakLinks( nodeId: NodeId ) : Int { return 0; }
	public static function breakLinks2( pinId: PinId ) : Int { return 0; }
	//
	public static function navigateToContent( duration: Single = -1 ) : Void { }
	public static function navigateToSelection( zoomIn: Bool = false, duration: Single = -1 ) : Void { }
	//
	public static function showNodeContextMenu( nodeId: hl.Ref<NodeId> ) : Bool { return false; }
	public static function showLinkContextMenu( linkId: hl.Ref<LinkId> ) : Bool { return false; }
	public static function showPinContextMenu( pinId: hl.Ref<PinId> ) : Bool { return false; }
	public static function showBackgroundContextMenu( ) : Bool { return false; }
	//
	public static function enableShortcuts( enabled: Bool ) : Void { }
	public static function areShortcutsEnabled( ) : Bool { return false; }
	//
	// @todo shortcuts
	//
	public static function getCurrentZoom() : Single { return 0; }
	//
	public static function getHoveredNode( ) : NodeId { return 0; }
	public static function getHoveredLink( ) : LinkId { return 0; }
	public static function getHoveredPin( ) : PinId { return 0; }
	public static function getDoubleClickedNode( ) : NodeId { return 0; }
	public static function getDoubleClickedLink( ) : LinkId { return 0; }
	public static function getDoubleClickedPin( ) : PinId { return 0; }
	public static function isBackgroundClicked( ) : Bool { return false; }
	public static function isBackgroundDoubleClicked( ) : Bool { return false; }
	//
	public static function getLinkPins( linkId: LinkId, startPinId: hl.Ref<PinId>, endPinId: hl.Ref<PinId> ) : Bool { return false; } // pass nullptr if particular pin do not interest you
	public static function pinHadAnyLinks( pinId: PinId ) : Bool { return false; }
	//
	public static function getScreenSize( ) : ExtDynamic<ImVec2> { return null; }
	public static function screenToCanvas( pos: ExtDynamic<ImVec2> ) : ExtDynamic<ImVec2> { return null; }
	public static function canvasToScreen( pos: ExtDynamic<ImVec2> ) : ExtDynamic<ImVec2> { return null; }
	//
	public static function getNodeCount( ) : Int { return 0; }


	// Internal
	static function ne_begin(name : String, size : ExtDynamic<ImVec2> = null ) : Void {}
	static function ne_end() : Void {}
	static function get_hint_foreground_draw_list() : ImDrawListPtr { return null; }
	static function get_hint_background_draw_list() : ImDrawListPtr { return null; }
	static function get_node_background_draw_list( nodeId: NodeId ) : ImDrawListPtr { return null; }


}