#include "utils.h"

HL_PRIM bool HL_NAME(is_rect_visible)(vimvec2* size)
{
    return ImGui::IsRectVisible(size);
}

HL_PRIM bool HL_NAME(is_rect_visible2)(vimvec2* rect_min, vimvec2* rect_max)
{
    return ImGui::IsRectVisible(rect_min, rect_max);
}

HL_PRIM double HL_NAME(get_time)()
{
    return ImGui::GetTime();
}

HL_PRIM int HL_NAME(get_frame_count)()
{
    return ImGui::GetFrameCount();
}

HL_PRIM vbyte* HL_NAME(get_style_color_name)(ImGuiCol idx)
{
    return getVByteFromCStr(ImGui::GetStyleColorName(idx));
}

HL_PRIM void HL_NAME(calc_list_clipping)(int items_count, float items_height, int* out_items_display_start, int* out_items_display_end)
{
    return ImGui::CalcListClipping(items_count, items_height, out_items_display_start, out_items_display_end);
}

HL_PRIM bool HL_NAME(begin_child_frame)(ImGuiID id, vimvec2* size, ImGuiWindowFlags* flags)
{
    return ImGui::BeginChildFrame(id, getImVec2(size), convertPtr(flags, 0));
}

HL_PRIM void HL_NAME(end_child_frame)()
{
    ImGui::EndChildFrame();
}


DEFINE_PRIM(_BOOL, is_rect_visible, _IMVEC2);
DEFINE_PRIM(_BOOL, is_rect_visible2, _IMVEC2 _IMVEC2);
DEFINE_PRIM(_F64, get_time, _NO_ARG);
DEFINE_PRIM(_I32, get_frame_count, _NO_ARG);
DEFINE_PRIM(_BYTES, get_style_color_name, _I32);
DEFINE_PRIM(_VOID, calc_list_clipping, _I32 _F32 _REF(_I32) _REF(_I32));
DEFINE_PRIM(_BOOL, begin_child_frame, _I32 _IMVEC2 _REF(_I32));
DEFINE_PRIM(_VOID, end_child_frame, _NO_ARG);

// State storage

HL_PRIM ImGuiStorage* HL_NAME(get_state_storage)() {
    return ImGui::GetStateStorage();
}

HL_PRIM void HL_NAME(set_state_storage)(ImGuiStorage* storage) {
    ImGui::SetStateStorage(storage);
}

HL_PRIM int HL_NAME(state_storage_get_int)(ImGuiStorage* storage, ImGuiID id, int default_val) {
    return storage->GetInt(id, default_val);
}
HL_PRIM void HL_NAME(state_storage_set_int)(ImGuiStorage* storage, ImGuiID id, int val) {
    storage->SetInt(id, val);
}

HL_PRIM bool HL_NAME(state_storage_get_bool)(ImGuiStorage* storage, ImGuiID id, bool default_val) {
    return storage->GetBool(id, default_val);
}
HL_PRIM void HL_NAME(state_storage_set_bool)(ImGuiStorage* storage, ImGuiID id, bool val) {
    storage->SetBool(id, val);
}

HL_PRIM float HL_NAME(state_storage_get_float)(ImGuiStorage* storage, ImGuiID id, float default_val) {
    return storage->GetFloat(id, default_val);
}
HL_PRIM void HL_NAME(state_storage_set_float)(ImGuiStorage* storage, ImGuiID id, float val) {
    storage->SetFloat(id, val);
}

#define _TSTATESTORAGE _ABSTRACT(imstatestorage)
DEFINE_PRIM_PROP(_TSTATESTORAGE, state_storage, _TSTATESTORAGE);
DEFINE_PRIM(_I32, state_storage_get_int, _TSTATESTORAGE _I32 _I32);
DEFINE_PRIM(_VOID, state_storage_set_int, _TSTATESTORAGE _I32 _I32);
DEFINE_PRIM(_BOOL, state_storage_get_bool, _TSTATESTORAGE _I32 _BOOL);
DEFINE_PRIM(_VOID, state_storage_set_bool, _TSTATESTORAGE _I32 _BOOL);
DEFINE_PRIM(_F32, state_storage_get_float, _TSTATESTORAGE _I32 _F32);
DEFINE_PRIM(_VOID, state_storage_set_float, _TSTATESTORAGE _I32 _F32);