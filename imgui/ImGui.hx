package imgui;

import imgui.types.Renderer;
import imgui.ImGuiUtils;
import imgui.types.ImFontAtlas;
import imgui.types.Pointers;
import haxe.io.Bytes;

// Compared to hl.Ref - FieldRef allows referencing instance and static fields without local variable crutching.
// Cannasse pls add $fieldref
typedef Ref<T> = imgui.FieldRef<T>;

enum abstract ImGuiWindowFlags(Int) from Int to Int {
	var None : Int = 0;
	var NoTitleBar : Int = 1;
	var NoResize : Int = 2;
	var NoMove : Int = 4;
	var NoScrollbar : Int = 8;
	var NoScrollWithMouse : Int = 16;
	var NoCollapse : Int = 32;
	var AlwaysAutoResize : Int = 64;
	var NoBackground : Int = 128;
	var NoSavedSettings : Int = 256;
	var NoMouseInputs : Int = 512;
	var MenuBar : Int = 1024;
	var HorizontalScrollbar : Int = 2048;
	var NoFocusOnAppearing : Int = 4096;
	var NoBringToFrontOnFocus : Int = 8192;
	var AlwaysVerticalScrollbar : Int = 16384;
	var AlwaysHorizontalScrollbar : Int = 32768;
	var AlwaysUseWindowPadding : Int = 65536;
	var NoNavInputs : Int = 262144;
	var NoNavFocus : Int = 524288;
	var UnsavedDocument : Int = 1048576;
	var NoDocking : Int = 2097152;
	var NoNav : Int = 786432;
	var NoDecoration : Int = 43;
	var NoInputs : Int = 786944;

	@:noCompletion var ChildWindow: Int = 16777216;
	@:noCompletion var Tooltip: Int = 33554432;
}

enum abstract ImGuiDockNodeFlags(Int) from Int to Int {
	var None : Int = 0;
	var KeepAliveOnly : Int = 1;
	var NoCentralNode : Int = 2;
	var NoDockingInCentralNode : Int = 4;
	var PassthruCentralNode : Int = 8;
	var NoSplit : Int = 16;
	var NoResize : Int = 32;
	var AutoHideTabBar : Int = 64;
	// Private/experimental flags
	var NoDocking : Int = 65536;
	var NoDockingSplitMe : Int = 131072;
}

enum abstract ImGuiTreeNodeFlags(Int) from Int to Int {
	var None : Int = 0;
	var Selected : Int = 1;
	var Framed : Int = 2;
	var AllowItemOverlap : Int = 4;
	var NoTreePushOnOpen : Int = 8;
	var NoAutoOpenOnLog : Int = 16;
	var DefaultOpen : Int = 32;
	var OpenOnDoubleClick : Int = 64;
	var OpenOnArrow : Int = 128;
	var Leaf : Int = 256;
	var Bullet : Int = 512;
	var FramePadding : Int = 1024;
	var SpanAvailWidth : Int = 2048;
	var SpanFullWidth : Int = 4096;
	var NavLeftJumpsBackHere : Int = 8192;
	var CollapsingHeader : Int = 26;
}

enum abstract ImGuiTabItemFlags(Int) from Int to Int {
	var None : Int = 0;
	var UnsavedDocument : Int = 1;
	var SetSelected : Int = 2;
	var NoCloseWithMiddleMouseButton : Int = 4;
	var NoPushId : Int = 8;
}

enum abstract ImGuiTabBarFlags(Int) from Int to Int {
	var None : Int = 0;
	var Reorderable : Int = 1;
	var AutoSelectNewTabs : Int = 2;
	var TabListPopupButton : Int = 4;
	var NoCloseWithMiddleMouseButton : Int = 8;
	var NoTabListScrollingButtons : Int = 16;
	var NoTooltip : Int = 32;
	var FittingPolicyResizeDown : Int = 64;
	var FittingPolicyScroll : Int = 128;
	var FittingPolicyMask_ : Int = 192;
	var FittingPolicyDefault_ : Int = 64;
}

enum abstract ImGuiStyleVar(Int) from Int to Int {
	/** float: use pushStyleVar() **/
	var Alpha = 0;
	/** float: use pushStyleVar() **/
	var DisabledAlpha;
	/** ImVec2: use pushStyleVar2() **/
	var WindowPadding;
	/** float: use pushStyleVar() **/
	var WindowRounding;
	/** float: use pushStyleVar() **/
	var WindowBorderSize;
	/** ImVec2: use pushStyleVar2() **/
	var WindowMinSize;
	/** ImVec2: use pushStyleVar2() **/
	var WindowTitleAlign;
	/** float: use pushStyleVar() **/
	var ChildRounding;
	/** float: use pushStyleVar() **/
	var ChildBorderSize;
	/** float: use pushStyleVar() **/
	var PopupRounding;
	/** float: use pushStyleVar() **/
	var PopupBorderSize;
	/** ImVec2: use pushStyleVar2() **/
	var FramePadding;
	/** float: use pushStyleVar() **/
	var FrameRounding;
	/** float: use pushStyleVar() **/
	var FrameBorderSize;
	/** ImVec2: use pushStyleVar2() **/
	var ItemSpacing;
	/** ImVec2: use pushStyleVar2() **/
	var ItemInnerSpacing;
	/** float: use pushStyleVar() **/
	var IndentSpacing;
	/** ImVec2: use pushStyleVar2() **/
	var CellPadding;
	/** float: use pushStyleVar() **/
	var ScrollbarSize;
	/** float: use pushStyleVar() **/
	var ScrollbarRounding;
	/** float: use pushStyleVar() **/
	var GrabMinSize;
	/** float: use pushStyleVar() **/
	var GrabRounding;
	/** float: use pushStyleVar() **/
	var TabRounding;
	/** ImVec2: use pushStyleVar2() **/
	var ButtonTextAlign;
	/** ImVec2: use pushStyleVar2() **/
	var SelectableTextAlign;
	var COUNT;
}

enum abstract ImGuiPopupFlags(Int) from Int to Int {
	final None                    = 0;
	final MouseButtonLeft         = 0;        // For BeginPopupContext*(): open on Left Mouse release. Guaranteed to always be == 0 (same as ImGuiMouseButton_Left)
	final MouseButtonRight        = 1;        // For BeginPopupContext*(): open on Right Mouse release. Guaranteed to always be == 1 (same as ImGuiMouseButton_Right)
	final MouseButtonMiddle       = 2;        // For BeginPopupContext*(): open on Middle Mouse release. Guaranteed to always be == 2 (same as ImGuiMouseButton_Middle)
	final MouseButtonMask_        = 0x1F;
	final MouseButtonDefault_     = 1;
	final NoOpenOverExistingPopup = 1 << 5;   // For OpenPopup*(), BeginPopupContext*(): don't open if there's already a popup at the same level of the popup stack
	final NoOpenOverItems         = 1 << 6;   // For BeginPopupContextWindow(): don't return true when hovering items, only when hovering empty space
	final AnyPopupId              = 1 << 7;   // For IsPopupOpen(): ignore the ImGuiID parameter and test for any popup.
	final AnyPopupLevel           = 1 << 8;   // For IsPopupOpen(): search/test at any level of the popup stack (default test in the current level)
	final AnyPopup                = AnyPopupId | AnyPopupLevel;
}

enum abstract ImGuiSelectableFlags(Int) from Int to Int {
	var None : Int = 0;
	var DontClosePopups : Int = 1;
	var SpanAllColumns : Int = 2;
	var AllowDoubleClick : Int = 4;
	var Disabled : Int = 8;
	var AllowItemOverlap : Int = 16;
}

enum abstract ImGuiNavInput(Int) from Int to Int {
	var Activate : Int = 0;
	var Cancel : Int = 1;
	var Input : Int = 2;
	var Menu : Int = 3;
	var DpadLeft : Int = 4;
	var DpadRight : Int = 5;
	var DpadUp : Int = 6;
	var DpadDown : Int = 7;
	var LStickLeft : Int = 8;
	var LStickRight : Int = 9;
	var LStickUp : Int = 10;
	var LStickDown : Int = 11;
	var FocusPrev : Int = 12;
	var FocusNext : Int = 13;
	var TweakSlow : Int = 14;
	var TweakFast : Int = 15;
	var KeyMenu_ : Int = 16;
	var KeyLeft_ : Int = 17;
	var KeyRight_ : Int = 18;
	var KeyUp_ : Int = 19;
	var KeyDown_ : Int = 20;
	var COUNT : Int = 21;
	var InternalStart_ : Int = 16;
}

enum abstract ImGuiMouseCursor(Int) from Int to Int {
	var None : Int = -1;
	var Arrow : Int = 0;
	var TextInput : Int = 1;
	var ResizeAll : Int = 2;
	var ResizeNS : Int = 3;
	var ResizeEW : Int = 4;
	var ResizeNESW : Int = 5;
	var ResizeNWSE : Int = 6;
	var Hand : Int = 7;
	var NotAllowed : Int = 8;
	var COUNT : Int = 9;
}

enum abstract ImGuiMouseButton(Int) from Int to Int {
	var Left : Int = 0;
	var Right : Int = 1;
	var Middle : Int = 2;
	var COUNT : Int = 5;
}

enum abstract ImGuiKey(Int) from Int to Int {
	var Tab : Int = 512;
	var LeftArrow : Int = 513;
	var RightArrow : Int = 514;
	var UpArrow : Int = 515;
	var DownArrow : Int = 516;
	var PageUp : Int = 517;
	var PageDown : Int = 518;
	var Home : Int = 519;
	var End : Int = 520;
	var Insert : Int = 521;
	var Delete : Int = 522;
	var Backspace : Int = 523;
	var Space : Int = 524;
	var Enter : Int = 525;
	var Escape : Int = 526;
	var LeftCtrl : Int = 527;
	var LeftShift : Int = 528;
	var LeftAlt : Int = 529;
	var LeftSuper : Int = 530;
	var RightCtrl : Int = 531;
	var RightShift : Int = 532;
	var RightAlt : Int = 533;
	var RightSuper : Int = 534;
	var F1 : Int = 572;
	var F2 : Int = 573;
	var F3 : Int = 574;
	var F4 : Int = 575;
	var F5 : Int = 576;
	var F6 : Int = 577;
	var F7 : Int = 578;
	var F8 : Int = 579;
	var F9 : Int = 580;
	var F10 : Int = 581;
	var F11 : Int = 582;
	var F12 : Int = 583;
	//
	var A: Int = 546;
	//
	var KeyPadEnter : Int = 615;
	//
	// Aliases: Mouse Buttons (auto-submitted from AddMouseButtonEvent() calls)
    // - This is mirroring the data also written to io.MouseDown[], io.MouseWheel, in a format allowing them to be accessed via standard key API.
	var MouseLeft: Int = 641;
	var MouseRight;
	var MouseMiddle;
	var MouseX1;
	var MouseX2;
	var MouseWheelX;
	var MouseWheelY;
	//
	var ModCtrl : Int = 1 << 12;
	var ModShift : Int = 1 << 13;
	var ModAlt : Int = 1 << 14;
	var ModSuper : Int = 1 << 15;
}

class ImGuiKeyStringExtender {
	static inline public function imKey(s:String): Int {
		var v = 546 + (s.charCodeAt(0) - 'A'.code);
		return v;
	}
}


enum abstract ImGuiInputTextFlags(Int) from Int to Int {
	var None : Int = 0;
	var CharsDecimal : Int = 1;
	var CharsHexadecimal : Int = 2;
	var CharsUppercase : Int = 4;
	var CharsNoBlank : Int = 8;
	var AutoSelectAll : Int = 16;
	var EnterReturnsTrue : Int = 32;
	var CallbackCompletion : Int = 64;
	var CallbackHistory : Int = 128;
	var CallbackAlways : Int = 256;
	var CallbackCharFilter : Int = 512;
	var AllowTabInput : Int = 1024;
	var CtrlEnterForNewLine : Int = 2048;
	var NoHorizontalScroll : Int = 4096;
	var AlwaysInsertMode : Int = 8192;
	var ReadOnly : Int = 16384;
	var Password : Int = 32768;
	var NoUndoRedo : Int = 65536;
	var CharsScientific : Int = 131072;
	var CallbackResize : Int = 262144;
	var Multiline : Int = 1048576;
	var NoMarkEdited : Int = 2097152;
}

enum abstract ImGuiHoveredFlags(Int) from Int to Int {
	var None                          = 0;        // Return true if directly over the item/window; not obstructed by another window; not obstructed by an active popup or modal blocking inputs under them.
	var ChildWindows                  = 1 << 0;   // IsWindowHovered() only: Return true if any children of the window is hovered
	var RootWindow                    = 1 << 1;   // IsWindowHovered() only: Test from root window (top most parent of the current hierarchy)
	var AnyWindow                     = 1 << 2;   // IsWindowHovered() only: Return true if any window is hovered
	var NoPopupHierarchy              = 1 << 3;   // IsWindowHovered() only: Do not consider popup hierarchy (do not treat popup emitter as parent of popup) (when used with _ChildWindows or _RootWindow)
	var DockHierarchy                 = 1 << 4;   // IsWindowHovered() only: Consider docking hierarchy (treat dockspace host as parent of docked window) (when used with _ChildWindows or _RootWindow)
	var AllowWhenBlockedByPopup       = 1 << 5;   // Return true even if a popup window is normally blocking access to this item/window
	//var AllowWhenBlockedByModal     = 1 << 6;   // Return true even if a modal popup window is normally blocking access to this item/window. FIXME-TODO: Unavailable yet.
	var AllowWhenBlockedByActiveItem  = 1 << 7;   // Return true even if an active item is blocking access to this item/window. Useful for Drag and Drop patterns.
	var AllowWhenOverlapped           = 1 << 8;   // IsItemHovered() only: Return true even if the position is obstructed or overlapped by another window
	var AllowWhenDisabled             = 1 << 9;   // IsItemHovered() only: Return true even if the item is disabled
	var NoNavOverride                 = 1 << 10;  // Disable using gamepad/keyboard navigation state when active; always query mouse.
	var RectOnly                      = AllowWhenBlockedByPopup | AllowWhenBlockedByActiveItem | AllowWhenOverlapped;
	var RootAndChildWindows           = RootWindow | ChildWindows;
}

enum abstract ImGuiFocusedFlags(Int) from Int to Int {
	var None : Int = 0;
	var ChildWindows : Int = 1;
	var RootWindow : Int = 2;
	var AnyWindow : Int = 4;
	var RootAndChildWindows : Int = 3;
	var DockHierarchy : Int = 4;
}

enum abstract ImGuiDragDropFlags(Int) from Int to Int {
	var None : Int = 0;
	var SourceNoPreviewTooltip : Int = 1;
	var SourceNoDisableHover : Int = 2;
	var SourceNoHoldToOpenOthers : Int = 4;
	var SourceAllowNullID : Int = 8;
	var SourceExtern : Int = 16;
	var SourceAutoExpirePayload : Int = 32;
	var AcceptBeforeDelivery : Int = 1024;
	var AcceptNoDrawDefaultRect : Int = 2048;
	var AcceptNoPreviewTooltip : Int = 4096;
	var AcceptPeekOnly : Int = 3072;
}

enum abstract ImGuiDir(Int) from Int to Int {
	var None : Int = -1;
	var Left : Int = 0;
	var Right : Int = 1;
	var Up : Int = 2;
	var Down : Int = 3;
	var COUNT : Int = 4;
}

enum abstract ImGuiDataType(Int) from Int to Int {
	var S8 : Int = 0;
	var U8 : Int = 1;
	var S16 : Int = 2;
	var U16 : Int = 3;
	var S32 : Int = 4;
	var U32 : Int = 5;
	var S64 : Int = 6;
	var U64 : Int = 7;
	var Float : Int = 8;
	var Double : Int = 9;
	var COUNT : Int = 10;
}
abstract ImGuiScalar(Dynamic) from Int from hl.UI8 from hl.UI16 from Single from Float from hl.I64 {}

enum abstract ImGuiConfigFlags(Int) from Int to Int {
    var None                   = 0;
    var NavEnableKeyboard      = 1 << 0;   // Master keyboard navigation enable flag. NewFrame() will automatically fill io.NavInputs[] based on io.AddKeyEvent() calls
    var NavEnableGamepad       = 1 << 1;   // Master gamepad navigation enable flag. This is mostly to instruct your imgui backend to fill io.NavInputs[]. Backend also needs to set ImGuiBackendFlags_HasGamepad.
    var NavEnableSetMousePos   = 1 << 2;   // Instruct navigation to move the mouse cursor. May be useful on TV/console systems where moving a virtual mouse is awkward. Will update io.MousePos and set io.WantSetMousePos=true. If enabled you MUST honor io.WantSetMousePos requests in your backend, otherwise ImGui will react as if the mouse is jumping around back and forth.
    var NavNoCaptureKeyboard   = 1 << 3;   // Instruct navigation to not set the io.WantCaptureKeyboard flag when io.NavActive is set.
    var NoMouse                = 1 << 4;   // Instruct imgui to clear mouse position/buttons in NewFrame(). This allows ignoring the mouse information set by the backend.
    var NoMouseCursorChange    = 1 << 5;   // Instruct backend to not alter mouse cursor shape and visibility. Use if the backend cursor changes are interfering with yours and you don't want to use SetMouseCursor() to change mouse cursor. You may want to honor requests from imgui by reading GetMouseCursor() yourself instead.

    // [BETA] Docking
    var DockingEnable          = 1 << 6;   // Docking enable flags.

    // [BETA] Viewports
    // When using viewports it is recommended that your default value for ImGuiCol_WindowBg is opaque (Alpha=1.0) so transition to a viewport won't be noticeable.
    var ViewportsEnable        = 1 << 10;  // Viewport enable flags (require both ImGuiBackendFlags_PlatformHasViewports + ImGuiBackendFlags_RendererHasViewports set by the respective backends)
    var DpiEnableScaleViewports= 1 << 14;  // [BETA: Don't use] FIXME-DPI: Reposition and resize imgui windows when the DpiScale of a viewport changed (mostly useful for the main viewport hosting other window). Note that resizing the main window itself is up to your application.
    var DpiEnableScaleFonts    = 1 << 15;  // [BETA: Don't use] FIXME-DPI: Request bitmap-scaled fonts to match DpiScale. This is a very low-quality workaround. The correct way to handle DPI is _currently_ to replace the atlas and/or fonts in the Platform_OnChangedViewport callback, but this is all early work in progress.

    // User storage (to allow your backend/engine to communicate to code that may be shared between multiple projects. Those flags are not used by core Dear ImGui)
    var IsSRGB                 = 1 << 20;  // Application is SRGB-aware.
    var IsTouchScreen          = 1 << 21;   // Application is using a touch screen instead of a mouse.
}

enum abstract ImGuiCond(Int) from Int to Int {
	var Always : Int = 1;
	var Once : Int = 2;
	var FirstUseEver : Int = 4;
	var Appearing : Int = 8;
}

enum abstract ImGuiComboFlags(Int) from Int to Int {
	var None : Int = 0;
	var PopupAlignLeft : Int = 1;
	var HeightSmall : Int = 2;
	var HeightRegular : Int = 4;
	var HeightLarge : Int = 8;
	var HeightLargest : Int = 16;
	var NoArrowButton : Int = 32;
	var NoPreview : Int = 64;
	var HeightMask_ : Int = 30;
}

enum abstract ImGuiColorEditFlags(Int) from Int to Int {
	var None : Int = 0;
	var NoAlpha : Int = 2;
	var NoPicker : Int = 4;
	var NoOptions : Int = 8;
	var NoSmallPreview : Int = 16;
	var NoInputs : Int = 32;
	var NoTooltip : Int = 64;
	var NoLabel : Int = 128;
	var NoSidePreview : Int = 256;
	var NoDragDrop : Int = 512;
	var AlphaBar : Int = 65536;
	var AlphaPreview : Int = 131072;
	var AlphaPreviewHalf : Int = 262144;
	var HDR : Int = 524288;
	var DisplayRGB : Int = 1048576;
	var DisplayHSV : Int = 2097152;
	var DisplayHex : Int = 4194304;
	var Uint8 : Int = 8388608;
	var Float : Int = 16777216;
	var PickerHueBar : Int = 33554432;
	var PickerHueWheel : Int = 67108864;
	var InputRGB : Int = 134217728;
	var InputHSV : Int = 268435456;
	var _OptionsDefault : Int = 177209344;
	var _DisplayMask : Int = 7340032;
	var _DataTypeMask : Int = 25165824;
	var _PickerMask : Int = 100663296;
	var _InputMask : Int = 402653184;
}

enum abstract ImGuiCol(Int) from Int to Int {
	var Text = 0;
	var TextDisabled;
	var WindowBg;
	var ChildBg;
	var PopupBg;
	var Border;
	var BorderShadow;
	var FrameBg;
	var FrameBgHovered;
	var FrameBgActive;
	var TitleBg;
	var TitleBgActive;
	var TitleBgCollapsed;
	var MenuBarBg;
	var ScrollbarBg;
	var ScrollbarGrab;
	var ScrollbarGrabHovered;
	var ScrollbarGrabActive;
	var CheckMark;
	var SliderGrab;
	var SliderGrabActive;
	var Button;
	var ButtonHovered;
	var ButtonActive;
	var Header;
	var HeaderHovered;
	var HeaderActive;
	var Separator;
	var SeparatorHovered;
	var SeparatorActive;
	var ResizeGrip;
	var ResizeGripHovered;
	var ResizeGripActive;
	var Tab;
	var TabHovered;
	var TabActive;
	var TabUnfocused;
	var TabUnfocusedActive;
	var DockingPreview;
	var DockingEmptyBg;
	var PlotLines;
	var PlotLinesHovered;
	var PlotHistogram;
	var PlotHistogramHovered;
	var TableHeaderBg;
	var TableBorderStrong;
	var TableBorderLight;
	var TableRowBg;
	var TableRowBgAlt;
	var TextSelectedBg;
	var DragDropTarget;
	var NavHighlight;
	var NavWindowingHighlight;
	var NavWindowingDimBg;
	var ModalWindowDimBg;
	var COUNT;
}

enum abstract ImGuiBackendFlags(Int) from Int to Int {
	var None : Int = 0;
	var HasGamepad : Int = 1;
	var HasMouseCursors : Int = 2;
	var HasSetMousePos : Int = 4;
	var RendererHasVtxOffset : Int = 8;

	    // [BETA] Viewports
	var PlatformHasViewports  = 1 << 10;  // Backend Platform supports multiple viewports.
	var HasMouseHoveredViewport=1 << 11;  // Backend Platform supports calling io.AddMouseViewportEvent() with the viewport under the mouse. IF POSSIBLE, ignore viewports with the ImGuiViewportFlags_NoInputs flag (Win32 backend, GLFW 3.30+ backend can do this, SDL backend cannot). If this cannot be done, Dear ImGui needs to use a flawed heuristic to find the viewport under.
	var RendererHasViewports  = 1 << 12;  // Backend Renderer supports multiple viewports.
}

enum abstract ImFontAtlasFlags(Int) from Int to Int {
	var None : Int = 0;
	var NoPowerOfTwoHeight : Int = 1;
	var NoMouseCursors : Int = 2;
}

enum abstract ImDrawListFlags(Int) from Int to Int {
	var None : Int = 0;
	var AntiAliasedLines : Int = 1;
	var AntiAliasedFill : Int = 2;
	var AllowVtxOffset : Int = 4;
}

enum abstract ImGuiSliderFlags(Int) from Int to Int {
	var None : Int = 0;
	var AlwaysClamp : Int = 16; // Clamp value to min/max bounds when input manually with CTRL+Click. By default CTRL+Click allows going out of bounds.
	var Logarithmic : Int = 32; // Make the widget logarithmic (linear otherwise). Consider using ImGuiSliderFlags_NoRoundToFormat with this if using a format-string with small amount of digits.
	var NoRoundToFormat : Int = 64; // Disable rounding underlying value to match precision of the display format string (e.g. %.3f values are rounded to those 3 digits)
	var NoInput : Int = 128; // Disable CTRL+Click or Enter key allowing to input text directly into the widget
}

enum abstract ImGuiTableFlags(Int) from Int to Int {
	var None                       = 0;
    var Resizable                  = 1 << 0;   // Enable resizing columns.
    var Reorderable                = 1 << 1;   // Enable reordering columns in header row (need calling TableSetupColumn() + TableHeadersRow() to display headers)
    var Hideable                   = 1 << 2;   // Enable hiding/disabling columns in context menu.
    var Sortable                   = 1 << 3;   // Enable sorting. Call TableGetSortSpecs() to obtain sort specs. Also see var SortMulti and var SortTristate.
    var NoSavedSettings            = 1 << 4;   // Disable persisting columns order; width and sort settings in the .ini file.
    var ContextMenuInBody          = 1 << 5;   // Right-click on columns body/contents will display table context menu. By default it is available in TableHeadersRow().
    // Decorations
    var RowBg                      = 1 << 6;   // Set each RowBg color with ImGuiCol_TableRowBg or ImGuiCol_TableRowBgAlt (equivalent of calling TableSetBgColor with ImGuiTableBgFlags_RowBg0 on each row manually)
    var BordersInnerH              = 1 << 7;   // Draw horizontal borders between rows.
    var BordersOuterH              = 1 << 8;   // Draw horizontal borders at the top and bottom.
    var BordersInnerV              = 1 << 9;   // Draw vertical borders between columns.
    var BordersOuterV              = 1 << 10;  // Draw vertical borders on the left and right sides.
    var BordersH                   = BordersInnerH | BordersOuterH; // Draw horizontal borders.
    var BordersV                   = BordersInnerV | BordersOuterV; // Draw vertical borders.
    var BordersInner               = BordersInnerV | BordersInnerH; // Draw inner borders.
    var BordersOuter               = BordersOuterV | BordersOuterH; // Draw outer borders.
    var Borders                    = BordersInner | BordersOuter;   // Draw all borders.
    var NoBordersInBody            = 1 << 11;  // [ALPHA] Disable vertical borders in columns Body (borders will always appears in Headers). -> May move to style
    var NoBordersInBodyUntilResize = 1 << 12;  // [ALPHA] Disable vertical borders in columns Body until hovered for resize (borders will always appears in Headers). -> May move to style
    // Sizing Policy (read above for defaults)
    var SizingFixedFit             = 1 << 13;  // Columns default to _WidthFixed or _WidthAuto (if resizable or not resizable); matching contents width.
    var SizingFixedSame            = 2 << 13;  // Columns default to _WidthFixed or _WidthAuto (if resizable or not resizable); matching the maximum contents width of all columns. Implicitly enable var NoKeepColumnsVisible.
    var SizingStretchProp          = 3 << 13;  // Columns default to _WidthStretch with default weights proportional to each columns contents widths.
    var SizingStretchSame          = 4 << 13;  // Columns default to _WidthStretch with default weights all equal; unless overridden by TableSetupColumn().
    // Sizing Extra Options
    var NoHostExtendX              = 1 << 16;  // Make outer width auto-fit to columns; overriding outer_size.x value. Only available when ScrollX/ScrollY are disabled and Stretch columns are not used.
    var NoHostExtendY              = 1 << 17;  // Make outer height stop exactly at outer_size.y (prevent auto-extending table past the limit). Only available when ScrollX/ScrollY are disabled. Data below the limit will be clipped and not visible.
    var NoKeepColumnsVisible       = 1 << 18;  // Disable keeping column always minimally visible when ScrollX is off and table gets too small. Not recommended if columns are resizable.
    var PreciseWidths              = 1 << 19;  // Disable distributing remainder width to stretched columns (width allocation on a 100-wide table with 3 columns: Without this flag: 33;33;34. With this flag: 33;33;33). With larger number of columns; resizing will appear to be less smooth.
    // Clipping
    var NoClip                     = 1 << 20;  // Disable clipping rectangle for every individual columns (reduce draw command count; items will be able to overflow into other columns). Generally incompatible with TableSetupScrollFreeze().
    // Padding
    var PadOuterX                  = 1 << 21;  // Default if BordersOuterV is on. Enable outer-most padding. Generally desirable if you have headers.
    var NoPadOuterX                = 1 << 22;  // Default if BordersOuterV is off. Disable outer-most padding.
    var NoPadInnerX                = 1 << 23;  // Disable inner padding between columns (double inner padding if BordersOuterV is on; single inner padding if BordersOuterV is off).
    // Scrolling
    var ScrollX                    = 1 << 24;  // Enable horizontal scrolling. Require 'outer_size' parameter of BeginTable() to specify the container size. Changes default sizing policy. Because this create a child window; ScrollY is currently generally recommended when using ScrollX.
    var ScrollY                    = 1 << 25;  // Enable vertical scrolling. Require 'outer_size' parameter of BeginTable() to specify the container size.
    // Sorting
    var SortMulti                  = 1 << 26;  // Hold shift when clicking headers to sort on multiple column. TableGetSortSpecs() may return specs where (SpecsCount > 1).
    var SortTristate               = 1 << 27;  // Allow no sorting; disable default sorting. TableGetSortSpecs() may return specs where (SpecsCount == 0).
}

enum abstract ImGuiTableRowFlags(Int) from Int to Int {
    var None                         = 0;
    var Headers                      = 1 << 0;    // Identify header row (set default background color + width of its contents accounted differently for auto column width)
}

enum abstract ImGuiTableBgTarget(Int) from Int to Int {
    var None                         = 0;
    var RowBg0                       = 1;        // Set row background color 0 (generally used for background, automatically set when ImGuiTableFlags_RowBg is used)
    var RowBg1                       = 2;        // Set row background color 1 (generally used for selection marking)
    var CellBg                       = 3;        // Set cell background color (top-most color)
}

enum abstract ImGuiTableColumnFlags(Int) from Int to Int {
    // Input configuration flags
    var None                  = 0;
    var Disabled              = 1 << 0;   // Overriding/master disable flag: hide column; won't show in context menu (unlike calling TableSetColumnEnabled() which manipulates the user accessible state)
    var DefaultHide           = 1 << 1;   // Default as a hidden/disabled column.
    var DefaultSort           = 1 << 2;   // Default as a sorting column.
    var WidthStretch          = 1 << 3;   // Column will stretch. Preferable with horizontal scrolling disabled (default if table sizing policy is _SizingStretchSame or _SizingStretchProp).
    var WidthFixed            = 1 << 4;   // Column will not stretch. Preferable with horizontal scrolling enabled (default if table sizing policy is _SizingFixedFit and table is resizable).
    var NoResize              = 1 << 5;   // Disable manual resizing.
    var NoReorder             = 1 << 6;   // Disable manual reordering this column; this will also prevent other columns from crossing over this column.
    var NoHide                = 1 << 7;   // Disable ability to hide/disable this column.
    var NoClip                = 1 << 8;   // Disable clipping for this column (all NoClip columns will render in a same draw command).
    var NoSort                = 1 << 9;   // Disable ability to sort on this field (even if ImGuiTableFlags_Sortable is set on the table).
    var NoSortAscending       = 1 << 10;  // Disable ability to sort in the ascending direction.
    var NoSortDescending      = 1 << 11;  // Disable ability to sort in the descending direction.
    var NoHeaderLabel         = 1 << 12;  // TableHeadersRow() will not submit label for this column. Convenient for some small columns. Name will still appear in context menu.
    var NoHeaderWidth         = 1 << 13;  // Disable header text width contribution to automatic column width.
    var PreferSortAscending   = 1 << 14;  // Make the initial sort direction Ascending when first sorting on this column (default).
    var PreferSortDescending  = 1 << 15;  // Make the initial sort direction Descending when first sorting on this column.
    var IndentEnable          = 1 << 16;  // Use current Indent value when entering cell (default for column 0).
    var IndentDisable         = 1 << 17;  // Ignore current Indent value when entering cell (default for columns > 0). Indentation changes _within_ the cell will still be honored.

    // Output status flags; read-only via TableGetColumnFlags()
    var IsEnabled             = 1 << 24;  // Status: is enabled == not hidden by user/api (referred to as "Hide" in _DefaultHide and _NoHide) flags.
    var IsVisible             = 1 << 25;  // Status: is visible == is enabled AND not clipped by scrolling.
    var IsSorted              = 1 << 26;  // Status: is currently part of the sort specs
    var IsHovered             = 1 << 27;  // Status: is hovered by mouse

}

enum abstract ImGuiInputFlags(Int) from Int to Int {
	// Flags for IsKeyPressed(), IsMouseClicked(), Shortcut()
    var None                = 0;
    var Repeat              = 1 << 0;   // Return true on successive repeats. Default for legacy IsKeyPressed(). NOT Default for legacy IsMouseClicked(). MUST BE == 1.
    var RepeatRateDefault   = 1 << 1;   // Repeat rate: Regular (default)
    var RepeatRateNavMove   = 1 << 2;   // Repeat rate: Fast
    var RepeatRateNavTweak  = 1 << 3;   // Repeat rate: Faster
    var RepeatRateMask_     = RepeatRateDefault | RepeatRateNavMove | RepeatRateNavTweak;

    // Flags for SetItemKeyOwner()
    var CondHovered         = 1 << 4;   // Only set if item is hovered (default to both)
    var CondActive          = 1 << 5;   // Only set if item is active (default to both)
    var CondDefault_        = CondHovered | CondActive;
    var CondMask_           = CondHovered | CondActive;

    // Flags for SetKeyOwner(), SetItemKeyOwner()
    var LockThisFrame       = 1 << 6;   // Access to key data will require EXPLICIT owner ID (ImGuiKeyOwner_Any/0 will NOT accepted for polling). Cleared at end of frame. This is useful to make input-owner-aware code steal keys from non-input-owner-aware code.
    var LockUntilRelease    = 1 << 7;   // Access to key data will require EXPLICIT owner ID (ImGuiKeyOwner_Any/0 will NOT accepted for polling). Cleared when the key is released or at end of each frame if key is released. This is useful to make input-owner-aware code steal keys from non-input-owner-aware code.

    // Routing policies for Shortcut() + low-level SetShortcutRouting()
    // - The general idea is that several callers register interest in a shortcut, and only one owner gets it.
    // - When a policy (other than _RouteAlways) is set, Shortcut() will register itself with SetShortcutRouting(),
    //   allowing the system to decide where to route the input among other route-aware calls.
    // - Shortcut() uses RouteFocused by default: meaning that a simple Shortcut() poll
    //   will register a route and only succeed when parent window is in the focus stack and if no-one
    //   with a higher priority is claiming the shortcut.
    // - Using RouteAlways is roughly equivalent to doing e.g. IsKeyPressed(key) + testing mods.
    // - Priorities: GlobalHigh > Focused (when owner is active item) > Global > Focused (when focused window) > GlobalLow.
    // - Can select only 1 policy among all available.
    var RouteFocused        = 1 << 8;   // (Default) Register focused route: Accept inputs if window is in focus stack. Deep-most focused window takes inputs. ActiveId takes inputs over deep-most focused window.
    var RouteGlobalLow      = 1 << 9;   // Register route globally (lowest priority: unless a focused window or active item registered the route) -> recommended Global priority.
    var RouteGlobal         = 1 << 10;  // Register route globally (medium priority: unless an active item registered the route, e.g. CTRL+A registered by InputText).
    var RouteGlobalHigh     = 1 << 11;  // Register route globally (highest priority: unlikely you need to use that: will interfere with every active items)
    var RouteMask_          = RouteFocused | RouteGlobal | RouteGlobalLow | RouteGlobalHigh; // _Always not part of this!
    var RouteAlways         = 1 << 12;  // Do not register route, poll keys directly.
    var RouteUnlessBgFocused= 1 << 13;  // Global routes will not be applied if underlying background/void is focused (== no Dear ImGui windows are focused). Useful for overlay applications.
    var RouteExtraMask_     = RouteAlways | RouteUnlessBgFocused;

    // [Internal] Mask of which function support which flags
	var SupportedByIsKeyPressed     = Repeat | RepeatRateMask_;
    var SupportedByShortcut         = Repeat | RepeatRateMask_ | RouteMask_ | RouteExtraMask_;
    var SupportedBySetKeyOwner      = LockThisFrame | LockUntilRelease;
    var SupportedBySetItemKeyOwner  = SupportedBySetKeyOwner | CondMask_;
}

// Flags for ImDrawList functions
// (Legacy: bit 0 must always correspond to ImDrawFlags_Closed to be backward compatible with old API using a bool. Bits 1..3 must be unused)
enum abstract ImDrawFlags(Int) from Int to Int {
    var None                        = 0;
    var Closed                      = 1 << 0; // PathStroke(); AddPolyline(): specify that shape should be closed (Important: this is always == 1 for legacy reason)
    var RoundCornersTopLeft         = 1 << 4; // AddRect(); AddRectFilled(); PathRect(): enable rounding top-left corner only (when rounding > 0.0f; we default to all corners). Was 0x01.
    var RoundCornersTopRight        = 1 << 5; // AddRect(); AddRectFilled(); PathRect(): enable rounding top-right corner only (when rounding > 0.0f; we default to all corners). Was 0x02.
    var RoundCornersBottomLeft      = 1 << 6; // AddRect(); AddRectFilled(); PathRect(): enable rounding bottom-left corner only (when rounding > 0.0f; we default to all corners). Was 0x04.
    var RoundCornersBottomRight     = 1 << 7; // AddRect(); AddRectFilled(); PathRect(): enable rounding bottom-right corner only (when rounding > 0.0f; we default to all corners). Wax 0x08.
    var RoundCornersNone            = 1 << 8; // AddRect(); AddRectFilled(); PathRect(): disable rounding on all corners (when rounding > 0.0f). This is NOT zero; NOT an implicit flag!
    var RoundCornersTop             = RoundCornersTopLeft | RoundCornersTopRight;
    var RoundCornersBottom          = RoundCornersBottomLeft | RoundCornersBottomRight;
    var RoundCornersLeft            = RoundCornersBottomLeft | RoundCornersTopLeft;
    var RoundCornersRight           = RoundCornersBottomRight | RoundCornersTopRight;
    var RoundCornersAll             = RoundCornersTopLeft | RoundCornersTopRight | RoundCornersBottomLeft | RoundCornersBottomRight;
    var RoundCornersDefault_        = (1 << 4 | 1 << 5 | 1 << 6 | 1 << 7); // Default to ALL corners if none of the _RoundCornersXX flags are specified.
    var RoundCornersMask_           = RoundCornersAll | RoundCornersNone;
}

enum abstract ImGuiViewportFlags(Int) from Int to Int
{
   var None                     = 0;
   var IsPlatformWindow         = 1 << 0;   // Represent a Platform Window
   var IsPlatformMonitor        = 1 << 1;   // Represent a Platform Monitor (unused yet)
   var OwnedByApp               = 1 << 2;   // Platform Window: is created/managed by the application (rather than a dear imgui backend)
   var NoDecoration             = 1 << 3;   // Platform Window: Disable platform decorations: title bar, borders, etc. (generally set all windows, but if ImGuiConfigFlags_ViewportsDecoration is set we only set this on popups/tooltips)
   var NoTaskBarIcon            = 1 << 4;   // Platform Window: Disable platform task bar icon (generally set on popups/tooltips, or all windows if ImGuiConfigFlags_ViewportsNoTaskBarIcon is set)
   var NoFocusOnAppearing       = 1 << 5;   // Platform Window: Don't take focus when created.
   var NoFocusOnClick           = 1 << 6;   // Platform Window: Don't take focus when clicked on.
   var NoInputs                 = 1 << 7;   // Platform Window: Make mouse pass through so we can drag this window while peaking behind it.
   var NoRendererClear          = 1 << 8;   // Platform Window: Renderer doesn't need to clear the framebuffer ahead (because we will fill it entirely).
   var TopMost                  = 1 << 9;   // Platform Window: Display on top (for tooltips only).
   var Minimized                = 1 << 10;  // Platform Window: Window is minimized, can skip render. When minimized we tend to avoid using the viewport pos/size for clipping window or testing if they are contained in the viewport.
   var NoAutoMerge              = 1 << 11;  // Platform Window: Avoid merging this window into another host window. This can only be set via ImGuiWindowClass viewport flags override (because we need to now ahead if we are going to create a viewport in the first place!).
   var CanHostOtherWindows      = 1 << 12;  // Main viewport: can host multiple imgui windows (secondary viewports are associated to a single window).
}

typedef ImEvents = {
	dt : Single,
	mouse_x : Single,
	mouse_y : Single,
	wheel : Single,
	left_click : Bool,
	right_click : Bool,
	shift : Bool,
	ctrl : Bool,
	alt : Bool
}

// In reality it's h3d.mat.Texture, but HL really dislike passing instances
// directly for some reason.
#if heaps
abstract ImTextureID(Dynamic) from h3d.mat.Texture to h3d.mat.Texture {}
#else
typedef ImTextureID = Dynamic;
#end
typedef ImU32 = Int;
typedef ImGuiID = Int;

/** The raw memory ImVec2 **/
@:keep
@:structInit class ImVec2S {
	public var x: Single;
	public var y: Single;

	@:deprecated("Remainder of ExtDynamic")
	@:noCompletion public var v(get, never): ImVec2;
	inline function get_v() return this;
	@:deprecated("Remainder of ExtDynamic")
	@:noCompletion public inline function to(): ImVec2 return this;

	public inline function new(x: Single = 0.0, y: Single = 0.0) {
		this.x = x;
		this.y = y;
	}

	public inline function set(x: Single = 0, y: Single = 0): ImVec2
	{
		this.x = x;
		this.y = y;
		return this;
	}

	public static inline function get(x: Single = 0, y: Single = 0): ImVec2 { return { x: x, y: y }; };

	@:keep public function toString() {
		return '{ x: $x, y: $y }';
	}

	@:noCompletion public inline function addScalar(other: Single) { return get(x + other, y + other); }
	@:noCompletion public inline function subScalar(other: Single) { return get(x - other, y - other); }
	@:noCompletion public inline function mulScalar(other: Single) { return get(x * other, y * other); }
	@:noCompletion public inline function divScalar(other: Single) { return get(x / other, y / other); }
	@:noCompletion public inline function modScalar(other: Single) { return get(x % other, y % other); }

	@:noCompletion public inline function add(other: ImVec2S) { return get(x + other.x, y + other.y); }
	@:noCompletion public inline function sub(other: ImVec2S) { return get(x - other.x, y - other.y); }
	@:noCompletion public inline function mul(other: ImVec2S) { return get(x * other.x, y * other.y); }
	@:noCompletion public inline function div(other: ImVec2S) { return get(x / other.x, y / other.y); }
	@:noCompletion public inline function neg() { return get(-x, -y); }

	@:noCompletion public inline function addSelf(other: ImVec2S) { x += other.x; y += other.y; return this; }
	@:noCompletion public inline function subSelf(other: ImVec2S) { x -= other.x; y -= other.y; return this; }
	@:noCompletion public inline function mulSelf(other: ImVec2S) { x *= other.x; y *= other.y; return this; }
	@:noCompletion public inline function divSelf(other: ImVec2S) { x /= other.x; y /= other.y; return this; }
	@:noCompletion public inline function negSelf() { x = -x; y = -y; return this; }

	@:noCompletion public inline function addSelfScalar(other: Single) { x += other; y += other; return this; }
	@:noCompletion public inline function subSelfScalar(other: Single) { x -= other; y -= other; return this; }
	@:noCompletion public inline function mulSelfScalar(other: Single) { x *= other; y *= other; return this; }
	@:noCompletion public inline function divSelfScalar(other: Single) { x /= other; y /= other; return this; }
	@:noCompletion public inline function modSelfScalar(other: Single) { x %= other; y %= other; return this; }

	@:noCompletion public inline function compare(other: ImVec2S) { return x == other.x && y == other.y; }
}

/** The raw memory ImVec2 **/
@:keep
@:structInit class ImVec4S
{
	public var x: Single;
	public var y: Single;
	public var z: Single;
	public var w: Single;

	public inline function new(x: Single = 0.0, y: Single = 0.0, z: Single = 0.0, w: Single = 0.0) {
		this.x = x;
		this.y = y;
		this.z = z;
		this.w = w;
	}
	/** Alias to `x` **/
	public var r(get, set): Single;
	/** Alias to `y` **/
	public var g(get, set): Single;
	/** Alias to `z` **/
	public var b(get, set): Single;
	/** Alias to `w` **/
	public var a(get, set): Single;

	inline function get_r() return x;
	inline function set_r(v) return x = v;
	inline function get_g() return y;
	inline function set_g(v) return y = v;
	inline function get_b() return z;
	inline function set_b(v) return z = v;
	inline function get_a() return w;
	inline function set_a(v) return w = v;

	@:deprecated("Remainder of ExtDynamic")
	@:noCompletion public var v(get, never): ImVec4;
	inline function get_v() return this;
	@:deprecated("Remainder of ExtDynamic")
	@:noCompletion public inline function to(): ImVec4 return this;

	public inline function set(x: Single = 0, y: Single = 0, z: Single = 0, w: Single = 0): ImVec4
	{
		this.x = x;
		this.y = y;
		this.z = z;
		this.w = w;
		return this;
	}

	public inline function setColor(colWAlpha: Int): ImVec4
	{
		return set(((colWAlpha) & 0xff) / 0xff, ((colWAlpha >> 8) & 0xff) / 0xff, ((colWAlpha >> 16) & 0xff) / 0xff, ((colWAlpha >> 24) & 0xff) / 0xff);
	}

	public inline function setColorRGB(col: Int, alpha: Float = 1.0): ImVec4
	{
		return set(((col) & 0xff) / 0xff, ((col >> 8) & 0xff) / 0xff, ((col >> 16) & 0xff) / 0xff, alpha);
	}

	public static inline function get(x: Single = 0, y: Single = 0, z: Single = 0, w: Single = 0): ImVec4 { return { x: x, y: y, z: z, w: w }; }
	public static inline function getColor(colWAlpha: Int): ImVec4
	{
		return {
			x: ((colWAlpha >> 16) & 0xff) / 0xff,
			y: ((colWAlpha >> 8 ) & 0xff) / 0xff,
			z: ((colWAlpha      ) & 0xff) / 0xff,
			w: ((colWAlpha >> 24) & 0xff) / 0xff
		};
	}
	public static inline function getColorRGB(col: Int, alpha: Float = 1.0): ImVec4
	{
		return {
			x: ((col >> 16) & 0xff) / 0xff,
			y: ((col >> 8 ) & 0xff) / 0xff,
			z: ((col      ) & 0xff) / 0xff,
			w: alpha
		};
	}

	public inline function toColor():Int
	{
		return ((Std.int(z * 0xff) & 0xff)      ) +
		       ((Std.int(y * 0xff) & 0xff) << 8 ) +
		       ((Std.int(x * 0xff) & 0xff) << 16) +
		       ((Std.int(w * 0xff) & 0xff) << 24);
	}

	public function xy(): ImVec2 { return ImVec2S.get(x, y); }
	public function zw(): ImVec2 { return ImVec2S.get(z, w); }

	@:keep public function toString() {
		return '{ x: $x, y: $y, z: $z, w: $w }';
	}

	@:noCompletion public inline function addScalar(other: Single) { return get(x + other, y + other, z + other, w + other); }
	@:noCompletion public inline function subScalar(other: Single) { return get(x - other, y - other, z - other, w - other); }
	@:noCompletion public inline function mulScalar(other: Single) { return get(x * other, y * other, z * other, w * other); }
	@:noCompletion public inline function divScalar(other: Single) { return get(x / other, y / other, z / other, w / other); }
	@:noCompletion public inline function modScalar(other: Single) { return get(x % other, y % other, z % other, w % other); }

	@:noCompletion public inline function add(other: ImVec4S) { return get(x + other.x, y + other.y, z + other.z, w + other.w); }
	@:noCompletion public inline function sub(other: ImVec4S) { return get(x - other.x, y - other.y, z - other.z, w - other.w); }
	@:noCompletion public inline function mul(other: ImVec4S) { return get(x * other.x, y * other.y, z * other.z, w * other.w); }
	@:noCompletion public inline function div(other: ImVec4S) { return get(x / other.x, y / other.y, z / other.z, w / other.w); }
	@:noCompletion public inline function neg() { return get(-x, -y, -z, -w); }

	@:noCompletion public inline function addSelf(other: ImVec4S) { x += other.x; y += other.y; z += other.z; w += other.w; return this; }
	@:noCompletion public inline function subSelf(other: ImVec4S) { x -= other.x; y -= other.y; z -= other.z; w -= other.w; return this; }
	@:noCompletion public inline function mulSelf(other: ImVec4S) { x *= other.x; y *= other.y; z *= other.z; w *= other.w; return this; }
	@:noCompletion public inline function divSelf(other: ImVec4S) { x /= other.x; y /= other.y; z /= other.z; w /= other.w; return this; }
	@:noCompletion public inline function negSelf() { x = -x; y = -y; z = -z; w = -w; return this; }

	@:noCompletion public inline function addSelfScalar(other: Single) { x += other; y += other; z += other; w += other; return this; }
	@:noCompletion public inline function subSelfScalar(other: Single) { x -= other; y -= other; z -= other; w -= other; return this; }
	@:noCompletion public inline function mulSelfScalar(other: Single) { x *= other; y *= other; z *= other; w *= other; return this; }
	@:noCompletion public inline function divSelfScalar(other: Single) { x /= other; y /= other; z /= other; w /= other; return this; }
	@:noCompletion public inline function modSelfScalar(other: Single) { x %= other; y %= other; z %= other; w %= other; return this; }

	@:noCompletion public inline function compare(other: ImVec4S) { return other != null && x == other.x && y == other.y && z == other.z && w == other.w; }
}

@:forward
@:forwardStatics
@:structInit
abstract ImVec2(ImVec2S) from ImVec2S to ImVec2S {

	public inline function new(x: Single = 0.0, y: Single = 0.0) this = new ImVec2S(x, y);

	@:op(A + B) static inline function _add(a: ImVec2, b: ImVec2) return a.add(b);
	@:op(A - B) static inline function _sub(a: ImVec2, b: ImVec2) return a.sub(b);
	@:op(A * B) static inline function _mul(a: ImVec2, b: ImVec2) return a.mul(b);
	@:op(A / B) static inline function _div(a: ImVec2, b: ImVec2) return a.div(b);
	@:op(-A) static inline function _neg(a: ImVec2) return a.neg();

	@:op(A + B) static inline function _addScalar(a: ImVec2, b: Single) return a.addScalar(b);
	@:op(A - B) static inline function _subScalar(a: ImVec2, b: Single) return a.subScalar(b);
	@:op(A * B) static inline function _mulScalar(a: ImVec2, b: Single) return a.mulScalar(b);
	@:op(A / B) static inline function _divScalar(a: ImVec2, b: Single) return a.divScalar(b);
	@:op(A % B) static inline function _modScalar(a: ImVec2, b: Single) return a.modScalar(b);

	@:op(A += B) static inline function _addSelf(a: ImVec2, b: ImVec2) return a.addSelf(b);
	@:op(A -= B) static inline function _subSelf(a: ImVec2, b: ImVec2) return a.subSelf(b);
	@:op(A *= B) static inline function _mulSelf(a: ImVec2, b: ImVec2) return a.mulSelf(b);
	@:op(A /= B) static inline function _divSelf(a: ImVec2, b: ImVec2) return a.divSelf(b);

	@:op(A += B) static inline function _addSelfScalar(a: ImVec2, b: Single) return a.addSelfScalar(b);
	@:op(A -= B) static inline function _subSelfScalar(a: ImVec2, b: Single) return a.subSelfScalar(b);
	@:op(A *= B) static inline function _mulSelfScalar(a: ImVec2, b: Single) return a.mulSelfScalar(b);
	@:op(A /= B) static inline function _divSelfScalar(a: ImVec2, b: Single) return a.divSelfScalar(b);
	@:op(A %= B) static inline function _modSelfScalar(a: ImVec2, b: Single) return a.modSelfScalar(b);

	@:op(A == B) static inline function _compare(a: ImVec2, b: ImVec2) return a == null ? b == null : a.compare(b);
}
@:forward
@:forwardStatics
@:structInit
abstract ImVec4(ImVec4S) from ImVec4S to ImVec4S {

	public inline function new(x: Single = 0.0, y: Single = 0.0, z: Single = 0.0, w: Single = 0.0) this = new ImVec4S(x, y, z, w);

	@:op(A + B) static inline function _add(a: ImVec4, b: ImVec4) return a.add(b);
	@:op(A - B) static inline function _sub(a: ImVec4, b: ImVec4) return a.sub(b);
	@:op(A * B) static inline function _mul(a: ImVec4, b: ImVec4) return a.mul(b);
	@:op(A / B) static inline function _div(a: ImVec4, b: ImVec4) return a.div(b);
	@:op(-A) static inline function _neg(a: ImVec4) return a.neg();

	@:op(A + B) static inline function _addScalar(a: ImVec4, b: Single) return a.addScalar(b);
	@:op(A - B) static inline function _subScalar(a: ImVec4, b: Single) return a.subScalar(b);
	@:op(A * B) static inline function _mulScalar(a: ImVec4, b: Single) return a.mulScalar(b);
	@:op(A / B) static inline function _divScalar(a: ImVec4, b: Single) return a.divScalar(b);
	@:op(A % B) static inline function _modScalar(a: ImVec4, b: Single) return a.modScalar(b);

	@:op(A += B) static inline function _addSelf(a: ImVec4, b: ImVec4) return a.addSelf(b);
	@:op(A -= B) static inline function _subSelf(a: ImVec4, b: ImVec4) return a.subSelf(b);
	@:op(A *= B) static inline function _mulSelf(a: ImVec4, b: ImVec4) return a.mulSelf(b);
	@:op(A /= B) static inline function _divSelf(a: ImVec4, b: ImVec4) return a.divSelf(b);

	@:op(A += B) static inline function _addSelfScalar(a: ImVec4, b: Single) return a.addSelfScalar(b);
	@:op(A -= B) static inline function _subSelfScalar(a: ImVec4, b: Single) return a.subSelfScalar(b);
	@:op(A *= B) static inline function _mulSelfScalar(a: ImVec4, b: Single) return a.mulSelfScalar(b);
	@:op(A /= B) static inline function _divSelfScalar(a: ImVec4, b: Single) return a.divSelfScalar(b);
	@:op(A %= B) static inline function _modSelfScalar(a: ImVec4, b: Single) return a.modSelfScalar(b);

	@:op(A == B) static inline function _compare(a: ImVec4, b: ImVec4) return a == null ? b == null : a.compare(b);
}

@:keep
@:build(imgui._ImGuiInternalMacro.buildFlatStruct())
@:hlNative("hlimgui")
@:struct class ImGuiStyle {
	var Alpha: Single;                      // Global alpha applies to everything in Dear ImGui.
	var DisabledAlpha: Single;              // Additional alpha multiplier applied by BeginDisabled(). Multiply over current value of Alpha.
	@:flatten var WindowPadding: ImVec2S;              // Padding within a window.
	var WindowRounding: Single;             // Radius of window corners rounding. Set to 0.0f to have rectangular windows. Large values tend to lead to variety of artifacts and are not recommended.
	var WindowBorderSize: Single;           // Thickness of border around windows. Generally set to 0.0f or 1.0f. (Other values are not well tested and more CPU/GPU costly).
	@:flatten var WindowMinSize: ImVec2S;              // Minimum window size. This is a global setting. If you want to constraint individual windows, use SetNextWindowSizeConstraints().
	@:flatten var WindowTitleAlign: ImVec2S;           // Alignment for title bar text. Defaults to (0.0f,0.5f) for left-aligned,vertically centered.
	var WindowMenuButtonPosition: ImGuiDir;   // Side of the collapsing/docking button in the title bar (None/Left/Right). Defaults to ImGuiDir_Left.
	var ChildRounding: Single;              // Radius of child window corners rounding. Set to 0.0f to have rectangular windows.
	var ChildBorderSize: Single;            // Thickness of border around child windows. Generally set to 0.0f or 1.0f. (Other values are not well tested and more CPU/GPU costly).
	var PopupRounding: Single;              // Radius of popup window corners rounding. (Note that tooltip windows use WindowRounding)
	var PopupBorderSize: Single;            // Thickness of border around popup/tooltip windows. Generally set to 0.0f or 1.0f. (Other values are not well tested and more CPU/GPU costly).
	@:flatten var FramePadding: ImVec2S;               // Padding within a framed rectangle (used by most widgets).
	var FrameRounding: Single;              // Radius of frame corners rounding. Set to 0.0f to have rectangular frame (used by most widgets).
	var FrameBorderSize: Single;            // Thickness of border around frames. Generally set to 0.0f or 1.0f. (Other values are not well tested and more CPU/GPU costly).
	@:flatten var ItemSpacing: ImVec2S;                // Horizontal and vertical spacing between widgets/lines.
	@:flatten var ItemInnerSpacing: ImVec2S;           // Horizontal and vertical spacing between within elements of a composed widget (e.g. a slider and its label).
	@:flatten var CellPadding: ImVec2S;                // Padding within a table cell
	@:flatten var TouchExtraPadding: ImVec2S;          // Expand reactive bounding box for touch-based system where touch position is not accurate enough. Unfortunately we don't sort widgets so priority on overlap will always be given to the first widget. So don't grow this too much!
	var IndentSpacing: Single;              // Horizontal indentation when e.g. entering a tree node. Generally == (FontSize + FramePadding.x*2).
	var ColumnsMinSpacing: Single;          // Minimum horizontal spacing between two columns. Preferably > (FramePadding.x + 1).
	var ScrollbarSize: Single;              // Width of the vertical scrollbar, Height of the horizontal scrollbar.
	var ScrollbarRounding: Single;          // Radius of grab corners for scrollbar.
	var GrabMinSize: Single;                // Minimum width/height of a grab box for slider/scrollbar.
	var GrabRounding: Single;               // Radius of grabs corners rounding. Set to 0.0f to have rectangular slider grabs.
	var LogSliderDeadzone: Single;          // The size in pixels of the dead-zone around zero on logarithmic sliders that cross zero.
	var TabRounding: Single;                // Radius of upper corners of a tab. Set to 0.0f to have rectangular tabs.
	var TabBorderSize: Single;              // Thickness of border around tabs.
	var TabMinWidthForCloseButton: Single;  // Minimum width for close button to appears on an unselected tab when hovered. Set to 0.0f to always show when hovering, set to FLT_MAX to never show close button unless selected.
	var ColorButtonPosition: ImGuiDir;        // Side of the color button in the ColorEdit4 widget (left/right). Defaults to ImGuiDir_Right.
	@:flatten var ButtonTextAlign: ImVec2S;            // Alignment of button text when button is larger than text. Defaults to (0.5f, 0.5f) (centered).
	@:flatten var SelectableTextAlign: ImVec2S;        // Alignment of selectable text. Defaults to (0.0f, 0.0f) (top-left aligned). It's generally important to keep this left-aligned if you want to lay multiple items on a same line.
	var SeparatorTextBorderSize: Single;				// Alignment of button text when button is larger than text.
	@:flatten var SeparatorTextAlign: ImVec2S;// Alignment of text within the separator. Defaults to (0.0f, 0.5f) (left aligned, center).
    @:flatten var SeparatorTextPadding: ImVec2S;// Horizontal offset of text from each edge of the separator + spacing on other axis. Generally small values. .y is recommended to be == FramePadding.y.
	@:flatten var DisplayWindowPadding: ImVec2S;       // Window position are clamped to be visible within the display area or monitors by at least this amount. Only applies to regular windows.
	@:flatten var DisplaySafeAreaPadding: ImVec2S;     // If you cannot see the edges of your screen (e.g. on a TV) increase the safe area padding. Apply to popups/tooltips as well regular windows. NB: Prefer configuring your TV sets correctly!
	var MouseCursorScale: Single;           // Scale software rendered mouse cursor (when io.MouseDrawCursor is enabled). We apply per-monitor DPI scaling over this scale. May be removed later.
	var AntiAliasedLines: Bool;           // Enable anti-aliased lines/borders. Disable if you are really tight on CPU/GPU. Latched at the beginning of the frame (copied to ImDrawList).
	var AntiAliasedLinesUseTex: Bool;     // Enable anti-aliased lines/borders using textures where possible. Require backend to render with bilinear filtering. Latched at the beginning of the frame (copied to ImDrawList).
	var AntiAliasedFill: Bool;            // Enable anti-aliased edges around filled shapes (rounded rectangles, circles, etc.). Disable if you are really tight on CPU/GPU. Latched at the beginning of the frame (copied to ImDrawList).
	var CurveTessellationTol: Single;       // Tessellation tolerance when using PathBezierCurveTo() without a specific number of segments. Decrease for highly tessellated curves (higher quality, more polygons), increase to reduce quality.
	var CircleTessellationMaxError: Single; // Maximum error (in pixels) allowed when using AddCircle()/AddCircleFilled() or drawing rounded corner rectangles with no explicit segment count specified. Decrease for higher quality but more geometry.
	@:flattenMap(ImGuiCol) var Colors : ImVec4S;

	public function new() {
		// Match allocation via C: Set default values andn use default colors.
		init_style(this);
	}

	public function scaleAllSizes( scaleFactor: Single ) { style_scale_all_sizes(this, scaleFactor); }

	static function init_style(style: ImGuiStyle) {}
	static function style_scale_all_sizes(style: ImGuiStyle, scaleFactor: Single): Void {}
}

enum abstract ImGuiKeyChord(Int) from Int to Int {
	var None;
	var Ctrl = ImGuiKey.ModCtrl;
	var Shift = ImGuiKey.ModShift;
	var Alt = ImGuiKey.ModAlt;
	var Super = ImGuiKey.ModSuper;
}

@:keep
@:structInit class ImGuiKeyData
{
	public var Down: Bool;
	public var DownDuration: Single;
	public var DownDurationPrev: Single;
	public var AnalogValue: Single;
}


@:keep
@:build(imgui._ImGuiInternalMacro.buildFlatStruct())
@:hlNative("hlimgui")
@:struct class ImGuiIO {
	var ConfigFlags: ImGuiConfigFlags;
	var BackendFlags: ImGuiBackendFlags;
	@:flatten var DisplaySize: ImVec2S;
	var DeltaTime: Single;
	var IniSavingRate: Single;
	var IniFilemame: hl.Bytes;
	var LogFilename: hl.Bytes;
	var MouseDoubleClickTime: Single;
	var MouseDoubleClickMaxDist: Single;
	var MouseDragThreshold: Single;
	var KeyRepeatDelay: Single;
	var KeyRepeatRate: Single;
	var HoverDelayNormal: Single;
	var HoverDelayShort: Single;
	var UserData: hl.Bytes;

	var Fonts: ImFontAtlas;
	var FontGlobalScale: Single;
	var FontAllowUserScaling: Bool;
	var FontDefault: ImFont;
	@:flatten var DisplayFramebufferScale: ImVec2S;

	// Docking options (when ImGuiConfigFlags_DockingEnable is set)
	var ConfigDockingNoSplit: Bool;
	var ConfigDockingWithShift: Bool;
	var ConfigDockingAlwaysTabBar: Bool;
	var ConfigDockingTransparentPayload: Bool;

	// Viewport options (when ImGuiConfigFlags_ViewportsEnable is set; which it's not in hlimgui)
	var ConfigViewportNoAutoMerge: Bool;
	var ConfigViewportsNoTaskBarIcon: Bool;
	var ConfigViewportsNoDecoration: Bool;
	var ConfigViewportsNoDefaultParent: Bool;

	// Miscellaneous options
	var MouseDrawCursor: Bool;
	var ConfigMacOSXBehaviors: Bool;
	var ConfigInputTrickleEventQueue: Bool;
	var ConfigInputTextCursorBlink: Bool;
	var ConfigInputTextEnterKeepActive: Bool;
	var ConfigDragClickToInputText: Bool;
	var ConfigWindowsResizeFromEdges: Bool;
	var ConfigWindowsMoveFromTitleBarOnly: Bool;
	var ConfigMemoryCompactTimer: Single;

	//------------------------------------------------------------------
    // Platform Functions
    // (the imgui_impl_xxxx backend files are setting those up for you)
    //------------------------------------------------------------------
	var BackendPlatformName: hl.Bytes;
	var BackendRendererName: hl.Bytes;
	var BackendPlatformUserData: hl.Bytes;
	var BackendRendererUserData: hl.Bytes;
	var BackendLanguageUserData: hl.Bytes;

	// Optional: Access OS clipboard
    // (default to use native Win32 clipboard on Windows, otherwise uses a private clipboard. Override to access OS clipboard on other architectures)
    @:noCompletion var GetClipboardTextFn: hl.Bytes;
    @:noCompletion var SetClipboardTextFn: hl.Bytes;
    var ClipboardUserData: hl.Bytes;

	// Optional: Notify OS Input Method Editor of the screen position of your cursor for text input position (e.g. when using Japanese/Chinese IME on Windows)
    // (default to use native imm32 api on Windows)
	@:noCompletion var SetPlatformImeDataFn: hl.Bytes;
	@:noCompletion var _UnusedPadding: hl.Bytes;

    //------------------------------------------------------------------
    // Input - Call before calling NewFrame()
    //------------------------------------------------------------------

	public function addKeyEvent( key: ImGuiKey, down: Bool ) { io_add_key_event(this, key, down); } 								// Queue a new key down/up event. Key should be "translated" (as in, generally ImGuiKey_A matches the key end-user would use to emit an 'A' character)
	public function addKeyAnalogEvent( key: ImGuiKey, down: Bool, v: Single ) { io_add_key_analog_event(this, key, down, v); }		// Queue a new key down/up event for analog values (e.g. ImGuiKey_Gamepad_ values). Dead-zones should be handled by the backend.
	public function addMousePosEvent( x: Single, y: Single ) { io_add_mouse_pos_event(this, x, y); }							// Queue a mouse position update. Use -FLT_MAX,-FLT_MAX to signify no mouse (e.g. app not focused and not hovered)
	public function addMouseButtonEvent( button: Int, down: Bool ) { io_add_mouse_button_event(this, button, down); }				// Queue a mouse button change
	public function addMouseWheelEvent( wheel_x: Single, wheel_y: Single ) { io_add_mouse_wheel_event(this, wheel_x, wheel_y); }					// Queue a mouse wheel update. wheel_y<0: scroll down, wheel_y>0: scroll up, wheel_x<0: scroll right, wheel_x>0: scroll left.
	public function addMouseViewportEvent( id: ImGuiID ) { io_add_mouse_viewport_event(this, id ); }								// Queue a mouse hovered viewport. Requires backend to set ImGuiBackendFlags_HasMouseHoveredViewport to call this (for multi-viewport support).
	public function addFocusEvent( focused: Bool ) { io_add_focus_event(this, focused ); }											// Queue a gain/loss of focus for the application (generally based on OS/platform focus of your window)
	public function addInputCharacter( c: Int ) { io_add_input_character(this, c ); }												// Queue a new character input
	public function addInputCharacterUTF16( c: Int ) { io_add_input_character_utf16(this, c ); }									// Queue a new character input from a UTF-16 character, it can be a surrogate
	public function addInputCharactersUTF8( chars: String ) { io_add_input_characters_utf8(this, chars ); }							// Queue a new characters input from a UTF-8 string
	// No, I have no idea why the utf8 variant accepts multiple characters...

	// [Optional] Specify index for legacy <1.87 IsKeyXXX() functions with native indices + specify native keycode, scancode.
	public function setKeyEventNativeData( key: ImGuiKey, native_keycode: Int, native_scancode: Int, native_legacy: Int = -1 ) {
		io_set_key_event_native_data(this, key, native_keycode, native_scancode, native_legacy );
	}
	public function setAppAcceptingEvents( accepting_events: Bool ) { io_set_app_accepting_events( this, accepting_events ); }		// Set master flag for accepting key/mouse/text events (default to true). Useful if you have native dialog boxes that are interrupting your application loop/refresh, and you want to disable events being queued while your app is frozen.
	public function clearInputCharacters() { io_clear_input_characters( this ); }													// Set master flag for accepting key/mouse/text events (default to true). Useful if you have native dialog boxes that are interrupting your application loop/refresh, and you want to disable events being queued while your app is frozen.
	public function clearInputKeys() { io_clear_input_keys( this ); }																// Set master flag for accepting key/mouse/text events (default to true). Useful if you have native dialog boxes that are interrupting your application loop/refresh, and you want to disable events being queued while your app is frozen.

	static function io_add_key_event(io: ImGuiIO, key: ImGuiKey, down: Bool) {}
	static function io_add_key_analog_event(io: ImGuiIO, key: ImGuiKey, down: Bool, v: Single) {}
	static function io_add_mouse_pos_event(io: ImGuiIO, x: Single, y: Single) {}
	static function io_add_mouse_button_event(io: ImGuiIO, button: Int, down: Bool) {}
	static function io_add_mouse_wheel_event(io: ImGuiIO, wheel_x: Single, wheel_y: Single) {}
	static function io_add_mouse_viewport_event(io: ImGuiIO, id: ImGuiID ) {}
	static function io_add_focus_event(io: ImGuiIO, focused: Bool ) {}
	static function io_add_input_character(io: ImGuiIO, c: Int ) {}
	static function io_add_input_character_utf16(io: ImGuiIO, c: Int ) {}
	static function io_add_input_characters_utf8(io: ImGuiIO, chars: String ) {}

	static function io_set_key_event_native_data(io: ImGuiIO, key: ImGuiKey, native_keycode: Int, native_scancode: Int, native_legacy: Int ) {}
	static function io_set_app_accepting_events( io: ImGuiIO, accepting_events: Bool ) {}
	static function io_clear_input_characters( io: ImGuiIO ) {}
	static function io_clear_input_keys( io: ImGuiIO ) {}

	//------------------------------------------------------------------
    // Output - Updated by NewFrame() or EndFrame()/Render()
    // (when reading from the io.WantCaptureMouse, io.WantCaptureKeyboard flags to dispatch your inputs, it is
    //  generally easier and more correct to use their state BEFORE calling NewFrame(). See FAQ for details!)
    //------------------------------------------------------------------

	var WantCaptureMouse: Bool;                   // Set when Dear ImGui will use mouse inputs, in this case do not dispatch them to your main game/application (either way, always pass on mouse inputs to imgui). (e.g. unclicked mouse is hovering over an imgui window, widget is active, mouse was clicked over an imgui window, etc.).
    var WantCaptureKeyboard: Bool;                // Set when Dear ImGui will use keyboard inputs, in this case do not dispatch them to your main game/application (either way, always pass keyboard inputs to imgui). (e.g. InputText active, or an imgui window is focused and navigation is enabled, etc.).
    var WantTextInput: Bool;                      // Mobile/console: when set, you may display an on-screen keyboard. This is set by Dear ImGui when it wants textual keyboard input to happen (e.g. when a InputText widget is active).
    var WantSetMousePos: Bool;                    // MousePos has been altered, backend should reposition mouse on next frame. Rarely used! Set only when ImGuiConfigFlags_NavEnableSetMousePos flag is enabled.
    var WantSaveIniSettings: Bool;                // When manual .ini load/save is active (io.IniFilename == NULL), this will be set to notify your application that you can call SaveIniSettingsToMemory() and save yourself. Important: clear io.WantSaveIniSettings yourself after saving!
    var NavActive: Bool;                          // Keyboard/Gamepad navigation is currently allowed (will handle ImGuiKey_NavXXX events) = a window is focused and it doesn't use the ImGuiWindowFlags_NoNavInputs flag.
    var NavVisible: Bool;                         // Keyboard/Gamepad navigation is visible and allowed (will handle ImGuiKey_NavXXX events).
    var Framerate: Single;                        // Estimate of application framerate (rolling average over 60 frames, based on io.DeltaTime), in frame per second. Solely for convenience. Slow applications may not want to use a moving average or may want to reset underlying buffers occasionally.
    var MetricsRenderVertices: Int;               // Vertices output during last call to Render()
    var MetricsRenderIndices: Int;                // Indices output during last call to Render() = number of triangles * 3
    var MetricsRenderWindows: Int;                // Number of visible windows
    var MetricsActiveWindows: Int;                // Number of active windows
    var MetricsActiveAllocations: Int;            // Number of active allocations, updated by MemAlloc/MemFree based on current context. May be off if you have multiple imgui contexts.
    @:flatten var MouseDelta: ImVec2S;            // Mouse delta. Note that this is zero if either current or previous position are invalid (-FLT_MAX,-FLT_MAX), so a disappearing/reappearing mouse won't have a huge delta.

	//------------------------------------------------------------------
    // [Internal] Dear ImGui will maintain those fields. Forward compatibility not guaranteed!
    //------------------------------------------------------------------
	// Main Input State
    // (this block used to be written by backend, since 1.87 it is best to NOT write to those directly, call the AddXXX functions above instead)
    // (reading from those variables is fair game, as they are extremely unlikely to be moving anywhere)
	@:flatten var MousePos: ImVec2S;
	// @todo: This is broken
	//@:flattenMap(ImGuiMouseButton) var MouseDown: Bool;
	// gross hack instead
	var MouseDown_Left: Bool;
	var MouseDown_Right: Bool;
	var MouseDown_Middle: Bool;
	var MouseDown_AltA: Bool;
	var MouseDown_AltB: Bool;
	// end hack
	var MouseWheel: Single;
	var MouseWheelH: Single;
	var MouseHoveredViewport: ImGuiID;
	var KeyCtrl: Bool;
	var KeyShift: Bool;
	var KeyAlt: Bool;
	var KeySuper: Bool;

	var KeyMods: ImGuiKeyChord;
	// @todo: We need a way to expose the key map here to go any further.
}

@:keep
@:build(imgui._ImGuiInternalMacro.buildFlatStruct())
@:hlNative("hlimgui")
@:struct class ImGuiPlatformIO {
	// MSVC throws errors on empty structures
	private var __placeholder:Int;

	// Internal functions. We don't bother passing the ptr here since we can only ever
	// have one PlatformIO instance.
	static function platformioSetPlatformCreateWindow( func: ImGuiViewport -> Void ) {};
	static function platformioSetPlatformDestroyWindow( func: ImGuiViewport -> Void ) {};
	static function platformioSetPlatformShowWindow( func: ImGuiViewport -> Void ) {};

	static function platformioSetPlatformSetWindowPos( func: ( ImGuiViewport, ImVec2 ) -> Void ) {};
	static function platformioSetPlatformGetWindowPos( func: ( ImGuiViewport, ImGuiVec2Struct ) -> Void ) {};

	static function platformioSetPlatformSetWindowSize( func: ( ImGuiViewport, ImVec2 ) -> Void ) {};
	static function platformioSetPlatformGetWindowSize( func: ( ImGuiViewport, ImGuiVec2Struct )  -> Void ) {};

	static function platformioSetPlatformSetWindowFocus( func: ImGuiViewport -> Void ) {};
	static function platformioSetPlatformGetWindowFocus( func: ImGuiViewport -> Bool ) {};

	static function platformioSetPlatformGetWindowMinimized( func: ImGuiViewport -> Bool ) {};
	static function platformioSetPlatformSetWindowTitle( func: (ImGuiViewport, hl.Bytes) -> Void ) {};
	static function platformioSetPlatformSetWindowAlpha( func: (ImGuiViewport, Single) -> Void ) {};

	static function platformioSetRendererRenderWindow( func: (ImGuiViewport, Dynamic) -> Void ) {};
	static function platformioSetRendererSwapBuffers( func: (ImGuiViewport, Dynamic) -> Void ) {};

	// Utils
	static function platformioAddMonitor( size: ImVec2S, pos: ImVec2S ) {};
	static function platformioSetMainViewport( w: Dynamic ): ImGuiViewport { return  null; };

	// haxe setters
	public var Platform_CreateWindow(never, set): ImGuiViewport -> Void;
	public var Platform_DestroyWindow(never, set): ImGuiViewport -> Void;
	public var Platform_ShowWindow(never, set): ImGuiViewport -> Void;

	public var Platform_SetWindowPos(never, set): ( ImGuiViewport, ImVec2 ) -> Void;
	public var Platform_GetWindowPos(never, set): ( ImGuiViewport, ImGuiVec2Struct ) -> Void;

	public var Platform_SetWindowSize(never, set): ( ImGuiViewport, ImVec2 ) -> Void;
	public var Platform_GetWindowSize(never, set): ( ImGuiViewport, ImGuiVec2Struct ) -> Void;

	public var Platform_SetWindowFocus(never, set): ImGuiViewport -> Void;
	public var Platform_GetWindowFocus(never, set): ImGuiViewport -> Bool;

	public var Platform_GetWindowMinimized(never, set): ImGuiViewport -> Bool;
	public var Platform_SetWindowTitle(never, set): (ImGuiViewport, hl.Bytes) -> Void;
	public var Platform_SetWindowAlpha(never, set): (ImGuiViewport, Single) -> Void;

	public var Renderer_RenderWindow(never, set): (ImGuiViewport, Dynamic) -> Void;
	public var Renderer_SwapBuffers(never, set): (ImGuiViewport, Dynamic) -> Void;


	inline function set_Platform_CreateWindow( func: ImGuiViewport -> Void ):ImGuiViewport -> Void { platformioSetPlatformCreateWindow( func ); return func; };
	inline function set_Platform_DestroyWindow( func: ImGuiViewport -> Void ):ImGuiViewport -> Void { platformioSetPlatformDestroyWindow( func ); return func; }
	inline function set_Platform_ShowWindow( func: ImGuiViewport -> Void ):ImGuiViewport -> Void { platformioSetPlatformShowWindow( func ); return func; }

	inline function set_Platform_SetWindowPos( func: ( ImGuiViewport, ImVec2 ) -> Void ):( ImGuiViewport, ImVec2 ) -> Void { platformioSetPlatformSetWindowPos( func ); return func; }
	inline function set_Platform_GetWindowPos( func: ( ImGuiViewport, ImGuiVec2Struct ) -> Void ):( ImGuiViewport, ImGuiVec2Struct ) -> Void { platformioSetPlatformGetWindowPos( func ); return func; }

	inline function set_Platform_SetWindowSize( func: ( ImGuiViewport, ImVec2 ) -> Void ):( ImGuiViewport, ImVec2 ) -> Void { platformioSetPlatformSetWindowSize( func ); return func; }
	inline function set_Platform_GetWindowSize( func: ( ImGuiViewport, ImGuiVec2Struct ) -> Void ):( ImGuiViewport, ImGuiVec2Struct ) -> Void { platformioSetPlatformGetWindowSize( func ); return func; }

	inline function set_Platform_SetWindowFocus( func: ImGuiViewport -> Void ):ImGuiViewport -> Void { platformioSetPlatformSetWindowFocus( func ); return func; }
	inline function set_Platform_GetWindowFocus( func: ImGuiViewport -> Bool ): ImGuiViewport -> Bool { platformioSetPlatformGetWindowFocus( func ); return func; }

	inline function set_Platform_GetWindowMinimized( func: ImGuiViewport -> Bool ): ImGuiViewport -> Bool { platformioSetPlatformGetWindowMinimized( func ); return func; }
	inline function set_Platform_SetWindowTitle( func: (ImGuiViewport, hl.Bytes) -> Void ):(ImGuiViewport, hl.Bytes) -> Void { platformioSetPlatformSetWindowTitle( func ); return func; }
	inline function set_Platform_SetWindowAlpha( func: (ImGuiViewport, Single) -> Void ):(ImGuiViewport, Single) -> Void { platformioSetPlatformSetWindowAlpha( func ); return func; }

	inline function set_Renderer_RenderWindow( func: (ImGuiViewport, Dynamic) -> Void ):(ImGuiViewport, Dynamic) -> Void{ platformioSetRendererRenderWindow( func ); return func; }
	inline function set_Renderer_SwapBuffers( func: (ImGuiViewport, Dynamic) -> Void ):(ImGuiViewport, Dynamic) -> Void { platformioSetRendererSwapBuffers( func ); return func; }

	// Utils
	public function addMonitor( size: ImVec2S, pos: ImVec2S ): Void platformioAddMonitor(size, pos );
	public function setMainViewport( window: Dynamic ): ImGuiViewport return platformioSetMainViewport( window );

}

typedef ImFontConfig = imgui.types.ImFontAtlas.ImFontConfig;

// Callbacks

/**
	@return `0` for success of the callback.
**/
typedef ImGuiInputTextCallbackDataFunc = ( ImGuiInputTextCallbackData ) -> Int;

@:keep
@:struct @:hlNative("hlimgui")
class ImGuiInputTextCallbackData
{

	public var eventFlag: ImGuiInputTextFlags; // One ImGuiInputTextFlags_Callback*    // Read-only
	public var flags: ImGuiInputTextFlags;     // What user passed to InputText()      // Read-only
	var unused: hl.Bytes;	                   // Internally used pointer to the callback func.

	public var eventChar: hl.UI16;             // Character input                      // Read-write   // [CharFilter] Replace character with another one, or set to zero to drop. return 1 is equivalent to setting EventChar=0;
	public var eventKey: Int;                  // Key pressed (Up/Down/TAB)            // Read-only    // [Completion,History]
	public var buf: hl.Bytes;                  // Text buffer                          // Read-write   // [Resize] Can replace pointer / [Completion,History,Always] Only write to pointed data, don't replace the actual pointer!
	public var bufTextLen: Int;                // Text length (in bytes)               // Read-write   // [Resize,Completion,History,Always] Exclude zero-terminator storage. In C land: == strlen(some_text), in C++ land: string.length()
	public var bufSize: Int;                   // Buffer size (in bytes) = capacity+1  // Read-only    // [Resize,Completion,History,Always] Include zero-terminator storage. In C land == ARRAYSIZE(my_char_array), in C++ land: string.capacity()+1
	public var bufDirty: Bool;                 // Set if you modify Buf/BufTextLen!    // Write        // [Completion,History,Always]
	public var cursorPos: Int;                 //                                      // Read-write   // [Completion,History,Always]
	public var selectionStart: Int;            //                                      // Read-write   // [Completion,History,Always] == to SelectionEnd when no selection)
	public var selectionEnd: Int;              //                                      // Read-write   // [Completion,History,Always]

	/** Helper method to calculate byte position of a character at position `pos` in Unicode string.**/
	public function utfCharPos(pos: Int, startAt: Int = 0): Int
	{
		var i = startAt;
		var p = 0;
		while (++p < pos)
		{
			var c = buf[i];
			if (c < 0x80)
			{
				if (c == 0) return i;
				i++;
			}
			else if (c < 0xC0) return i;
			else if (c < 0xE0)
			{
				if ((buf[i+1]&0x80) == 0) return i;
				i += 2;
			}
			else if (c < 0xF0)
			{
				if ((buf[i+1]&buf[i+2]&0x80) == 0) return i;
				i += 3;
			}
			else if (c < 0xF8)
			{
				if ((buf[i+1]&buf[i+2]&buf[i+3]&0x80) == 0) return i;
				p++;
				i += 4;
			} else return i;
		}
		return i;
	}
	/**
		Helper method to delete N UTF-8 characters instead of N bytes
		@param pos The character position inside the string. (Not byte position)
		@param charCount The amount of UTF-8 character to delete. Pass -1 to delete everything past `pos`.
	**/
	public function deleteCharsUnicode(pos: Int, charCount: Int)
	{
		pos = utfCharPos(pos);
		if (charCount == -1)
		{
			deleteChars(pos, bufTextLen - pos);
			return;
		}
		deleteChars(pos, utfCharPos(charCount, pos));
	}

	/**
		Helper method to insert `text` at the UTF-8 character position instead of byte position.
	**/
	public function insertCharsUnicode(pos: Int, text: String)
	{
		insertChars(utfCharPos(pos), text);
	}
	/** Deletes `bytesCount` bytes starting at `pos` position from the text buffer. **/
	public inline function deleteChars(pos: Int, bytesCount: Int) input_text_callback_delete_chars(this, pos, bytesCount);
	/** Inserts `text` at `pos` byte position in the text buffer. **/
	public inline function insertChars(pos: Int, text: String) input_text_callback_insert_chars(this, pos, text);
	public function selectAll()			{ selectionStart = 0; selectionEnd = bufTextLen; }
	public function clearSelection() 	{ selectionStart = selectionEnd = bufTextLen; }
	public function hasSelection() 		{ return selectionStart != selectionEnd; }

	static function input_text_callback_delete_chars(data:ImGuiInputTextCallbackData, pos: Int, bytes_count: Int) {}
	static function input_text_callback_insert_chars(data:ImGuiInputTextCallbackData, pos: Int, text: String) {}
}


typedef ImDrawList = imgui.types.ImDrawList;
typedef ImDrawListSplitter = imgui.types.ImDrawList.ImDrawListSplitter;
typedef ImFont = imgui.types.ImFont;
typedef ImFontAtlas = imgui.types.ImFontAtlas;
typedef ImGuiListClipper = imgui.types.ImGuiListClipper;
typedef ImGuiDockNode = imgui.types.ImGuiDockNode;


@:keep
@:build(imgui._ImGuiInternalMacro.buildFlatStruct())
@:hlNative("hlimgui")
@:struct class ImGuiVec2Struct
{
	public var x: Single;
	public var y: Single;
}


@:keep
@:build(imgui._ImGuiInternalMacro.buildFlatStruct())
@:hlNative("hlimgui")
@:struct class ImGuiViewport
{
	public var ID: ImGuiID;
	public var Flags: ImGuiViewportFlags;
	@:flatten public var Pos: ImVec2S;
	@:flatten public var Size: ImVec2S;
	@:flatten public var WorkPos: ImVec2S;
	@:flatten public var WorkSize: ImVec2S;
	public var DpiScale: Single;
	public var ParentViewportId: ImGuiID;
	@:noCompletion public var DrawData: hl.Bytes; // ImDrawData*

	@:noCompletion public var RendererUserData: hl.Bytes; // void*
	public var PlatformUserData: h3d.Engine; // void*
	public var PlatformHandle: hxd.Window; // void*
	@:noCompletion public var PlatformHandleRaw: Dynamic; // void*

	public var PlatformWindowCreated: Bool; // Platform window has been created (Platform_CreateWindow() has been called). This is false during the first frame where a viewport is being created.
	public var PlatformRequestMove: Bool; // Platform window requested move (e.g. window was moved by the OS / host window manager, authoritative position will be OS window position)
	public var PlatformRequestResize: Bool; // Platform window requested resize (e.g. window was resized by the OS / host window manager, authoritative size will be OS window size)
	public var PlatformRequestClose: Bool; // Platform window requested closure (e.g. window was moved by the OS / host window manager, e.g. pressing ALT-F4)

}

@:hlNative("hlimgui")
abstract ImStateStorage(ImStateStoragePtr) from ImStateStoragePtr to ImStateStoragePtr
{
	public inline function new(ptr: ImStateStoragePtr) { this = ptr; }

	static function state_storage_get_int(storage: ImStateStoragePtr, id: ImGuiID, default_val: Int): Int { return 0; }
	static function state_storage_set_int(storage: ImStateStoragePtr, id: ImGuiID, val: Int): Void {}
	static function state_storage_get_bool(storage: ImStateStoragePtr, id: ImGuiID, default_val: Bool): Bool { return false; }
	static function state_storage_set_bool(storage: ImStateStoragePtr, id: ImGuiID, val: Bool): Void {}
	static function state_storage_get_float(storage: ImStateStoragePtr, id: ImGuiID, default_val: Single): Single { return 0; }
	static function state_storage_set_float(storage: ImStateStoragePtr, id: ImGuiID, val: Single): Void {}

	public inline function setInt(id: ImGuiID, val: Int):Void state_storage_set_int(this, id, val);
	public inline function getInt(id: ImGuiID, default_val: Int = 0):Int return state_storage_get_int(this, id, default_val);
	public inline function setBool(id: ImGuiID, val: Bool):Void state_storage_set_bool(this, id, val);
	public inline function getBool(id: ImGuiID, default_val: Bool = false):Bool return state_storage_get_bool(this, id, default_val);
	public inline function setFloat(id: ImGuiID, val: Single):Void state_storage_set_float(this, id, val);
	public inline function getFloat(id: ImGuiID, default_val: Single = 0.0):Single return state_storage_get_float(this, id, default_val);
}

@:hlNative("hlimgui")
abstract ImDragDropPayload(ImDragDropPayloadPtr) from ImDragDropPayloadPtr to ImDragDropPayloadPtr {

	public inline function new(ptr: ImDragDropPayloadPtr) { this = ptr; }

	public inline function clear() dndpayload_clear(this);
	public inline function isDataType(type: String) return dndpayload_is_data_type(this, type);
	public var isPreview(get, never): Bool;
	public var isDelivery(get, never): Bool;

	public var asBinary(get, never):hl.Bytes;
	public var asString(get, never):String;
	public var asInt(get, never):Int;
	public var asFloat(get, never): Float;
	public var asBool(get, never): Bool;
	/**
		@param clear If true, the stored object will be removed from gc root and could be GC collected at any time if no other references to it remained on Haxe side.
		Subsequent asObject calls would return null as well.
	**/
	public inline function asObject<T>(clear: Bool = false):T return dndpayload_get_object(this, clear);

	inline function get_isPreview() return dndpayload_is_preview(this);
	inline function get_isDelivery() return dndpayload_is_delivery(this);
	inline function get_asBinary() return dndpayload_get_binary(this);
	inline function get_asString() return @:privateAccess String.fromUTF8(asBinary);
	inline function get_asInt() return asBinary.getI32(0);
	inline function get_asFloat() return asBinary.getF64(0);
	inline function get_asBool() return asBinary[0] != 0;

	static function dndpayload_clear(payload: ImDragDropPayloadPtr) {};
	static function dndpayload_is_data_type(payload: ImDragDropPayloadPtr, type: String): Bool {return false;};
	static function dndpayload_is_preview(payload: ImDragDropPayloadPtr): Bool {return false;};
	static function dndpayload_is_delivery(payload: ImDragDropPayloadPtr): Bool {return false;};

	static function dndpayload_get_binary(payload: ImDragDropPayloadPtr): hl.Bytes {return null;}
	static function dndpayload_get_object(payload: ImDragDropPayloadPtr, clear: Bool): Dynamic {return null;}
}


@:hlNative("hlimgui")
class ImGui
{
	public static inline var FLT_MAX = 3.402823466e+38;
	public static inline var FLT_MIN = 1.175494e-38;

	// Context
	public static function createContext() : ImContextPtr {return null;}
	public static function destroyContext(ctx : ImContextPtr = null) {}
	public static function getCurrentContext() : ImContextPtr {return null;}
	public static function setCurrentContext(ctx : ImContextPtr) {}

	// Main
	public static function getIO() : ImGuiIO {return null;}
	public static function getPlatformIO() : ImGuiPlatformIO {return null;}
	public static function getStyle() : ImGuiStyle {return null;}
	public static function setStyle(style : ImGuiStyle) {}
	public static function newFrame() {}
	public static function endFrame() {}
	public static function render() {}

	// Demo, Debug, Information
	public static function showDemoWindow(open : Ref<Bool> = null) {}
	public static function showMetricsWindow(open : Ref<Bool> = null) {}
	public static function showStackToolWindow(open : Ref<Bool> = null) {}
	public static function showAboutWindow(open : Ref<Bool> = null) {}
	public static function showStyleEditor(style : ImGuiStyle = null) {}
	public static function showStyleSelector(label : String) : Bool {return false;}
	public static function showFontSelector(label : String) {}
	public static function showUserGuide() {}
	static function get_version() : hl.Bytes {return null;}
	public static inline function getVersion() : String {
		return @:privateAccess String.fromUTF8(get_version());
	}

	// Styles
	public static function styleColorsDark(style : ImGuiStyle = null) {}
	public static function styleColorsClassic(style : ImGuiStyle = null) {}
	public static function styleColorsLight(style : ImGuiStyle = null) {}

	// Windows
	public static function begin(name : String, open : Ref<Bool> = null, flags : ImGuiWindowFlags = 0) : Bool {return false;}
	/** Always call `end()` regardless of `begin()` return value! **/
	public static function end() {}

	// Child Windows
	public static extern inline overload function beginChild(str_id : String, ?size : ImVec2, border : Bool = false, flags : ImGuiWindowFlags = 0) : Bool { return begin_child(str_id, size, border, flags); }
	public static extern inline overload function beginChild(id : Int, ?size : ImVec2, border : Bool = false, flags : ImGuiWindowFlags = 0) : Bool { return begin_child2(id, size, border, flags); }
	static function begin_child(str_id : String, ?size : ImVec2, border : Bool = false, flags : ImGuiWindowFlags = 0) : Bool {return false;}
	static function begin_child2(id : Int, ?size : ImVec2, border : Bool = false, flags : ImGuiWindowFlags = 0) : Bool {return false;}

	/** Always call `endChild()` regardless of `beginChild()` return value! **/
	public static function endChild() {}

	// Windows Utilities
	public static function isWindowAppearing() : Bool {return false;}
	public static function isWindowCollapsed() : Bool {return false;}
	public static function isWindowFocused(flags : ImGuiFocusedFlags = 0) {return false;}
	public static function isWindowHovered(flags : ImGuiHoveredFlags = 0) {return false;}
	public static function getWindowDrawList() : ImDrawList {return null;}
	public static function getWindowDpiScale(): Single { return 0; }
	public static function getWindowPos() : ImVec2 {return null;}
	public static function getWindowSize() : ImVec2 {return null;}
	public static function getWindowWidth() : Single {return 0;}
	public static function getWindowHeight(): Single {return 0;}

	// Window manipulation
	public static function setNextWindowPos(pos: ImVec2, cond: ImGuiCond = 0, ?pivot: ImVec2) {}
	public static function setNextWindowSize(size: ImVec2, cond : ImGuiCond = 0) {}
	public static function setNextWindowSizeConstraints(size_min : ImVec2, size_max : ImVec2) {}
	public static function setNextWindowContentSize(size : ImVec2) {}
	public static function setNextWindowCollapsed(collapsed : Bool, cond : ImGuiCond = 0) {}
	public static function setNextWindowFocus() {}
	public static function setNextWindowBgAlpha(alpha : Single) {}
	public static extern inline overload function setWindowPos(pos : ImVec2, cond : ImGuiCond = 0) { set_window_pos(pos, cond); }
	public static extern inline overload function setWindowSize(size : ImVec2, cond : ImGuiCond = 0) { set_window_size(size, cond); }
	public static extern inline overload function setWindowCollapsed(collapsed : Bool, cond : ImGuiCond = 0) { set_window_collapsed(collapsed, cond); }
	public static extern inline overload function setWindowFocus() { set_window_focus(); }
	public static extern inline overload function setWindowFontScale(scale : Single) {}
	public static extern inline overload function setWindowPos(name : String, pos : ImVec2, cond : ImGuiCond = 0) { set_window_pos2(name, pos, cond); }
	public static extern inline overload function setWindowSize(name : String, size : ImVec2, cond : ImGuiCond = 0) { set_window_size2(name, size, cond); }
	public static extern inline overload function setWindowCollapsed(name : String, collapsed : Bool, cond : ImGuiCond = 0) { set_window_collapsed2(name, collapsed, cond); }
	public static extern inline overload function setWindowFocus(name : String) { set_window_focus2(name); }

	static function set_window_pos(pos : ImVec2, cond : ImGuiCond = 0) {}
	static function set_window_size(size : ImVec2, cond : ImGuiCond = 0) {}
	static function set_window_collapsed(collapsed : Bool, cond : ImGuiCond = 0) {}
	static function set_window_focus() {}
	static function set_window_pos2(name : String, pos : ImVec2, cond : ImGuiCond = 0) {}
	static function set_window_size2(name : String, size : ImVec2, cond : ImGuiCond = 0) {}
	static function set_window_collapsed2(name : String, collapsed : Bool, cond : ImGuiCond = 0) {}
	static function set_window_focus2(name : String) {}

	// Content region
	public static function getContentRegionMax() : ImVec2 {return null;}
	public static function getContentRegionAvail() : ImVec2 {return null;}
	public static function getWindowContentRegionMin() : ImVec2 {return null;}
	public static function getWindowContentRegionMax() : ImVec2 {return null;}

	// Windows Scrolling
	public static function getScrollX() : Single {return 0;}
	public static function getScrollY() : Single {return 0;}
	public static function setScrollX(scroll_x : Single) {}
	public static function setScrollY(scroll_y : Single) {}
	public static function getScrollMaxX() : Single {return 0;}
	public static function getScrollMaxY() : Single {return 0;}
	public static function setScrollHereX(center_x_ratio : Single = 0.5) {}
	public static function setScrollHereY(center_y_ratio : Single = 0.5) {}
	public static function setScrollFromPosX(local_x : Single, center_x_ratio : Single = 0.5) {}
	public static function setScrollFromPosY(local_y : Single, center_y_ratio : Single = 0.5) {}

	// Parameters stacks (shared)
	public static function pushFont( font: ImFont ) {}
	public static function popFont() {}
	public static extern inline overload function pushStyleColor(idx : ImGuiCol, col : ImU32) { push_style_color(idx, col); }
	public static extern inline overload function pushStyleColor(idx : ImGuiCol, col : ImVec4) { push_style_color2(idx, col); }
	public static function popStyleColor(count : Int = 1) {}
	public static extern inline overload function pushStyleVar(idx : ImGuiStyleVar, val : Single) { push_style_var(idx, val); }
	public static extern inline overload function pushStyleVar(idx : ImGuiStyleVar, val : ImVec2) { push_style_var2(idx, val); }
	public static function popStyleVar(count : Int = 1) {}
	public static function pushAllowKeyboardFocus(allow_keyboard_focus : Bool) {}
	public static function popAllowKeyboardFocus() {}
	public static function pushButtonRepeat(repeat : Bool) {}
	public static function popButtonRepeat() {}

	static function push_style_color(idx : ImGuiCol, col : ImU32) {}
	static function push_style_color2(idx : ImGuiCol, col : ImVec4) {}
	static function push_style_var(idx : ImGuiStyleVar, val : Single) {}
	static function push_style_var2(idx : ImGuiStyleVar, val : ImVec2) {}

	// Parameters stacks (current window)
	public static function pushItemWidth(item_width : Single) {}
	public static function popItemWidth() {}
	public static function setNextItemWidth(item_width : Single) {}
	public static function calcItemWidth() : Single {return 0;}
	public static function pushTextWrapPos(wrap_local_pos_x : Single = 0.0) {}
	public static function popTextWrapPos() {}

	// Style read access
	public static function getFont(): ImFont {return null;}
	public static function getFontSize() : Single {return 0;}
	public static function getFontTexUvWhitePixel() : ImVec2 {return null;}
	public static extern inline overload function getColorU32(idx : ImGuiCol, alpha_mul : Single = 1.0) : ImU32 {return get_color_u32(idx, alpha_mul);}
	public static extern inline overload function getColorU32(col : ImVec4) : ImU32 {return get_color_u322(col);}
	public static extern inline overload function getColorU32(col : ImU32) : ImU32 {return get_color_u323(col);}
	public static function getStyleColorVec4(idx : ImGuiCol) : ImVec4 {return null;}

	static function get_color_u32(idx : ImGuiCol, alpha_mul : Single = 1.0) : ImU32 {return 0;}
	static function get_color_u322(col : ImVec4) : ImU32 {return 0;}
	static function get_color_u323(col : ImU32) : ImU32 {return 0;}

	// Cursor / Layout
	public static function separator() {}
	public static function sameLine(offset_from_start_x : Single = 0.0, spacing : Single = -1.0) {}
	public static function newLine() {}
	public static function spacing() {}
	public static function dummy(size : ImVec2) {}
	public static function indent(indent_w : Single = 0.0) {}
	public static function unindent(indent_w : Single = 0.0) {}
	public static function beginGroup() {}
	public static function endGroup() {}
	public static function getCursorPos() : ImVec2 {return null;}
	public static function getCursorPosX() : Single {return 0;}
	public static function getCursorPosY() : Single {return 0;}
	public static function setCursorPos(local_pos : ImVec2) {}
	public static function setCursorPosX(local_x : Single) {}
	public static function setCursorPosY(local_y : Single) {}
	public static function getCursorStartPos() : ImVec2 {return null;}
	public static function getCursorScreenPos() : ImVec2 {return null;}
	public static function setCursorScreenPos(pos : ImVec2) {}
	public static function alignTextToFramePadding() {}
	public static function getTextLineHeight() : Single {return 0;}
	public static function getTextLineHeightWithSpacing() : Single {return 0;}
	public static function getFrameHeight() : Single {return 0;}
	public static function getFrameHeightWithSpacing() : Single {return 0;}

	// ID stack/scopes
	public static function pushID(str_id : String) {}
	@:native("push_id_sub") public static function pushIDSub(str_id : String, begin : Int, end : Int) {}
	@:native("push_id_int") public static function pushIDInt(int_id : Int) {}
	@:native("push_id_ptr") public static function pushIDPtr(obj: Any) {}
	public static function popID() {}
	public static function getID(str_id : String) : Int {return 0;}
	@:native("get_id_sub") public static function getIDSub(str_id : String, begin: Int, end: Int) : Int {return 0;}
	@:native("get_id_ptr") public static function getIDPtr(obj: Any) : Int {return 0;}

	// Widgets: Text
	// TODO: TextUnformatted(text: String, ?start: Int, ?end: Int)
	// TODO: Allow format arguments to be passed
	public static function text(text : String) {}
	public static function textColored(col : ImVec4, fmt : String) {}
	public static function textDisabled(text : String) {}
	public static function textWrapped(text : String) {}
	public static function labelText(label : String, text : String) {}
	public static function bulletText(text : String) {}
//	public static function textMarkdown(text : String) {}

	// Widgets: Main
	public static function button(name : String, ?size : ImVec2) : Bool {return false;}
	public static function smallButton(label : String) : Bool {return false;}
	public static function invisibleButton(str_id : String, ?size : ImVec2) : Bool {return false;}
	public static function arrowButton(str_id : String, dir : ImGuiDir) : Bool {return false;}
	public static function image(user_texture_id: ImTextureID, size: ImVec2, ?uv0: ImVec2, ?uv1: ImVec2, ?tint_col: ImVec4, ?border_col: ImVec4) {}
	public static function imageButton(user_texture_id: ImTextureID, size: ImVec2, ?uv0: ImVec2, ?uv1: ImVec2, frame_padding: Int = -1, ?bg_col: ImVec4, ?tint_col: ImVec4) : Bool {return false;}
	#if heaps
	public static inline function imageTile( tile: h2d.Tile, ?size: ImVec2, ?tint_col: ImVec4, ?border_col: ImVec4) @:privateAccess {
		image(tile.getTexture(), size == null ? ImTypeCache.vec2(tile.width, tile.height) : size, ImTypeCache.vec2(tile.u, tile.v), ImTypeCache.vec2(tile.u2, tile.v2), tint_col, border_col);
	}

	public static inline function imageTileButton( tile: h2d.Tile, ?size: ImVec2, frame_padding: Int = -1, ?bg_col: ImVec4, ?tint_col: ImVec4): Bool @:privateAccess {
		return imageButton(tile.getTexture(), size == null ? ImTypeCache.vec2(tile.width, tile.height) : size, ImTypeCache.vec2(tile.u, tile.v), ImTypeCache.vec2(tile.u2, tile.v2), frame_padding, bg_col, tint_col);
	}
	#end
	public static function checkbox(label : String, v : Ref<Bool>) : Bool {return false;}
	public static function checkboxFlags(label : String, flags : Ref<Int>, flags_value : Int) : Bool {return false;}
	public static extern inline overload function radioButton(label : String, active : Bool) : Bool {return radio_button(label, active);}
	public static extern inline overload function radioButton(label : String, v : Ref<Int>, v_button : Int) : Bool {return radio_button2(label, v, v_button);}
	public static function progressBar(fraction: Single, ?size_arg: ImVec2, ?overlay: String) {}
	public static function bullet() {}

	static function radio_button(label : String, active : Bool) : Bool {return false;}
	static function radio_button2(label : String, v : Ref<Int>, v_button : Int) : Bool {return false;}

	// Widgets: Combo Box
	/** You MUST call `endCombo()` if this method returns `true`! **/
	public static function beginCombo(label : String, preview_value : String, flags : ImGuiComboFlags = 0) : Bool {return false;}
	/** Only call `endCombo()` if `beginCombo()` returns `true`! **/
	public static function endCombo() {}
	public static extern inline overload function combo(label : String, current_item : Ref<Int>, items : hl.NativeArray<String>, popup_max_height_in_items : Int = -1) : Bool {return _combo(label, current_item, items, popup_max_height_in_items);}
	public static extern inline overload function combo(label : String, current_item : Ref<Int>, items_separated_by_zeros : String, popup_max_height_in_items : Int = -1) : Bool {return _combo2(label, current_item, items_separated_by_zeros, popup_max_height_in_items);}
	// TODO: comboCallback variant

	@:native("combo") static function _combo(label : String, current_item : Ref<Int>, items : hl.NativeArray<String>, popup_max_height_in_items : Int = -1) : Bool {return false;}
	@:native("combo_2") static function _combo2(label : String, current_item : Ref<Int>, items_separated_by_zeros : String, popup_max_height_in_items : Int = -1) : Bool {return false;}

	// Widgets: Drag Sliders
	public static function dragFloat(label : String, v : Ref<Single>, v_speed : Single = 1.0, v_min : Single = 0.0, v_max : Single = 0.0, format : String = "%.3f", flags : ImGuiSliderFlags = 0) : Bool {return false;}
	public static function dragInt(label : String, v : Ref<Int>, v_speed : Single = 1.0, v_min : Int = 0, v_max : Int = 0, format : String = "%d", flags : ImGuiSliderFlags = 0) : Bool {return false;}
	public static function dragDouble(label : String, v : Ref<Float>, v_speed : Single = 1.0, v_min : Float = 0.0, v_max : Float = 0.0, format : String = "%.3lf", flags : ImGuiSliderFlags = 0) : Bool {return false;}

	public static function dragFloatRange2(label : String, v_current_min : Ref<Single>, v_current_max : Ref<Single>, v_speed : Single = 1.0, v_min : Single = 0.0, v_max : Single = 0.0, format : String = "%.3f", format_max : String = null, flags : ImGuiSliderFlags = 0) : Bool {return false;}
	public static function dragIntRange2(label : String, v_current_min : Ref<Int>, v_current_max : Ref<Int>, v_speed : Single = 1.0, v_min : Int = 0, v_max : Int = 0, format : String = "%.d", format_max : String = null, flags : ImGuiSliderFlags = 0) : Bool {return false;}

	public static inline function dragFloatN(label : String, v : hl.NativeArray<Single>, v_speed : Single = 1.0, v_min : Single = 0.0, v_max : Single = 0.0, format : String = "%.3f", flags : ImGuiSliderFlags = 0) : Bool {
		return drag_scalar_n(label, ImGuiDataType.Float, cast v, v_speed, v_min, v_max, format, flags);
	}
	public static inline function dragIntN(label : String, v : hl.NativeArray<Int>, v_speed : Single = 1.0, v_min : Int = 0, v_max : Int = 0, format : String = "%d", flags : ImGuiSliderFlags = 0) : Bool {
		return drag_scalar_n(label, ImGuiDataType.S32, cast v, v_speed, v_min, v_max, format, flags);
	}
	public static inline function dragDoubleN(label : String, v : hl.NativeArray<Float>, v_speed : Single = 1.0, v_min : Float = 0.0, v_max : Float = 0.0, format : String = "%.3lf", flags : ImGuiSliderFlags = 0) : Bool {
		return drag_scalar_n(label, ImGuiDataType.Double, cast v, v_speed, v_min, v_max, format, flags);
	}
	static function drag_scalar_n(label : String, type : Int, v : hl.NativeArray<Dynamic>, v_speed : Single, v_min : Dynamic, v_max : Dynamic, format : String, flags : Int) : Bool {return false;}

	// Widgets: Regular Sliders
	public static function sliderFloat(label : String, v : Ref<Single>, v_min : Single, v_max : Single, format : String = "%.3f", flags : ImGuiSliderFlags = 0) : Bool {return false;}
	public static function sliderInt(label : String, v : Ref<Int>, v_min : Int, v_max : Int, format : String = "%d", flags : ImGuiSliderFlags = 0) : Bool {return false;}
	public static function sliderDouble(label : String, v : Ref<Float>, v_min : Float, v_max : Float, format : String = "%.3lf", flags : ImGuiSliderFlags = 0) : Bool {return false;}

	public static function vSliderFloat(label : String, size : ImVec2, v : Ref<Single>, v_min : Single, v_max : Single, format : String = "%.3f", flags : ImGuiSliderFlags = 0) : Bool {return false;}
	public static function vSliderInt(label : String, size : ImVec2, v : Ref<Int>, v_min : Int, v_max : Int, format : String = "%d", flags : ImGuiSliderFlags = 0) : Bool {return false;}
	public static function sliderAngle(label : String, v_rad : Ref<Single>, v_degrees_min : Single = -360.0, v_degrees_max : Single = 360.0, format : String = "%.0f deg", flags : ImGuiSliderFlags = 0) : Bool {return false;}

	public static inline function sliderFloatN(label : String, v : hl.NativeArray<Single>, v_min : Single, v_max : Single, format : String = "%.3f", flags : ImGuiSliderFlags = 0) : Bool {
		return slider_scalar_n(label, ImGuiDataType.Float, cast v, v_min, v_max, format, flags);
	}
	public static inline function sliderIntN(label : String, v : hl.NativeArray<Int>, v_min : Int, v_max : Int, format : String = "%d", flags : ImGuiSliderFlags = 0) : Bool {
		return slider_scalar_n(label, ImGuiDataType.S32, cast v, v_min, v_max, format, flags);
	}
	public static inline function sliderDoubleN(label : String, v : hl.NativeArray<Float>, v_min : Float, v_max : Float, format : String = "%.3lf", flags : ImGuiSliderFlags = 0) : Bool {
		return slider_scalar_n(label, ImGuiDataType.Double, cast v, v_min, v_max, format, flags);
	}
	static function slider_scalar_n(label : String, type: Int, v : hl.NativeArray<ImGuiScalar>, v_min : ImGuiScalar, v_max : ImGuiScalar, format : String, flags : Int) : Bool {return false;}

	public static function vSliderDouble(label: String, size: ImVec2, v: Ref<Float>, v_min: Float, v_max: Float, ?format: String, flags: Int = 0) {
		var tmp = ImTypeCache.array(v.get());
		var ret = v_slider_scalar(label, size, Double, cast tmp, v_min, v_max, format, flags);
		if (isItemEdited()) v.set(tmp[0]);
		return ret;
	}
	// TODO: Allow usage of vSliderScalar directly?
	public static function v_slider_scalar(label: String, size: ImVec2, type: ImGuiDataType, v: hl.NativeArray<ImGuiScalar>, v_min: ImGuiScalar, v_max: ImGuiScalar, ?format: String, flags: Int = 0): Bool {return false;}

	// Widgets: Input with Keyboard
	public static function inputText(label : String, value: Ref<String>, flags : ImGuiInputTextFlags = 0, callback: ImGuiInputTextCallbackDataFunc = null) : Bool {return false;}
	public static function inputTextMultiline(label : String, value: Ref<String>, ?size: ImVec2, flags : ImGuiInputTextFlags = 0, callback: ImGuiInputTextCallbackDataFunc = null ) : Bool {return false;}
	public static function inputTextWithHint(label : String, hint : String, value: Ref<String>, flags : ImGuiInputTextFlags = 0, callback: ImGuiInputTextCallbackDataFunc = null) : Bool {return false;}

	public static function inputTextBuf(label : String, buf : hl.Bytes, buf_size : Int, flags : ImGuiInputTextFlags = 0, callback: ImGuiInputTextCallbackDataFunc = null) : Bool {return false;}
	public static function inputTextMultilineBuf(label : String, buf : hl.Bytes, buf_size : Int, ?size: ImVec2, flags : ImGuiInputTextFlags = 0, callback: ImGuiInputTextCallbackDataFunc = null ) : Bool {return false;}
	public static function inputTextWithHintBuf(label : String, hint : String, buf : hl.Bytes, buf_size : Int, flags : ImGuiInputTextFlags = 0, callback: ImGuiInputTextCallbackDataFunc = null) : Bool {return false;}

	public static function inputInt(label : String, v : Ref<Int>, step : Int = 1, step_fast : Int = 100, flags : ImGuiInputTextFlags = 0) : Bool {return false;}
	public static function inputFloat(label : String, v : Ref<Single>, step : Single = 0.0, step_fast : Single = 0.0, format : String = "%.3f", flags : ImGuiInputTextFlags = 0) : Bool {return false;}
	public static function inputDouble(label : String, v : Ref<Float>, step : Float = 0.0, step_fast : Float = 0.0, format : String = "%.6f", flags : ImGuiInputTextFlags = 0) : Bool {return false;}

	public static inline function inputFloatN(label : String, v : hl.NativeArray<Single>, step : Single = 0.0, step_fast : Single = 0.0, format : String = "%.3f", flags : ImGuiInputTextFlags = 0) : Bool {
		return input_scalar_n(label, ImGuiDataType.Float, cast v, step, step_fast, format, flags);
	}
	public static inline function inputIntN(label : String, v : hl.NativeArray<Int>, step : Int = 0, step_fast : Int = 0, flags : ImGuiInputTextFlags = 0): Bool {
		return input_scalar_n(label, ImGuiDataType.S32, cast v, step, step_fast, "%d", flags);
	}
	public static inline function inputDoubleN(label : String, v : hl.NativeArray<Float>, step : Float = 0.0, step_fast : Float = 0.0, format : String = "%.6f", flags : ImGuiInputTextFlags = 0) : Bool {
		return input_scalar_n(label, ImGuiDataType.Double, cast v, step, step_fast, format, flags);
	}

	static function input_scalar_n(label : String, type : Int, v : hl.NativeArray<ImGuiScalar>, step : ImGuiScalar, step_fast : ImGuiScalar, format : String, flags : Int) : Bool {return false;}

// Widgets: Color Editor/Picker
	public static function colorEdit3(label : String, col : hl.NativeArray<Single>, flags : ImGuiColorEditFlags = 0) : Bool {return false;}
	public static function colorEdit4(label : String, col : hl.NativeArray<Single>,  flags : ImGuiColorEditFlags = 0) : Bool {return false;}
	public static function colorPicker3(label : String, col : hl.NativeArray<Single>, flags : ImGuiColorEditFlags = 0) : Bool {return false;}
	public static function colorPicker4(label : String, col : hl.NativeArray<Single>, flags : ImGuiColorEditFlags = 0, ref_col : Ref<Single> = null) : Bool {return false;}
	public static function colorButton(desc_id: String, ?col: ImVec4, flags: ImGuiColorEditFlags = 0, ?size: ImVec2) : Bool {return false;}
	public static function setColorEditOptions(flags : ImGuiColorEditFlags) {}

	// Widgets: Trees
	public static extern inline overload function treeNode(label : String) : Bool {return tree_node(label);}
	public static extern inline overload function treeNode(str_id : String, label : String) : Bool {return tree_node2(str_id, label);}
	public static extern inline overload function treeNodeEx(label : String, flags : ImGuiTreeNodeFlags = 0) : Bool {return tree_node_ex(label, flags);}
	public static extern inline overload function treeNodeEx(str_id : String, flags : ImGuiTreeNodeFlags, label : String) : Bool {return tree_node_ex2(str_id, flags, label);}
	public static function treePush(str_id : String) {}
	public static function treePop() {}
	public static function getTreeNodeToLabelSpacing() : Single {return 0;}
	public static extern inline overload function collapsingHeader(label : String, flags : ImGuiTreeNodeFlags = 0) : Bool {return collapsing_header(label, flags);}
	public static extern inline overload function collapsingHeader(label : String, p_open : Ref<Bool>, flags : ImGuiTreeNodeFlags = 0) : Bool {return collapsing_header2(label, p_open, flags);}
	public static function setNextItemOpen(is_open : Bool, cond : ImGuiCond = 0) {}

	static function tree_node(label : String) : Bool {return false;}
	static function tree_node2(str_id : String, label : String) : Bool {return false;}
	static function tree_node_ex(label : String, flags : ImGuiTreeNodeFlags = 0) : Bool {return false;}
	static function tree_node_ex2(str_id : String, flags : ImGuiTreeNodeFlags, label : String) : Bool {return false;}
	static function collapsing_header(label : String, flags : ImGuiTreeNodeFlags = 0) : Bool {return false;}
	static function collapsing_header2(label : String, p_open : Ref<Bool>, flags : ImGuiTreeNodeFlags = 0) : Bool {return false;}

	// Widgets: Selectables
	public static extern inline overload function selectable(label : String, selected : Bool = false, flags : ImGuiSelectableFlags = 0, ?size: ImVec2) : Bool {return _selectable(label, selected, flags, size);}
	public static extern inline overload function selectable(label : String, p_selected : Ref<Bool>, flags : ImGuiSelectableFlags = 0, ?size: ImVec2) : Bool {return _selectable2(label, p_selected, flags, size);}

	@:native("selectable") static function _selectable(label : String, selected : Bool = false, flags : ImGuiSelectableFlags = 0, ?size: ImVec2) : Bool {return false;}
	@:native("selectable_2") static function _selectable2(label : String, p_selected : Ref<Bool>, flags : ImGuiSelectableFlags = 0, ?size: ImVec2) : Bool {return false;}

	// Widgets: List Boxes
	/**
		You MUST call `endListBox()` if this method returns `true`!
		- Choose frame width:   size.x > 0.0f: custom  /  size.x < 0.0f or -FLT_MIN: right-align   /  size.x = 0.0f (default): use current ItemWidth
		- Choose frame height:  size.y > 0.0f: custom  /  size.y < 0.0f or -FLT_MIN: bottom-align  /  size.y = 0.0f (default): arbitrary default height which can fit ~7 items
	**/
	public static function beginListBox(label: String, ?size: ImVec2): Bool { return false; }
	/** Only call `endListBox()` if `beginListBox()` returns `true`! **/
	public static function endListBox() {}

	public static function listBox(label : String, current_item : Ref<Int>, items : hl.NativeArray<String>, height_in_items : Int = -1) : Bool {return false;}
	// TODO: Callback variant

	// Widgets: Data Plotting
	public static function plotLines(label : String, values : hl.NativeArray<Single>, values_offset : Int = 0, overlay_text : String = null, scale_min : Single = FLT_MAX, scale_max : Single = FLT_MAX, ?graph_size : ImVec2) {}
	public static function plotHistogram(label : String, values : hl.NativeArray<Single>, values_offset : Int = 0, overlay_text : String = null, scale_min : Single = FLT_MAX, scale_max : Single = FLT_MAX, ?graph_size : ImVec2) {}

	// Widgets: Value() Helpers.
	public static function valueBool(prefix : String, b : Bool) {}
	public static function valueInt(prefix : String, v : Int) {}
	public static function valueSingle(prefix : String, v : Single, float_format : String = null) {}
	public static function valueDouble(prefix: String, v: Float, double_format: String = null) {}

	// Widgets: Menus
	public static function beginMenuBar() : Bool {return false;}
	/** Only call `endMenuBar()` if `beginMenuBar()` returns `true`! **/
	public static function endMenuBar() {}
	public static function beginMainMenuBar() : Bool {return false;}
	/** Only call `endMainMenuBar()` if `beginMainMenuBar()` returns `true`! **/
	public static function endMainMenuBar() {}
	public static function beginMenu(label : String, enabled : Bool = true) : Bool {return false;}
	/** Only call `endMenu()` if `beginMenu()` returns `true`! **/
	public static function endMenu() {}
	public static extern inline overload function menuItem(label : String, shortcut : String = null, selected : Bool = false, enabled : Bool = true) : Bool {return menu_item(label, shortcut, selected, enabled);}
	public static extern inline overload function menuItem(label : String, shortcut : String, p_selected : Ref<Bool>, enabled : Bool = true) : Bool {return menu_item2(label, shortcut, p_selected, enabled);}

	static function menu_item(label : String, shortcut : String = null, selected : Bool = false, enabled : Bool = true) : Bool {return false;}
	static function menu_item2(label : String, shortcut : String, p_selected : Ref<Bool>, enabled : Bool = true) : Bool {return false;}

	// ToolTips
	public static function beginTooltip() {}
	public static function endTooltip() {}
	public static function setTooltip(fmt : String) {} // TODO: Allow format args

	// Popups, Modals

	// Popups: begin/end function
	public static function beginPopup(str_id : String, flags : ImGuiWindowFlags = 0) : Bool {return false;}
	public static function beginPopupModal(name : String, p_open : Ref<Bool> = null, flags : ImGuiWindowFlags = 0) : Bool {return false;}
	/** Only call `endPopup()` if `beginPopupXXX()` returns `true`! **/
	public static function endPopup() {}

	// Popups: open/close functions
	public static function openPopup(str_id: String, flags: ImGuiPopupFlags = 0) {}
	public static function openPopupId(id: ImGuiID, flags: ImGuiPopupFlags = 0) {}
	public static function openPopupOnItemClick(str_id : String = null, flags : ImGuiPopupFlags = 1) : Void {}
	public static function closeCurrentPopup() {}

	// Popups: open+begin combined function helpers
	public static function beginPopupContextItem(str_id : String = null, flags : ImGuiPopupFlags = 1) : Bool {return false;}
	public static function beginPopupContextWindow(str_id : String = null, flags : ImGuiPopupFlags = 1) : Bool {return false;}
	public static function beginPopupContextVoid(str_id : String = null, flags : ImGuiPopupFlags = 1) : Bool {return false;}

	// Popups: query functions
	public static function isPopupOpen(str_id : String, flags: ImGuiPopupFlags = 0) : Bool {return false;}

	// Tables
	public static function beginTable( id: String, column: Int, flags: ImGuiTableFlags = ImGuiTableFlags.None, ?outer_size: ImVec2, inner_width = 0 ): Bool { return false; }
	/** Only call `endTable()` if `beginTable()` returns `true`! **/
	public static function endTable() {}
	public static function tableNextRow( rowFlags: ImGuiTableRowFlags = ImGuiTableRowFlags.None, minRowHeight: Single = 0 ) {}
	public static function tableNextColumn() {}
	public static function tableSetColumnIndex( columnIndex: Int ) {}

	// Tables: Headers & Columns declaration
	public static function tableSetupColumn( id: String, flags: ImGuiTableColumnFlags = ImGuiTableColumnFlags.None, initWidthOrHeight: Single = 0, userId: ImGuiID = 0) {}
	public static function tableSetupScrollFreeze( cols: Int, rows: Int ) {}
	public static function tableHeadersRow() {}
	public static function tableHeader( id: String ) {}

	// Tables: Sorting
	//public static function tableGetSortSpecs( id: String ): ImGUiTableSortSpecs { return null } // @todo

	// Tables: Miscellaneous functions
	public static function tableGetColumnCount(): Int { return 0; }
	public static function tableGetColumnIndex(): Int { return 0; }
	public static function tableGetRowIndex(): Int { return 0; }
	public static function tableGetColumnName(): String { return null; }
	public static function tableGetColumnFlags(): ImGuiTableColumnFlags { return 0; }
	public static function tableSetColumnEnabled( column_n: Int, enabled: Bool ): Void {}
	public static function tableSetBGColor( target: ImGuiTableBgTarget, color: Int, column_n: Int = -1 ): Void { }

	// Legacy Columns API (prefer using Tables!)
	public static function columns(count : Int = 1, id : String = null, border : Bool = true) {}
	public static function nextColumn() {}
	public static function getColumnIndex() : Int {return 0;}
	public static function getColumnWidth(column_index : Int = -1) : Single {return 0;}
	public static function setColumnWidth(column_index : Int, width : Single) {}
	public static function getColumnOffset(column_index : Int = -1) : Single {return 0;}
	public static function setColumnOffset(column_index : Int, offset_x : Single) {}
	public static function getColumnsCount() : Int {return 0;}

	// Tab Bars, Tabs
	public static function beginTabBar(str_id : String, flags : ImGuiTabBarFlags = 0) : Bool {return false;}
	/** Only call `endTabBar()` if `beginTabBar()` returns `true`! **/
	public static function endTabBar() {}
	public static function beginTabItem(label : String, p_open : Ref<Bool> = null, flags : ImGuiTabItemFlags = 0) : Bool {return false;}
	/** Only call `endTabItem()` if `beginTabItem()` returns `true`! **/
	public static function endTabItem() {}
	public static function tabItemButton(label : String, flags : ImGuiTabItemFlags = 0) : Bool {return false;}
	public static function setTabItemClosed(tab_or_docked_window_label : String) {}

	// Docking
	public static function dockSpace(id : ImGuiID, ?size : ImVec2, flags : ImGuiDockNodeFlags = 0) {}
	// dockSpaceOverViewport // Viewport API
	public static function setNextWindowDockId(id : ImGuiID, cond : ImGuiCond = 0) {}
	// setNextWindowClass // Viewport API
	public static function getWindowDockId() : ImGuiID { return 0; }
	public static function isWindowDocked() : Bool { return false; }

	// [imgui_internal] Dock Builder
	public static function dockBuilderDockWindow(window_name: String, node_id : ImGuiID) {}
	public static function dockBuilderGetNode(node_id : ImGuiID) : ImGuiDockNode { return null; }
	public static function dockBuilderGetCentralNode(node_id : ImGuiID) : ImGuiDockNode { return null; }
	public static function dockBuilderAddNode(node_id : ImGuiID, flags: ImGuiDockNodeFlags) : ImGuiID { return 0; }
	public static function dockBuilderRemoveNode(node_id : ImGuiID) {}
	public static function dockBuilderRemoveNodeDockedWindows(node_id : ImGuiID, clear_settings_refs: Bool) {}
	public static function dockBuilderRemoveNodeChildNodes(node_id : ImGuiID) {}
	public static function dockBuilderSetNodePos(node_id : ImGuiID, pos: ImVec2 ) {}
	public static function dockBuilderSetNodeSize(node_id : ImGuiID, size: ImVec2 ) {}
	public static function dockBuilderSplitNode(node_id : ImGuiID, split_dir: ImGuiDir, size_ratio_for_node_at_dir: Single, out_id_at_dir: Ref<ImGuiID>, out_id_at_opposite_dir: Ref<ImGuiID> ) { return 0; }
	// DockBuilderCopyDockSpace
	// DockBuilderCopyNode
	public static function dockBuilderCopyWindowSettings(src_name: String, dst_name: String) {}
	public static function dockBuilderFinish(node_id : ImGuiID) {}

	// Logging/Capture
	public static function logToTTY(auto_open_depth : Int = -1) {}
	public static function logToFile(auto_open_depth : Int = -1, filename : String = null) {}
	public static function logToClipboard(auto_open_depth : Int = -1) {}
	public static function logFinish() {}
	public static function logButtons() {}
	public static function logText(text : String) {} // TODO: Allow format args

	// Drag and drop
	public static function beginDragDropTarget(): Bool { return false; }
	/** Only call `endDragDropTarget()` if `beginDragDropTarget()` returns `true`! **/
	public static function endDragDropTarget() {}
	public static function beginDragDropSource( flags: ImGuiDragDropFlags = 0 ): Bool { return false; }
	/** Only call `endDragDropSource()` if `beginDragDropSource()` returns `true`! **/
	public static function endDragDropSource() {}
	public static function setDragDropPayload(type: String, payload: hl.Bytes, length: Int, cond: ImGuiCond = 0 ) : Bool { return false; }
	public static function acceptDragDropPayload(type: String, cond: ImGuiCond = 0 ) : ImDragDropPayload { return null; }
	public static function getDragDropPayload() : ImDragDropPayload { return null; }
	/**
		Due to Haxe being a GC language, payload will be added as gc root until new payload is set or `clearDragDropPayloadObject()` is called.
		Alternatively, when accepting payload, call `payload.asObject(true)` to clear the stored object, however subsequent `asObject` calls will yield `null`.
	**/
	public static function setDragDropPayloadObject(type: String, payload: Dynamic, cond: ImGuiCond = 0): Bool { return false; }
	public static function clearDragDropPayloadObject() {}
	/**
		Returns currently stored payload object.
	**/
	public static function getDragDropPayloadObject<T>(): T { return null; }

	// Payload helpers
	/** Shortcut to set a String payload **/
	public static inline function setDragDropPayloadString(type: String, payload: String, cond: ImGuiCond = 0 ): Bool
	{
		var b = Bytes.ofString( payload + '\x00' );
		return setDragDropPayload(type, b, b.length, cond);
	}
	/**
		Accept a drag&drop payload with specified type and return it as String or null if no payload present.
	**/
	public static inline function acceptDragDropPayloadString(type: String, cond: ImGuiCond = 0 ): String
	{
		var payload = acceptDragDropPayload(type, cond);
		return payload != null ? payload.asString : null;
	}
	/** Shortcut to set an Int payload **/
	public static inline function setDragDropPayloadInt(type: String, payload: Int, cond: ImGuiCond = 0 ): Bool
	{
		var b = new hl.Bytes(4);
		b.setI32(0, payload);
		return setDragDropPayload(type, b, 4, cond);
	}
	/**
		Accept a drag&drop payload with specified type and return it as an Int or 0 if no payload present.
	**/
	public static inline function acceptDragDropPayloadInt(type: String, cond: ImGuiCond = 0 ): Int
	{
		var payload = ImGui.acceptDragDropPayload(type);
		return payload != null ? payload.asInt : 0;
	}
	/**
		Accept a drag&drop payload with specified type and return it as `T` or null if no payload present.
	**/
	public static inline function acceptDragDropPayloadObject<T>(type: String, cond: ImGuiCond = 0, clear: Bool = false): T
	{
		var payload = ImGui.acceptDragDropPayload(type);
		return payload != null ? payload.asObject(clear) : null;
	}

	// Disabling [BETA API]
	public static inline function beginDisabled(disabled: Bool = true) { begin_disabled(disabled); }
	static function begin_disabled(disabled: Bool) {}
	public static function endDisabled() {}

	// Clipping
	public static function pushClipRect(clip_rect_min : ImVec2, clip_rect_max : ImVec2, intersect_with_current_clip_rect : Bool) {}
	public static function popClipRect() {}

	// Focus, Activation
	public static function setItemDefaultFocus() {}
	public static function setKeyboardFocusHere(offset : Int = 0) {}

	// Item/Widgets Utilities
	public static function isItemHovered(flags : ImGuiHoveredFlags = 0) : Bool {return false;}
	public static function isItemActive() : Bool {return false;}
	public static function isItemFocused() : Bool {return false;}
	public static function isItemClicked(mouse_button : ImGuiMouseButton = 0) : Bool {return false;}
	public static function isItemVisible() : Bool {return false;}
	public static function isItemEdited() : Bool {return false;}
	public static function isItemActivated() : Bool {return false;}
	public static function isItemDeactivated() : Bool {return false;}
	public static function isItemDeactivatedAfterEdit() : Bool {return false;}
	public static function isItemToggledOpen() : Bool {return false;}
	public static function isAnyItemHovered() : Bool {return false;}
	public static function isAnyItemActive() : Bool {return false;}
	public static function isAnyItemFocused() : Bool {return false;}
	public static function getItemRectMin() : ImVec2 {return null;}
	public static function getItemRectMax() : ImVec2 {return null;}
	public static function getItemRectSize() : ImVec2 {return null;}
	public static function setItemAllowOverlap() {}

	// Key owner [EXPERIMENTAL API]
	public static function setKeyOwner( key: ImGuiKey, owner_id: ImGuiID, flags: ImGuiInputFlags = ImGuiInputFlags.None ) : Void {}
	public static function setItemKeyOwner( key: ImGuiKey, flags: ImGuiInputFlags = ImGuiInputFlags.None ) : Void {}

	// Context accessors
	public static function contextGetCurrentViewport(): ImGuiViewport { return  null; };

	// Miscellaneous Utilities
	public static inline extern overload function isRectVisible(size : ImVec2) : Bool { return is_rect_visible(size); }
	public static inline extern overload function isRectVisible(rect_min : ImVec2, rect_max : ImVec2) : Bool { return is_rect_visible2(rect_min, rect_max); }
	static function is_rect_visible(size : ImVec2) : Bool {return false;}
	static function is_rect_visible2(rect_min : ImVec2, rect_max : ImVec2) : Bool {return false;}

	public static function getTime() : Float {return 0;}
	public static function getFrameCount() : Int {return 0;}
	public static function getForegroundDrawList() : ImDrawList {return null;}
	//getForegroundDrawList(viewport) // Viewport API
	public static function getBackgroundDrawList() : ImDrawList {return null;}
	//getBackgroundDrawList(viewport) // Viewport API
	//getDrawListSharedData()
	static function get_style_color_name(idx : ImGuiCol) : hl.Bytes {return null;}
	public static function getStyleColorName(idx : ImGuiCol) : String {
		return @:privateAccess String.fromUTF8(get_style_color_name(idx));
	}
	public static function getStateStorage() : ImStateStorage {return null;}
	//setStateStorage
	public static function beginChildFrame(id : ImGuiID, size : ImVec2, flags : ImGuiWindowFlags = 0) : Bool {return false;}
	/** Always call `endChildFrame()` regardless of `beginChildFrame()` return value! **/
	public static function endChildFrame() {}
	@:deprecated("Obsolete: Use ImGuiListClipper")
	public static function calcListClipping(items_count : Int, items_height : Single, out_items_display_start : Ref<Int>, out_items_display_end : Ref<Int>) {}

	// Text Utilities
	public static function calcTextSize(text : String, text_end : String = null, hide_text_after_double_hash : Bool = false, wrap_width : Single = -1.0): ImVec2 {return null;}

	// Color Utilities
	public static function colorConvertU32ToFloat4(color : ImU32) : ImVec4 {return null;}
	public static function colorConvertFloat4ToU32(color : ImVec4) : ImU32 {return 0;}
	public static function colorConvertRGBtoHSV(r : Single, g : Single, b : Single, out_h : Ref<Single>, out_s : Ref<Single>, out_v : Ref<Single>) {}
	public static function colorConvertHSVtoRGB(h : Single, s : Single, v : Single, out_r : Ref<Single>, out_g : Ref<Single>, out_b : Ref<Single>) {}
	/** Helper method to reduce Ref dependency. w/alpha is preserved. **/
	public static function colorConvertRGBtoHSVVec(input: ImVec4): ImVec4 {return null;}
	/** Helper method to reduce Ref dependency. w/alpha is preserved. **/
	public static function colorConvertHSVtoRGBVec(input: ImVec4): ImVec4 {return null;}

	// Inputs Utilities: Keyboard
	public static function isKeyDown(user_key_index : Int) : Bool {return false;}
	public static function isKeyPressed(user_key_index : Int, repeat : Bool = true) : Bool {return false;}
	public static function isKeyReleased(user_key_index : Int) : Bool {return false;}
	public static function getKeyPressedAmount(key_index : Int, repeat_delay : Single, rate : Single) : Int {return 0;}
	//TODO: getKeyName
	public static function captureKeyboardFromApp(want_capture_keyboard_value : Bool = true) {}
	@:deprecated("Obsolete")
	public static function getKeyIndex(imgui_key : ImGuiKey) : Int {return 0;}

	// Inputs Utilities: Mouse
	public static function isMouseDown(button : ImGuiMouseButton) : Bool {return false;}
	public static function isMouseClicked(button : ImGuiMouseButton, repeat : Bool = false) : Bool {return false;}
	public static function isMouseReleased(button : ImGuiMouseButton) : Bool {return false;}
	public static function isMouseDoubleClicked(button : ImGuiMouseButton) : Bool {return false;}
	public static function getMouseClickedCount(button : ImGuiMouseButton) : Int {return 0;}
	public static function isMouseHoveringRect(r_min : ImVec2, r_max : ImVec2, clip : Bool = true) : Bool {return false;}
	public static function isMousePosValid(?mouse_pos : ImVec2) : Bool {return false;}
	public static function isAnyMouseDown() : Bool {return false;}
	public static function getMousePos() : ImVec2 {return null;}
	public static function getMousePosOnOpeningCurrentPopup() : ImVec2 {return null;}
	public static function isMouseDragging(button : ImGuiMouseButton, lock_threshold : Single = -1.0) : Bool {return false;}
	public static function getMouseDragDelta(button : ImGuiMouseButton = 0, lock_threshold : Single = -1.0) : ImVec2 {return null;}
	public static function resetMouseDragDelta(button : ImGuiMouseButton = 0) {}
	public static function getMouseCursor() : ImGuiMouseCursor {return 0;}
	public static function setMouseCursor(cursor_type : ImGuiMouseCursor) {}
	public static function captureMouseFromApp(want_capture_mouse_value : Bool = true) {}

	// Clipboard Utilities
	static function get_clipboard_text() : hl.Bytes {return null;}
	public static function getClipboardText() : String {
		return @:privateAccess String.fromUTF8(get_clipboard_text());
	}
	public static function setClipboardText(text : String) {}

	// Settings/.Ini Utilities
	public static function loadIniSettingsFromDisk(ini_filename : String) {}
	public static function loadIniSettingsFromMemory(ini_data : String, ini_size : Int = 0) {}
	public static function saveIniSettingsToDisk(ini_filename : String) {}
	static function save_ini_settings_to_memory(out_ini_size : Ref<Int>) : hl.Bytes {return null;}
	public static function saveIniSettingsToMemory(out_ini_size : Ref<Int> = null) : String {
		return @:privateAccess String.fromUTF8(save_ini_settings_to_memory(out_ini_size));
	}



	// Viewport
	public static function updatePlatformWindows() {};
	public static function renderPlatformWindowsDefault( platform_arg: Dynamic = null, render_arg: Dynamic = null) {};



	// Debug Utilities
	//debugCheckVersionAndDataLayout

	// Memory Allocators - Should not be exposed!
	//setAllocatorFunctions(ImGuiMemAllocFunc alloc_func, ImGuiMemFreeFunc free_func, void* user_data = NULL);
	//getAllocatorFunctions(ImGuiMemAllocFunc* p_alloc_func, ImGuiMemFreeFunc* p_free_func, void** p_user_data);
	//memAlloc(size_t size);
	//memFree(void* ptr);

	// (Optional) Platform/OS interface for multi-viewport support
	// Read comments around the ImGuiPlatformIO structure for more details.
	// Note: You may use GetWindowViewport() to get the current viewport of the current window.
	// GetPlatformIO(): ImGuiPlatformIO
	// UpdatePlatformWindows();                                        // call in main loop. will call CreateWindow/ResizeWindow/etc. platform functions for each secondary viewport, and DestroyWindow for each inactive viewport.
	// RenderPlatformWindowsDefault(void* platform_render_arg = NULL, void* renderer_render_arg = NULL); // call in main loop. will call RenderWindow/SwapBuffers platform functions for each secondary viewport which doesn't have the ImGuiViewportFlags_Minimized flag set. May be reimplemented by user for custom rendering needs.
	// DestroyPlatformWindows();                                       // call DestroyWindow platform functions for all viewports. call from backend Shutdown() if you need to close platform windows before imgui shutdown. otherwise will be called by DestroyContext().
	// FindViewportByID(ImGuiID id): ImGuiViewport;                                   // this is a helper for backends.
	// FindViewportByPlatformHandle(void* platform_handle): ImGuiViewport;            // this is a helper for backends. the type platform_handle is decided by the backend (e.g. HWND, MyWindow*, GLFWwindow* etc.)

	// GetIO()->... wrappers
	@:deprecated public static function setIniFilename(filename : String) {} // IniFilename
	@:deprecated public static function addKeyChar(c : Int) {} // AddInputCharacter
	@:deprecated public static function addKeyEvent(c : Int, down: Bool) {} // AddKeyEvent
	// Shortcut to set MousePos, MouseWheel, MouseDown[0] and MouseDown[1]
	@:deprecated public static function setEvents(dt : Single, mouse_x : Single, mouse_y : Single, wheel : Single, left_click : Bool, right_click : Bool) {}
	@:deprecated public static function setDisplaySize(display_width:Int, display_height:Int) {} // DisplaySize
	@:deprecated public static function wantCaptureMouse() : Bool {return false;} // WantCaptureMouse
	@:deprecated public static function wantCaptureKeyboard() : Bool {return false;} // WantCaptureKeyboard
	@:deprecated public static function setConfigFlags(flags:ImGuiConfigFlags = 0) : Void {} // ConfigFlags
	@:deprecated public static function getConfigFlags() : ImGuiConfigFlags {return 0;} // ConfigFlags
	@:deprecated public static function setUserData(data : Dynamic) {} // UserData; Should be safe to store anything and not be GCd.
	@:deprecated public static function getUserData() : Dynamic {return null;} // UserData
	@:deprecated public static function getFontAtlas(): ImFontAtlas { return null; }

	// internal functions
	public static function setRenderCallback(render_fn:RenderList->Void) {}

	/**
		Mandatory to call before anything else!
		Provides C side the necessary hl_type references for data constructed on C side such as ImVec2 and ImVec4.
	**/
	public static inline function provideTypes() @:privateAccess {
		_init(ImVec2.get(), ImVec4.get(), new RenderList(), new RenderData(), new RenderCommand());
	}
	@:hlNative("hlimgui", "initialize")
	static function _init(vec2: ImVec2, vec4: ImVec4, renderlist: RenderList, renderdata: RenderData, rendercommand: RenderCommand) {};

	/**
		Bootstrap helper to initialize Imgui.
	**/
	public static inline function initialize(render_fn:RenderList->Void) : ImFontTexData {
		provideTypes();
		createContext();
		setRenderCallback(render_fn);
		var fonts = getIO().Fonts;
		fonts.addFontDefault();
		var output = new ImFontTexData();
		fonts.getTexDataAsRGBA32(output);
		fonts.clearTexData();
		return output;
	}

	@:deprecated("Use beginPopupContextWindow(id, MouseButtonRight | NoOpenOverItems)") @:noCompletion
	public static function beginPopupContextWindow2(str_id : String = null, mouse_button : ImGuiMouseButton = 1, also_over_items : Bool = true) : Bool {
		return beginPopupContextWindow(str_id, mouse_button | (also_over_items ? NoOpenOverItems : 0));
	}

	// DEPRECATED SECTION

	@:deprecated("Use getFontAtlas().getTexDataAsRGBA32() + getFontAtlas().clearTexData()") @:noCompletion
	public static inline function getTexDataAsRgba32(): ImFontTexData {
		var atlas = getFontAtlas();
		var output = new ImFontTexData();
		atlas.getTexDataAsRGBA32(output);
		atlas.clearTexData();
		return output;
	}

	// ImFontAtlas / ImGui::GetIO().Fonts->... wrappers
	@:deprecated("Use getFontAtlas().setTexId()")
	public static inline function setFontTexture(texture_id : ImTextureID) { getFontAtlas().setTexId(texture_id); }
	@:deprecated("Use getFontAtlas().addFontDefault()")
	public static inline function addFontDefault(?config:ImFontConfig) : ImFont { return getFontAtlas().addFontDefault(config); }
	@:deprecated("Use getFontAtlas().addFontFromFileTTF()")
	public static inline function addFontFromFileTtf( filename: String, size: Single, ?config: ImFontConfig, ?glyphRanges: hl.NativeArray<hl.UI16>) : ImFont { return getFontAtlas().addFontFromFileTTF(filename, size, config, glyphRanges); }
	@:deprecated("Use getFontAtlas().addFontFromMemoryTTF()")
	public static inline function addFontFromMemoryTtf( bytes: hl.Bytes, size: Int, font_size: Single, ?config: ImFontConfig, ?glyphRanges: hl.NativeArray<hl.UI16>) : ImFont { return getFontAtlas().addFontFromMemoryTTF(bytes, size, font_size, config, glyphRanges); }
	@:deprecated("Use getFontAtlas().build()")
	public static inline function buildFont(): Bool { return getFontAtlas().build(); }

	@:deprecated("Use beginListBox")
	public static inline function listBoxHeader(label: String, ?size: ImVec2) : Bool {return beginListBox(label, size);}
	@:deprecated("Obsolete")
	public static function listBoxHeader2(label : String, items_count : Int, height_in_items : Int = -1) : Bool {return false;}
	@:deprecated("Use endListBox")
	public static inline function listBoxFooter() { endListBox(); }

	@:deprecated("Use inputFloatN")
	public static inline function inputFloat2(label : String, v : hl.NativeArray<Single>, format : String = "%.3f", flags : ImGuiInputTextFlags = 0) : Bool {
		return inputFloatN(label, v, format, flags);
	}
	@:deprecated("Use inputFloatN")
	public static inline function inputFloat3(label : String, v : hl.NativeArray<Single>, format : String = "%.3f", flags : ImGuiInputTextFlags = 0) : Bool {
		return inputFloatN(label, v, format, flags);
	}
	@:deprecated("Use inputFloatN")
	public static inline function inputFloat4(label : String, v : hl.NativeArray<Single>, format : String = "%.3f", flags : ImGuiInputTextFlags = 0) : Bool {
		return inputFloatN(label, v, format, flags);
	}
	@:deprecated("Use inputIntN")
	public static inline function inputInt2(label : String, v : hl.NativeArray<Int>, flags : ImGuiInputTextFlags = 0) : Bool {
		return inputIntN(label, v, flags);
	}
	@:deprecated("Use inputIntN")
	public static inline function inputInt3(label : String, v : hl.NativeArray<Int>, flags : ImGuiInputTextFlags = 0) : Bool {
		return inputIntN(label, v, flags);
	}
	@:deprecated("Use inputIntN")
	public static inline function inputInt4(label : String, v : hl.NativeArray<Int>, flags : ImGuiInputTextFlags = 0) : Bool {
		return inputIntN(label, v, flags);
	}

	@:deprecated("Obsolete in latest imgui. Use GetWindowContentRegionMax().x - GetWindowContentRegionMin().x")
	public static function getWindowContentRegionWidth() : Single {return 0;}

	@:deprecated("use getIDSub") @:noCompletion public static function getID2(str_id : String, begin: Int, end: Int) : Int {return getIDSub(str_id, begin, end);}
	@:deprecated("use pushIDSub") @:noCompletion public static inline function pushID2(str_id : String, begin : Int, end : Int) { pushIDSub(str_id, begin, end); }
	@:deprecated("use pushIDInt") @:noCompletion public static inline function pushID3(int_id : Int) { pushIDInt(int_id); }

	// Pre-overload support methods.

	@:deprecated("Use beginChild overload.") @:noCompletion
	public static inline function beginChild2(id : Int, ?size : ImVec2, border : Bool = false, flags : ImGuiWindowFlags = 0) : Bool { return begin_child2(id, size, border, flags); }

	@:deprecated("Use setWindowPos overload.") @:noCompletion
	public static inline function setWindowPos2(name : String, pos : ImVec2, cond : ImGuiCond = 0) { set_window_pos2(name, pos, cond); }
	@:deprecated("Use setWindowSize overload.") @:noCompletion
	public static inline function setWindowSize2(name : String, size : ImVec2, cond : ImGuiCond = 0) { set_window_size2(name, size, cond); }
	@:deprecated("Use setWindowCollapsed overload.") @:noCompletion
	public static inline function setWindowCollapsed2(name : String, collapsed : Bool, cond : ImGuiCond = 0) { set_window_collapsed2(name, collapsed, cond); }
	@:deprecated("Use setWindowFocus overload.") @:noCompletion
	public static inline function setWindowFocus2(name : String) { set_window_focus2(name); }

	@:deprecated("Use pushStyleColor overload.") @:noCompletion
	public static inline function pushStyleColor2(idx : ImGuiCol, col : ImVec4) { push_style_color2(idx, col); }
	@:deprecated("Use pushStyleVar overload.") @:noCompletion
	public static inline function pushStyleVar2(idx : ImGuiStyleVar, val : ImVec2) { push_style_var2(idx, val); }

	@:deprecated("Use getColorU32 overload.") @:noCompletion
	public static inline function getColorU322(col : ImVec4) : ImU32 {return get_color_u322(col);}
	@:deprecated("Use getColorU32 overload.") @:noCompletion
	public static inline function getColorU323(col : ImU32) : ImU32 {return get_color_u323(col);}

	@:deprecated("Use radioButton overload.") @:noCompletion
	public static inline function radioButton2(label : String, v : Ref<Int>, v_button : Int) : Bool {return radio_button2(label, v, v_button);}

	@:deprecated("Use combo overload.") @:noCompletion
	public static inline function combo2(label : String, current_item : Ref<Int>, items_separated_by_zeros : String, popup_max_height_in_items : Int = -1) : Bool {return _combo2(label, current_item, items_separated_by_zeros, popup_max_height_in_items);}

	@:deprecated("Use treeNode overload.") @:noCompletion
	public static inline function treeNode2(str_id : String, label : String) : Bool {return tree_node2(str_id, label);}
	@:deprecated("Use treeNodeEx overload.") @:noCompletion
	public static inline function treeNodeEx2(str_id : String, flags : ImGuiTreeNodeFlags, label : String) : Bool {return tree_node_ex2(str_id, flags, label);}
	@:deprecated("Use collapsingHeader overload.") @:noCompletion
	public static inline function collapsingHeader2(label : String, p_open : Ref<Bool>, flags : ImGuiTreeNodeFlags = 0) : Bool {return collapsing_header2(label, p_open, flags);}

	@:deprecated("Use selectable overload.") @:noCompletion
	public static inline function selectable2(label : String, p_selected : Ref<Bool>, flags : ImGuiSelectableFlags = 0, ?size: ImVec2) : Bool {return _selectable2(label, p_selected, flags, size);}

	@:deprecated("Use menuItem overload.") @:noCompletion
	public static inline function menuItem2(label : String, shortcut : String, p_selected : Ref<Bool>, enabled : Bool = true) : Bool {return menu_item2(label, shortcut, p_selected, enabled);}

	@:deprecated("Use isRectVisible overload.") @:noCompletion
	public static inline function isRectVisible2(rect_min : ImVec2, rect_max : ImVec2) : Bool {return false;}
}
