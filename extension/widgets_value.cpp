#include "utils.h"
#include "lib/imgui/imgui_internal.h"

HL_PRIM void HL_NAME(value_bool)(vstring* prefix, bool b)
{
    ImGui::Value(convertString(prefix), b);
}

HL_PRIM void HL_NAME(value_int)(vstring* prefix, int v)
{
    ImGui::Value(convertString(prefix), v);
}

HL_PRIM void HL_NAME(value_single)(vstring* prefix, float v, vstring* float_format)
{
    ImGui::Value(convertString(prefix), v, convertString(float_format));
}

HL_PRIM void HL_NAME(value_double)(vstring* prefix, double v, vstring* double_format)
{
    if (double_format != NULL)
    {
        char fmt[64];
        ImFormatString(fmt, IM_ARRAYSIZE(fmt), "%%s: %s", convertString(double_format));
        ImGui::Text(fmt, prefix, v);
    }
    else
    {
        ImGui::Text("%s: %.3lf", prefix, v);
    }
}

DEFINE_PRIM(_VOID, value_bool, _STRING _BOOL);
DEFINE_PRIM(_VOID, value_int, _STRING _I32);
DEFINE_PRIM(_VOID, value_single, _STRING _F32 _STRING);
DEFINE_PRIM(_VOID, value_double, _STRING _F64 _STRING);
