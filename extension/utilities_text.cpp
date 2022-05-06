#include "utils.h"

HL_PRIM vimvec2* HL_NAME(calc_text_size)(vstring* text, vstring* text_end, bool* hide_text_after_double_hash, float* wrap_width)
{
    return ImGui::CalcTextSize(convertString(text), convertString(text_end), convertPtr(hide_text_after_double_hash, false), convertPtr(wrap_width, -1.0f));
}

DEFINE_PRIM(_IMVEC2, calc_text_size, _STRING _STRING _REF(_BOOL) _REF(_F32));
