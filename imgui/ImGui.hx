package imgui;

import haxe.io.Bytes;

@:forward
@:forward.variance
abstract ExtDynamic<T>(Dynamic) from T to T {
	// Helper methods to cconvert away from vdynamic.
	public var v(get, never):T;
	inline function get_v():T return (this:T);
	public inline function to():T return (this:T);
	
}

@:enum abstract ImGuiWindowFlags(Int) from Int to Int {
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
}

@:enum abstract ImGuiDockNodeFlags(Int) from Int to Int {
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

@:enum abstract ImGuiTreeNodeFlags(Int) from Int to Int {
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

@:enum abstract ImGuiTabItemFlags(Int) from Int to Int {
	var None : Int = 0;
	var UnsavedDocument : Int = 1;
	var SetSelected : Int = 2;
	var NoCloseWithMiddleMouseButton : Int = 4;
	var NoPushId : Int = 8;
}

@:enum abstract ImGuiTabBarFlags(Int) from Int to Int {
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

@:enum abstract ImGuiStyleVar(Int) from Int to Int {
	var Alpha : Int = 0;
	var DisabledAlpha : Int = 1;
	var WindowPadding : Int = 2;
	var WindowRounding : Int = 3;
	var WindowBorderSize : Int = 4;
	var WindowMinSize : Int = 5;
	var WindowTitleAlign : Int = 6;
	var ChildRounding : Int = 7;
	var ChildBorderSize : Int = 8;
	var PopupRounding : Int = 9;
	var PopupBorderSize : Int = 10;
	var FramePadding : Int = 11;
	var FrameRounding : Int = 12;
	var FrameBorderSize : Int = 13;
	var ItemSpacing : Int = 14;
	var ItemInnerSpacing : Int = 15;
	var IndentSpacing : Int = 16;
	var CellPadding : Int = 17;
	var ScrollbarSize : Int = 18;
	var ScrollbarRounding : Int = 19;
	var GrabMinSize : Int = 20;
	var GrabRounding : Int = 21;
	var TabRounding : Int = 22;
	var ButtonTextAlign : Int = 23;
	var SelectableTextAlign : Int = 24;
	var COUNT : Int = 25;
}

@:enum abstract ImGuiSelectableFlags(Int) from Int to Int {
	var None : Int = 0;
	var DontClosePopups : Int = 1;
	var SpanAllColumns : Int = 2;
	var AllowDoubleClick : Int = 4;
	var Disabled : Int = 8;
	var AllowItemOverlap : Int = 16;
}

@:enum abstract ImGuiNavInput(Int) from Int to Int {
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

@:enum abstract ImGuiMouseCursor(Int) from Int to Int {
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

@:enum abstract ImGuiMouseButton(Int) from Int to Int {
	var Left : Int = 0;
	var Right : Int = 1;
	var Middle : Int = 2;
	var COUNT : Int = 5;
}

@:enum abstract ImGuiKey(Int) from Int to Int {
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
	//
	var A: Int = 546;
	//
	var KeyPadEnter : Int = 615;
	//
	var ModCtrl : Int = 641;
	var ModShift : Int = 642;
	var ModAlt : Int = 643;
	var ModSuper : Int = 644;
}

@:enum abstract ImGuiInputTextFlags(Int) from Int to Int {
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

@:enum abstract ImGuiHoveredFlags(Int) from Int to Int {
	var None : Int = 0;
	var ChildWindows : Int = 1;
	var RootWindow : Int = 2;
	var AnyWindow : Int = 4;
	var AllowWhenBlockedByPopup : Int = 8;
	var AllowWhenBlockedByActiveItem : Int = 32;
	var AllowWhenOverlapped : Int = 64;
	var AllowWhenDisabled : Int = 128;
	var RectOnly : Int = 104;
	var RootAndChildWindows : Int = 3;
}

@:enum abstract ImGuiFocusedFlags(Int) from Int to Int {
	var None : Int = 0;
	var ChildWindows : Int = 1;
	var RootWindow : Int = 2;
	var AnyWindow : Int = 4;
	var RootAndChildWindows : Int = 3;
	var DockHierarchy : Int = 4;
}

@:enum abstract ImGuiDragDropFlags(Int) from Int to Int {
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

@:enum abstract ImGuiDir(Int) from Int to Int {
	var None : Int = -1;
	var Left : Int = 0;
	var Right : Int = 1;
	var Up : Int = 2;
	var Down : Int = 3;
	var COUNT : Int = 4;
}

@:enum abstract ImGuiDataType(Int) from Int to Int {
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

@:enum abstract ImGuiConfigFlags(Int) from Int to Int {
	var None : Int = 0;
	var NavEnableKeyboard : Int = 1;
	var NavEnableGamepad : Int = 2;
	var NavEnableSetMousePos : Int = 4;
	var NavNoCaptureKeyboard : Int = 8;
	var NoMouse : Int = 16;
	var NoMouseCursorChange : Int = 32;
	var DockingEnable : Int = 64;
	var ViewportsEnable : Int = 1024;
	var IsSRGB : Int = 1048576;
	var IsTouchScreen : Int = 2097152;
}

@:enum abstract ImGuiCond(Int) from Int to Int {
	var Always : Int = 1;
	var Once : Int = 2;
	var FirstUseEver : Int = 4;
	var Appearing : Int = 8;
}

@:enum abstract ImGuiComboFlags(Int) from Int to Int {
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

@:enum abstract ImGuiColorEditFlags(Int) from Int to Int {
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

@:enum abstract ImGuiCol(Int) from Int to Int {
	var Text : Int = 0;
	var TextDisabled : Int = 1;
	var WindowBg : Int = 2;
	var ChildBg : Int = 3;
	var PopupBg : Int = 4;
	var Border : Int = 5;
	var BorderShadow : Int = 6;
	var FrameBg : Int = 7;
	var FrameBgHovered : Int = 8;
	var FrameBgActive : Int = 9;
	var TitleBg : Int = 10;
	var TitleBgActive : Int = 11;
	var TitleBgCollapsed : Int = 12;
	var MenuBarBg : Int = 13;
	var ScrollbarBg : Int = 14;
	var ScrollbarGrab : Int = 15;
	var ScrollbarGrabHovered : Int = 16;
	var ScrollbarGrabActive : Int = 17;
	var CheckMark : Int = 18;
	var SliderGrab : Int = 19;
	var SliderGrabActive : Int = 20;
	var Button : Int = 21;
	var ButtonHovered : Int = 22;
	var ButtonActive : Int = 23;
	var Header : Int = 24;
	var HeaderHovered : Int = 25;
	var HeaderActive : Int = 26;
	var Separator : Int = 27;
	var SeparatorHovered : Int = 28;
	var SeparatorActive : Int = 29;
	var ResizeGrip : Int = 30;
	var ResizeGripHovered : Int = 31;
	var ResizeGripActive : Int = 32;
	var Tab : Int = 33;
	var TabHovered : Int = 34;
	var TabActive : Int = 35;
	var TabUnfocused : Int = 36;
	var TabUnfocusedActive : Int = 37;
	var PlotLines : Int = 38;
	var PlotLinesHovered : Int = 39;
	var PlotHistogram : Int = 40;
	var PlotHistogramHovered : Int = 41;
	var TextSelectedBg : Int = 42;
	var DragDropTarget : Int = 43;
	var NavHighlight : Int = 44;
	var NavWindowingHighlight : Int = 45;
	var NavWindowingDimBg : Int = 46;
	var ModalWindowDimBg : Int = 47;
	var COUNT : Int = 48;
}

@:enum abstract ImGuiBackendFlags(Int) from Int to Int {
	var None : Int = 0;
	var HasGamepad : Int = 1;
	var HasMouseCursors : Int = 2;
	var HasSetMousePos : Int = 4;
	var RendererHasVtxOffset : Int = 8;
}

@:enum abstract ImFontAtlasFlags(Int) from Int to Int {
	var None : Int = 0;
	var NoPowerOfTwoHeight : Int = 1;
	var NoMouseCursors : Int = 2;
}

@:enum abstract ImDrawListFlags(Int) from Int to Int {
	var None : Int = 0;
	var AntiAliasedLines : Int = 1;
	var AntiAliasedFill : Int = 2;
	var AllowVtxOffset : Int = 4;
}

@:enum abstract ImGuiSliderFlags(Int) from Int to Int {
	var None : Int = 0;
	var AlwaysClamp : Int = 16; // Clamp value to min/max bounds when input manually with CTRL+Click. By default CTRL+Click allows going out of bounds.
	var Logarithmic : Int = 32; // Make the widget logarithmic (linear otherwise). Consider using ImGuiSliderFlags_NoRoundToFormat with this if using a format-string with small amount of digits.
	var NoRoundToFormat : Int = 64; // Disable rounding underlying value to match precision of the display format string (e.g. %.3f values are rounded to those 3 digits)
	var NoInput : Int = 128; // Disable CTRL+Click or Enter key allowing to input text directly into the widget
}

@:enum abstract ImGuiTableFlags(Int) from Int to Int {
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

@:enum abstract ImGuiTableRowFlags(Int) from Int to Int {
    var None                         = 0;
    var Headers                      = 1 << 0;    // Identify header row (set default background color + width of its contents accounted differently for auto column width)
}

@:enum abstract ImGuiTableBgTarget(Int) from Int to Int {
    var None                         = 0;
    var RowBg0                       = 1;        // Set row background color 0 (generally used for background, automatically set when ImGuiTableFlags_RowBg is used)
    var RowBg1                       = 2;        // Set row background color 1 (generally used for selection marking)
    var CellBg                       = 3;        // Set cell background color (top-most color)
}

@:enum abstract ImGuiTableColumnFlags(Int) from Int to Int {
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

// Flags for ImDrawList functions
// (Legacy: bit 0 must always correspond to ImDrawFlags_Closed to be backward compatible with old API using a bool. Bits 1..3 must be unused)
@:enum abstract ImDrawFlags(Int) from Int to Int {
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
    var RoundCornersDefault_        = RoundCornersAll; // Default to ALL corners if none of the _RoundCornersXX flags are specified.
    var RoundCornersMask_           = RoundCornersAll | RoundCornersNone;
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
// To avoid allocation of unecessary things - cache and reuse some instances.
private class ImTypeCache {
	
	public static var imVec2: Array<ImVec2Impl> = [
		{ x: 0, y: 0 },
		{ x: 0, y: 0 },
		{ x: 0, y: 0 },
		{ x: 0, y: 0 },
	];
	
}
@:structInit
private class ImVec2Impl {
	public var x: Single;
	public var y: Single;
	public inline function set(x: Single, y: Single) {
		this.x = x;
		this.y = y;
		return this;
	}
}
#else
typedef ImTextureID = Dynamic;
#end
typedef ImU32 = Int;
typedef ImGuiID = Int;

typedef ImVec2 = {
	x : Single,
	y : Single
}

typedef ImVec4 = {
	x : Single,
	y : Single,
	z : Single,
	w : Single
}

typedef ImGuiStyle = {
    Alpha : Single,
    WindowPadding : ImVec2,
    WindowRounding : Single,
    WindowBorderSize : Single,
    WindowMinSize : ImVec2,
    WindowTitleAlign : ImVec2,
    WindowMenuButtonPosition : ImGuiDir,
    ChildRounding : Single,
    ChildBorderSize : Single,
    PopupRounding : Single,
    PopupBorderSize : Single,
    FramePadding : ImVec2,
    FrameRounding : Single,
    FrameBorderSize : Single,
    ItemSpacing : ImVec2,
    ItemInnerSpacing : ImVec2,
    TouchExtraPadding : ImVec2,
    IndentSpacing : Single,
    ColumnsMinSpacing : Single,
    ScrollbarSize : Single,
    ScrollbarRounding : Single,
    GrabMinSize : Single,
    GrabRounding : Single,
    TabRounding : Single,
    TabBorderSize : Single,
    TabMinWidthForCloseButton : Single,
    ColorButtonPosition : ImGuiDir,
    ButtonTextAlign : ImVec2,
    SelectableTextAlign : ImVec2,
    DisplayWindowPadding : ImVec2,
    DisplaySafeAreaPadding : ImVec2,
    MouseCursorScale : Single,
    AntiAliasedLines : Bool,
    AntiAliasedFill : Bool,
    CurveTessellationTol : Single,
    CircleSegmentMaxError : Single,
    Colors : hl.NativeArray<ImVec4>
};

/**
 * ImFontConfig
 * Currently we don't support passing this struct back into haxe on creation; so it's current definition
 * and use cases are limited to configuring a font you're about to create.
 *
 * As a technical note, glypgRanges will currently leak memory, so avoid paths which use this feature per frame.
 */
 @:structInit
class ImFontConfig
{
	var OversampleH: Int = 3;						// Rasterize at higher quality for sub-pixel positioning. Read https://github.com/nothings/stb/blob/master/tests/oversample/README.md for details.
	var OversampleV: Int = 1;						// Rasterize at higher quality for sub-pixel positioning. We don't use sub-pixel positions on the Y axis.// Rasterize at higher quality for sub-pixel positioning. We don't use sub-pixel positions on the Y axis.
	var PixelSnapH: Bool = false;					// Align every glyph to pixel boundary. Useful e.g. if you are merging a non-pixel aligned font with the default font. If enabled, you can set OversampleH/V to 1.
	var GlyphExtraSpacing: ImVec2 = {x: 0, y:0};	// Extra spacing (in pixels) between glyphs. Only X axis is supported for now.
	var GlyphOffset: ImVec2 =  {x: 0, y:0};			// Offset all glyphs from this font input.
	var GlyphRanges: hl.NativeArray<hl.UI16> = null;// Pointer to a user-provided list of Unicode range (2 value per range, values are inclusive, zero-terminated list). THE ARRAY DATA NEEDS TO PERSIST AS LONG AS THE FONT IS ALIVE, currently this will just leak.
	var GlyphMinAdvanceX: Single = 0;				// Minimum AdvanceX for glyphs, set Min to align font icons, set both Min/Max to enforce mono-space font
	var GlyphMaxAdvanceX: Single = 3.402823E+38;	// FLT_MAX  // Maximum AdvanceX for glyphs
	var MergeMode: Bool = false;					// Merge into previous ImFont, so you can combine multiple inputs font into one ImFont (e.g. ASCII font + icons + Japanese glyphs). You may want to use GlyphOffset.y when merge font of different heights.
	var RasterizerFlags: Int = 0;					// Settings for custom font rasterizer (e.g. ImGuiFreeType). Leave as zero if you aren't using one.
	var RasterizerMultiply: Single = 1;				// Brighten (>1.0f) or darken (<1.0f) font output. Brightening small fonts may be a good workaround to make them more readable.
	var EllipsisChar: Int = -1;						// Explicitly specify unicode codepoint of ellipsis character. When fonts are being merged first specified ellipsis will be used.
}

private typedef ImFontPtr = hl.Abstract<"imfont">;
private typedef ImDrawListPtr = hl.Abstract<"imdrawlist">;
private typedef ImStateStoragePtr = hl.Abstract<"imstatestorage">;
private typedef ImContextPtr = hl.Abstract<"imcontext">;
private typedef ImGuiDockNode = hl.Abstract<"imguidocknode">;

@:hlNative("hlimgui")
abstract ImDrawList(ImDrawListPtr) from ImDrawListPtr to ImDrawListPtr
{
	public function new(ptr: ImDrawListPtr) { this = ptr; }

	public function addLine( p1: ImVec2, p2: ImVec2, col: ImU32, thickness: Single = 1.0 ) { drawlist_add_line( this, p1, p2, col, thickness ); }
	public function addRect( pMin: ImVec2, pMax: ImVec2, col: ImU32, rounding: Single = 0.0, roundingCorners: ImDrawFlags = ImDrawFlags.None, thickness: Single = 1.0 ) { drawlist_add_rect( this, pMin, pMax, col, rounding, roundingCorners, thickness ); }
	public function addRectFilled( pMin: ImVec2, pMax: ImVec2, col: ImU32, rounding: Single = 0.0, roundingCorners: ImDrawFlags = ImDrawFlags.None ) { drawlist_add_rect_filled( this, pMin, pMax, col, rounding, roundingCorners); }
	public function addRectFilledMultiColor( pMin: ExtDynamic<ImVec2>, pMax: ExtDynamic<ImVec2>, col_upr_left: ImU32, col_upr_right: ImU32, col_bot_right: ImU32, col_bot_left: ImU32 ) { drawlist_add_rect_filled_multicolor( this, pMin, pMax, col_upr_left, col_upr_right, col_bot_right, col_bot_left ); }
	public function addQuad( p1: ExtDynamic<ImVec2>, p2: ExtDynamic<ImVec2>, p3: ExtDynamic<ImVec2>, p4: ExtDynamic<ImVec2>, col: ImU32, thickness: Single = 1.0 ) { drawlist_add_quad(this, p1, p2, p3, p4, col, thickness ); }
	public function addQuadFilled( p1: ExtDynamic<ImVec2>, p2: ExtDynamic<ImVec2>, p3: ExtDynamic<ImVec2>, p4: ExtDynamic<ImVec2>, col: ImU32 ) { drawlist_add_quad_filled( this, p1, p2, p3, p4, col ); }
	public function addTriangle( p1: ExtDynamic<ImVec2>, p2: ExtDynamic<ImVec2>, p3: ExtDynamic<ImVec2>, col: ImU32, thickness: Single = 1.0 ) { drawlist_add_triangle(this, p1, p2, p3, col, thickness ); }
	public function addTriangleFilled( p1: ExtDynamic<ImVec2>, p2: ExtDynamic<ImVec2>, p3: ExtDynamic<ImVec2>, col: ImU32 ) { drawlist_add_triangle_filled(this, p1, p2, p3, col ); }
	public function addCircle( center: ExtDynamic<ImVec2>, radius: Single, col: ImU32, num_segments: Int = 0, thickness: Single = 1.0 ) { drawlist_add_circle( this, center, radius, col, num_segments, thickness ); }
	public function addCircleFilled( center: ExtDynamic<ImVec2>, radius: Single, col: ImU32, num_segments: Int = 0) { drawlist_add_circle_filled(this, center, radius, col, num_segments ); }
	public function addNgon( center: ExtDynamic<ImVec2>, radius: Single, col: ImU32, num_segments: Int, thickness: Single = 1.0 ) { drawlist_add_ngon(this, center, radius, col, num_segments, thickness ); }
	public function addNgonFilled( center: ExtDynamic<ImVec2>, radius: Single, col: ImU32, num_segments: Int = 0) { drawlist_add_ngon_filled(this, center, radius, col, num_segments ); }
	//public function addPolyLine( points: hl.NativeArray<ImVec2>, col: ImU32, closed: Bool, thickness: Single = 1.0 ) { drawlist_add_poly_line(this, points, col, closed, thickness ); }
	//public function addConvexPolyFilled( points: hl.NativeArray<ExtDynamic<ImVec2>>, col: ImU32 ) { drawlist_add_convex_poly_filled(this, points, col ); }
	public function addBezierCurve( p1: ExtDynamic<ImVec2>, p2: ExtDynamic<ImVec2>, p3: ExtDynamic<ImVec2>, p4: ExtDynamic<ImVec2>, col: ImU32, thickness: Single = 1.0, num_segments: Int = 0 ) { drawlist_add_bezier_curve(this, p1, p2, p3, p4, col, thickness, num_segments ); }
	//
	public function addText( pos: ImVec2, col: ImU32, text: String ) { drawlist_add_text(this, pos, col, text); }
	public function addText2( font: ImFont, fontSize: Single, pos: ImVec2, col: ImU32, text: String, wrapWidth: Single = 0.0, ?cpuFineClipRect: ImVec4 ) { drawlist_add_text2(this, font==null?null:(@:privateAccess font.ptr), fontSize, pos, col, text, wrapWidth, cpuFineClipRect); }

	public function addImage( userTextureId: ImTextureID, pMin: ImVec2, pMax: ImVec2, ?uvMin: ImVec2, ?uvMax: ImVec2, col: Int = 0xffffffff ) { drawlist_add_image(this, userTextureId, pMin, pMax, uvMin, uvMax, col); }
	public function addImageQuad( userTextureId: ImTextureID, p1: ImVec2, p2: ImVec2, p3: ImVec2, p4: ImVec2, ?uv1: ImVec2, ?uv2: ImVec2, ?uv3: ImVec2, ?uv4: ImVec2, col: Int = 0xffffffff ) { drawlist_add_image_quad(this, userTextureId, p1, p2, p3, p4, uv1, uv2, uv3, uv4, col); }
	// Due to Haxe limitation on defualt parameters being "constant" and enum abstract values that rely on previous enum abstract value (A | B) are not "constant" - hack with -1
	public function addImageRounded( userTextureId: ImTextureID, pMin: ImVec2, pMax: ImVec2, ?uvMin: ImVec2, ?uvMax: ImVec2, col: Int, rounding: Single, roundingCorners: ImDrawFlags = -1 ) { drawlist_add_image_rounded(this, userTextureId, pMin, pMax, uvMin, uvMax, col, rounding, roundingCorners == -1 ? ImDrawFlags.RoundCornersDefault_ : roundingCorners); }
	
	#if heaps
	// Helper methods for Heaps: Use Tile instead of Texture to pass image segments easily.
	
	public inline function addTile( tile: h2d.Tile, pMin: ImVec2, pMax: ImVec2, col: Int = 0xffffffff, honorDxDy = false) @:privateAccess {
		if (honorDxDy) {
			pMin.x += tile.dx;
			pMin.y += tile.dy;
			pMax.x += tile.dx;
			pMax.y += tile.dy;
		}
		addImage(tile.getTexture(), pMin, pMax, ImTypeCache.imVec2[0].set(tile.u, tile.v), ImTypeCache.imVec2[1].set(tile.u2, tile.v2), col);
	}
	
	public inline function addTileQuad( tile: h2d.Tile, p1: ImVec2, p2: ImVec2, p3: ImVec2, p4: ImVec2, col: Int = 0xffffffff) @:privateAccess {
		addImageQuad( tile.getTexture(), p1, p2, p3, p4,
			ImTypeCache.imVec2[0].set(tile.u, tile.v), ImTypeCache.imVec2[1].set(tile.u2, tile.v), ImTypeCache.imVec2[2].set(tile.u2, tile.v2), ImTypeCache.imVec2[3].set(tile.u2, tile.v),
			col
		);
	}
	
	public inline function addTileRounded( tile: h2d.Tile, pMin: ImVec2, pMax: ImVec2, col: Int, rounding: Single, roundingCorners: ImDrawFlags = -1, honorDxDy = false ) @:privateAccess {
		if (honorDxDy) {
			pMin.x += tile.dx;
			pMin.y += tile.dy;
			pMax.x += tile.dx;
			pMax.y += tile.dy;
		}
		addImageRounded( tile.getTexture(), pMin, pMax, ImTypeCache.imVec2[0].set(tile.u, tile.v), ImTypeCache.imVec2[1].set(tile.u2, tile.v2), col, rounding, roundingCorners);
	}
	#end
	
	static function drawlist_add_line( drawlist: ImDrawListPtr, p1: ExtDynamic<ImVec2>, p2: ExtDynamic<ImVec2>, col: ImU32, thickness: Single ) {}
	static function drawlist_add_rect( drawlist: ImDrawListPtr, pMin: ExtDynamic<ImVec2>, pMax: ExtDynamic<ImVec2>, col: ImU32, rounding: Single, roundingCorners: ImDrawFlags, thickness ) {}
	static function drawlist_add_rect_filled( drawlist: ImDrawListPtr, pMin: ExtDynamic<ImVec2>, pMax: ExtDynamic<ImVec2>, col: ImU32, rounding: Single, roundingCorners: ImDrawFlags ) {}
	static function drawlist_add_rect_filled_multicolor( drawlist: ImDrawListPtr, pMin: ExtDynamic<ImVec2>, pMax: ExtDynamic<ImVec2>, col_upr_left: ImU32, col_upr_right: ImU32, col_bot_right: ImU32, col_bot_left: ImU32 ) {}
	static function drawlist_add_quad( drawlist: ImDrawListPtr, p1: ExtDynamic<ImVec2>, p2: ExtDynamic<ImVec2>, p3: ExtDynamic<ImVec2>, p4: ExtDynamic<ImVec2>, col: ImU32, thickness: Single ) {}
	static function drawlist_add_quad_filled( drawlist: ImDrawListPtr, p1: ExtDynamic<ImVec2>, p2: ExtDynamic<ImVec2>, p3: ExtDynamic<ImVec2>, p4: ExtDynamic<ImVec2>, col: ImU32 ) {}
	static function drawlist_add_triangle( drawlist: ImDrawListPtr, p1: ExtDynamic<ImVec2>, p2: ExtDynamic<ImVec2>, p3: ExtDynamic<ImVec2>, col: ImU32, thickness: Single ) {}
	static function drawlist_add_triangle_filled( drawlist: ImDrawListPtr, p1: ExtDynamic<ImVec2>, p2: ExtDynamic<ImVec2>, p3: ExtDynamic<ImVec2>, col: ImU32 ) {}
	static function drawlist_add_circle( drawlist: ImDrawListPtr, center: ExtDynamic<ImVec2>, radius: Single, col: ImU32, num_segments: Int, thickness: Single ) {}
	static function drawlist_add_circle_filled( drawlist: ImDrawListPtr, center: ExtDynamic<ImVec2>, radius: Single, col: ImU32, num_segments: Int) {}
	static function drawlist_add_ngon( drawlist: ImDrawListPtr, center: ExtDynamic<ImVec2>, radius: Single, col: ImU32, num_segments: Int, thickness: Single ) {}
	static function drawlist_add_ngon_filled( drawlist: ImDrawListPtr, center: ExtDynamic<ImVec2>, radius: Single, col: ImU32, num_segments: Int) {}
	static function drawlist_add_poly_line( drawlist: ImDrawListPtr, points: hl.NativeArray<ImVec2>, col: ImU32, closed: Bool, thickness: Single ) {}
	static function drawlist_add_convex_poly_filled( drawlist: ImDrawListPtr, points: hl.NativeArray<ExtDynamic<ImVec2>>, col: ImU32 ) {}
	static function drawlist_add_bezier_curve( drawlist: ImDrawListPtr, p1: ExtDynamic<ImVec2>, p2: ExtDynamic<ImVec2>, p3: ExtDynamic<ImVec2>, p4: ExtDynamic<ImVec2>, col: ImU32, thickness: Single, num_segments: Int ) {}
	static function drawlist_add_text( drawlist: ImDrawListPtr, pos: ExtDynamic<ImVec2>, col: ImU32, text: String ) {}
	static function drawlist_add_text2( drawlist: ImDrawListPtr, font: ImFontPtr, font_size: Single, pos: ExtDynamic<ImVec2>, col: ImU32, text: String, wrap_width: Single, cpu_fine_clip_rect: ExtDynamic<ImVec4> ) {}
	
	static function drawlist_add_image( drawlist: ImDrawListPtr, userTextureId: ImTextureID, pMin: ExtDynamic<ImVec2>, pMax: ExtDynamic<ImVec2>, uvMin: ExtDynamic<ImVec2>, uvMax: ExtDynamic<ImVec2>, col: ImU32 ) {}
	static function drawlist_add_image_quad( drawlist: ImDrawListPtr, userTextureId: ImTextureID, p1: ExtDynamic<ImVec2>, p2: ExtDynamic<ImVec2>, p3: ExtDynamic<ImVec2>, p4: ExtDynamic<ImVec2>, uv1: ExtDynamic<ImVec2>, uv2: ExtDynamic<ImVec2>, uv3: ExtDynamic<ImVec2>, uv4: ExtDynamic<ImVec2>, col: ImU32 ) {}
	static function drawlist_add_image_rounded( drawlist: ImDrawListPtr, userTextureId: ImTextureID, pMin: ExtDynamic<ImVec2>, pMax: ExtDynamic<ImVec2>, uvMin: ExtDynamic<ImVec2>, uvMax: ExtDynamic<ImVec2>, col: ImU32, rounding: Single, roundingCorners: ImDrawFlags ) {}
}


@:hlNative("hlimgui")
abstract ImFont(ImFontPtr) from ImFontPtr to ImFontPtr
{
	// For backwards compatibility
	var ptr(get, never): ImFontPtr;
	inline function get_ptr() return this;

	public function new(ptr: ImFontPtr) { this = ptr; }
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
class ImGui
{
	public static inline var FLT_MAX = 3.402823466e+38;

	// Context
	public static function createContext() : ImContextPtr {return null;}
	public static function destroyContext(ctx : ImContextPtr = null) {}
	public static function getCurrentContext() : ImContextPtr {return null;}
	public static function setCurrentContext(ctx : ImContextPtr) {}

	// Main
	public static function getStyle() : ExtDynamic<ImGuiStyle> {return null;}
	public static function setStyle(style : ExtDynamic<ImGuiStyle>) {}
	public static function newFrame() {}
	public static function endFrame() {}
	public static function render() {}

	// Demo, Debug, Information
	public static function showDemoWindow(open : hl.Ref<Bool> = null) {}
	public static function showMetricsWindow(open : hl.Ref<Bool> = null) {}
	public static function showStackToolWindow(open : hl.Ref<Bool> = null) {}
	public static function showAboutWindow(open : hl.Ref<Bool> = null) {}
	public static function showStyleEditor(style : ExtDynamic<ImGuiStyle> = null) {}
	public static function showStyleSelector(label : String) : Bool {return false;}
	public static function showFontSelector(label : String) {}
	public static function showUserGuide() {}
	static function get_version() : hl.Bytes {return null;}
	public static inline function getVersion() : String {
		return @:privateAccess String.fromUTF8(get_version());
	}

	// styles
	public static function styleColorsDark(style : ExtDynamic<ImGuiStyle> = null) {}
	public static function styleColorsClassic(style : ExtDynamic<ImGuiStyle> = null) {}
	public static function styleColorsLight(style : ExtDynamic<ImGuiStyle> = null) {}

	// windows
	public static function begin(name : String, open : hl.Ref<Bool> = null, flags : ImGuiWindowFlags = 0) : Bool {return false;}
	public static function end() {}

	// Child windows
	public static function beginChild(str_id : String, size : ExtDynamic<ImVec2> = null, border : Bool = false, flags : ImGuiWindowFlags = 0) : Bool {return false;}
	public static function beginChild2(id : Int, size : ExtDynamic<ImVec2> = null, border : Bool = false, flags : ImGuiWindowFlags = 0) : Bool {return false;}
	public static function endChild() {}

	// Windows utilities
	public static function isWindowAppearing() : Bool {return false;}
	public static function isWindowCollapsed() : Bool {return false;}
	public static function isWindowFocused(flags : ImGuiFocusedFlags = 0) {return false;}
	public static function isWindowHovered(flags : ImGuiFocusedFlags = 0) {return false;}
	public static function getWindowDpiScale(): Single { return 0; }
	public static function getWindowPos() : ExtDynamic<ImVec2> {return null;}
	public static function getWindowSize() : ExtDynamic<ImVec2> {return null;}
	public static function getWindowWidth() : Single {return 0;}
	public static function getWindowHeight(): Single {return 0;}

	// Window manipulation
	public static function setNextWindowPos(pos : ExtDynamic<ImVec2>, cond : ImGuiCond = 0, pivot : ExtDynamic<ImVec2> = null) {}
	public static function setNextWindowSize(size: ExtDynamic<ImVec2>, cond : ImGuiCond = 0) {}
	public static function setNextWindowSizeConstraints(size_min : ExtDynamic<ImVec2>, size_max : ExtDynamic<ImVec2>) {}
	public static function setNextWindowContentSize(size : ExtDynamic<ImVec2>) {}
	public static function setNextWindowCollapsed(collapsed : Bool, cond : ImGuiCond = 0) {}
	public static function setNextWindowFocus() {}
	public static function setNextWindowBgAlpha(alpha : Single) {}
	public static function setWindowPos(pos : ExtDynamic<ImVec2>, cond : ImGuiCond = 0) {}
	public static function setWindowSize(size : ExtDynamic<ImVec2>, cond : ImGuiCond = 0) {}
	public static function setWindowCollapsed(collapsed : Bool, cond : ImGuiCond = 0) {}
	public static function setWindowFocus() {}
	public static function setWindowFontScale(scale : Single) {}
	public static function setWindowPos2(name : String, pos : ExtDynamic<ImVec2>, cond : ImGuiCond = 0) {}
	public static function setWindowSize2(name : String, size : ExtDynamic<ImVec2>, cond : ImGuiCond = 0) {}
	public static function setWindowCollapsed2(name : String, collapsed : Bool, cond : ImGuiCond = 0) {}
	public static function setWindowFocus2(name : String) {}

	// Docking
	public static function dockSpace(id : ImGuiID, size : ExtDynamic<ImVec2> = null, flags : ImGuiDockNodeFlags = 0) {}
	public static function setNextWindowDockId(id : ImGuiID, cond : ImGuiCond = 0) {}
	public static function getWindowDockId() : ImGuiID { return 0; }
	public static function isWindowDocked() : Bool { return false; }

	// Dock Builder
	public static function dockBuilderDockWindow(window_name: String, node_id : ImGuiID) {}
	public static function dockBuilderGetNode(node_id : ImGuiID) : ImGuiDockNode { return null; }
	public static function dockBuilderGetCentralNode(node_id : ImGuiID) : ImGuiDockNode { return null; }
	public static function dockBuilderAddNode(node_id : ImGuiID, flags: ImGuiDockNodeFlags) : ImGuiID { return 0; }
	public static function dockBuilderRemoveNode(node_id : ImGuiID) {}
	public static function dockBuilderRemoveNodeDockedWindows(node_id : ImGuiID, clear_settings_refs: Bool) {}
	public static function dockBuilderRemoveNodeChildNodes(node_id : ImGuiID) {}
	public static function dockBuilderSetNodePos(node_id : ImGuiID, pos: ExtDynamic<ImVec2> ) {}
	public static function dockBuilderSetNodeSize(node_id : ImGuiID, size: ExtDynamic<ImVec2> ) {}
	public static function dockBuilderSplitNode(node_id : ImGuiID, split_dir: ImGuiDir, size_ratio_for_node_at_dir: Single, out_id_at_dir: hl.Ref<ImGuiID>, out_id_at_opposite_dir: hl.Ref<ImGuiID> ) { return 0; }
	public static function dockBuilderCopyWindowSettings(src_name: String, dst_name: String) {}
	public static function dockBuilderFinish(node_id : ImGuiID) {}

	// Content region
	public static function getContentRegionMax() : ExtDynamic<ImVec2> {return null;}
	public static function getContentRegionAvail() : ExtDynamic<ImVec2> {return null;}
	public static function getWindowContentRegionMin() : ExtDynamic<ImVec2> {return null;}
	public static function getWindowContentRegionMax() : ExtDynamic<ImVec2> {return null;}
	@:deprecated // Obsoleted in latest imgui
	public static function getWindowContentRegionWidth() : Single {return 0;}

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
	public static function pushStyleColor(idx : ImGuiCol, col : ImU32) {}
	public static function pushStyleColor2(idx : ImGuiCol, col : ExtDynamic<ImVec4>) {}
	public static function popStyleColor(count : Int = 1) {}
	public static function pushStyleVar(idx : ImGuiStyleVar, val : Single) {}
	public static function pushStyleVar2(idx : ImGuiStyleVar, val : ExtDynamic<ImVec2>) {}
	public static function popStyleVar(count : Int = 1) {}
	public static function pushAllowKeyboardFocus(allow_keyboard_focus : Bool) {}
	public static function popAllowKeyboardFocus() {}
	public static function pushButtonRepeat(repeat : Bool) {}
	public static function popButtonRepeat() {}
	
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
	public static function getFontTexUvWhitePixel() : ExtDynamic<ImVec2> {return null;}
	public static function getColorU32(idx : ImGuiCol, alpha_mul : Single = 1.0) : ImU32 {return 0;}
	public static function getColorU322(col : ExtDynamic<ImVec4>) : ImU32 {return 0;}
	public static function getColorU323(col : ImU32) : ImU32 {return 0;}
	public static function getStyleColorVec4(idx : ImGuiCol) : ExtDynamic<ImVec4> {return null;}

	// Cursor / Layout
	public static function separator() {}
	public static function sameLine(offset_from_start_x : Single = 0.0, spacing : Single = -1.0) {}
	public static function newLine() {}
	public static function spacing() {}
	public static function dummy(size : ExtDynamic<ImVec2>) {}
	public static function indent(indent_w : Single = 0.0) {}
	public static function unindent(indent_w : Single = 0.0) {}
	public static function beginGroup() {}
	public static function endGroup() {}
	public static function getCursorPos() : ExtDynamic<ImVec2> {return null;}
	public static function getCursorPosX() : Single {return 0;}
	public static function getCursorPosY() : Single {return 0;}
	public static function setCursorPos(local_pos : ExtDynamic<ImVec2>) {}
	public static function setCursorPosX(local_x : Single) {}
	public static function setCursorPosY(local_y : Single) {}
	public static function getCursorStartPos() : ExtDynamic<ImVec2> {return null;}
	public static function getCursorScreenPos() : ExtDynamic<ImVec2> {return null;}
	public static function setCursorScreenPos(pos : ExtDynamic<ImVec2>) {}
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
	
	@:deprecated("use getIDSub") public static function getID2(str_id : String, begin: Int, end: Int) : Int {return getIDSub(str_id, begin, end);}
	@:deprecated("use pushIDSub") public static inline function pushID2(str_id : String, begin : Int, end : Int) { pushIDSub(str_id, begin, end); }
	@:deprecated("use pushIDInt") public static inline function pushID3(int_id : Int) { pushIDInt(int_id); }

	// Widgets: Text
	// TODO: TextUnformatted(text: String, ?start: Int, ?end: Int)
	// TODO: Allow format arguments to be passed
	public static function text(text : String) {}
	public static function textColored(col : ExtDynamic<ImVec4>, fmt : String) {}
	public static function textDisabled(text : String) {}
	public static function textWrapped(text : String) {}
	public static function labelText(label : String, text : String) {}
	public static function bulletText(text : String) {}

	// Widgets: Main
	public static function button(name : String, ?size : ExtDynamic<ImVec2>) : Bool {return false;}
	public static function smallButton(label : String) : Bool {return false;}
	public static function invisibleButton(str_id : String, ?size : ExtDynamic<ImVec2>) : Bool {return false;}
	public static function arrowButton(str_id : String, dir : ImGuiDir) : Bool {return false;}
	public static function image(user_texture_id : ImTextureID, size : ExtDynamic<ImVec2>, uv0 : ExtDynamic<ImVec2> = null, uv1 : ExtDynamic<ImVec2> = null, tint_col : ExtDynamic<ImVec4> = null, border_col : ExtDynamic<ImVec4> = null) {}
	public static function imageButton(user_texture_id : ImTextureID, size : ExtDynamic<ImVec2>, uv0 : ExtDynamic<ImVec2> = null,  uv1 : ExtDynamic<ImVec2> = null, frame_padding : Int = -1, bg_col : ExtDynamic<ImVec4> = null, tint_col : ExtDynamic<ImVec4> = null) : Bool {return false;}
	#if heaps
	public static inline function imageTile( tile: h2d.Tile, ?size: ImVec2, ?tint_col: ImVec4, ?border_col: ImVec4) @:privateAccess {
		image(tile.getTexture(), size == null ? ImTypeCache.imVec2[0].set(tile.width, tile.height) : size, ImTypeCache.imVec2[1].set(tile.u, tile.v), ImTypeCache.imVec2[2].set(tile.u2, tile.v2), tint_col, border_col);
	}
	
	public static inline function imageTileButton( tile: h2d.Tile, ?size: ImVec2, frame_padding: Int = -1, ?bg_col: ImVec4, ?tint_col: ImVec4): Bool @:privateAccess {
		return imageButton(tile.getTexture(), size == null ? ImTypeCache.imVec2[0].set(tile.width, tile.height) : size, ImTypeCache.imVec2[1].set(tile.u, tile.v), ImTypeCache.imVec2[2].set(tile.u2, tile.v2), frame_padding, bg_col, tint_col);
	}
	#end
	public static function checkbox(label : String, v : hl.Ref<Bool>) : Bool {return false;}
	public static function checkboxFlags(label : String, flags : hl.Ref<Int>, flags_value : Int) : Bool {return false;}
	public static function radioButton(label : String, active : Bool) : Bool {return false;}
	public static function radioButton2(label : String, v : hl.Ref<Int>, v_button : Int) : Bool {return false;}
	public static function progressBar(fraction : Single, size_arg : ExtDynamic<ImVec2> = null, overlay : String = null) {}
	public static function bullet() {}

	// Widgets: Combo Box
	public static function beginCombo(label : String, preview_value : String, flags : ImGuiComboFlags = 0) : Bool {return false;}
	public static function endCombo() {}
	public static function combo(label : String, current_item : hl.Ref<Int>, items : hl.NativeArray<String>, popup_max_height_in_items : Int = -1) : Bool {return false;}
	public static function combo2(label : String, current_item : hl.Ref<Int>, items_separated_by_zeros : String, popup_max_height_in_items : Int = -1) : Bool {return false;}
	// TODO: comboCallback variant

	// Widgets: Drags
	public static function dragFloat(label : String, v : hl.Ref<Single>, v_speed : Single = 1.0, v_min : Single = 0.0, v_max : Single = 0.0, format : String = "%.3f", flags : ImGuiSliderFlags = 0) : Bool {return false;}
	public static function dragInt(label : String, v : hl.Ref<Int>, v_speed : Single = 1.0, v_min : Int = 0, v_max : Int = 0, format : String = "%d", flags : ImGuiSliderFlags = 0) : Bool {return false;}
	public static function dragDouble(label : String, v : hl.Ref<Float>, v_speed : Single = 1.0, v_min : Float = 0.0, v_max : Float = 0.0, format : String = "%.3lf", flags : ImGuiSliderFlags = 0) : Bool {return false;}

	public static function dragFloatRange2(label : String, v_current_min : hl.Ref<Single>, v_current_max : hl.Ref<Single>, v_speed : Single = 1.0, v_min : Single = 0.0, v_max : Single = 0.0, format : String = "%.3f", format_max : String = null, flags : ImGuiSliderFlags = 0) : Bool {return false;}
	public static function dragIntRange2(label : String, v_current_min : hl.Ref<Int>, v_current_max : hl.Ref<Int>, v_speed : Single = 1.0, v_min : Int = 0, v_max : Int = 0, format : String = "%.d", format_max : String = null, flags : ImGuiSliderFlags = 0) : Bool {return false;}

	public static inline function dragFloatN(label : String, v : hl.NativeArray<Single>, v_speed : Single = 1.0, v_min : Single = 0.0, v_max : Single = 0.0, format : String = "%.3f", flags : ImGuiSliderFlags = 0) : Bool {
		return drag_scalar_n(label, ImGuiDataType.Float, v, v_speed, v_min, v_max, format, flags);
	}
	public static inline function dragIntN(label : String, v : hl.NativeArray<Int>, v_speed : Single = 1.0, v_min : Int = 0, v_max : Int = 0, format : String = "%d", flags : ImGuiSliderFlags = 0) : Bool {
		return drag_scalar_n(label, ImGuiDataType.S32, v, v_speed, v_min, v_max, format, flags);
	}
	public static inline function dragDoubleN(label : String, v : hl.NativeArray<Float>, v_speed : Single = 1.0, v_min : Float = 0.0, v_max : Float = 0.0, format : String = "%.3lf", flags : ImGuiSliderFlags = 0) : Bool {
		return drag_scalar_n(label, ImGuiDataType.Double, v, v_speed, v_min, v_max, format, flags);
	}
	static function drag_scalar_n(label : String, type : Int, v : hl.NativeArray<Dynamic>, v_speed : Single, v_min : Dynamic, v_max : Dynamic, format : String, flags : Int) : Bool {return false;}

	// Widgets: Sliders
	public static function sliderFloat(label : String, v : hl.Ref<Single>, v_min : Single, v_max : Single, format : String = "%.3f", flags : ImGuiSliderFlags = 0) : Bool {return false;}
	public static function sliderInt(label : String, v : hl.Ref<Int>, v_min : Int, v_max : Int, format : String = "%d", flags : ImGuiSliderFlags = 0) : Bool {return false;}
	public static function sliderDouble(label : String, v : hl.Ref<Float>, v_min : Float, v_max : Float, format : String = "%.3lf", flags : ImGuiSliderFlags = 0) : Bool {return false;}

	public static function vSliderFloat(label : String, size : ExtDynamic<ImVec2>, v : hl.Ref<Single>, v_min : Single, v_max : Single, format : String = "%.3f", flags : ImGuiSliderFlags = 0) : Bool {return false;}
	public static function vSliderInt(label : String, size : ExtDynamic<ImVec2>, v : hl.Ref<Int>, v_min : Int, v_max : Int, format : String = "%d", flags : ImGuiSliderFlags = 0) : Bool {return false;}
	public static function sliderAngle(label : String, v_rad : hl.Ref<Single>, v_degrees_min : Single = -360.0, v_degrees_max : Single = 360.0, format : String = "%.0f deg", flags : ImGuiSliderFlags = 0) : Bool {return false;}

	public static inline function sliderFloatN(label : String, v : hl.NativeArray<Single>, v_min : Single, v_max : Single, format : String = "%.3f", flags : ImGuiSliderFlags = 0) : Bool {
		return slider_scalar_n(label, ImGuiDataType.Float, v, v_min, v_max, format, flags);
	}
	public static inline function sliderIntN(label : String, v : hl.NativeArray<Int>, v_min : Int, v_max : Int, format : String = "%d", flags : ImGuiSliderFlags = 0) : Bool {
		return slider_scalar_n(label, ImGuiDataType.S32, v, v_min, v_max, format, flags);
	}
	public static inline function sliderDoubleN(label : String, v : hl.NativeArray<Float>, v_min : Float, v_max : Float, format : String = "%.3lf", flags : ImGuiSliderFlags = 0) : Bool {
		return slider_scalar_n(label, ImGuiDataType.Double, v, v_min, v_max, format, flags);
	}
	static function slider_scalar_n(label : String, type: Int, v : hl.NativeArray<Dynamic>, v_min : Dynamic, v_max : Dynamic, format : String, flags : Int) : Bool {return false;}

	// Widgets: Input with Keyboard
	public static function inputText(label : String, buf : hl.Bytes, buf_size : Int, flags : ImGuiInputTextFlags = 0) : Bool {return false;}
	public static function inputTextMultiline(label : String, buf : hl.Bytes, buf_size : Int, size : ExtDynamic<ImVec2> = null, flags : ImGuiInputTextFlags = 0) : Bool {return false;}
	public static function inputTextWithHint(label : String, hint : String, buf : hl.Bytes, buf_size : Int, flags : ImGuiInputTextFlags = 0) : Bool {return false;}
	public static function inputInt(label : String, v : hl.Ref<Int>, step : Int = 1, step_fast : Int = 100, flags : ImGuiInputTextFlags = 0) : Bool {return false;}
	public static function inputFloat(label : String, v : hl.Ref<Single>, step : Single = 0.0, step_fast : Single = 0.0, format : String = "%.3f", flags : ImGuiInputTextFlags = 0) : Bool {return false;}
	public static function inputDouble(label : String, v : hl.Ref<Float>, step : Float = 0.0, step_fast : Float = 0.0, format : String = "%.6f", flags : ImGuiInputTextFlags = 0) : Bool {return false;}

	public static inline function inputFloatN(label : String, v : hl.NativeArray<Single>, step : Single = 0.0, step_fast : Single = 0.0, format : String = "%.3f", flags : ImGuiInputTextFlags = 0) : Bool {
		return input_scalar_n(label, ImGuiDataType.Float, v, step, step_fast, format, flags);
	}
	public static inline function inputIntN(label : String, v : hl.NativeArray<Int>, step : Int = 0, step_fast : Int = 0, flags : ImGuiInputTextFlags = 0): Bool {
		return input_scalar_n(label, ImGuiDataType.S32, v, step, step_fast, "%d", flags);
	}
	public static inline function inputDoubleN(label : String, v : hl.NativeArray<Float>, step : Float = 0.0, step_fast : Float = 0.0, format : String = "%.6f", flags : ImGuiInputTextFlags = 0) : Bool {
		return input_scalar_n(label, ImGuiDataType.Double, v, step, step_fast, format, flags);
	}
	@:deprecated("Use inputFloatN")
	public static inline function inputFloat2(label : String, v : hl.NativeArray<Single>, format : String = "%.3f", flags : ImGuiInputTextFlags = 0) : Bool {
		return inputFloatN(label, v, format, flags);
	}
	@:deprecated("Use inputFloatN")
	public static function inputFloat3(label : String, v : hl.NativeArray<Single>, format : String = "%.3f", flags : ImGuiInputTextFlags = 0) : Bool {
		return inputFloatN(label, v, format, flags);
	}
	@:deprecated("Use inputFloatN")
	public static function inputFloat4(label : String, v : hl.NativeArray<Single>, format : String = "%.3f", flags : ImGuiInputTextFlags = 0) : Bool {
		return inputFloatN(label, v, format, flags);
	}
	@:deprecated("Use inputIntN")
	public static function inputInt2(label : String, v : hl.NativeArray<Int>, flags : ImGuiInputTextFlags = 0) : Bool {
		return inputIntN(label, v, flags);
	}
	@:deprecated("Use inputIntN")
	public static function inputInt3(label : String, v : hl.NativeArray<Int>, flags : ImGuiInputTextFlags = 0) : Bool {
		return inputIntN(label, v, flags);
	}
	@:deprecated("Use inputIntN")
	public static function inputInt4(label : String, v : hl.NativeArray<Int>, flags : ImGuiInputTextFlags = 0) : Bool {
		return inputIntN(label, v, flags);
	}

	static function input_scalar_n(label : String, type : Int, v : hl.NativeArray<Dynamic>, step : Dynamic, step_fast : Dynamic, format : String, flags : Int) : Bool {return false;}

	// Widgets: Color Editor/Picker
    public static function colorEdit3(label : String, col : hl.NativeArray<Single>, flags : ImGuiColorEditFlags = 0) : Bool {return false;}
    public static function colorEdit4(label : String, col : hl.NativeArray<Single>,  flags : ImGuiColorEditFlags = 0) : Bool {return false;}
    public static function colorPicker3(label : String, col : hl.NativeArray<Single>, flags : ImGuiColorEditFlags = 0) : Bool {return false;}
    public static function colorPicker4(label : String, col : hl.NativeArray<Single>, flags : ImGuiColorEditFlags = 0, ref_col : hl.Ref<Single> = null) : Bool {return false;}
    public static function colorButton(desc_id : String, col : ExtDynamic<ImVec4> = null, flags : ImGuiColorEditFlags = 0, size : ExtDynamic<ImVec2> = null) : Bool {return false;}
	public static function setColorEditOptions(flags : ImGuiColorEditFlags) {}

	// Widgets: Trees
	public static function treeNode(label : String) : Bool {return false;}
    public static function treeNode2(str_id : String, label : String) : Bool {return false;}
    public static function treeNodeEx(label : String, flags : ImGuiTreeNodeFlags = 0) : Bool {return false;}
    public static function treeNodeEx2(str_id : String, flags : ImGuiTreeNodeFlags, label : String) : Bool {return false;}
    public static function treePush(str_id : String) {}
    public static function treePop() {}
    public static function getTreeNodeToLabelSpacing() : Single {return 0;}
    public static function collapsingHeader(label : String, flags : ImGuiTreeNodeFlags = 0) : Bool {return false;}
    public static function collapsingHeader2(label : String, p_open : hl.Ref<Bool>, flags : ImGuiTreeNodeFlags = 0) : Bool {return false;}
	public static function setNextItemOpen(is_open : Bool, cond : ImGuiCond = 0) {}

	// Widgets: Selectables
    public static function selectable(label : String, selected : Bool = false, flags : ImGuiSelectableFlags = 0, size : ExtDynamic<ImVec2> = null) : Bool {return false;}
	public static function selectable2(label : String, p_selected : hl.Ref<Bool>, flags : ImGuiSelectableFlags = 0, size : ExtDynamic<ImVec2> = null) : Bool {return false;}

	// Widgets: List Boxes
	/**
		- Choose frame width:   size.x > 0.0f: custom  /  size.x < 0.0f or -FLT_MIN: right-align   /  size.x = 0.0f (default): use current ItemWidth
		- Choose frame height:  size.y > 0.0f: custom  /  size.y < 0.0f or -FLT_MIN: bottom-align  /  size.y = 0.0f (default): arbitrary default height which can fit ~7 items
	**/
	public static function beginListBox(label: String, size: ExtDynamic<ImVec2> = null): Bool { return false; }
	/** Only call if beginListBox returns true! **/
	public static function endListBox(): Bool { return false; }
	
	public static function listBox(label : String, current_item : hl.Ref<Int>, items : hl.NativeArray<String>, height_in_items : Int = -1) : Bool {return false;}
	// TODO: Callback variant
	@:deprecated("Use beginListBox")
	public static function listBoxHeader(label : String, size : ExtDynamic<ImVec2> = null) : Bool {return beginListBox(label, size);}
	@:deprecated("Obsolete")
	public static function listBoxHeader2(label : String, items_count : Int, height_in_items : Int = -1) : Bool {return false;}
	@:deprecated("Use endListBox")
	public static function listBoxFooter() {}

	// Widgets: Data Plotting
    public static function plotLines(label : String, values : hl.NativeArray<Single>, values_offset : Int = 0, overlay_text : String = null, scale_min : Single = FLT_MAX, scale_max : Single = FLT_MAX, graph_size : ExtDynamic<ImVec2>) {}
	public static function plotHistogram(label : String, values : hl.NativeArray<Single>, values_offset : Int = 0, overlay_text : String = null, scale_min : Single = FLT_MAX, scale_max : Single = FLT_MAX, graph_size : ExtDynamic<ImVec2>) {}

    // Widgets: Value() Helpers.
    public static function valueBool(prefix : String, b : Bool) {}
    public static function valueInt(prefix : String, v : Int) {}
	public static function valueSingle(prefix : String, v : Single, float_format : String = null) {}

    // Widgets: Menus
    public static function beginMenuBar() : Bool {return false;}
    public static function endMenuBar() {}
    public static function beginMainMenuBar() : Bool {return false;}
    public static function endMainMenuBar() {}
    public static function beginMenu(label : String, enabled : Bool = true) : Bool {return false;}
    public static function endMenu() {}
    public static function menuItem(label : String, shortcut : String = null, selected : Bool = false, enabled : Bool = true) : Bool {return false;}
    public static function menuItem2(label : String, shortcut : String, p_selected : hl.Ref<Bool>, enabled : Bool = true) : Bool {return false;}

	// ToolTips
    public static function beginTooltip() {}
    public static function endTooltip() {}
	public static function setTooltip(fmt : String) {}

	// Popups
	public static function openPopup(str_id : String) {}
    public static function beginPopup(str_id : String, flags : ImGuiWindowFlags = 0) : Bool {return false;}
    public static function beginPopupContextItem(str_id : String = null, mouse_button : ImGuiMouseButton = 1) : Bool {return false;}
    public static function beginPopupContextWindow(str_id : String = null, mouse_button : ImGuiMouseButton = 1, also_over_items : Bool = true) : Bool {return false;}
    public static function beginPopupContextVoid(str_id : String = null, mouse_button : ImGuiMouseButton= 1) : Bool {return false;}
    public static function beginPopupModal(name : String, p_open : hl.Ref<Bool> = null, flags : ImGuiWindowFlags = 0) : Bool {return false;}
    public static function endPopup() {}
    public static function openPopupOnItemClick(str_id : String = null, mouse_button : ImGuiMouseButton = 1) : Void {}
    public static function isPopupOpen(str_id : String) : Bool {return false;}
	public static function closeCurrentPopup() {}

    // Columns
    public static function columns(count : Int = 1, id : String = null, border : Bool = true) {}
    public static function nextColumn() {}
    public static function getColumnIndex() : Int {return 0;}
    public static function getColumnWidth(column_index : Int = -1) : Single {return 0;}
    public static function setColumnWidth(column_index : Int, width : Single) {}
    public static function getColumnOffset(column_index : Int = -1) : Single {return 0;}
    public static function setColumnOffset(column_index : Int, offset_x : Single) {}
	public static function getColumnsCount() : Int {return 0;}

	// Tables
	public static function beginTable( id: String, column: Int, flags: ImGuiTableFlags = ImGuiTableFlags.None, outer_size: ExtDynamic<ImVec2> = null, inner_width = 0 ): Bool { return false; }
	public static function endTable() {}
	public static function tableNextRow( rowFlags: ImGuiTableRowFlags = ImGuiTableRowFlags.None, minRowHeight: Single = 0 ) {}
	public static function tableNextColumn() {}
	public static function tableSetColumnIndex( columnIndex: Int ) {}
	public static function tableSetupColumn( id: String, flags: ImGuiTableColumnFlags = ImGuiTableColumnFlags.None, initWidthOrHeight: Single = 0, userId: ImGuiID = 0) {}
	public static function tableSetupScrollFreeze( cols: Int, rows: Int ) {}
	public static function tableHeadersRow() {}
	public static function tableHeader( id: String ) {}
	//public static function tableGetSortSpecs( id: String ): ImGUiTableSortSpecs { return null } // @todo
	public static function tableGetColumnCount(): Int { return 0; }
	public static function tableGetColumnIndex(): Int { return 0; }
	public static function tableGetRowIndex(): Int { return 0; }
	public static function tableGetColumnName(): String { return null; }
	public static function tableGetColumnFlags(): ImGuiTableColumnFlags { return 0; }
	public static function tableSetColumnEnabled( column_n: Int, enabled: Bool ): Void {}
	public static function tableSetBGColor( target: ImGuiTableBgTarget, color: Int, column_n: Int = -1 ): Void { }


	// Tab Bars, Tabs
	public static function beginTabBar(str_id : String, flags : ImGuiTabBarFlags = 0) : Bool {return false;}
	public static function endTabBar() {}
	public static function beginTabItem(label : String, p_open : hl.Ref<Bool> = null, flags : ImGuiTabItemFlags = 0) : Bool {return false;}
	public static function endTabItem() {}
	public static function setTabItemClosed(tab_or_docked_window_label : String) {}

	// Logging/Capture
	public static function logToTTY(auto_open_depth : Int = -1) {}
	public static function logToFile(auto_open_depth : Int = -1, filename : String = null) {}
	public static function logToClipboard(auto_open_depth : Int = -1) {}
	public static function logFinish() {}
	public static function logButtons() {}
	public static function logText(text : String) {}

    // Clipping
    public static function pushClipRect(clip_rect_min : ExtDynamic<ImVec2>, clip_rect_max : ExtDynamic<ImVec2>, intersect_with_current_clip_rect : Bool) {}
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
    public static function getItemRectMin() : ExtDynamic<ImVec2> {return null;}
    public static function getItemRectMax() : ExtDynamic<ImVec2> {return null;}
    public static function getItemRectSize() : ExtDynamic<ImVec2> {return null;}
    public static function setItemAllowOverlap() {}

    // Miscellaneous Utilities
    public static function isRectVisible(size : ExtDynamic<ImVec2>) : Bool {return false;}
    public static function isRectVisible2(rect_min : ExtDynamic<ImVec2>, rect_max : ExtDynamic<ImVec2>) : Bool {return false;}
    public static function getTime() : Float {return 0;}
    public static function getFrameCount() : Int {return 0;}
	static function get_style_color_name(idx : ImGuiCol) : hl.Bytes {return null;}
    public static function getStyleColorName(idx : ImGuiCol) : String {
		return @:privateAccess String.fromUTF8(get_style_color_name(idx));
	}
    public static function calcListClipping(items_count : Int, items_height : Single, out_items_display_start : hl.Ref<Int>, out_items_display_end : hl.Ref<Int>) {}
    public static function beginChildFrame(id : ImGuiID, size : ExtDynamic<ImVec2>, flags : ImGuiWindowFlags = 0) : Bool {return false;}
	public static function endChildFrame() {}

	// Text Utilities
	public static function calcTextSize(text : String, text_end : String = null, hide_text_after_double_hash : Bool = false, wrap_width : Single = -1.0) : ExtDynamic<ImVec2> {return null;}

    // Color Utilities
    public static function colorConvertU32ToFloat4(color : ImU32) : ExtDynamic<ImVec4> {return null;}
    public static function colorConvertFloat4ToU32(color : ExtDynamic<ImVec4>) : ImU32 {return 0;}
    public static function colorConvertRGBtoHSV(r : Single, g : Single, b : Single, out_h : hl.Ref<Single>, out_s : hl.Ref<Single>, out_v : hl.Ref<Single>) {}
    public static function colorConvertHSVtoRGB(h : Single, s : Single, v : Single, out_r : hl.Ref<Single>, out_g : hl.Ref<Single>, out_b : hl.Ref<Single>) {}

    // Inputs Utilities: Keyboard
    public static function getKeyIndex(imgui_key : ImGuiKey) : Int {return 0;}
    public static function isKeyDown(user_key_index : Int) : Bool {return false;}
    public static function isKeyPressed(user_key_index : Int, repeat : Bool = true) : Bool {return false;}
    public static function isKeyReleased(user_key_index : Int) : Bool {return false;}
    public static function getKeyPressedAmount(key_index : Int, repeat_delay : Single, rate : Single) : Int {return 0;}
    public static function captureKeyboardFromApp(want_capture_keyboard_value : Bool = true) {}

    // Inputs Utilities: Mouse
    public static function isMouseDown(button : ImGuiMouseButton) : Bool {return false;}
    public static function isMouseClicked(button : ImGuiMouseButton, repeat : Bool = false) : Bool {return false;}
    public static function isMouseReleased(button : ImGuiMouseButton) : Bool {return false;}
    public static function isMouseDoubleClicked(button : ImGuiMouseButton) : Bool {return false;}
    public static function isMouseHoveringRect(r_min : ExtDynamic<ImVec2>, r_max : ExtDynamic<ImVec2>, clip : Bool = true) : Bool {return false;}
    public static function isMousePosValid(mouse_pos : ExtDynamic<ImVec2> = null) : Bool {return false;}
    public static function isAnyMouseDown() : Bool {return false;}
    public static function getMousePos() : ExtDynamic<ImVec2> {return null;}
    public static function getMousePosOnOpeningCurrentPopup() : ExtDynamic<ImVec2> {return null;}
    public static function isMouseDragging(button : ImGuiMouseButton, lock_threshold : Single = -1.0) : Bool {return false;}
    public static function getMouseDragDelta(button : ImGuiMouseButton = 0, lock_threshold : Single = -1.0) : ExtDynamic<ImVec2> {return null;}
    public static function resetMouseDragDelta(button : ImGuiMouseButton = 0) {}
    public static function getMouseCursor() : ImGuiMouseCursor {return 0;}
    public static function setMouseCursor(cursor_type : ImGuiMouseCursor) {}
    public static function captureMouseFromApp(want_capture_mouse_value : Bool = true) {}

	// Drag and drop
	public static function beginDragDropTarget(): Bool { return false; }
	public static function endDragDropTarget() {}
	public static function beginDragDropSource( flags: ImGuiDragDropFlags = 0 ): Bool { return false; }
	public static function endDragDropSource() {}
	public static function setDragDropPayload(type: String, payload: hl.Bytes, length: Int, cond: ImGuiCond = 0 ) : Bool { return false; }
	public static function acceptDragDropPayload(type: String, cond: ImGuiCond = 0 ) : hl.Bytes { return null; }

	// Payload helpers
	public static inline function setDragDropPayloadString(type: String, payload: String, cond: ImGuiCond = 0 ) : Bool {
		var b = Bytes.ofString( payload + '\x00' );
		return setDragDropPayload(type, b, b.length, cond);
	 }
	public static inline function acceptDragDropPayloadString(type: String, cond: ImGuiCond = 0 ) : String {
		var bytes = ImGui.acceptDragDropPayload(type);
		if( bytes != null )
			return @:privateAccess String.fromUTF8( bytes );
		return null;
	}
	public static inline function setDragDropPayloadInt(type: String, payload: Int, cond: ImGuiCond = 0 ) : Bool {
		var b = new hl.Bytes(4);
		b.setI32(0, payload);
		return setDragDropPayload(type, b, 4, cond);
	 }
	public static inline function acceptDragDropPayloadInt(type: String, cond: ImGuiCond = 0 ) : Int {
		var bytes = ImGui.acceptDragDropPayload(type);
		if( bytes != null )
			return bytes.getI32(0);
		return 0;
	}


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
	static function save_ini_settings_to_memory(out_ini_size : hl.Ref<Int>) : hl.Bytes {return null;}
    public static function saveIniSettingsToMemory(out_ini_size : hl.Ref<Int> = null) : String {
		return @:privateAccess String.fromUTF8(save_ini_settings_to_memory(out_ini_size));
	}

	// IO
	public static function setIniFilename(filename : String) {}

	// Fonts

	public static inline function addFontDefault(?config:ImFontConfig) : ImFont { return new ImFont(add_font_default(config)); }
	static function add_font_default(config:ExtDynamic<ImFontConfig>) : ImFontPtr { return null; }
	public static inline function addFontFromFileTtf( filename: String, size: Single, ?config: ImFontConfig = null, ?glyphRanges: hl.NativeArray<hl.UI16> = null ) : ImFont { return new ImFont(add_font_from_file_ttf(filename, size, config, glyphRanges)); }
	public static function add_font_from_file_ttf( filename: String, size: Single, config: ExtDynamic<ImFontConfig>, glyphRanges: hl.NativeArray<hl.UI16>) : ImFontPtr { return null; }
	public static inline function addFontFromMemoryTtf( bytes: hl.Bytes, size: Int, font_size: Single, ?config: ImFontConfig, ?glyphRanges: hl.NativeArray<hl.UI16>) : ImFont { return new ImFont(add_font_from_memory_ttf(bytes, size, font_size, config, glyphRanges)); }
	public static function add_font_from_memory_ttf( bytes: hl.Bytes, size: Int, font_size: Single, config: ExtDynamic<ImFontConfig>, glyphRanges: hl.NativeArray<hl.UI16>) : ImFontPtr { return null; }
	public static function buildFont() {} // flat version of ImGui::GetIO().Fonts->Build();
	public static function getTexDataAsRgba32() : Dynamic {return null;} // : {buffer:hl.Bytes, width:Int, height:Int} { return{ buffer: null, width: 0, height: 0 }; }

	// internal functions
	public static function initialize(render_fn:Dynamic->Void) : Dynamic {return null;}
	public static function setFontTexture(texture_id : ImTextureID) {}
	public static function addKeyChar(c : Int) {}
	public static function addKeyEvent(c : Int, down: Bool) {}
	public static function setEvents(dt : Single, mouse_x : Single, mouse_y : Single, wheel : Single, left_click : Bool, right_click : Bool) {}
	public static function setDisplaySize(display_width:Int, display_height:Int) {}
	public static function wantCaptureMouse() : Bool {return false;}
	public static function wantCaptureKeyboard() : Bool {return false;}
	public static function setConfigFlags(flags:ImGuiConfigFlags = 0) : Void {}
	public static function getConfigFlags() : ImGuiConfigFlags {return 0;}
	public static function setUserData(data : Dynamic) {}
	public static function getUserData() : Dynamic {return null;}

	// Draw Lists
	public static inline function getWindowDrawList() : ImDrawList { return new ImDrawList( drawlist_get_window_draw_list() ); }
	public static inline function getForegroundDrawList() : ImDrawList { return new ImDrawList( drawlist_get_foreground_draw_list() ); }
	public static inline function getBackgroundDrawList() : ImDrawList { return new ImDrawList( drawlist_get_background_draw_list() ); }

	static function drawlist_get_window_draw_list() : ImDrawListPtr { return null; }
	static function drawlist_get_foreground_draw_list() : ImDrawListPtr { return null; }
	static function drawlist_get_background_draw_list() : ImDrawListPtr { return null; }

	// State storage
	public static inline function getStateStorage() : ImStateStorage { return new ImStateStorage( get_state_storage() ); }

	static function get_state_storage() : ImStateStoragePtr { return null; }

}
