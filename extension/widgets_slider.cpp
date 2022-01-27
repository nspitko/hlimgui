#define HL_NAME(n) hlimgui_##n

#include <hl.h>
#include "imgui/imgui.h"
#include "utils.h"

HL_PRIM bool HL_NAME(slider_float)(vstring* label, float* v, float v_min, float v_max, vstring* format, ImGuiSliderFlags* flags) {
    return ImGui::SliderFloat(convertString(label), v, v_min, v_max, convertString(format), convertPtr(flags, 0));
}

HL_PRIM bool HL_NAME(slider_angle)(vstring* label, float* v_rad, float* v_degrees_minf, float* v_degrees_max, vstring* format, ImGuiSliderFlags* flags)
{
    return ImGui::SliderAngle(convertString(label), v_rad, convertPtr(v_degrees_minf, -360.0f), convertPtr(v_degrees_max, +360.0f), convertString(format), convertPtr(flags, 0));
}

HL_PRIM bool HL_NAME(slider_int)(vstring* label, int* v, int v_min, int v_max, vstring* format, ImGuiSliderFlags* flags) {
    return ImGui::SliderInt(convertString(label), v, v_min, v_max, convertString(format), convertPtr(flags, 0));
}

HL_PRIM bool HL_NAME(v_slider_float)(vstring* label, vdynamic* size, float* v, float v_min, float v_max, vstring* format, ImGuiSliderFlags* flags)
{
    return ImGui::VSliderFloat(convertString(label), getImVec2(size), v, v_min, v_max, convertString(format), convertPtr(flags, 0));
}

HL_PRIM bool HL_NAME(v_slider_int)(vstring* label, vdynamic* size, int* v, int v_min, int v_max, vstring* format, ImGuiSliderFlags* flags)
{
    return ImGui::VSliderInt(convertString(label), getImVec2(size), v, v_min, v_max, convertString(format), convertPtr(flags, 0));
}


HL_PRIM bool HL_NAME(slider_double)(vstring* label, double* v, double v_min, double v_max, vstring* format, ImGuiSliderFlags* flags) {
    return ImGui::SliderScalar(convertString(label), ImGuiDataType_Double, v, &v_min, &v_max, convertString(format), convertPtr(flags, 0));
}
HL_PRIM bool HL_NAME(slider_scalar_n)(vstring* label, int type, varray* v, vdynamic* v_min, vdynamic* v_max, vstring* format, int flags) {
    switch (type) {
        case ImGuiDataType_Float: {
            float fmin = hl_dyn_castf(&v_min->v, v_min->t);
            float fmax = hl_dyn_castf(&v_max->v, v_max->t);
            return ImGui::SliderScalarN(convertString(label), type, hl_aptr(v,float), v->size, &fmin, &fmax, convertString(format), flags);
        }
        case ImGuiDataType_Double: {
            double dmin = hl_dyn_castd(&v_min->v, v_min->t);
            double dmax = hl_dyn_castd(&v_max->v, v_max->t);
            return ImGui::SliderScalarN(convertString(label), type, hl_aptr(v,double), v->size, &dmin, &dmax, convertString(format), flags);
        }
        default:
            return ImGui::SliderScalarN(convertString(label), type, hl_aptr(v,void), v->size, &(v_min->v), &(v_max->v), convertString(format), flags);
    }
}

DEFINE_PRIM(_BOOL, slider_float, _STRING _REF(_F32) _F32 _F32 _STRING _REF(_I32));
DEFINE_PRIM(_BOOL, slider_angle, _STRING _REF(_F32) _REF(_F32) _REF(_F32) _STRING _REF(_I32));
DEFINE_PRIM(_BOOL, slider_int, _STRING _REF(_I32) _I32 _I32 _STRING _REF(_I32));
DEFINE_PRIM(_BOOL, v_slider_float, _STRING _DYN _REF(_F32) _F32 _F32 _STRING _REF(_I32));
DEFINE_PRIM(_BOOL, v_slider_int, _STRING _DYN _REF(_I32) _I32 _I32 _STRING _REF(_I32));
DEFINE_PRIM(_BOOL, slider_double, _STRING _REF(_F64) _F64 _F64 _STRING _REF(_I32));
DEFINE_PRIM(_BOOL, slider_scalar_n, _STRING _I32 _ARR _DYN _DYN _STRING _I32);
