#include "utils.h"

HL_PRIM ImDrawList *HL_NAME(get_window_draw_list)()
{
    return ImGui::GetWindowDrawList();
}

HL_PRIM ImDrawList *HL_NAME(get_foreground_draw_list)()
{
    return ImGui::GetForegroundDrawList();
}

HL_PRIM ImDrawList *HL_NAME(get_background_draw_list)()
{
    return ImGui::GetBackgroundDrawList();
}

// Render-level scissoring. This is passed down to your render function but not used for CPU-side coarse clipping. Prefer using higher-level ImGui::PushClipRect() to affect logic (hit-testing and widget culling)
HL_PRIM void HL_NAME(drawlist_push_clip_rect)(ImDrawList *drawlist, vdynamic* clip_rect_min, vdynamic* clip_rect_max, bool intersect_with_current_clip_rect) {
	drawlist->PushClipRect(clip_rect_min, clip_rect_max, intersect_with_current_clip_rect);
}

HL_PRIM void HL_NAME(drawlist_push_clip_rect_full_screen)(ImDrawList* drawlist) {
	drawlist->PushClipRectFullScreen();
}

HL_PRIM void HL_NAME(drawlist_pop_clip_rect)(ImDrawList* drawlist) {
	drawlist->PopClipRect();
}

HL_PRIM void HL_NAME(drawlist_push_texture_id)(ImDrawList* drawlist, ImTextureID texture_id) {
	drawlist->PushTextureID(texture_id);
}

HL_PRIM void HL_NAME(drawlist_pop_texture_id)(ImDrawList* drawlist) {
	drawlist->PopTextureID();
}

HL_PRIM vdynamic* HL_NAME(drawlist_get_clip_rect_min)(ImDrawList* drawlist) {
	return drawlist->GetClipRectMin();
}

HL_PRIM vdynamic* HL_NAME(drawlist_get_clip_rect_max)(ImDrawList* drawlist) {
	return drawlist->GetClipRectMax();
}

HL_PRIM void HL_NAME(drawlist_add_line)(ImDrawList *drawlist, vdynamic* p1, vdynamic* p2, ImU32 col, float thickness)
{
	drawlist->AddLine( getImVec2(p1), getImVec2(p2), col, thickness );
}

HL_PRIM void HL_NAME(drawlist_add_rect)(ImDrawList *drawlist, vdynamic* p_min, vdynamic* p_max, ImU32 col, float rounding, ImDrawFlags rounding_corners, float thickness)
{
	drawlist->AddRect( getImVec2(p_min), getImVec2(p_max), col, rounding, rounding_corners, thickness );
}

HL_PRIM void HL_NAME(drawlist_add_rect_filled)(ImDrawList *drawlist, vdynamic* p_min, vdynamic* p_max, ImU32 col, float rounding, ImDrawFlags rounding_corners)
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

HL_PRIM void HL_NAME(drawlist_add_text)(ImDrawList* drawlist, vdynamic* pos, int col, vstring* text) {
	drawlist->AddText(pos, col, convertString(text));
}

HL_PRIM void HL_NAME(drawlist_add_text2)(ImDrawList* drawlist, ImFont* font, float font_size, vdynamic* pos, int col, vstring* text, float wrap_width, vdynamic* cpu_fine_clip_rect) {
	ImVec4 clip = cpu_fine_clip_rect == nullptr ? NULL : ImVec4(cpu_fine_clip_rect);
	drawlist->AddText(font, font_size, ImVec2(pos), col, convertString(text), (const char*)NULL, wrap_width, &clip);
}

HL_PRIM void HL_NAME(drawlist_add_image)(ImDrawList* drawlist, ImTextureID user_texture_id, vdynamic* p_min, vdynamic* p_max, vdynamic* uv_min, vdynamic* uv_max, int col) {
	drawlist->AddImage(user_texture_id, p_min, p_max, getImVec2(uv_min), getImVec2(uv_max, ImVec2(1, 1)),  col);
}

HL_PRIM void HL_NAME(drawlist_add_image_quad)(ImDrawList* drawlist, ImTextureID user_texture_id, vdynamic* p1, vdynamic* p2, vdynamic* p3, vdynamic* p4, vdynamic* uv1, vdynamic* uv2, vdynamic* uv3, vdynamic* uv4, int col) {
	drawlist->AddImageQuad(user_texture_id, 
		p1, p2, p3, p4,
		getImVec2(uv1), getImVec2(uv2, ImVec2(1, 0)), getImVec2(uv3, ImVec2(1, 1)), getImVec2(uv4, ImVec2(0, 1)),
		col);
}

HL_PRIM void HL_NAME(drawlist_add_image_rounded)(ImDrawList *drawlist, ImTextureID user_texture_id, vdynamic* p_min, vdynamic* p_max, vdynamic* uv_min, vdynamic* uv_max, int col, float rounding, ImDrawFlags flags) {
	drawlist->AddImageRounded(user_texture_id, p_min, p_max, getImVec2(uv_min), getImVec2(uv_max, ImVec2(1, 1)), col, rounding, flags);
}

#define _TDRAWLIST _ABSTRACT(imdrawlist)

DEFINE_PRIM(_TDRAWLIST, get_window_draw_list, _NO_ARG );
DEFINE_PRIM(_TDRAWLIST, get_foreground_draw_list, _NO_ARG );
DEFINE_PRIM(_TDRAWLIST, get_background_draw_list, _NO_ARG );

DEFINE_PRIM(_VOID, drawlist_push_clip_rect, _TDRAWLIST _DYN _DYN _BOOL);
DEFINE_PRIM(_VOID, drawlist_push_clip_rect_full_screen, _TDRAWLIST);
DEFINE_PRIM(_VOID, drawlist_pop_clip_rect, _TDRAWLIST);
DEFINE_PRIM(_VOID, drawlist_push_texture_id, _TDRAWLIST _DYN);
DEFINE_PRIM(_VOID, drawlist_pop_texture_id, _TDRAWLIST);
DEFINE_PRIM(_DYN, drawlist_get_clip_rect_min, _TDRAWLIST);
DEFINE_PRIM(_DYN, drawlist_get_clip_rect_max, _TDRAWLIST);

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
//
DEFINE_PRIM(_VOID, drawlist_add_text, _TDRAWLIST _DYN _I32 _STRING);
DEFINE_PRIM(_VOID, drawlist_add_text2, _TDRAWLIST _ABSTRACT(imfont) _F32 _DYN _I32 _STRING _F32 _DYN);

DEFINE_PRIM(_VOID, drawlist_add_image, _TDRAWLIST _DYN _DYN _DYN _DYN _DYN _I32 );
DEFINE_PRIM(_VOID, drawlist_add_image_quad, _TDRAWLIST _DYN _DYN _DYN _DYN _DYN _DYN _DYN _DYN _DYN _I32 );
DEFINE_PRIM(_VOID, drawlist_add_image_rounded, _TDRAWLIST _DYN _DYN _DYN _DYN _DYN _I32 _F32 _I32 );



