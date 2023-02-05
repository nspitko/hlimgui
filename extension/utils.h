#pragma once

#define HL_NAME(n) hlimgui_##n
#define _IMVEC2 _OBJ(_F32 _F32)
#define _IMVEC4 _OBJ(_F32 _F32 _F32 _F32)
#define _IMTEXID _DYN
#define _IMVECTOR _ABSTRACT(imvector)
#define _FIN _ABSTRACT(finalizer)

#define _TRENDERCALLBACK _FUN(_VOID, _DYN _DYN _DYN)
#define _TRENDERCOMMAND _OBJ(_IMTEXID _I32 _I32 _I32 _I32 _I32 _I32 _TRENDERCALLBACK _DYN)
#define _TRENDERDATA _OBJ(_BYTES _I32 _BYTES _I32 _ARR _I32)
#define _TRENDERLIST _OBJ(_ARR _I32)

#include <string>
#include <hl.h>
#include <vector>
#include "lib/imgui/imgui.h"
#include "types.h"

#define convertString(st) st != nullptr ? unicodeToUTF8(st).c_str() : NULL
#define convertStringNullAsEmpty(st) st != nullptr ? unicodeToUTF8(st).c_str() : ""
#define convertPtr(ptr,default_value) ptr != nullptr ? *ptr : default_value
#define convertArray(arr,type) arr != nullptr ? hl_aptr(arr,type) : nullptr
#define convertVec(ptr,default_value) ptr != nullptr ? ImVec2(ptr) : ImVec2(default_value)

#ifdef __APPLE__
#define throw_error(err) hl_throw(hl_alloc_strbytes((const uchar*)(USTR(err))))
#else
#define throw_error(err) hl_error(err)
#endif

// Usage:
// DEFINE_PRIM_PROP(_I32,prop_name,_REF(_I32))
// Equates to:
// DEFINE_PRIM(_I32,get_prop_name,_NO_ARG)
// DEFINE_PRIM(_VOID,set_prop_name,_REF(_I32))
#define DEFINE_PRIM_PROP(t,name,args) DEFINE_PRIM(t,get_##name,_NO_ARG)\
	DEFINE_PRIM(_VOID,set_##name,args)

void convertColor(ImU32 color, float& r, float& g, float& b, float& a);
int unicodeSizeInUTF8(vstring* hl_string);
void unicodeToUTF8Buffer(vstring* hl_string, char* out);
std::string unicodeToUTF8(vstring* hl_string);

// Converters that handle nullptr with default value
inline ImVec2 getImVec2(vimvec2* vec2, const ImVec2& default_value = ImVec2(0, 0)) { return vec2 == nullptr ? default_value :  ImVec2(vec2); }
inline ImVec4 getImVec4(vimvec4* vec4, const ImVec4& default_value = ImVec4(0, 0, 0, 0)) { return vec4 == nullptr ? default_value : ImVec4(vec4); }

vbyte* getVByteFromCStr(const char* str);

// Structs
void getStructFloat(vdynamic* dyn, const char* name, float& value);
void setStructFloat(vdynamic* dyn, const char* name, float value);
void getStructInt(vdynamic* dyn, const char* name, int& value);
void setStructInt(vdynamic* dyn, const char* name, int value);
void getStructBool(vdynamic* dyn, const char* name, bool& value);
void setStructBool(vdynamic* dyn, const char* name, bool value);
void getStructImVec2(vdynamic* dyn, const char* name, ImVec2& value);
void setStructImVec2(vdynamic* dyn, const char* name, const ImVec2& value);
void getStructImVec4(vdynamic* dyn, const char* name, ImVec4& values);
void setStructImVec4(vdynamic* dyn, const char* name, const ImVec4& values);
void getStructArrayImVec4(vdynamic* dyn, const char* name, ImVec4* values, int size);
void setStructArrayImVec4(vdynamic* dyn, const char* name, const ImVec4* values, int size);

inline void assertArraySize(varray* arr, int size) {if (arr->size != size) throw_error("Invalid array size");}
inline void assertArraySizeRange(varray* arr, int size_min, int size_max) {if (arr->size < size_min && arr->size > size_max) throw_error("Invalid array size");}
