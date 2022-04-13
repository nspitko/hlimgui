#include "utils.h"

HL_PRIM ImGuiContext* HL_NAME(create_context)()
{
	return ImGui::CreateContext(NULL);
}

HL_PRIM void HL_NAME(destroy_context)(ImGuiContext* ptr)
{
	ImGui::DestroyContext(ptr);
}

HL_PRIM ImGuiContext* HL_NAME(get_current_context)()
{
	return ImGui::GetCurrentContext();
}

HL_PRIM void HL_NAME(set_current_context)(ImGuiContext* ptr)
{
	ImGui::SetCurrentContext(ptr);
}

#define _TCONTEXT _ABSTRACT(imcontext)

DEFINE_PRIM(_TCONTEXT, create_context, _NO_ARG);
DEFINE_PRIM(_VOID, destroy_context, _TCONTEXT);
DEFINE_PRIM(_TCONTEXT, get_current_context, _NO_ARG);
DEFINE_PRIM(_VOID, set_current_context, _TCONTEXT);
