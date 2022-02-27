#define HL_NAME(n) hlimgui_##n

#include <hl.h>
#include <vector>
#include "lib/imgui/imgui.h"
#include "utils.h"



HL_PRIM ImDrawList *HL_NAME(drawlist_get_window_draw_list)()
{
    return ImGui::GetWindowDrawList();
}

HL_PRIM ImDrawList *HL_NAME(drawlist_get_foreground_draw_list)()
{
    return ImGui::GetForegroundDrawList();
}

HL_PRIM ImDrawList *HL_NAME(drawlist_get_background_draw_list)()
{
    return ImGui::GetBackgroundDrawList();
}

HL_PRIM void HL_NAME(drawlist_add_line)(ImDrawList *drawlist, vdynamic* p1, vdynamic* p2, ImU32 col, float thickness)
{
	drawlist->AddLine( getImVec2(p1), getImVec2(p2), col, thickness );
}

HL_PRIM void HL_NAME(drawlist_add_rect)(ImDrawList *drawlist, vdynamic* p_min, vdynamic* p_max, ImU32 col, float rounding, ImDrawCornerFlags rounding_corners, float thickness)
{
	drawlist->AddRect( getImVec2(p_min), getImVec2(p_max), col, rounding, rounding_corners, thickness );
}

HL_PRIM void HL_NAME(drawlist_add_rect_filled)(ImDrawList *drawlist, vdynamic* p_min, vdynamic* p_max, ImU32 col, float rounding, ImDrawCornerFlags rounding_corners)
{
	drawlist->AddRectFilled( getImVec2(p_min), getImVec2(p_max), col, rounding, rounding_corners );
}

HL_PRIM void HL_NAME(drawlist_add_rect_filled_multicolor)( ImDrawList *drawlist, vdynamic* p_min, vdynamic* p_max, ImU32 col_upr_left , ImU32 col_upr_right, ImU32 col_bot_right, ImU32 col_bot_left)
{
	drawlist->AddRectFilledMultiColor( getImVec2(p_min), getImVec2(p_max), col_upr_left, col_upr_right, col_bot_right, col_bot_left );
}

HL_PRIM void HL_NAME(drawlist_add_quad)(ImDrawList *drawlist, vdynamic* p1, vdynamic* p2, vdynamic* p3, vdynamic* p4, ImU32 col, float thickness)
{
	drawlist->AddQuad( getImVec2(p1), getImVec2(p2), getImVec2(p3), getImVec2(p4), col, thickness );
}

HL_PRIM void HL_NAME(drawlist_add_quad_filled)(ImDrawList *drawlist, vdynamic* p1, vdynamic* p2, vdynamic* p3, vdynamic* p4, ImU32 col)
{
	drawlist->AddQuadFilled( getImVec2(p1), getImVec2(p2), getImVec2(p3), getImVec2(p4), col );
}

HL_PRIM void HL_NAME(drawlist_add_triangle)(ImDrawList *drawlist, vdynamic* p1, vdynamic* p2, vdynamic* p3, ImU32 col, float thickness)
{
	drawlist->AddTriangle( getImVec2(p1), getImVec2(p2), getImVec2(p3), col, thickness );
}

HL_PRIM void HL_NAME(drawlist_add_triangle_filled)(ImDrawList *drawlist, vdynamic* p1, vdynamic* p2, vdynamic* p3, ImU32 col)
{
	drawlist->AddTriangleFilled( getImVec2(p1), getImVec2(p2), getImVec2(p3), col );
}

HL_PRIM void HL_NAME(drawlist_add_circle)(ImDrawList *drawlist, vdynamic* center, float radius, ImU32 col, int num_segments, float thickness)
{
	drawlist->AddCircle( getImVec2(center), radius, col, num_segments, thickness );
}

HL_PRIM void HL_NAME(drawlist_add_circle_filled)(ImDrawList *drawlist, vdynamic* center, float radius, ImU32 col, int num_segments)
{
	drawlist->AddCircleFilled( getImVec2(center), radius, col, num_segments );
}

HL_PRIM void HL_NAME(drawlist_add_ngon)(ImDrawList *drawlist, vdynamic* center, float radius, ImU32 col, int num_segments, float thickness)
{
	drawlist->AddNgon( getImVec2(center), radius, col, num_segments, thickness );
}

HL_PRIM void HL_NAME(drawlist_add_ngon_filled)(ImDrawList *drawlist, vdynamic* center, float radius, ImU32 col, int num_segments)
{
	drawlist->AddNgonFilled( getImVec2(center), radius, col, num_segments );
}

HL_PRIM void HL_NAME(drawlist_add_poly_line)(ImDrawList *drawlist, varray* points, ImU32 col, bool closed, float thickness)
{
	std::vector<ImVec2> vecPoints;
	for (int i = 0; i < points->size; i++)
    {
        vecPoints.push_back(getImVec2(hl_aptr(points, vdynamic*)[i]));
    }

	drawlist->AddPolyline( &vecPoints[0], points->size, col, closed, thickness );
}

HL_PRIM void HL_NAME(drawlist_add_convex_poly_filled)(ImDrawList *drawlist, varray* points, ImU32 col)
{
	std::vector<ImVec2> vecPoints;
	for (int i = 0; i < points->size; i++)
    {
        vecPoints.push_back(getImVec2(hl_aptr(points, vdynamic*)[i]));
    }

	drawlist->AddConvexPolyFilled( &vecPoints[0], points->size, col);
}

HL_PRIM void HL_NAME(drawlist_add_bezier_curve)(ImDrawList *drawlist, vdynamic* p1, vdynamic* p2, vdynamic* p3, vdynamic* p4, ImU32 col, float thickness, int num_segments)
{
	drawlist->AddBezierCurve( getImVec2(p1), getImVec2(p2), getImVec2(p3), getImVec2(p4), col, thickness, num_segments );
}



#define _TDRAWLIST _ABSTRACT(imdrawlist)

DEFINE_PRIM(_TDRAWLIST, drawlist_get_window_draw_list, _NO_ARG );
DEFINE_PRIM(_TDRAWLIST, drawlist_get_foreground_draw_list, _NO_ARG );
DEFINE_PRIM(_TDRAWLIST, drawlist_get_background_draw_list, _NO_ARG );
DEFINE_PRIM(_VOID, drawlist_add_line, _TDRAWLIST _DYN _DYN _I32 _F32 );
DEFINE_PRIM(_VOID, drawlist_add_rect, _TDRAWLIST _DYN _DYN _I32 _F32 _I32 _F32 );
DEFINE_PRIM(_VOID, drawlist_add_rect_filled, _TDRAWLIST _DYN _DYN _I32 _F32 _I32 );
DEFINE_PRIM(_VOID, drawlist_add_rect_filled_multicolor, _TDRAWLIST _DYN _DYN _I32 _I32 _I32 _I32 );
DEFINE_PRIM(_VOID, drawlist_add_quad, _TDRAWLIST _DYN _DYN _DYN _DYN _I32 _F32 );
DEFINE_PRIM(_VOID, drawlist_add_quad_filled, _TDRAWLIST _DYN _DYN _DYN _DYN _I32 );
DEFINE_PRIM(_VOID, drawlist_add_triangle, _TDRAWLIST _DYN _DYN _DYN _I32 _F32 );
DEFINE_PRIM(_VOID, drawlist_add_triangle_filled, _TDRAWLIST _DYN _DYN _DYN _I32 );
DEFINE_PRIM(_VOID, drawlist_add_circle, _TDRAWLIST _DYN _F32 _I32 _I32 _F32 );
DEFINE_PRIM(_VOID, drawlist_add_circle_filled, _TDRAWLIST _DYN _F32 _I32 _I32 );
DEFINE_PRIM(_VOID, drawlist_add_ngon, _TDRAWLIST _DYN _F32 _I32 _I32 _F32 );
DEFINE_PRIM(_VOID, drawlist_add_ngon_filled, _TDRAWLIST _DYN _F32 _I32 _I32 );
DEFINE_PRIM(_VOID, drawlist_add_poly_line, _TDRAWLIST _ARR _I32 _BOOL _F32 );
DEFINE_PRIM(_VOID, drawlist_add_convex_poly_filled, _TDRAWLIST _ARR _I32  );
DEFINE_PRIM(_VOID, drawlist_add_bezier_curve, _TDRAWLIST _DYN _DYN _DYN _DYN _I32 _F32 _I32 );



