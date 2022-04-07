#include "utils.h"

HL_PRIM bool HL_NAME(input_text)(vstring* label, vbyte* buf, int buf_size, ImGuiInputTextFlags* flags)
{
    return ImGui::InputText(convertString(label), (char*)buf, buf_size, convertPtr(flags, 0));
}

HL_PRIM bool HL_NAME(input_text_multiline)(vstring* label, vbyte* buf, int buf_size, vdynamic* size, ImGuiInputTextFlags* flags)
{
    return ImGui::InputTextMultiline(convertString(label), (char*)buf, buf_size, getImVec2(size), convertPtr(flags, 0));
}

HL_PRIM bool HL_NAME(input_text_with_hint)(vstring* label, vstring* hint, vbyte* buf, int buf_size, ImGuiInputTextFlags* flags)
{
    return ImGui::InputTextWithHint(convertString(label), convertString(hint), (char*)buf, buf_size, convertPtr(flags, 0));
}

HL_PRIM bool HL_NAME(input_float)(vstring* label, float* v, float* step, float* step_fast, vstring* format, ImGuiInputTextFlags* flags)
{
    return ImGui::InputFloat(convertString(label), v, convertPtr(step, 0.0f), convertPtr(step_fast, 0.0f), convertString(format), convertPtr(flags, 0));
}

HL_PRIM bool HL_NAME(input_int)(vstring* label, int* v, int* step, int* step_fast, ImGuiInputTextFlags* flags)
{
    return ImGui::InputInt(convertString(label), v, convertPtr(step, 1), convertPtr(step_fast, 100), convertPtr(flags, 0));
}

HL_PRIM bool HL_NAME(input_double)(vstring* label, double* v, double* step, double* step_fast, vstring* format, ImGuiInputTextFlags* flags)
{
    return ImGui::InputDouble(convertString(label), v, convertPtr(step, 0.0), convertPtr(step_fast, 0.0), convertString(format), convertPtr(flags, 0));
}

HL_PRIM bool HL_NAME(input_scalar_n)(vstring* label, int type, varray* v, vdynamic* step, vdynamic* step_fast, vstring* format, int flags) {
    switch (type) {
        case ImGuiDataType_Float: {
            float fstep = step == nullptr ? 0.0f : hl_dyn_castf(&step->v, step->t);
            float fstep_fast = step == nullptr ? 0.0f :hl_dyn_castf(&step_fast->v, step_fast->t);
            return ImGui::InputScalarN(convertString(label), type, hl_aptr(v,float), v->size, fstep > 0.0f ? &fstep : NULL, fstep_fast > 0.0f ? &fstep_fast : NULL, convertString(format), flags);
        }
        case ImGuiDataType_Double: {
            double dstep = step == nullptr ? 0.0 : hl_dyn_castd(&step->v, step->t);
            double dstep_fast = step == nullptr ? 0.0 : hl_dyn_castd(&step_fast->v, step_fast->t);
            return ImGui::InputScalarN(convertString(label), type, hl_aptr(v,double), v->size, dstep > 0.0 ? &dstep : NULL, dstep_fast > 0.0 ? &dstep_fast : NULL, convertString(format), flags);
        }
        default:
            int istep = step == nullptr ? 0 : hl_dyn_casti(&step->v, step->t, &hlt_i32);
            int istep_fast = step == nullptr ? 0 : hl_dyn_casti(&step->v, step->t, &hlt_i32);
            return ImGui::InputScalarN(convertString(label), type, hl_aptr(v,void), v->size, istep > 0 ? &istep : NULL, istep_fast > 0 ? &istep_fast : NULL, convertString(format), flags);
    }
}
//const char* label, ImGuiDataType data_type, void* p_data, int components, const void* p_step, const void* p_step_fast, const char* format, ImGuiInputTextFlags flags)

DEFINE_PRIM(_BOOL, input_text, _STRING _BYTES _I32 _REF(_I32));
DEFINE_PRIM(_BOOL, input_text_multiline, _STRING _BYTES _I32 _DYN _REF(_I32));
DEFINE_PRIM(_BOOL, input_text_with_hint, _STRING _STRING _BYTES _I32 _REF(_I32));
DEFINE_PRIM(_BOOL, input_float, _STRING _REF(_F32) _REF(_F32) _REF(_F32) _STRING _REF(_I32));
DEFINE_PRIM(_BOOL, input_int, _STRING _REF(_I32) _REF(_I32) _REF(_I32) _REF(_I32));
DEFINE_PRIM(_BOOL, input_double, _STRING _REF(_F64) _REF(_F64) _REF(_F64) _STRING _REF(_I32));
DEFINE_PRIM(_BOOL, input_scalar_n, _STRING _I32 _ARR _DYN _DYN _STRING _I32);