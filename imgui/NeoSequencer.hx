package imgui;
#if hlimgui
import imgui.ImGui.ImVec2;
import imgui.ImGui.ImVec2S;
import imgui.ImGui.ImVec4;
import imgui.ImGui.ImVec4S;
import imgui.ImGui.ImDrawList;
import imgui.ImGui.Ref;

// Flags for ImGui::BeginNeoSequencer()
enum abstract ImGuiNeoSequencerFlags(Int) from Int to Int {
    var None                 = 0;
    var AllowLengthChanging  = 1 << 0; // Allows changing length of sequence
    var EnableSelection      = 1 << 1; // Enables selection of keyframes
    var HideZoom             = 1 << 2; // Disables zoom bar
    //var PH                 = 1 << 3; // PLACEHOLDER
    var AlwaysShowHeader     = 1 << 4; // Enables overlay header, keeping it visible when scrolling

    // Selection options, only work with enable selection flag
    var Selection_EnableDragging = 1 << 5;
    var Selection_EnableDeletion = 1 << 6;

}

// Flags for ImGui::BeginNeoTimeline()
enum abstract ImGuiNeoTimelineFlags(Int) from Int to Int {
    var None                 = 0;
    var AllowFrameChanging   = 1 << 0;
    var Group                = 1 << 1;
}

// Flags for ImGui::IsNeoTimelineSelected()
enum abstract ImGuiNeoTimelineIsSelectedFlags(Int) from Int to Int {
    var None: Int            = 0;
    var NewlySelected: Int   = 1 << 0;
}




enum abstract NeoStyleColor(Int) from Int to Int {
    var Bg = 0;
    var TopBarBg = 1;
    var SelectedTimeline = 2;
    var TimelineBorder = 3;
    var TimelineBg = 4;
    var FramePointer = 5;
    var FramePointerHovered = 6;
    var FramePointerPressed = 7;
    var Keyframe = 8;
    var KeyframeHovered = 9;
    var KeyframePressed= 10;
    var KeyframeSelected = 11;
    var FramePointerLine = 12;

    var ZoomBarBg = 13;
    var ZoomBarSlider = 14;
    var ZoomBarSliderHovered = 15;
    var ZoomBarSliderEnds = 16;
    var ZoomBarSliderEndsHovered = 17;

	var SelectionBorder = 18;
	var Selection = 19;

    //var Count = 20;
}

/**
 * Neo Sequencer style.
 */
@:keep
@:build(imgui._ImGuiInternalMacro.buildFlatStruct())
@:hlNative("hlimgui","ns_")
@:struct
class NeoStyle
{
	public var SequencerRounding: Single;
	public var TopBarHeight: Single;
	public var TopBarShowFrameLines: Bool;
	public var TopBarShowFrameText: Bool;
	@:flatten var ItemSpacing: ImVec2S;
	public var DepthItemSPacing: Single;
	public var TopbarSpacing: Single;
	public var TimelineBorderSize: Single;
	public var CurrentFramePointerSize: Single;
	public var CurrentFameLineWidth: Single;
	public var ZoomHeightScale: Single;
	public var CollidedKeyframeOffset: Single;

	@:flattenMap(NeoStyleColor) var Colors: ImVec4S;

	public var ModRemoveKey: Int;
	public var ModAddKey: Int;

	public function new()
	{
		init_style(this);
	}

	static function init_style(style: NeoStyle) {}
}


@:hlNative("hlimgui","ns_")
class NeoSequencer
{
	public static function getStyle():NeoStyle { return null; }
	// Context
	public static function begin( id: String, frame: Ref<Int>, startFrame: Ref<Int>, endFrame: Ref<Int>, size: ImVec2S, flags: ImGuiNeoSequencerFlags = None ) : Bool { return false; }
	public static function end(): Void {};
	public static function beginGroup( label: String, ?open: Ref<Bool>): Bool { return false; }
	public static function endGroup() {};

	public static function beginTimeline( label: String, ?open: Ref<Bool>, flags: ImGuiNeoTimelineFlags = None): Bool { return false; }
	public static function endTimeline() {};
	public static function setSelectedTimeline( timelineLabel: String ): Void {}
	public static function isTimelineSelected( flags: ImGuiNeoTimelineIsSelectedFlags = None ): Bool { return false; }

	public static function keyframe( value: Ref<Int> ) {};
	public static function isKeyframeHovered(): Bool { return false; }
	public static function isKeyframeSelected(): Bool { return false; }
	public static function isKeyframeRightClicked(): Bool { return false; }

	public static function clearSelection(): Void {}
	public static function isSelecting(): Bool { return false; }
	public static function hasSelection(): Bool { return false; }
	public static function isDraggingSelection(): Bool { return false; }
	public static function canDeleteSelection(): Bool { return false; }
	public static function isKeyframeSelectionRightClicked(): Bool { return false; }
	public static function getKeyframeSelectionSize(): Int { return 0; }
	public static function getKeyframeSelection(): hl.NativeArray<Int> { return null; }

}

#end