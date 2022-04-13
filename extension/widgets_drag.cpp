#include "utils.h"

HL_PRIM bool HL_NAME(drag_float)(vstring* label, float* v, float* v_speed, float* v_min, float* v_max, vstring* format, ImGuiSliderFlags* flags)
{
    return ImGui::DragFloat(
        convertString(label), v, convertPtr(v_speed, 1.0f),
        convertPtr(v_min, 0.0f), convertPtr(v_max, 0.0f), convertString(format), convertPtr(flags, 0)
    );
}

HL_PRIM bool HL_NAME(drag_int)(vstring* label, int* v, float* v_speed, int* v_min, int* v_max, vstring* format, ImGuiSliderFlags* flags)
{
    return ImGui::DragInt(
        convertString(label), v, convertPtr(v_speed, 1.0f),
        convertPtr(v_min, 0), convertPtr(v_max, 0), convertString(format), convertPtr(flags, 0)
    );
}

HL_PRIM bool HL_NAME(drag_double)(vstring* label, double* v, float* v_speed, double* v_min, double* v_max, vstring* format, ImGuiSliderFlags* flags)
{
    double min = convertPtr(v_min, 0.0);
    double max = convertPtr(v_max, 0.0);
    return ImGui::DragScalar(convertString(label), ImGuiDataType_Double, v, convertPtr(v_speed, 1.0f), &min, &max, convertString(format), convertPtr(flags, 0));
}


HL_PRIM bool HL_NAME(drag_float_range2)(vstring* label, float* v_current_min, float* v_current_max, float* v_speed, float* v_min, float* v_max, vstring* format, vstring* format_max, ImGuiSliderFlags* flags)
{
    return ImGui::DragFloatRange2(
        convertString(label), v_current_min, v_current_max, convertPtr(v_speed, 1.0f),
        convertPtr(v_min, 0.0f), convertPtr(v_max, 0.0f), convertString(format), convertString(format_max), convertPtr(flags, 0)
    );
}

HL_PRIM bool HL_NAME(drag_int_range2)(vstring* label, int* v_current_min, int* v_current_max, float* v_speed, int* v_min, int* v_max, vstring* format, vstring* format_max, ImGuiSliderFlags* flags)
{
    return ImGui::DragIntRange2(
        convertString(label), v_current_min, v_current_max, convertPtr(v_speed, 1.0f),
        convertPtr(v_min, 0), convertPtr(v_max, 0), convertString(format), convertString(format_max), convertPtr(flags, 0)
    );
}

HL_PRIM bool HL_NAME(drag_scalar_n)(vstring* label, int type, varray* p_data, float v_speed, vdynamic* p_min, vdynamic* p_max, vstring* format, int flags) {
    switch (type) {
        case ImGuiDataType_Float: {
            float fmin = hl_dyn_castf(&p_min->v, p_min->t);
            float fmax = hl_dyn_castf(&p_max->v, p_max->t);
            return ImGui::DragScalarN(convertString(label), type, hl_aptr(p_data,float), p_data->size, v_speed, &fmin, &fmax, convertString(format), flags);
        }
        case ImGuiDataType_Double: {
            double dmin = hl_dyn_castd(&p_min->v, p_min->t);
            double dmax = hl_dyn_castd(&p_max->v, p_max->t);
            return ImGui::DragScalarN(convertString(label), type, hl_aptr(p_data,double), p_data->size, v_speed, &dmin, &dmax, convertString(format), flags);
        }
        default:
            return ImGui::DragScalarN(convertString(label), type, hl_aptr(p_data,void), p_data->size, v_speed, &(p_min->v), &(p_max->v), convertString(format), flags);
    }
}

DEFINE_PRIM(_BOOL, drag_float, _STRING _REF(_F32) _REF(_F32) _REF(_F32) _REF(_F32) _STRING _REF(_I32));
DEFINE_PRIM(_BOOL, drag_int, _STRING _REF(_I32) _REF(_F32) _REF(_I32) _REF(_I32) _STRING _REF(_I32));
DEFINE_PRIM(_BOOL, drag_double, _STRING _REF(_F64) _REF(_F32) _REF(_F64) _REF(_F64) _STRING _REF(_I32));
DEFINE_PRIM(_BOOL, drag_float_range2, _STRING _REF(_F32) _REF(_F32) _REF(_F32) _REF(_F32) _REF(_F32) _STRING _STRING _REF(_I32));
DEFINE_PRIM(_BOOL, drag_int_range2, _STRING _REF(_I32) _REF(_I32) _REF(_F32) _REF(_I32) _REF(_I32) _STRING _STRING _REF(_I32));
DEFINE_PRIM(_BOOL, drag_scalar_n, _STRING _I32 _ARR _F32 _DYN _DYN _STRING _I32);