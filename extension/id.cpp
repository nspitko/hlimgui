#include "utils.h"

HL_PRIM void HL_NAME(push_id)(vstring* str_id)
{
	ImGui::PushID(unicodeToUTF8(str_id).c_str());
}

HL_PRIM void HL_NAME(push_id_sub)(vstring* str_id, int begin, int end)
{
	// Likely will break if contains real UTF, but at least it works compared to old implementation.
	auto str = unicodeToUTF8(str_id).c_str();
	if (end > str_id->length) end = str_id->length;
	ImGui::PushID(str + begin, str + end);
}

HL_PRIM void HL_NAME(push_id_int)(int int_id)
{
	ImGui::PushID(int_id);
}

HL_PRIM void HL_NAME(push_id_ptr)(vobj* ptr_id) {
	ImGui::PushID((void*)ptr_id);
}

HL_PRIM void HL_NAME(pop_id)()
{
	ImGui::PopID();
}

HL_PRIM ImGuiID HL_NAME(get_id)(vstring* str_id)
{
	return ImGui::GetID(unicodeToUTF8(str_id).c_str());
}

HL_PRIM ImGuiID HL_NAME(get_id_sub)(vstring* str_id, int begin, int end)
{
	auto str = unicodeToUTF8(str_id).c_str();
	if (end > str_id->length) end = str_id->length;
	return ImGui::GetID(str + begin, str + end);
}

HL_PRIM ImGuiID HL_NAME(get_id_ptr)(vobj* ptr_id) {
	return ImGui::GetID((void*)ptr_id);
}


DEFINE_PRIM(_VOID, push_id, _STRING);
DEFINE_PRIM(_VOID, push_id_sub, _STRING _I32 _I32);
DEFINE_PRIM(_VOID, push_id_int, _I32);
DEFINE_PRIM(_VOID, push_id_ptr, _DYN);
DEFINE_PRIM(_VOID, pop_id, _NO_ARG);
DEFINE_PRIM(_I32, get_id, _STRING);
DEFINE_PRIM(_I32, get_id_sub, _STRING _I32 _I32);
DEFINE_PRIM(_I32, get_id_ptr, _DYN);
