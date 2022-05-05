#pragma once

#include <hl.h>
typedef struct {
	hl_type* t;
	union {
		ImVec2 v;
		struct { float x; float y; };
	};
} vimvec2;

typedef struct {
	hl_type* t;
	union {
		ImVec4 v;
		struct { ImVec2 min; ImVec2 max; };
		struct { float x; float y; float z; float w; };
	};
} vimvec4;

extern hl_type* hlt_imvec2;
extern hl_type* hlt_imvec4;
