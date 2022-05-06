#pragma once

#include <hl.h>
typedef struct ImVec2 ImVec2;
typedef struct ImVec4 ImVec4;

extern hl_type* hlt_imvec2;
extern hl_type* hlt_imvec4;

typedef struct HLT_ImVec2 {
	hl_type* t;
	float x, y;
	inline ImVec2* v() const { return (ImVec2*)&x; };
} vimvec2;

typedef struct HLT_ImVec4 {
	hl_type* t;
	float x, y, z, w;
	inline ImVec4* v() const { return (ImVec4*)&x; };
	inline ImVec2* vmin() const { return (ImVec2*)&x; };
	inline ImVec2* vmax() const { return (ImVec2*)&z; };
} vimvec4;
