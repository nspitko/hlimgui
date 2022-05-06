#include "utils.h"

HL_PRIM void HL_NAME(push_clip_rect)(vimvec2* clip_rect_min, vimvec2* clip_rect_max, bool intersect_with_current_clip_rect)
{
    ImGui::PushClipRect(clip_rect_min, clip_rect_max, intersect_with_current_clip_rect);
}

HL_PRIM void HL_NAME(pop_clip_rect)()
{
    ImGui::PopClipRect();
}

DEFINE_PRIM(_VOID, push_clip_rect, _IMVEC2 _IMVEC2 _BOOL);
DEFINE_PRIM(_VOID, pop_clip_rect, _NO_ARG);
