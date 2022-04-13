#include "utils.h"

HL_PRIM bool HL_NAME(begin_drag_drop_target)()
{
    return ImGui::BeginDragDropTarget();
}

HL_PRIM void HL_NAME(end_drag_drop_target)()
{
    ImGui::EndDragDropTarget();
}

HL_PRIM bool HL_NAME(begin_drag_drop_source)(ImGuiDragDropFlags* flags)
{
    return ImGui::BeginDragDropSource(convertPtr( flags, 0) );
}

HL_PRIM void HL_NAME(end_drag_drop_source)()
{
    ImGui::EndDragDropSource();
}

HL_PRIM bool HL_NAME(set_drag_drop_payload)(vstring* type, const char* payload, int len, ImGuiCond* cond)
{
    return ImGui::SetDragDropPayload(convertString(type), payload, len, convertPtr(cond, 0 ) );
}

HL_PRIM const char* HL_NAME(accept_drag_drop_payload)(vstring* type, ImGuiCond* cond)
{
    const ImGuiPayload *payload = ImGui::AcceptDragDropPayload(convertString(type), convertPtr(cond, 0));
	if( payload != nullptr )
		return (const char*)payload->Data;

	return nullptr;
}



DEFINE_PRIM(_BOOL, begin_drag_drop_target, _NO_ARG);
DEFINE_PRIM(_VOID, end_drag_drop_target, _NO_ARG);
DEFINE_PRIM(_BOOL, begin_drag_drop_source, _REF(_I32));
DEFINE_PRIM(_VOID, end_drag_drop_source, _NO_ARG);
DEFINE_PRIM(_BOOL, set_drag_drop_payload, _STRING _BYTES _I32 _REF(_I32) );
DEFINE_PRIM(_BYTES, accept_drag_drop_payload, _STRING _REF(_I32) );
