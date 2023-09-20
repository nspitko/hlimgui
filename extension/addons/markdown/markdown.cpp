#include "../../utils.h"
#include "../../lib/markdown/imgui_markdown.h"


// Following includes for Windows LinkCallback
#define WIN32_LEAN_AND_MEAN
#include <Windows.h>
#include "Shellapi.h"
#include <string>

#define _TMDCONFIG _ABSTRACT(immarkdownconfig)


void LinkCallback( ImGui::MarkdownLinkCallbackData data_ )
{
    std::string url( data_.link, data_.linkLength );
    if( !data_.isImage )
    {
        ShellExecuteA( NULL, "open", url.c_str(), NULL, NULL, SW_SHOWNORMAL );
    }
}

inline ImGui::MarkdownImageData ImageCallback( ImGui::MarkdownLinkCallbackData data_ )
{
    // In your application you would load an image based on data_ input. Here we just use the imgui font texture.
    ImTextureID image = ImGui::GetIO().Fonts->TexID;
    // > C++14 can use ImGui::MarkdownImageData imageData{ true, false, image, ImVec2( 40.0f, 20.0f ) };
    ImGui::MarkdownImageData imageData;
    imageData.isValid =         true;
    imageData.useLinkCallback = false;
    imageData.user_texture_id = image;
    imageData.size =            ImVec2( 40.0f, 20.0f );
    
    // For image resize when available size.x > image width, add
    ImVec2 const contentSize = ImGui::GetContentRegionAvail();
    if( imageData.size.x > contentSize.x )
    {
        float const ratio = imageData.size.y/imageData.size.x;
        imageData.size.x = contentSize.x;
        imageData.size.y = contentSize.x*ratio;
    }

    return imageData;
}



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

DEFINE_PRIM(_VOID, markdown_text, _STRING _STRUCT );
DEFINE_PRIM(_VOID, markdown_init_config, _STRUCT );
DEFINE_PRIM(_VOID, markdown_init_image_data, _STRUCT );