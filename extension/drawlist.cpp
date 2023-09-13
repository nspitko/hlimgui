#include "utils.h"

#define _TDRAWLIST _ABSTRACT(imdrawlist)
#define F_NAME(n) HL_NAME(drawlist_##n)
#define DEFINE_FPRIM(t,name,args) DEFINE_PRIM(t,drawlist_##name,_TDRAWLIST args)

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
HL_PRIM void F_NAME(push_clip_rect)(ImDrawList *drawlist, vimvec2* clip_rect_min, vimvec2* clip_rect_max, bool* intersect_with_current_clip_rect) {
	drawlist->PushClipRect(clip_rect_min, clip_rect_max, convertPtr(intersect_with_current_clip_rect, false));
}

HL_PRIM void F_NAME(push_clip_rect_full_screen)(ImDrawList* drawlist) {
	drawlist->PushClipRectFullScreen();
}

HL_PRIM void F_NAME(pop_clip_rect)(ImDrawList* drawlist) {
	drawlist->PopClipRect();
}

HL_PRIM void F_NAME(push_texture_id)(ImDrawList* drawlist, ImTextureID texture_id) {
	drawlist->PushTextureID(texture_id);
}

HL_PRIM void F_NAME(pop_texture_id)(ImDrawList* drawlist) {
	drawlist->PopTextureID();
}

HL_PRIM vimvec2* F_NAME(get_clip_rect_min)(ImDrawList* drawlist) {
	return drawlist->GetClipRectMin();
}

HL_PRIM vimvec2* F_NAME(get_clip_rect_max)(ImDrawList* drawlist) {
	return drawlist->GetClipRectMax();
}

HL_PRIM void F_NAME(add_line)(ImDrawList *drawlist, vimvec2* p1, vimvec2* p2, ImU32 col, float* thickness)
{
	drawlist->AddLine( p1, p2, col, convertPtr(thickness, 1.0f) );
}

HL_PRIM void F_NAME(add_rect)(ImDrawList *drawlist, vimvec2* p_min, vimvec2* p_max, ImU32 col, float* rounding, ImDrawFlags* rounding_corners, float* thickness)
{
	drawlist->AddRect( p_min, p_max, col, convertPtr(rounding, 0.0f), convertPtr(rounding_corners, 0), convertPtr(thickness, 1.0f) );
}

HL_PRIM void F_NAME(add_rect_filled)(ImDrawList *drawlist, vimvec2* p_min, vimvec2* p_max, ImU32 col, float* rounding, ImDrawFlags* rounding_corners)
{
	drawlist->AddRectFilled( p_min, p_max, col, convertPtr(rounding, 0.0f), convertPtr(rounding_corners, 0) );
}

HL_PRIM void F_NAME(add_rect_filled_multi_color)( ImDrawList *drawlist, vimvec2* p_min, vimvec2* p_max, ImU32 col_upr_left , ImU32 col_upr_right, ImU32 col_bot_right, ImU32 col_bot_left)
{
	drawlist->AddRectFilledMultiColor( p_min, p_max, col_upr_left, col_upr_right, col_bot_right, col_bot_left );
}

HL_PRIM void F_NAME(add_quad)(ImDrawList *drawlist, vimvec2* p1, vimvec2* p2, vimvec2* p3, vimvec2* p4, ImU32 col, float* thickness)
{
	drawlist->AddQuad( p1, p2, p3, p4, col, convertPtr(thickness, 1.0f) );
}

HL_PRIM void F_NAME(add_quad_filled)(ImDrawList *drawlist, vimvec2* p1, vimvec2* p2, vimvec2* p3, vimvec2* p4, ImU32 col)
{
	drawlist->AddQuadFilled(p1, p2, p3, p4, col );
}

HL_PRIM void F_NAME(add_triangle)(ImDrawList *drawlist, vimvec2* p1, vimvec2* p2, vimvec2* p3, ImU32 col, float* thickness)
{
	drawlist->AddTriangle( p1, p2, p3, col, convertPtr(thickness, 1.0f) );
}

HL_PRIM void F_NAME(add_triangle_filled)(ImDrawList *drawlist, vimvec2* p1, vimvec2* p2, vimvec2* p3, ImU32 col)
{
	drawlist->AddTriangleFilled( p1, p2, p3, col );
}

HL_PRIM void F_NAME(add_circle)(ImDrawList *drawlist, vimvec2* center, float radius, ImU32 col, int* num_segments, float* thickness)
{
	drawlist->AddCircle( center, radius, col, convertPtr(num_segments, 0), convertPtr(thickness, 1.0f) );
}

HL_PRIM void F_NAME(add_circle_filled)(ImDrawList *drawlist, vimvec2* center, float radius, ImU32 col, int* num_segments)
{
	drawlist->AddCircleFilled( center, radius, col, convertPtr(num_segments, 0) );
}

HL_PRIM void F_NAME(add_ngon)(ImDrawList *drawlist, vimvec2* center, float radius, ImU32 col, int num_segments, float* thickness)
{
	drawlist->AddNgon( center, radius, col, num_segments, convertPtr(thickness, 1.0f) );
}

HL_PRIM void F_NAME(add_ngon_filled)(ImDrawList *drawlist, vimvec2* center, float radius, ImU32 col, int num_segments)
{
	drawlist->AddNgonFilled( center, radius, col, num_segments );
}

HL_PRIM void F_NAME(add_poly_line)(ImDrawList *drawlist, varray* points, ImU32 col, bool closed, float* thickness)
{
	std::vector<ImVec2> vecPoints;
	auto hlPoints = hl_aptr(points, vimvec2*);
	for (int i = 0; i < points->size; i++)
	{
		vecPoints.push_back(hlPoints[i]);
	}

	drawlist->AddPolyline( &vecPoints[0], points->size, col, closed, convertPtr(thickness, 1.0f) );
}

HL_PRIM void F_NAME(add_convex_poly_filled)(ImDrawList *drawlist, varray* points, ImU32 col)
{
	std::vector<ImVec2> vecPoints;
	auto hlPoints = hl_aptr(points, vimvec2*);
	for (int i = 0; i < points->size; i++)
	{
		vecPoints.push_back(hlPoints[i]);
	}

	drawlist->AddConvexPolyFilled( &vecPoints[0], points->size, col);
}

HL_PRIM void F_NAME(add_text)(ImDrawList* drawlist, vimvec2* pos, int col, vstring* text) {
	drawlist->AddText(pos, col, convertString(text));
}

HL_PRIM void F_NAME(add_text2)(ImDrawList* drawlist, ImFont* font, float font_size, vimvec2* pos, int col, vstring* text, float* wrap_width, vimvec4* cpu_fine_clip_rect) {
	drawlist->AddText(font, font_size, pos, col, convertString(text), (const char*)NULL, convertPtr(wrap_width, 0.0f), cpu_fine_clip_rect == nullptr ? NULL : cpu_fine_clip_rect->v());
}

HL_PRIM void F_NAME(add_bezier_cubic)(ImDrawList* drawlist, vimvec2* p1, vimvec2* p2, vimvec2* p3, vimvec2* p4, int col, float thickness, int* num_segments) {
	drawlist->AddBezierCubic(p1, p2, p3, p4, col, thickness, convertPtr(num_segments, 0));
}

HL_PRIM void F_NAME(add_bezier_quadratic)(ImDrawList* drawlist, vimvec2* p1, vimvec2* p2, vimvec2* p3, int col, float thickness, int* num_segments) {
	drawlist->AddBezierQuadratic(p1, p2, p3, col, thickness, convertPtr(num_segments, 0));
}


HL_PRIM void F_NAME(add_image)(ImDrawList* drawlist, ImTextureID user_texture_id, vimvec2* p_min, vimvec2* p_max, vimvec2* uv_min, vimvec2* uv_max, int* col) {
	drawlist->AddImage(user_texture_id, p_min, p_max, convertVec(uv_min, ImVec2(0, 0)), convertVec(uv_max, ImVec2(1, 1)), convertPtr(col, IM_COL32_WHITE));
}

HL_PRIM void F_NAME(add_image_quad)(ImDrawList* drawlist, ImTextureID user_texture_id, vimvec2* p1, vimvec2* p2, vimvec2* p3, vimvec2* p4, vimvec2* uv1, vimvec2* uv2, vimvec2* uv3, vimvec2* uv4, int* col) {
	drawlist->AddImageQuad(user_texture_id, 
		p1, p2, p3, p4,
		convertVec(uv1, ImVec2(0, 0)), convertVec(uv2, ImVec2(1, 0)), convertVec(uv3, ImVec2(1, 1)), convertVec(uv4, ImVec2(0, 1)),
		convertPtr(col, IM_COL32_WHITE)
	);
}

HL_PRIM void F_NAME(add_image_rounded)(ImDrawList *drawlist, ImTextureID user_texture_id, vimvec2* p_min, vimvec2* p_max, vimvec2* uv_min, vimvec2* uv_max, int col, float rounding, ImDrawFlags* flags) {
	drawlist->AddImageRounded(user_texture_id, p_min, p_max, uv_min, uv_max, col, rounding, convertPtr(flags, 0));
}


// Stateful path API, add points then finish with PathFillConvex() or PathStroke()
HL_PRIM void F_NAME(path_clear)(ImDrawList* drawlist)
{
	drawlist->PathClear();
}

HL_PRIM void F_NAME(path_line_to)(ImDrawList* drawlist, vimvec2* pos)
{
	drawlist->PathLineTo(pos);
}

HL_PRIM void F_NAME(path_line_to_merge_duplicate)(ImDrawList* drawlist, vimvec2* pos)
{
	drawlist->PathLineToMergeDuplicate(pos);
}

HL_PRIM void F_NAME(path_fill_convex)(ImDrawList* drawlist, int col)
{
	drawlist->PathFillConvex(col);
}

HL_PRIM void F_NAME(path_stroke)(ImDrawList* drawlist, int col, ImDrawFlags* flags, float* thickness)
{
	drawlist->PathStroke(col, convertPtr(flags, 0), convertPtr(thickness, 1.0f));
}

HL_PRIM void F_NAME(path_arc_to)(ImDrawList* drawlist, vimvec2* center, float radius, float a_min, float a_max, int* num_segments)
{
	drawlist->PathArcTo(center, radius, a_min, a_max, convertPtr(num_segments, 0));
}

HL_PRIM void F_NAME(path_arc_to_fast)(ImDrawList* drawlist, vimvec2* center, float radius, int a_min_of_12, int a_max_of_12)
{
	drawlist->PathArcToFast(center, radius, a_min_of_12, a_max_of_12);
}

HL_PRIM void F_NAME(path_bezier_cubic_curve_to)(ImDrawList* drawlist, vimvec2* p2, vimvec2* p3, vimvec2* p4, int* num_segments)
{
	drawlist->PathBezierCubicCurveTo(p2, p3, p4, convertPtr(num_segments, 0));
}

HL_PRIM void F_NAME(path_bezier_quadratic_curve_to)(ImDrawList* drawlist, vimvec2* p2, vimvec2* p3, int* num_segments)
{
	drawlist->PathBezierQuadraticCurveTo(p2, p3, convertPtr(num_segments, 0));
}

HL_PRIM void F_NAME(path_rect)(ImDrawList* drawlist, vimvec2* rect_min, vimvec2* rect_max, float* rounding, ImDrawFlags* flags)
{
	drawlist->PathRect(rect_min, rect_max, convertPtr(rounding, 0.0f), convertPtr(flags, 0));
}

// Advanced

HL_PRIM void F_NAME(add_callback)(ImDrawList* drawlist, vclosure* callback, vdynamic* data) {
	drawlist->AddCallback((ImDrawCallback)(void*)callback, data);
}

HL_PRIM void F_NAME(add_draw_cmd)(ImDrawList* drawlist) {
	drawlist->AddDrawCmd();
}

// HL_PRIM ImDrawList* CloneOutput() {
// 	// TODO
// }

DEFINE_PRIM(_TDRAWLIST, get_window_draw_list, _NO_ARG );
DEFINE_PRIM(_TDRAWLIST, get_foreground_draw_list, _NO_ARG );
DEFINE_PRIM(_TDRAWLIST, get_background_draw_list, _NO_ARG );

DEFINE_FPRIM(_VOID, push_clip_rect, _IMVEC2 _IMVEC2 _REF(_BOOL));
DEFINE_FPRIM(_VOID, push_clip_rect_full_screen, _NO_ARG);
DEFINE_FPRIM(_VOID, pop_clip_rect, _NO_ARG);
DEFINE_FPRIM(_VOID, push_texture_id, _DYN);
DEFINE_FPRIM(_VOID, pop_texture_id, _NO_ARG);
DEFINE_FPRIM(_IMVEC2, get_clip_rect_min, _NO_ARG);
DEFINE_FPRIM(_IMVEC2, get_clip_rect_max, _NO_ARG);

DEFINE_FPRIM(_VOID, add_line, _IMVEC2 _IMVEC2 _I32 _REF(_F32) );
DEFINE_FPRIM(_VOID, add_rect, _IMVEC2 _IMVEC2 _I32 _REF(_F32) _REF(_I32) _REF(_F32) );
DEFINE_FPRIM(_VOID, add_rect_filled, _IMVEC2 _IMVEC2 _I32 _REF(_F32) _REF(_I32) );
DEFINE_FPRIM(_VOID, add_rect_filled_multi_color, _IMVEC2 _IMVEC2 _I32 _I32 _I32 _I32 );
DEFINE_FPRIM(_VOID, add_quad, _IMVEC2 _IMVEC2 _IMVEC2 _IMVEC2 _I32 _REF(_F32) );
DEFINE_FPRIM(_VOID, add_quad_filled, _IMVEC2 _IMVEC2 _IMVEC2 _IMVEC2 _I32 );
DEFINE_FPRIM(_VOID, add_triangle, _IMVEC2 _IMVEC2 _IMVEC2 _I32 _REF(_F32) );
DEFINE_FPRIM(_VOID, add_triangle_filled, _IMVEC2 _IMVEC2 _IMVEC2 _I32 );
DEFINE_FPRIM(_VOID, add_circle, _IMVEC2 _F32 _I32 _REF(_I32) _REF(_F32) );
DEFINE_FPRIM(_VOID, add_circle_filled, _IMVEC2 _F32 _I32 _REF(_I32) );
DEFINE_FPRIM(_VOID, add_ngon, _IMVEC2 _F32 _I32 _I32 _REF(_F32) );
DEFINE_FPRIM(_VOID, add_ngon_filled, _IMVEC2 _F32 _I32 _I32 );
DEFINE_FPRIM(_VOID, add_poly_line, _ARR _I32 _BOOL _REF(_F32) );
DEFINE_FPRIM(_VOID, add_convex_poly_filled, _ARR _I32 );
DEFINE_FPRIM(_VOID, add_bezier_cubic, _IMVEC2 _IMVEC2 _IMVEC2 _IMVEC2 _I32 _F32 _REF(_I32));
DEFINE_FPRIM(_VOID, add_bezier_quadratic, _IMVEC2 _IMVEC2 _IMVEC2 _I32 _F32 _REF(_I32));
//
DEFINE_FPRIM(_VOID, add_text, _IMVEC2 _I32 _STRING);
DEFINE_FPRIM(_VOID, add_text2, _ABSTRACT(imfont) _F32 _IMVEC2 _I32 _STRING _REF(_F32) _IMVEC4);

DEFINE_FPRIM(_VOID, add_image, _DYN _IMVEC2 _IMVEC2 _IMVEC2 _IMVEC2 _REF(_I32) );
DEFINE_FPRIM(_VOID, add_image_quad, _DYN _IMVEC2 _IMVEC2 _IMVEC2 _IMVEC2 _IMVEC2 _IMVEC2 _IMVEC2 _IMVEC2 _REF(_I32) );
DEFINE_FPRIM(_VOID, add_image_rounded, _DYN _IMVEC2 _IMVEC2 _IMVEC2 _IMVEC2 _I32 _F32 _REF(_I32) );

DEFINE_FPRIM(_VOID, path_clear, _NO_ARG);
DEFINE_FPRIM(_VOID, path_line_to, _IMVEC2);
DEFINE_FPRIM(_VOID, path_line_to_merge_duplicate, _IMVEC2);
DEFINE_FPRIM(_VOID, path_fill_convex, _I32);
DEFINE_FPRIM(_VOID, path_stroke, _I32 _REF(_I32) _REF(_F32));
DEFINE_FPRIM(_VOID, path_arc_to, _IMVEC2 _F32 _F32 _F32 _REF(_I32));
DEFINE_FPRIM(_VOID, path_arc_to_fast, _IMVEC2 _F32 _I32 _I32);
DEFINE_FPRIM(_VOID, path_bezier_cubic_curve_to, _IMVEC2 _IMVEC2 _IMVEC2 _REF(_I32));
DEFINE_FPRIM(_VOID, path_bezier_quadratic_curve_to, _IMVEC2 _IMVEC2 _REF(_I32));
DEFINE_FPRIM(_VOID, path_rect, _IMVEC2 _IMVEC2 _REF(_F32) _REF(_I32));

DEFINE_FPRIM(_VOID, add_callback, _TRENDERCALLBACK _DYN);
DEFINE_FPRIM(_VOID, add_draw_cmd, _NO_ARG);

// DrawListSplitter

#define S_NAME(n) HL_NAME(drawlistsplitter_##n)
#define DEFINE_SPRIM(t,name,args) DEFINE_PRIM(t,drawlistsplitter_##name,_STRUCT args)

typedef struct _hl_list_splitter hl_list_splitter;
struct _hl_list_splitter {
	void(*finalize)(hl_list_splitter*);
	ImDrawListSplitter splitter;
};

static void drawlistsplitter_finalize(hl_list_splitter *c)
{
	c->splitter.~ImDrawListSplitter();
}

HL_PRIM hl_list_splitter* S_NAME(init)()
{
	hl_list_splitter* hl_mem = (hl_list_splitter*)hl_gc_alloc_finalizer(sizeof(hl_list_splitter));
	hl_mem->finalize = drawlistsplitter_finalize;
	new (&hl_mem->splitter)ImDrawListSplitter();
	return hl_mem;
}

HL_PRIM void S_NAME(clear)(hl_list_splitter* s)
{
	s->splitter.Clear();
}

HL_PRIM void S_NAME(clear_free_memory)(hl_list_splitter* s)
{
	s->splitter.ClearFreeMemory();
}

HL_PRIM void S_NAME(split)(hl_list_splitter* s, ImDrawList* draw_list, int count)
{
	s->splitter.Split(draw_list, count);
}

HL_PRIM void S_NAME(merge)(hl_list_splitter* s, ImDrawList* draw_list)
{
	s->splitter.Merge(draw_list);
}

HL_PRIM void S_NAME(set_current_channel)(hl_list_splitter* s, ImDrawList* draw_list, int channel_idx)
{
	s->splitter.SetCurrentChannel(draw_list, channel_idx);
}

DEFINE_PRIM(_STRUCT, drawlistsplitter_init, _NO_ARG);
DEFINE_SPRIM(_VOID, clear, _NO_ARG);
DEFINE_SPRIM(_VOID, clear_free_memory, _NO_ARG);
DEFINE_SPRIM(_VOID, split, _TDRAWLIST _I32);
DEFINE_SPRIM(_VOID, merge, _TDRAWLIST);
DEFINE_SPRIM(_VOID, set_current_channel, _TDRAWLIST _I32);