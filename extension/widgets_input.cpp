#include "utils.h"

int TextInputCallback(ImGuiInputTextCallbackData* data)
{
    vclosure* vcallback = (vclosure*)data->UserData;
    if( vcallback == nullptr ) return 0;

    if (vcallback->hasValue)
    {
        return ((int(*)(vdynamic*,ImGuiInputTextCallbackData*))vcallback->fun)((vdynamic*)vcallback->value,data);
    }
    else
    {
        return ((int(*)(ImGuiInputTextCallbackData*))vcallback->fun)(data);
    }
}

#define BUFFER_RESIZE_STEP 256
static char* textBuffer = NULL;
static int textBufferSize = 0;

void stringToBuffer(vstring** str)
{
    int len = unicodeSizeInUTF8(*str) + 1;
    if (len >= textBufferSize)
    {
        textBufferSize = (len / BUFFER_RESIZE_STEP) * BUFFER_RESIZE_STEP + BUFFER_RESIZE_STEP;
        textBuffer = (char*)realloc(textBuffer, textBufferSize);
    }
    unicodeToUTF8Buffer(*str, textBuffer);
    textBuffer[len-1] = 0;
}

void bufferToString(vstring** str)
{
    int ulen = hl_utf8_length((vbyte*)textBuffer, 0);
    uchar *s = (uchar*)hl_gc_alloc_noptr((ulen + 1)*sizeof(uchar));
    hl_from_utf8(s,ulen,(char*)(textBuffer));
    // Due to instance reuse we can't just edit the vstring* in-place and forced to reallocate it.
    vstring* ret = (vstring*)hl_alloc_obj((*str)->t);
    ret->bytes = s;
    ret->length = ulen;
    *str = ret;
}

int TextInputCallbackWithResize(ImGuiInputTextCallbackData* data)
{
    if (data->EventFlag == ImGuiInputTextFlags_CallbackResize)
    {
        // Always resize at minimum of BUFFER_RESIZE_STEP and if required data->BufferSize larger than one step - increment buffer size in steps.
        textBufferSize = (data->BufSize / BUFFER_RESIZE_STEP) * BUFFER_RESIZE_STEP + BUFFER_RESIZE_STEP;
        textBuffer = (char*)realloc(textBuffer, textBufferSize);
        data->Buf = textBuffer;
    }
    return TextInputCallback(data);
}

HL_PRIM bool HL_NAME(input_text)(vstring* label, vstring** string, ImGuiInputTextFlags* flags, vclosure* callback)
{
    stringToBuffer(string);
    bool result = ImGui::InputText(convertString(label), textBuffer, textBufferSize, convertPtr(flags, 0) | ImGuiInputTextFlags_CallbackResize, TextInputCallbackWithResize, callback);
    if (result || ImGui::IsItemEdited()) bufferToString(string); // Avoid unnecessary reallocations.
    return result;
}

HL_PRIM bool HL_NAME(input_text_multiline)(vstring* label, vstring** string, vimvec2* size, ImGuiInputTextFlags* flags, vclosure* callback)
{
    stringToBuffer(string);
    bool result = ImGui::InputTextMultiline(convertString(label), textBuffer, textBufferSize, getImVec2(size), convertPtr(flags, 0) | ImGuiInputTextFlags_CallbackResize, TextInputCallbackWithResize, callback );
    if (result || ImGui::IsItemEdited()) bufferToString(string);
    return result;
}

HL_PRIM bool HL_NAME(input_text_with_hint)(vstring* label, vstring* hint, vstring** string, ImGuiInputTextFlags* flags, vclosure* callback)
{
    stringToBuffer(string);
    bool result = ImGui::InputTextWithHint(convertString(label), convertString(hint), textBuffer, textBufferSize, convertPtr(flags, 0) | ImGuiInputTextFlags_CallbackResize, TextInputCallbackWithResize, callback );
    if (result || ImGui::IsItemEdited()) bufferToString(string);
    return result;
}

HL_PRIM bool HL_NAME(input_text_buf)(vstring* label, vbyte* buf, int buf_size, ImGuiInputTextFlags* flags, vclosure* callback)
{
    return ImGui::InputText(convertString(label), (char*)buf, buf_size, convertPtr(flags, 0), TextInputCallback, callback);
}

HL_PRIM bool HL_NAME(input_text_multiline_buf)(vstring* label, vbyte* buf, int buf_size, vimvec2* size, ImGuiInputTextFlags* flags, vclosure* callback)
{
    return ImGui::InputTextMultiline(convertString(label), (char*)buf, buf_size, getImVec2(size), convertPtr(flags, 0), TextInputCallback, callback );
}

HL_PRIM bool HL_NAME(input_text_with_hint_buf)(vstring* label, vstring* hint, vbyte* buf, int buf_size, ImGuiInputTextFlags* flags, vclosure* callback)
{
    return ImGui::InputTextWithHint(convertString(label), convertString(hint), (char*)buf, buf_size, convertPtr(flags, 0), TextInputCallback, callback );
}

HL_PRIM void HL_NAME(input_text_callback_delete_chars)(ImGuiInputTextCallbackData* data, int pos, int bytes_count)
{
    data->DeleteChars(pos, bytes_count);
}

HL_PRIM void HL_NAME(input_text_callback_insert_chars)(ImGuiInputTextCallbackData* data, int pos, vstring* text)
{
    data->InsertChars(pos, convertString(text));
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

DEFINE_PRIM(_BOOL, input_text, _STRING _REF(_STRING) _REF(_I32) _FUN(_I32, _STRUCT));
DEFINE_PRIM(_BOOL, input_text_multiline, _STRING _REF(_STRING) _IMVEC2 _REF(_I32) _FUN(_I32, _STRUCT));
DEFINE_PRIM(_BOOL, input_text_with_hint, _STRING _STRING _REF(_STRING) _REF(_I32) _FUN(_I32, _STRUCT));

DEFINE_PRIM(_BOOL, input_text_buf, _STRING _BYTES _I32 _REF(_I32) _FUN(_I32, _STRUCT));
DEFINE_PRIM(_BOOL, input_text_multiline_buf, _STRING _BYTES _I32 _IMVEC2 _REF(_I32) _FUN(_I32, _STRUCT));
DEFINE_PRIM(_BOOL, input_text_with_hint_buf, _STRING _STRING _BYTES _I32 _REF(_I32) _FUN(_I32, _STRUCT));

DEFINE_PRIM(_BOOL, input_float, _STRING _REF(_F32) _REF(_F32) _REF(_F32) _STRING _REF(_I32));
DEFINE_PRIM(_BOOL, input_int, _STRING _REF(_I32) _REF(_I32) _REF(_I32) _REF(_I32));
DEFINE_PRIM(_BOOL, input_double, _STRING _REF(_F64) _REF(_F64) _REF(_F64) _STRING _REF(_I32));
DEFINE_PRIM(_BOOL, input_scalar_n, _STRING _I32 _ARR _DYN _DYN _STRING _I32);

DEFINE_PRIM(_VOID, input_text_callback_delete_chars, _STRUCT _I32 _I32);
DEFINE_PRIM(_VOID, input_text_callback_insert_chars, _STRUCT _I32 _STRING);