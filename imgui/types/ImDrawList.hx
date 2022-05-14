package imgui.types;

import imgui.ImGuiUtils;
import imgui.ImGui;
import imgui.types.Pointers;

@:hlNative("hlimgui", "drawlist_")
abstract ImDrawList(ImDrawListPtr) from ImDrawListPtr to ImDrawListPtr
{
	public inline function new(ptr: ImDrawListPtr) { this = ptr; }
	
	// Note: Because how HL interprets optional values (i.e. `_REF(_T)`)
	// and default value given to them is silently ignored, instead providing a nullptr,
	// all calls that have default values that are not nulls are inline wrappers.

	public inline function pushClipRect(clipRectMin: ImVec2, clipRectMax: ImVec2, intersectWithCurrentClipRect: Bool = false) { push_clip_rect(clipRectMin, clipRectMax, intersectWithCurrentClipRect); }
	public        function pushClipRectFullScreen() {}
	public        function popClipRect() {}
	public        function pushTextureId(textureId: ImTextureID) {}
	public        function popTextureId() {}
	public        function getClipRectMin(): ImVec2 { return null; }
	public        function getClipRectMax(): ImVec2 { return null; }

	public inline function addLine( p1: ImVec2, p2: ImVec2, col: ImU32, thickness: Single = 1.0 ) { add_line( p1, p2, col, thickness ); }
	public inline function addRect( pMin: ImVec2, pMax: ImVec2, col: ImU32, rounding: Single = 0.0, roundingCorners: ImDrawFlags = ImDrawFlags.None, thickness: Single = 1.0 ) { add_rect( pMin, pMax, col, rounding, roundingCorners, thickness ); }
	public inline function addRectFilled( pMin: ImVec2, pMax: ImVec2, col: ImU32, rounding: Single = 0.0, roundingCorners: ImDrawFlags = ImDrawFlags.None ) { add_rect_filled( pMin, pMax, col, rounding, roundingCorners); }
	public        function addRectFilledMultiColor( pMin: ImVec2, pMax: ImVec2, col_upr_left: ImU32, col_upr_right: ImU32, col_bot_right: ImU32, col_bot_left: ImU32 ) {}
	public inline function addQuad( p1: ImVec2, p2: ImVec2, p3: ImVec2, p4: ImVec2, col: ImU32, thickness: Single = 1.0 ) { add_quad(p1, p2, p3, p4, col, thickness ); }
	public        function addQuadFilled( p1: ImVec2, p2: ImVec2, p3: ImVec2, p4: ImVec2, col: ImU32 ) {}
	public inline function addTriangle( p1: ImVec2, p2: ImVec2, p3: ImVec2, col: ImU32, thickness: Single = 1.0 ) { add_triangle(p1, p2, p3, col, thickness ); }
	public        function addTriangleFilled( p1: ImVec2, p2: ImVec2, p3: ImVec2, col: ImU32 ) {}
	public inline function addCircle( center: ImVec2, radius: Single, col: ImU32, num_segments: Int = 0, thickness: Single = 1.0 ) { add_circle( center, radius, col, num_segments, thickness ); }
	public inline function addCircleFilled( center: ImVec2, radius: Single, col: ImU32, num_segments: Int = 0) { add_circle_filled(center, radius, col, num_segments ); }
	public inline function addNgon( center: ImVec2, radius: Single, col: ImU32, num_segments: Int, thickness: Single = 1.0 ) { add_ngon(center, radius, col, num_segments, thickness ); }
	public inline function addNgonFilled( center: ImVec2, radius: Single, col: ImU32, num_segments: Int = 0) { add_ngon_filled(center, radius, col, num_segments ); }
	public inline function addPolyLine( points: hl.NativeArray<ImVec2>, col: ImU32, closed: Bool, thickness: Single = 1.0 ) { add_poly_line(points, col, closed, thickness ); }
	public        function addConvexPolyFilled( points: hl.NativeArray<ImVec2>, col: ImU32 ) {}
	public inline function addBezierCurve( p1: ImVec2, p2: ImVec2, p3: ImVec2, p4: ImVec2, col: ImU32, thickness: Single = 1.0, num_segments: Int = 0 ) { add_bezier_curve(p1, p2, p3, p4, col, thickness, num_segments ); }
	//
	public        function addText( pos: ImVec2, col: ImU32, text: String ) {}
	public inline function addText2( font: ImFont, fontSize: Single, pos: ImVec2, col: ImU32, text: String, wrapWidth: Single = 0.0, ?cpuFineClipRect: ImVec4 ) { add_text2(font, fontSize, pos, col, text, wrapWidth, cpuFineClipRect); }

	public inline function addImage( userTextureId: ImTextureID, pMin: ImVec2, pMax: ImVec2, ?uvMin: ImVec2, ?uvMax: ImVec2, col: Int = 0xffffffff ) { add_image(userTextureId, pMin, pMax, uvMin, uvMax, col); }
	public inline function addImageQuad( userTextureId: ImTextureID, p1: ImVec2, p2: ImVec2, p3: ImVec2, p4: ImVec2, ?uv1: ImVec2, ?uv2: ImVec2, ?uv3: ImVec2, ?uv4: ImVec2, col: Int = 0xffffffff ) { add_image_quad(userTextureId, p1, p2, p3, p4, uv1, uv2, uv3, uv4, col); }
	public inline function addImageRounded( userTextureId: ImTextureID, pMin: ImVec2, pMax: ImVec2, uvMin: ImVec2, uvMax: ImVec2, col: Int, rounding: Single, roundingCorners: ImDrawFlags = RoundCornersDefault_ ) { add_image_rounded(userTextureId, pMin, pMax, uvMin, uvMax, col, rounding, roundingCorners); }

	// Stateful path API, add points then finish with pathFillConvex() or pathStroke()

	public        function pathClear() {}
	public        function pathLineTo(pos: ImVec2) {}
	public        function pathLineToMergeDuplicate(pos: ImVec2) {}
	public        function pathFillConvex(col: Int) {}
	public inline function pathStroke(col: Int, flags: ImDrawFlags = 0, thickness: Single = 1.0) { path_stroke(col, flags, thickness); }
	              function path_stroke(col: Int, flags: ImDrawFlags, thickness: Single) {}
	public inline function pathArcTo(center: ImVec2, radius: Single, a_min: Single, a_max: Single, num_segments: Int = 0) { path_arc_to(center, radius, a_min, a_max, num_segments); }
	              function path_arc_to(center: ImVec2, radius: Single, a_min: Single, a_max: Single, num_segments: Int) {}
	/* Use precomputed angles for a 12 steps circle */
	public        function pathArcToFast(center: ImVec2, radius: Single, a_min_of_12: Int, a_max_of_12: Int) {}
	public inline function pathBezierCubicCurveTo(p2: ImVec2, p3: ImVec2, p4: ImVec2, num_segments: Int = 0) { path_bezier_cubic_curve_to(p2, p3, p4, num_segments); }
	              function path_bezier_cubic_curve_to(p2: ImVec2, p3: ImVec2, p4: ImVec2, num_segments: Int) {}
	public inline function pathBezierQuadraticCurveTo(p2: ImVec2, p3: ImVec2, num_segments: Int = 0) { path_bezier_quadratic_curve_to(p2, p3, num_segments); }
	              function path_bezier_quadratic_curve_to(p2: ImVec2, p3: ImVec2, num_segments: Int) {}
	public inline function pathRect(rect_min: ImVec2, rect_max: ImVec2, rounding: Single = 0.0, flags: ImDrawFlags = 0) { path_rect(rect_min, rect_max, rounding, flags); }
	              function path_rect(rect_min: ImVec2, rect_max: ImVec2, rounding: Single, flags: ImDrawFlags) {}
	
	#if heaps
	// Helper methods for Heaps: Use Tile instead of Texture to pass image segments easily.

	public inline function addTile( tile: h2d.Tile, pMin: ImVec2, ?pMax: ImVec2, col: Int = 0xffffffff, honorDxDy = false) @:privateAccess {
		if (pMax == null) pMax = ImTypeCache.vec2(pMin.x + tile.width, pMin.y + tile.height);
		if (honorDxDy) {
			pMin.x += tile.dx;
			pMin.y += tile.dy;
			pMax.x += tile.dx;
			pMax.y += tile.dy;
		}
		addImage(tile.getTexture(), pMin, pMax, ImTypeCache.vec2(tile.u, tile.v), ImTypeCache.vec2(tile.u2, tile.v2), col);
	}

	public inline function addTileQuad( tile: h2d.Tile, p1: ImVec2, p2: ImVec2, p3: ImVec2, p4: ImVec2, col: Int = 0xffffffff) @:privateAccess {
		addImageQuad( tile.getTexture(), p1, p2, p3, p4,
			ImTypeCache.vec2(tile.u, tile.v), ImTypeCache.vec2(tile.u2, tile.v), ImTypeCache.vec2(tile.u2, tile.v2), ImTypeCache.vec2(tile.u2, tile.v),
			col
		);
	}

	public inline function addTileRounded( tile: h2d.Tile, pMin: ImVec2, ?pMax: ImVec2, col: Int, rounding: Single, roundingCorners: ImDrawFlags = -1, honorDxDy = false ) @:privateAccess {
		if (pMax == null) pMax = ImTypeCache.vec2(pMin.x + tile.width, pMin.y + tile.height);
		if (honorDxDy) {
			pMin.x += tile.dx;
			pMin.y += tile.dy;
			pMax.x += tile.dx;
			pMax.y += tile.dy;
		}
		addImageRounded( tile.getTexture(), pMin, pMax, ImTypeCache.vec2(tile.u, tile.v), ImTypeCache.vec2(tile.u2, tile.v2), col, rounding, roundingCorners);
	}
	#end

	function push_clip_rect(clip_rect_min: ImVec2, clip_rect_max: ImVec2, intersect_with_current_clip_rect: Bool ) {}
	
	function add_line( p1: ImVec2, p2: ImVec2, col: ImU32, thickness: Single ) {}
	function add_rect( pMin: ImVec2, pMax: ImVec2, col: ImU32, rounding: Single, roundingCorners: ImDrawFlags, thickness ) {}
	function add_rect_filled( pMin: ImVec2, pMax: ImVec2, col: ImU32, rounding: Single, roundingCorners: ImDrawFlags ) {}
	function add_quad( p1: ImVec2, p2: ImVec2, p3: ImVec2, p4: ImVec2, col: ImU32, thickness: Single ) {}
	function add_triangle( p1: ImVec2, p2: ImVec2, p3: ImVec2, col: ImU32, thickness: Single ) {}
	function add_circle( center: ImVec2, radius: Single, col: ImU32, num_segments: Int, thickness: Single ) {}
	function add_circle_filled( center: ImVec2, radius: Single, col: ImU32, num_segments: Int) {}
	function add_ngon( center: ImVec2, radius: Single, col: ImU32, num_segments: Int, thickness: Single ) {}
	function add_ngon_filled( center: ImVec2, radius: Single, col: ImU32, num_segments: Int) {}
	function add_poly_line( points: hl.NativeArray<ImVec2>, col: ImU32, closed: Bool, thickness: Single ) {}
	function add_bezier_curve( p1: ImVec2, p2: ImVec2, p3: ImVec2, p4: ImVec2, col: ImU32, thickness: Single, num_segments: Int ) {}
	
	function add_text2( font: ImFontPtr, font_size: Single, pos: ImVec2, col: ImU32, text: String, wrap_width: Single, cpu_fine_clip_rect: ImVec4 ) {}

	function add_image( userTextureId: ImTextureID, pMin: ImVec2, pMax: ImVec2, uvMin: ImVec2, uvMax: ImVec2, col: ImU32 ) {}
	function add_image_quad( userTextureId: ImTextureID, p1: ImVec2, p2: ImVec2, p3: ImVec2, p4: ImVec2, uv1: ImVec2, uv2: ImVec2, uv3: ImVec2, uv4: ImVec2, col: ImU32 ) {}
	function add_image_rounded( userTextureId: ImTextureID, pMin: ImVec2, pMax: ImVec2, uvMin: ImVec2, uvMax: ImVec2, col: ImU32, rounding: Single, roundingCorners: ImDrawFlags ) {}
}
