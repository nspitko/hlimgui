#include "utils.h"

HL_PRIM bool HL_NAME(list_box)(vstring* label, int* current_item, varray* items, int* height_in_items)
{
    std::vector<std::string> std_items;
    std::vector<const char*> cstr_items;

    std_items.resize(items->size);
    cstr_items.resize(items->size);
    for (int i=0; i<items->size; i++)
    {
        std_items[i] = unicodeToUTF8(hl_aptr(items,vstring*)[i]);
        cstr_items[i] = std_items[i].c_str();
    }

    return ImGui::ListBox(convertString(label), current_item, &cstr_items[0], convertPtr(height_in_items, -1));
}

HL_PRIM bool HL_NAME(begin_list_box)(vstring* label, vimvec2* size)
{
    return ImGui::BeginListBox(convertString(label), getImVec2(size));
}

HL_PRIM bool HL_NAME(list_box_header2)(vstring* label, int items_count, int* height_in_items)
{
    return ImGui::ListBoxHeader(convertString(label), items_count, convertPtr(height_in_items, -1));
}

HL_PRIM void HL_NAME(end_list_box)()
{
    ImGui::EndListBox();
}

DEFINE_PRIM(_BOOL, list_box, _STRING _REF(_I32) _ARR _REF(_I32));
DEFINE_PRIM(_BOOL, begin_list_box, _STRING _IMVEC2);
DEFINE_PRIM(_BOOL, list_box_header2, _STRING _I32 _REF(_I32));
DEFINE_PRIM(_VOID, end_list_box, _NO_ARG);
