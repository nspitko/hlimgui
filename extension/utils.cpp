#include "utils.h"

void convertColor(ImU32 color, float& r, float& g, float& b, float& a)
{
	r = ((color >> IM_COL32_R_SHIFT) & 0xFF) / 255.0f;
	g = ((color >> IM_COL32_G_SHIFT) & 0xFF) / 255.0f;
	b = ((color >> IM_COL32_B_SHIFT) & 0xFF) / 255.0f;
	a = ((color >> IM_COL32_A_SHIFT) & 0xFF) / 255.0f;
}

int unicodeSizeInUTF8(vstring* hl_string)
{
	uchar *c = hl_string->bytes;
	uchar *end = c + hl_string->length;
	int utf8bytes = 0;
	while(c != end)
	{
		auto v = *c;
		if(v < 0x80) utf8bytes++;
		else if(v < 0x800) utf8bytes += 2;
		else if(v >= 0xD800 && v <= 0xDFFF)
		{
			utf8bytes += 4;
			c++;
		}
		else utf8bytes += 3;
		c++;
	}
	return utf8bytes;
}
// UNSAFE API - no size checks are done! Use `unicodeSizeInUTF8` to estimate the output buffer size and alloc accordingly!
void unicodeToUTF8Buffer(vstring* hl_string, char* out)
{
	uchar *c = hl_string->bytes;
	uchar *end = c + hl_string->length;
	int p = 0;
	while (c != end)
	{
		unsigned int v = (unsigned int)*c;
		if (v <= 0x7F) out[p++] = (char)v;
		else if (v <= 0x7FF)
		{
			out[p++] = (char)(0xC0 | (v >> 6));
			out[p++] = (char)(0x80 | (v & 0x3F));
		}
		else if (v >= 0xD800 && v <= 0xDFFF)
		{
			int k = ((((int)v - 0xD800) << 10) | (((int)*++c) - 0xDC00)) + 0x10000;
			out[p++] = (char)(0xF0 | (k >> 18));
			out[p++] = (char)(0x80 | ((k >> 12) & 0x3F));
			out[p++] = (char)(0x80 | ((k >> 6) & 0x3F));
			out[p++] = (char)(0x80 | (k & 0x3F));
		}
		else
		{
			out[p++] = (char)(0xE0 | (v >> 12));
			out[p++] = (char)(0x80 | ((v >> 6) & 0x3F));
			out[p++] = (char)(0x80 | (v & 0x3F));
		}
		c++;
	}
}

std::string unicodeToUTF8(vstring* hl_string)
{
	std::string result;

	for (int i = 0; i < hl_string->length; i++)
	{
		auto code = ((unsigned short*)hl_string->bytes)[i];
		if (code <= 0x7F)
		{
			result += char(code);
		}
		else if (code <= 0x7FF)
		{
			result += char(0xC0 | (code >> 6));            /* 110xxxxx */
			result += char(0x80 | (code & 0x3F));          /* 10xxxxxx */
		}
		else
		{
			result += char(0xE0 | (code >> 12));           /* 1110xxxx */
			result += char(0x80 | ((code >> 6) & 0x3F));   /* 10xxxxxx */
			result += char(0x80 | (code & 0x3F));          /* 10xxxxxx */
		}
	}

	return result;
}

void getStructFloat(vdynamic* dyn, const char* name, float& value)
{
	value = hl_dyn_getf(dyn, hl_hash_utf8(name));
}

void setStructFloat(vdynamic* dyn, const char* name, float value)
{
	hl_dyn_setf(dyn, hl_hash_utf8(name), value);
}

void getStructInt(vdynamic* dyn, const char* name, int& value)
{
	value = hl_dyn_geti(dyn, hl_hash_utf8(name), &hlt_i32);
}

void setStructInt(vdynamic* dyn, const char* name, int value)
{
	hl_dyn_seti(dyn, hl_hash_utf8(name), &hlt_i32, value);
}

void getStructBool(vdynamic* dyn, const char* name, bool& value)
{
	value = (bool)hl_dyn_geti(dyn, hl_hash_utf8(name), &hlt_bool);
}

void setStructBool(vdynamic* dyn, const char* name, bool value)
{
	hl_dyn_seti(dyn, hl_hash_utf8(name), &hlt_bool, value);
}

void getStructImVec2(vdynamic* dyn, const char* name, ImVec2& value)
{
	vdynamic* vec2 = (vdynamic*)hl_dyn_getp(dyn, hl_hash_utf8(name), &hlt_dyn);
	getStructFloat(vec2, "x", value.x);
	getStructFloat(vec2, "y", value.y);
}

void setStructImVec2(vdynamic* dyn, const char* name, const ImVec2& value)
{
	vdynamic* vec2 = (vdynamic*)hl_alloc_dynobj();
	setStructFloat(vec2, "x", value.x);
	setStructFloat(vec2, "y", value.y);
	hl_dyn_setp(dyn, hl_hash_utf8(name), &hlt_dynobj, vec2);
}

void getStructImVec4(vdynamic* dyn, const char* name, ImVec4& value)
{
	vdynamic* vec4 = (vdynamic*)hl_dyn_getp(dyn, hl_hash_utf8(name), &hlt_dyn);
	getStructFloat(vec4, "x", value.x);
	getStructFloat(vec4, "y", value.y);
	getStructFloat(vec4, "z", value.z);
	getStructFloat(vec4, "w", value.w);
}

void setStructImVec4(vdynamic* dyn, const char* name, const ImVec4& value)
{
	vdynamic* vec4 = (vdynamic*)hl_alloc_dynobj();
	setStructFloat(vec4, "x", value.x);
	setStructFloat(vec4, "y", value.y);
	setStructFloat(vec4, "z", value.z);
	setStructFloat(vec4, "w", value.w);
	hl_dyn_setp(dyn, hl_hash_utf8(name), &hlt_dynobj, vec4);
}

void getStructArrayImVec4(vdynamic* dyn, const char* name, ImVec4* values, int size)
{
	varray* array = (varray*)hl_dyn_getp(dyn, hl_hash_utf8(name), &hlt_array);
	if (array->size < size)
	{
		size = array->size;
	}
	for (int i = 0; i < size; i++)
	{
		vdynamic* vec4 = hl_aptr(array, vdynamic*)[i];
		getStructFloat(vec4, "x", values[i].x);
		getStructFloat(vec4, "y", values[i].y);
		getStructFloat(vec4, "z", values[i].z);
		getStructFloat(vec4, "w", values[i].w);
	}
}

void setStructArrayImVec4(vdynamic* dyn, const char* name, const ImVec4* values, int size)
{
	varray* array = hl_alloc_array(&hlt_dynobj, size);
	for (int i = 0; i < size; i++)
	{
		vdynamic* vec4 = (vdynamic*)hl_alloc_dynobj();
		setStructFloat(vec4, "x", values[i].x);
		setStructFloat(vec4, "y", values[i].y);
		setStructFloat(vec4, "z", values[i].z);
		setStructFloat(vec4, "w", values[i].w);
		hl_aptr(array, vdynamic*)[i] = vec4;
	}
	hl_dyn_setp(dyn, hl_hash_utf8(name), &hlt_array, array);
}

// ImVec2 getImVec2(vdynamic* vec2, const ImVec2& default_value)
// {
// 	ImVec2 result = default_value;
// 	if (vec2 != nullptr) {
// 		getStructFloat(vec2, "x", result.x);
// 		getStructFloat(vec2, "y", result.y);
// 	}
// 	return result;
// }

// ImVec4 getImVec4(vdynamic* vec4, const ImVec4& default_value)
// {
// 	ImVec4 result = default_value;
// 	if (vec4 != nullptr) {
// 		getStructFloat(vec4, "x", result.x);
// 		getStructFloat(vec4, "y", result.y);
// 		getStructFloat(vec4, "z", result.z);
// 		getStructFloat(vec4, "w", result.w);
// 	}
// 	return result;
// }

// vdynamic* getHLFromImVec2(ImVec2 value)
// {
// 	vdynamic* vec2 = (vdynamic*)hl_alloc_dynobj();
// 	setStructFloat(vec2, "x", value.x);
// 	setStructFloat(vec2, "y", value.y);
// 	return vec2;
// }

// vdynamic* getHLFromImVec4(ImVec4 value)
// {
// 	vdynamic* vec4 = (vdynamic*)hl_alloc_dynobj();
// 	setStructFloat(vec4, "x", value.x);
// 	setStructFloat(vec4, "y", value.y);
// 	setStructFloat(vec4, "z", value.z);
// 	setStructFloat(vec4, "w", value.w);
// 	return vec4;
// }

vbyte* getVByteFromCStr(const char* str)
{
	int size = int(strlen(str) + 1);
	vbyte* result = hl_alloc_bytes(size);
	memcpy(result, str, size);
	return result;
}
