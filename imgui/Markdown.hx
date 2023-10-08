package imgui;
#if hlimgui
import imgui.ImGui.ImVec2;
import imgui.ImGui.ImVec2S;
import imgui.ImGui.ImVec4;
import imgui.ImGui.ImVec4S;
import imgui.ImGui.ImDrawList;
import imgui.ImGui.ImFont;

@:keep
@:struct
class MarkdownLinkCallbackData
{
	public var text: hl.Bytes;
	public var textLength: Int;
	public var link: hl.Bytes;
	public var linkLength: Int;
	public var userData: hl.Bytes; // void*
	public var isImage: Bool;
}
@:keep
@:struct
class MarkdownTooltipCallbackData                              // for tooltips
{
	// MarkdownLinkCallbackData
	public var text: hl.Bytes;
	public var textLength: Int;
	public var link: hl.Bytes;
	public var linkLength: Int;
	public var userData: hl.Bytes; // void*
	public var isImage: Bool;

	//
	public var linkIcon: hl.Bytes; // void*
}

@:struct
@:build(imgui._ImGuiInternalMacro.buildFlatStruct())
class MarkdownImageData
{
	public var isValid: Bool;
	public var useLinkCallback: Bool;
	public var textureId: imgui.ImGui.ImTextureID;
	@:flatten public var size: ImVec2S;
	@:flatten public var uv0: ImVec2S;
	@:flatten public var uv1: ImVec2S;
	@:flatten public var tintColor: ImVec4S;
	@:flatten public var borderColor: ImVec4S;
}

typedef MarkdownImageCallback = ( MarkdownLinkCallbackData, MarkdownImageData ) -> Void;
typedef MarkdownLinkCallback = ( MarkdownLinkCallbackData ) -> Void;
typedef MarkdownTooltipCallback = ( MarkdownTooltipCallbackData ) -> Void;

/**
 * Node editor style.
 *
 * Unlike imgui style, there's no "set" function, so there is no constructor.
 */
@:keep
@:build(imgui._ImGuiInternalMacro.buildFlatStruct())
@:hlNative("hlimgui","markdown_")
@:struct
class MarkdownConfig
{
	public var heading1: ImFont;
	public var heading1Separator: Bool;

	public var heading2: ImFont;
	public var heading2Separator: Bool;

	public var heading3: ImFont;
	public var heading3Separator: Bool;

	public var linkIcon: hl.Bytes; // WARNING: This is a const char*!
	public var userData: hl.Bytes; // WARNING: This is a const void*!

	public var imageCallback: MarkdownImageCallback;
	public var linkCallback: MarkdownLinkCallback;
	public var tooltipCallback: MarkdownTooltipCallback;

	public var cb1: hl.Bytes;



	public function new()
	{
		init_config(this);
	}

	static function init_config(config: MarkdownConfig) {}
}



@:hlNative("hlimgui","markdown_")
class Markdown
{
	// Context
	public static function text( text: String, config: MarkdownConfig ) : Void  { }
}

#end