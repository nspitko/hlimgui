package imgui;
#if hlimgui
import imgui.ImGui.ImVec2;
import imgui.ImGui.ImVec2S;
import imgui.ImGui.ImVec4;
import imgui.ImGui.ImVec4S;
import imgui.ImGui.ImDrawList;

typedef NodeId = hl.I64;
typedef PinId = hl.I64;
typedef LinkId = hl.I64;

private typedef ImDrawListPtr = hl.Abstract<"imdrawlist">;

typedef EditorContext = hl.Abstract<"imnecontext">;

@:enum abstract StyleColor(Int) from Int to Int {
    var Bg = 0;
    var Grid = 1;
    var NodeBg = 2;
    var NodeBorder = 3;
    var HovNodeBorder = 4;
    var SelNodeBorder = 5;
    var NodeSelRect = 6;
    var NodeSelRectBorder = 7;
    var HovLinkBorder = 8;
    var SelLinkBorder = 9;
    var LinkSelRect = 10;
    var LinkSelRectBorder = 11;
    var PinRect = 12;
    var PinRectBorder = 13;
    var Flow = 14;
    var FlowMarker = 15;
    var GroupBg = 16;
    var GroupBorder = 17;

    var Count = 18;
}

@:enum abstract StyleVar(Int) from Int to Int {
    var NodePadding = 0;
    var NodeRounding = 1;
    var NodeBorderWidth = 2;
    var HoveredNodeBorderWidth = 3;
    var SelectedNodeBorderWidth = 4;
    var PinRounding = 5;
    var PinBorderWidth = 6;
    var LinkStrength = 7;
    var SourceDirection = 8;
    var TargetDirection = 9;
    var ScrollDuration = 10;
    var FlowMarkerDistance = 11;
    var FlowSpeed = 12;
    var FlowDuration = 13;
    var PivotAlignment = 14;
    var PivotSize = 15;
    var PivotScale = 16;
    var PinCorners = 17;
    var PinRadius = 18;
    var PinArrowSize = 19;
    var PinArrowWidth = 20;
    var GroupRounding = 21;
    var GroupBorderWidth = 22;

    var Count = 23;
}

/**
 * Node editor style.
 *
 * Unlike imgui style, there's no "set" function, so there is no constructor.
 */
@:keep
@:build(imgui._ImGuiInternalMacro.buildFlatStruct())
@:hlNative("hlimgui","nodeeditor_")
@:struct
class Style
{
	@:flatten var NodePadding: ImVec4S;
	public var NodeRounding: Single;
	public var NodeBorderWidth: Single;
	public var HoveredNodeBorderWidth: Single;
	public var SelectedNodeBorderWidth: Single;
	public var PinRounding: Single;
	public var PinBorderWidth: Single;
	public var LinkStrength: Single;
	@:flatten var SourceDirection: ImVec2;
	@:flatten var TargetDirection: ImVec2;
	public var ScrollDuration: Single;
	public var FlowMarkerDistance: Single;
	public var FlowSpeed: Single;
	public var FlowDuration: Single;
	@:flatten var PivotAlignment: ImVec2;
	@:flatten var PivotSize: ImVec2;
	@:flatten var PivotScale: ImVec2;
	public var PinCorners: Single;
	public var PinRadius: Single;
	public var PinArrowSize: Single;
	public var PinArrowWidth: Single;
	public var GroupRounding: Single;
	public var GroupBorderWidth: Single;
	@:flattenMap(StyleColor) var Colors: ImVec4S;

	public function new()
	{
		init_style(this);
	}

	static function init_style(style: Style) {}
}


@:enum abstract PinKind(Int) from Int to Int {
	var Input : Int = 0;
	var Output : Int = 1;
}

@:enum abstract FlowDirection(Int) from Int to Int {
	var Forward : Int = 0;
	var Backward : Int = 1;
}

@:hlNative("hlimgui","nodeeditor_")
class NodeEditor
{
	// Context
	public static function setCurrentEditor( context: EditorContext ) : Void {}
	public static function getCurrentEditor( ) : EditorContext { return null; }
	public static function createEditor() : EditorContext { return null; }
	public static function destroyEditor( context: EditorContext ) : Void { }

	// Style
	public static function getStyle( ) : Style { return null; }
	public static function setStyle( style: Style ) { }

	public static function pushStyleVar( varIndex: StyleVar, val: Single ) { }
	public static function pushStyleVar2( varIndex: StyleVar, vec2: ImVec2 ) { }
	public static function pushStyleVar3( varIndex: StyleVar, vec4: ImVec4 ) { }
	public static function popStyleVar( count: Int = 1 ) { }
	public static function pushStyleColor( varIndex: StyleColor, vec2: ImVec4 ) { }
	public static function popStyleColor( count: Int = 1 ) { }

	// Item
	public static function begin(name : String, ?size : ImVec2) : Void { }
	public static function end() : Void { }

	public static function beginNode(nodeId : NodeId ) : Void { }
	public static function endNode() : Void { }

	public static function beginPin(pinId : PinId, kind : PinKind) : Void { }
	public static function pinRect(a : ImVec2, a : ImVec2) : Void { }
	public static function pinPivotRect(a : ImVec2, a : ImVec2) : Void { }
	public static function pinPivotSize(size : ImVec2 ) : Void { }
	public static function pinPivotScale(scale : ImVec2 ) : Void { }
	public static function pinPivotAlignment(alignment : ImVec2 ) : Void { }
	public static function endPin() : Void { }

	// group
	public static function group( size : ImVec2 = null ) : Void { }
	public static function beginGroupHint( nodeId: NodeId ) : Bool { return false; }
	public static function getGroupMin() : ImVec2 { return null; }
	public static function getGroupMax() : ImVec2 { return null; }
	public static inline function getHintForegroundDrawList() : ImDrawList { return new ImDrawList( get_hint_foreground_draw_list() ); }
	public static inline function getHintBackgroundDrawList() : ImDrawList { return new ImDrawList( get_hint_background_draw_list() ); }
	public static function endGroupHint() : Void { }

	public static inline function getNodeBackgroundDrawList( nodeId: NodeId ) : ImDrawList { return new ImDrawList( get_node_background_draw_list( nodeId ) ); }

	public static function link( linkId: LinkId, startId: PinId, endId: PinId, color: ImVec4 = null, thickness: Single = 0 ) : Bool { return false; }
	public static function flow( linkId: LinkId, direction: FlowDirection = FlowDirection.Forward ): Void  { }

	// Create
	public static function beginCreate( color: ImVec4 = null, thickness: Single = 1.0 ) : Bool { return false; }
	public static function queryNewLink( startPinId: hl.Ref<PinId>, endPinId: hl.Ref<PinId> ) : Bool { return false; }
	public static function queryNewLink2( startPinId: hl.Ref<PinId>, endPinId: hl.Ref<PinId>, color: ImVec4, thickness: Single = 1.0 ) : Bool { return false; }
	public static function queryNewNode( startNodeId: hl.Ref<NodeId> ) : Bool { return false; }
	public static function queryNewNode2( startNodeId: hl.Ref<NodeId>, color: ImVec4, thickness: Single = 1.0 ) : Bool { return false; }
	public static function acceptNewItem() : Bool { return false; }
	public static function acceptNewItem2( color: ImVec4 = null , thickness: Single = 1.0 ) : Bool { return false; }
	public static function rejectNewItem() : Bool { return false; }
	public static function rejectNewItem2( color: ImVec4 = null , thickness: Single = 1.0 ) : Bool { return false; }
	public static function endCreate() : Void { }

	// Delete
	public static function beginDelete() : Bool { return false; }
	public static function queryDeletedLink( linkId: hl.Ref<LinkId>, startId: hl.Ref<PinId>, endId:  hl.Ref<PinId>) : Bool { return false; }
	public static function queryDeletedNode( nodeID: hl.Ref<NodeId>) : Bool { return false; }
	public static function acceptDeletedItem( deleteDependencies: Bool = true ) : Bool { return false; }
	public static function rejectDeletedItem() : Void {}
	public static function endDelete() : Void {}

	// Status
	public static function setNodePosition( nodeId: NodeId, position: ImVec2 ) : Void {}
	public static function getNodePosition( nodeId: NodeId ) : ImVec2 { return null; }
	public static function getNodeSize( nodeId: NodeId ) : ImVec2 { return null; }
	public static function setGroupSize( nodeId: NodeId, size: ImVec2 ) : Void {}
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
	public static function getScreenSize( ) : ImVec2 { return null; }
	public static function screenToCanvas( pos: ImVec2 ) : ImVec2 { return null; }
	public static function canvasToScreen( pos: ImVec2 ) : ImVec2 { return null; }
	//
	public static function getNodeCount( ) : Int { return 0; }


	// Internal
	static function get_hint_foreground_draw_list() : ImDrawListPtr { return null; }
	static function get_hint_background_draw_list() : ImDrawListPtr { return null; }
	static function get_node_background_draw_list( nodeId: NodeId ) : ImDrawListPtr { return null; }


}

#end