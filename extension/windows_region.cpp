#include "utils.h"

HL_PRIM vimvec2* HL_NAME(get_content_region_max)()
{
	return ImGui::GetContentRegionMax();
}

HL_PRIM vimvec2* HL_NAME(get_content_region_avail)()
{
	return ImGui::GetContentRegionAvail();
}

HL_PRIM vimvec2* HL_NAME(get_window_content_region_min)()
{
	return ImGui::GetWindowContentRegionMin();
}

HL_PRIM vimvec2* HL_NAME(get_window_content_region_max)()
{
	return ImGui::GetWindowContentRegionMax();
}

HL_PRIM float HL_NAME(get_window_content_region_width)()
{
	return ImGui::GetWindowContentRegionWidth();
}

DEFINE_PRIM(_IMVEC2, get_content_region_max, _NO_ARG);
DEFINE_PRIM(_IMVEC2, get_content_region_avail, _NO_ARG);
DEFINE_PRIM(_IMVEC2, get_window_content_region_min, _NO_ARG);
DEFINE_PRIM(_IMVEC2, get_window_content_region_max, _NO_ARG);
DEFINE_PRIM(_F32, get_window_content_region_width, _NO_ARG);
