#include "../../utils.h"
#include "../../lib/markdown/imgui_markdown.h"

#define _TMDCONFIG _ABSTRACT(immarkdownconfig)

HL_PRIM void HL_NAME(markdown_text)(vstring* text, ImGui::MarkdownConfig* mdConfig)
{
    ImGui::Markdown(convertStringNullAsEmpty(text), text->length, *mdConfig );
}

HL_PRIM void HL_NAME(markdown_init_config)(ImGui::MarkdownConfig* mdConfig)
{
	if (mdConfig != nullptr)
	{
		new (mdConfig)ImGui::MarkdownConfig();
	}
}

HL_PRIM void HL_NAME(markdown_init_image_data)(ImGui::MarkdownImageData* mdConfig)
{
	if (mdConfig != nullptr)
	{
		new (mdConfig)ImGui::MarkdownImageData();
	}
}

HL_PRIM void HL_NAME(markdown_default_format)( const ImGui::MarkdownFormatInfo* markdownFormatInfo_, bool start_ )
{
	ImGui::defaultMarkdownFormatCallback( *markdownFormatInfo_, start_ );
}

DEFINE_PRIM(_VOID, markdown_text, _STRING _STRUCT );
DEFINE_PRIM(_VOID, markdown_init_config, _STRUCT );
DEFINE_PRIM(_VOID, markdown_init_image_data, _STRUCT );
DEFINE_PRIM(_VOID, markdown_default_format, _STRUCT _BOOL );