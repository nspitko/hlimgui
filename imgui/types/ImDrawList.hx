package imgui.types;

import imgui.ImGuiUtils;
import imgui.ImGui;
import imgui.types.Pointers;

@:hlNative("hlimgui", "drawlist_")
abstract ImDrawList(ImDrawListPtr) from ImDrawListPtr to ImDrawListPtr
{
	public inline function new(ptr: ImDrawListPtr) { this = ptr; }
  
  // TODO: Migrate to ImVec2S/ImVec4S

	public inline function pushClipRect(clipRectMin: ImVec2, clipRectMax: ImVec2, intersectWithCurrentClipRect: Bool = false) { push_clip_rect(clipRectMin, clipRectMax, intersectWithCurrentClipRect); }
	public function pushClipRectFullScreen() {}
	public function popClipRect() {}
	public function pushTextureId(textureId: ImTextureID) {}
	public function popTextureId() {}
	public inline function getClipRectMin(): ImVec2 { return get_clip_rect_min(); }
	public inline function getClipRectMax(): ImVec2 { return get_clip_rect_max(); }

	public inline function addLine( p1: ImVec2, p2: ImVec2, col: ImU32, thickness: Single = 1.0 ) { add_line( this, p1, p2, col, thickness ); }
	public inline function addRect( pMin: ImVec2, pMax: ImVec2, col: ImU32, rounding: Single = 0.0, roundingCorners: ImDrawFlags = ImDrawFlags.None, thickness: Single = 1.0 ) { add_rect( this, pMin, pMax, col, rounding, roundingCorners, thickness ); }
	public inline function addRectFilled( pMin: ImVec2, pMax: ImVec2, col: ImU32, rounding: Single = 0.0, roundingCorners: ImDrawFlags = ImDrawFlags.None ) { add_rect_filled( this, pMin, pMax, col, rounding, roundingCorners); }
	public inline function addRectFilledMultiColor( pMin: ImVec2, pMax: ImVec2, col_upr_left: ImU32, col_upr_right: ImU32, col_bot_right: ImU32, col_bot_left: ImU32 ) { add_rect_filled_multicolor( this, pMin, pMax, col_upr_left, col_upr_right, col_bot_right, col_bot_left ); }
	public inline function addQuad( p1: ImVec2, p2: ImVec2, p3: ImVec2, p4: ImVec2, col: ImU32, thickness: Single = 1.0 ) { add_quad(this, p1, p2, p3, p4, col, thickness ); }
	public inline function addQuadFilled( p1: ImVec2, p2: ImVec2, p3: ImVec2, p4: ImVec2, col: ImU32 ) { add_quad_filled( this, p1, p2, p3, p4, col ); }
	public inline function addTriangle( p1: ImVec2, p2: ImVec2, p3: ImVec2, col: ImU32, thickness: Single = 1.0 ) { add_triangle(this, p1, p2, p3, col, thickness ); }
	public inline function addTriangleFilled( p1: ImVec2, p2: ImVec2, p3: ImVec2, col: ImU32 ) { add_triangle_filled(this, p1, p2, p3, col ); }
	public inline function addCircle( center: ImVec2, radius: Single, col: ImU32, num_segments: Int = 0, thickness: Single = 1.0 ) { add_circle( this, center, radius, col, num_segments, thickness ); }
	public inline function addCircleFilled( center: ImVec2, radius: Single, col: ImU32, num_segments: Int = 0) { add_circle_filled(this, center, radius, col, num_segments ); }
	public inline function addNgon( center: ImVec2, radius: Single, col: ImU32, num_segments: Int, thickness: Single = 1.0 ) { add_ngon(this, center, radius, col, num_segments, thickness ); }
	public inline function addNgonFilled( center: ImVec2, radius: Single, col: ImU32, num_segments: Int = 0) { add_ngon_filled(this, center, radius, col, num_segments ); }
	public inline function addPolyLine( points: hl.NativeArray<ImVec2>, col: ImU32, closed: Bool, thickness: Single = 1.0 ) { add_poly_line(this, points, col, closed, thickness ); }
	public inline function addConvexPolyFilled( points: hl.NativeArray<ImVec2>, col: ImU32 ) { add_convex_poly_filled(this, points, col ); }
	public inline function addBezierCurve( p1: ImVec2, p2: ImVec2, p3: ImVec2, p4: ImVec2, col: ImU32, thickness: Single = 1.0, num_segments: Int = 0 ) { add_bezier_curve(this, p1, p2, p3, p4, col, thickness, num_segments ); }
	//
	public inline function addText( pos: ImVec2, col: ImU32, text: String ) { add_text(this, pos, col, text); }
	public inline function addText2( font: ImFont, fontSize: Single, pos: ImVec2, col: ImU32, text: String, wrapWidth: Single = 0.0, ?cpuFineClipRect: ImVec4 ) { add_text2(this, font==null?null:(@:privateAccess font), fontSize, pos, col, text, wrapWidth, cpuFineClipRect); }

	public inline function addImage( userTextureId: ImTextureID, pMin: ImVec2, pMax: ImVec2, ?uvMin: ImVec2, ?uvMax: ImVec2, col: Int = 0xffffffff ) { add_image(this, userTextureId, pMin, pMax, uvMin, uvMax, col); }
	public inline function addImageQuad( userTextureId: ImTextureID, p1: ImVec2, p2: ImVec2, p3: ImVec2, p4: ImVec2, ?uv1: ImVec2, ?uv2: ImVec2, ?uv3: ImVec2, ?uv4: ImVec2, col: Int = 0xffffffff ) { add_image_quad(this, userTextureId, p1, p2, p3, p4, uv1, uv2, uv3, uv4, col); }
	// Due to Haxe limitation on defualt parameters being "constant" and enum abstract values that rely on previous enum abstract value (A | B) are not "constant" - hack with -1
	public inline function addImageRounded( userTextureId: ImTextureID, pMin: ImVec2, pMax: ImVec2, ?uvMin: ImVec2, ?uvMax: ImVec2, col: Int, rounding: Single, roundingCorners: ImDrawFlags = -1 ) { add_image_rounded(this, userTextureId, pMin, pMax, uvMin, uvMax, col, rounding, roundingCorners == -1 ? ImDrawFlags.RoundCornersDefault_ : roundingCorners); }

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

	function push_clip_rect(clip_rect_min: ExtDynamic<ImVec2>, clip_rect_max: ExtDynamic<ImVec2>, intersect_with_current_clip_rect: Bool ) {}
	function get_clip_rect_min(): ExtDynamic<ImVec2> { return null; }
	function get_clip_rect_max(): ExtDynamic<ImVec2> { return null; }
	
	static function add_line( drawlist: ImDrawListPtr, p1: ExtDynamic<ImVec2>, p2: ExtDynamic<ImVec2>, col: ImU32, thickness: Single ) {}
	static function add_rect( drawlist: ImDrawListPtr, pMin: ExtDynamic<ImVec2>, pMax: ExtDynamic<ImVec2>, col: ImU32, rounding: Single, roundingCorners: ImDrawFlags, thickness ) {}
	static function add_rect_filled( drawlist: ImDrawListPtr, pMin: ExtDynamic<ImVec2>, pMax: ExtDynamic<ImVec2>, col: ImU32, rounding: Single, roundingCorners: ImDrawFlags ) {}
	static function add_rect_filled_multicolor( drawlist: ImDrawListPtr, pMin: ExtDynamic<ImVec2>, pMax: ExtDynamic<ImVec2>, col_upr_left: ImU32, col_upr_right: ImU32, col_bot_right: ImU32, col_bot_left: ImU32 ) {}
	static function add_quad( drawlist: ImDrawListPtr, p1: ExtDynamic<ImVec2>, p2: ExtDynamic<ImVec2>, p3: ExtDynamic<ImVec2>, p4: ExtDynamic<ImVec2>, col: ImU32, thickness: Single ) {}
	static function add_quad_filled( drawlist: ImDrawListPtr, p1: ExtDynamic<ImVec2>, p2: ExtDynamic<ImVec2>, p3: ExtDynamic<ImVec2>, p4: ExtDynamic<ImVec2>, col: ImU32 ) {}
	static function add_triangle( drawlist: ImDrawListPtr, p1: ExtDynamic<ImVec2>, p2: ExtDynamic<ImVec2>, p3: ExtDynamic<ImVec2>, col: ImU32, thickness: Single ) {}
	static function add_triangle_filled( drawlist: ImDrawListPtr, p1: ExtDynamic<ImVec2>, p2: ExtDynamic<ImVec2>, p3: ExtDynamic<ImVec2>, col: ImU32 ) {}
	static function add_circle( drawlist: ImDrawListPtr, center: ExtDynamic<ImVec2>, radius: Single, col: ImU32, num_segments: Int, thickness: Single ) {}
	static function add_circle_filled( drawlist: ImDrawListPtr, center: ExtDynamic<ImVec2>, radius: Single, col: ImU32, num_segments: Int) {}
	static function add_ngon( drawlist: ImDrawListPtr, center: ExtDynamic<ImVec2>, radius: Single, col: ImU32, num_segments: Int, thickness: Single ) {}
	static function add_ngon_filled( drawlist: ImDrawListPtr, center: ExtDynamic<ImVec2>, radius: Single, col: ImU32, num_segments: Int) {}
	static function add_poly_line( drawlist: ImDrawListPtr, points: hl.NativeArray<ImVec2>, col: ImU32, closed: Bool, thickness: Single ) {}
	static function add_convex_poly_filled( drawlist: ImDrawListPtr, points: hl.NativeArray<ExtDynamic<ImVec2>>, col: ImU32 ) {}
	static function add_bezier_curve( drawlist: ImDrawListPtr, p1: ExtDynamic<ImVec2>, p2: ExtDynamic<ImVec2>, p3: ExtDynamic<ImVec2>, p4: ExtDynamic<ImVec2>, col: ImU32, thickness: Single, num_segments: Int ) {}
	static function add_text( drawlist: ImDrawListPtr, pos: ExtDynamic<ImVec2>, col: ImU32, text: String ) {}
	static function add_text2( drawlist: ImDrawListPtr, font: ImFontPtr, font_size: Single, pos: ExtDynamic<ImVec2>, col: ImU32, text: String, wrap_width: Single, cpu_fine_clip_rect: ExtDynamic<ImVec4> ) {}

	static function add_image( drawlist: ImDrawListPtr, userTextureId: ImTextureID, pMin: ExtDynamic<ImVec2>, pMax: ExtDynamic<ImVec2>, uvMin: ExtDynamic<ImVec2>, uvMax: ExtDynamic<ImVec2>, col: ImU32 ) {}
	static function add_image_quad( drawlist: ImDrawListPtr, userTextureId: ImTextureID, p1: ExtDynamic<ImVec2>, p2: ExtDynamic<ImVec2>, p3: ExtDynamic<ImVec2>, p4: ExtDynamic<ImVec2>, uv1: ExtDynamic<ImVec2>, uv2: ExtDynamic<ImVec2>, uv3: ExtDynamic<ImVec2>, uv4: ExtDynamic<ImVec2>, col: ImU32 ) {}
	static function add_image_rounded( drawlist: ImDrawListPtr, userTextureId: ImTextureID, pMin: ExtDynamic<ImVec2>, pMax: ExtDynamic<ImVec2>, uvMin: ExtDynamic<ImVec2>, uvMax: ExtDynamic<ImVec2>, col: ImU32, rounding: Single, roundingCorners: ImDrawFlags ) {}
}
