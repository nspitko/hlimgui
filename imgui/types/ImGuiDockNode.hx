package imgui.types;

import hl.Bytes;
import imgui.types.Pointers;
import imgui.ImGui;

enum abstract ImGuiDockNodeState(Int) from Int to Int {
  var Unknown;
  var HostWindowHiddenBecauseSingleWindow;
  var HostWindowHiddenBecauseWindowsAreResizing;
  var HostWindowVisible;
}

@:keep
@:build(imgui._ImGuiInternalMacro.buildFlatStruct())
@:struct class ImGuiDockNode {
  
  var ID: ImGuiID;
  var SharedFlags: ImGuiDockNodeFlags;                // (Write) Flags shared by all nodes of a same dockspace hierarchy (inherited from the root node)
  var LocalFlags: ImGuiDockNodeFlags;                 // (Write) Flags specific to this node
  var LocalFlagsInWindows: ImGuiDockNodeFlags;        // (Write) Flags specific to this node, applied from windows
  var MergedFlags: ImGuiDockNodeFlags;                // (Read)  Effective flags (== SharedFlags | LocalFlagsInNode | LocalFlagsInWindows)
  var State: ImGuiDockNodeState;
  var ParentNode: ImGuiDockNode;
  var ChildNodesLeft: ImGuiDockNode;              // [Split node only] Child nodes (left/right or top/bottom). Consider switching to an array.
  var ChildNodesRight: ImGuiDockNode;              // [Split node only] Child nodes (left/right or top/bottom). Consider switching to an array.
  @:flatten var Windows: imgui.types.ImVector; // ImVector<ImGuiWindow*>// Note: unordered list! Iterate TabBar->Tabs for user-order.
  var TabBar: ImGuiTabBar; // ImGuiTabBar*
  @:flatten var Pos: ImVec2S;                        // Current position
  @:flatten var Size: ImVec2S;                       // Current size
  @:flatten var SizeRef: ImVec2S;                    // [Split node only] Last explicitly written-to size (overridden when using a splitter affecting the node), used to calculate Size.
  // ImGuiAxis               SplitAxis;                  // [Split node only] Split axis (X or Y)
  // ImGuiWindowClass        WindowClass;                // [Root node only]
  // ImU32                   LastBgColor;

//     ImGuiWindow*            HostWindow;
//     ImGuiWindow*            VisibleWindow;              // Generally point to window which is ID is == SelectedTabID, but when CTRL+Tabbing this can be a different window.
//     ImGuiDockNode*          CentralNode;                // [Root node only] Pointer to central node.
//     ImGuiDockNode*          OnlyNodeWithWindows;        // [Root node only] Set when there is a single visible node within the hierarchy.
//     int                     CountNodeWithWindows;       // [Root node only]
//     int                     LastFrameAlive;             // Last frame number the node was updated or kept alive explicitly with DockSpace() + ImGuiDockNodeFlags_KeepAliveOnly
//     int                     LastFrameActive;            // Last frame number the node was updated.
//     int                     LastFrameFocused;           // Last frame number the node was focused.
//     ImGuiID                 LastFocusedNodeId;          // [Root node only] Which of our child docking node (any ancestor in the hierarchy) was last focused.
//     ImGuiID                 SelectedTabId;              // [Leaf node only] Which of our tab/window is selected.
//     ImGuiID                 WantCloseTabId;             // [Leaf node only] Set when closing a specific tab/window.
//     ImGuiDataAuthority      AuthorityForPos         :3;
//     ImGuiDataAuthority      AuthorityForSize        :3;
//     ImGuiDataAuthority      AuthorityForViewport    :3;
//     bool                    IsVisible               :1; // Set to false when the node is hidden (usually disabled as it has no active window)
//     bool                    IsFocused               :1;
//     bool                    IsBgDrawnThisFrame      :1;
//     bool                    HasCloseButton          :1; // Provide space for a close button (if any of the docked window has one). Note that button may be hidden on window without one.
//     bool                    HasWindowMenuButton     :1;
//     bool                    HasCentralNodeChild     :1;
//     bool                    WantCloseAll            :1; // Set when closing all tabs at once.
//     bool                    WantLockSizeOnce        :1;
//     bool                    WantMouseMove           :1; // After a node extraction we need to transition toward moving the newly created host window
//     bool                    WantHiddenTabBarUpdate  :1;
//     bool                    WantHiddenTabBarToggle  :1;

//     ImGuiDockNode(ImGuiID id);
//     ~ImGuiDockNode();
//     bool                    IsRootNode() const      { return ParentNode == NULL; }
//     bool                    IsDockSpace() const     { return (MergedFlags & ImGuiDockNodeFlags_DockSpace) != 0; }
//     bool                    IsFloatingNode() const  { return ParentNode == NULL && (MergedFlags & ImGuiDockNodeFlags_DockSpace) == 0; }
//     bool                    IsCentralNode() const   { return (MergedFlags & ImGuiDockNodeFlags_CentralNode) != 0; }
//     bool                    IsHiddenTabBar() const  { return (MergedFlags & ImGuiDockNodeFlags_HiddenTabBar) != 0; } // Hidden tab bar can be shown back by clicking the small triangle
//     bool                    IsNoTabBar() const      { return (MergedFlags & ImGuiDockNodeFlags_NoTabBar) != 0; }     // Never show a tab bar
//     bool                    IsSplitNode() const     { return ChildNodes[0] != NULL; }
//     bool                    IsLeafNode() const      { return ChildNodes[0] == NULL; }
//     bool                    IsEmpty() const         { return ChildNodes[0] == NULL && Windows.Size == 0; }
//     ImRect                  Rect() const            { return ImRect(Pos.x, Pos.y, Pos.x + Size.x, Pos.y + Size.y); }

//     void                    SetLocalFlags(ImGuiDockNodeFlags flags) { LocalFlags = flags; UpdateMergedFlags(); }
//     void                    UpdateMergedFlags()     { MergedFlags = SharedFlags | LocalFlags | LocalFlagsInWindows; }
  
}