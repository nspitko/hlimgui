#include "utils.h"

static vdynamic* refPayload = nullptr;

inline void clear_gc_payload()
{
	if (refPayload != nullptr) {
		hl_remove_root(refPayload);
		refPayload = nullptr;
	}
}

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
	clear_gc_payload();
	return ImGui::SetDragDropPayload(convertString(type), payload, len, convertPtr(cond, 0 ) );
}

HL_PRIM bool HL_NAME(set_drag_drop_payload_object)(vstring* type, vdynamic* payload, ImGuiCond* cond)
{
	// Avoid adding payload to gc root multiple times.
	if (payload != refPayload) {
		clear_gc_payload();
		if (payload != nullptr) {
			refPayload = payload;
			hl_add_root(payload);
		}
	}
	int data = 0x52454600;
	return ImGui::SetDragDropPayload(convertString(type), &data, 4, convertPtr(cond, 0 ) );
}

HL_PRIM ImGuiPayload* HL_NAME(accept_drag_drop_payload)(vstring* type, ImGuiCond* cond)
{
	return (ImGuiPayload*)ImGui::AcceptDragDropPayload(convertString(type), convertPtr(cond, 0));
}

HL_PRIM ImGuiPayload* HL_NAME(get_drag_drop_payload)()
{
	return (ImGuiPayload*)ImGui::GetDragDropPayload();
}

HL_PRIM vdynamic* HL_NAME(get_drag_drop_payload_object)()
{
	return refPayload;
}

HL_PRIM void HL_NAME(dndpayload_clear)(ImGuiPayload* payload)
{
	clear_gc_payload();
	payload->Clear();
}

HL_PRIM bool HL_NAME(dndpayload_is_data_type)(ImGuiPayload* payload, vstring* type)
{
	return payload->IsDataType(convertString(type));
}

HL_PRIM bool HL_NAME(dndpayload_is_preview)(ImGuiPayload* payload)
{
	return payload->IsPreview();
}

HL_PRIM bool HL_NAME(dndpayload_is_delivery)(ImGuiPayload* payload)
{
	return payload->IsDelivery();
}

HL_PRIM vbyte* HL_NAME(dndpayload_get_binary)(ImGuiPayload* payload)
{
	return hl_copy_bytes((vbyte*)payload->Data, payload->DataSize);
}

HL_PRIM vdynamic* HL_NAME(dndpayload_get_object)(ImGuiPayload* payload, bool clear)
{
	if (clear) {
		vdynamic* prev = refPayload;
		clear_gc_payload();
		return prev;
	}
	return refPayload;
}

HL_PRIM void HL_NAME(clear_drag_drop_payload_object)()
{
	clear_gc_payload();
}

#define _TPAYLOAD _ABSTRACT(imdnd)

DEFINE_PRIM(_BOOL, begin_drag_drop_target, _NO_ARG);
DEFINE_PRIM(_VOID, end_drag_drop_target, _NO_ARG);
DEFINE_PRIM(_BOOL, begin_drag_drop_source, _REF(_I32));
DEFINE_PRIM(_VOID, end_drag_drop_source, _NO_ARG);
DEFINE_PRIM(_BOOL, set_drag_drop_payload, _STRING _BYTES _I32 _REF(_I32) );
DEFINE_PRIM(_BOOL, set_drag_drop_payload_object, _STRING _DYN _REF(_I32));
DEFINE_PRIM(_TPAYLOAD, accept_drag_drop_payload, _STRING _REF(_I32) );
DEFINE_PRIM(_TPAYLOAD, get_drag_drop_payload, _NO_ARG);
DEFINE_PRIM(_DYN, get_drag_drop_payload_object, _NO_ARG);

DEFINE_PRIM(_VOID, dndpayload_clear, _TPAYLOAD);
DEFINE_PRIM(_BOOL, dndpayload_is_data_type, _TPAYLOAD _STRING);
DEFINE_PRIM(_BOOL, dndpayload_is_preview, _TPAYLOAD);
DEFINE_PRIM(_BOOL, dndpayload_is_delivery, _TPAYLOAD);
DEFINE_PRIM(_BYTES, dndpayload_get_binary, _TPAYLOAD);
DEFINE_PRIM(_DYN, dndpayload_get_object, _TPAYLOAD _BOOL);
DEFINE_PRIM(_VOID, clear_drag_drop_payload_object, _NO_ARG);
