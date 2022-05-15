package imgui.types;

import imgui.types.Renderer;
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

	public function pushClipRect(clipRectMin: ImVec2, clipRectMax: ImVec2, intersectWithCurrentClipRect: Bool = false) {}
	public function pushClipRectFullScreen() {}
	public function popClipRect() {}
	public function pushTextureId(textureId: ImTextureID) {}
	public function popTextureId() {}
	public function getClipRectMin(): ImVec2 { return null; }
	public function getClipRectMax(): ImVec2 { return null; }

	public function addLine( p1: ImVec2, p2: ImVec2, col: ImU32, thickness: Single = 1.0 ) {}
	public function addRect( pMin: ImVec2, pMax: ImVec2, col: ImU32, rounding: Single = 0.0, roundingCorners: ImDrawFlags = ImDrawFlags.None, thickness: Single = 1.0 ) {}
	public function addRectFilled( pMin: ImVec2, pMax: ImVec2, col: ImU32, rounding: Single = 0.0, roundingCorners: ImDrawFlags = ImDrawFlags.None ) {}
	public function addRectFilledMultiColor( pMin: ImVec2, pMax: ImVec2, col_upr_left: ImU32, col_upr_right: ImU32, col_bot_right: ImU32, col_bot_left: ImU32 ) {}
	public function addQuad( p1: ImVec2, p2: ImVec2, p3: ImVec2, p4: ImVec2, col: ImU32, thickness: Single = 1.0 ) {}
	public function addQuadFilled( p1: ImVec2, p2: ImVec2, p3: ImVec2, p4: ImVec2, col: ImU32 ) {}
	public function addTriangle( p1: ImVec2, p2: ImVec2, p3: ImVec2, col: ImU32, thickness: Single = 1.0 ) {}
	public function addTriangleFilled( p1: ImVec2, p2: ImVec2, p3: ImVec2, col: ImU32 ) {}
	public function addCircle( center: ImVec2, radius: Single, col: ImU32, num_segments: Int = 0, thickness: Single = 1.0 ) {}
	public function addCircleFilled( center: ImVec2, radius: Single, col: ImU32, num_segments: Int = 0) {}
	public function addNgon( center: ImVec2, radius: Single, col: ImU32, num_segments: Int, thickness: Single = 1.0 ) {}
	public function addNgonFilled( center: ImVec2, radius: Single, col: ImU32, num_segments: Int) {}
	public function addPolyLine( points: hl.NativeArray<ImVec2>, col: ImU32, closed: Bool, thickness: Single = 1.0 ) {}
	public function addConvexPolyFilled( points: hl.NativeArray<ImVec2>, col: ImU32 ) {}
	
	public function addBezierCubic( p1: ImVec2, p2: ImVec2, p3: ImVec2, p4: ImVec2, col: ImU32, thickness: Single, num_segments: Int = 0 ) {}
	public function addBezierQuadratic( p1: ImVec2, p2: ImVec2, p3: ImVec2, col: ImU32, thickness: Single, num_segments: Int = 0 ) {}
	
	public function addText( pos: ImVec2, col: ImU32, text: String ) {}
	public function addText2( font: ImFont, fontSize: Single, pos: ImVec2, col: ImU32, text: String, wrapWidth: Single = 0.0, ?cpuFineClipRect: ImVec4 ) {}

	public function addImage( userTextureId: ImTextureID, pMin: ImVec2, pMax: ImVec2, ?uvMin: ImVec2, ?uvMax: ImVec2, col: Int = 0xffffffff ) {}
	public function addImageQuad( userTextureId: ImTextureID, p1: ImVec2, p2: ImVec2, p3: ImVec2, p4: ImVec2, ?uv1: ImVec2, ?uv2: ImVec2, ?uv3: ImVec2, ?uv4: ImVec2, col: Int = 0xffffffff ) {}
	public function addImageRounded( userTextureId: ImTextureID, pMin: ImVec2, pMax: ImVec2, uvMin: ImVec2, uvMax: ImVec2, col: Int, rounding: Single, roundingCorners: ImDrawFlags = RoundCornersDefault_ ) {}

	@:deprecated("Use addBezuerrCubic")
	public inline function addBezierCurve( p1: ImVec2, p2: ImVec2, p3: ImVec2, p4: ImVec2, col: ImU32, thickness: Single = 1.0, num_segments: Int = 0 ) { addBezierCubic(p1, p2, p3, p4, col, thickness, num_segments ); }
	
	// Stateful path API, add points then finish with pathFillConvex() or pathStroke()

	public function pathClear() {}
	public function pathLineTo(pos: ImVec2) {}
	public function pathLineToMergeDuplicate(pos: ImVec2) {}
	public function pathFillConvex(col: Int) {}
	public function pathStroke(col: Int, flags: ImDrawFlags = 0, thickness: Single = 1.0) {}
	public function pathArcTo(center: ImVec2, radius: Single, a_min: Single, a_max: Single, num_segments: Int = 0) {}
	/* Use precomputed angles for a 12 steps circle */
	public function pathArcToFast(center: ImVec2, radius: Single, a_min_of_12: Int, a_max_of_12: Int) {}
	public function pathBezierCubicCurveTo(p2: ImVec2, p3: ImVec2, p4: ImVec2, num_segments: Int = 0) {}
	public function pathBezierQuadraticCurveTo(p2: ImVec2, p3: ImVec2, num_segments: Int = 0) {}
	public function pathRect(rect_min: ImVec2, rect_max: ImVec2, rounding: Single = 0.0, flags: ImDrawFlags = 0) {}
	
	// Advanced
	
	public function addCallback(callback: RenderCommandCallback, ?data: Dynamic) {}
	public function addDrawCmd() {}
	// public function cloneOutput(): ImDrawList; // TODO
	
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
}

@:struct private class ImDrawListSplitterStruct {
	
	@:noCompletion var finalizer: HLFinalizer; // [HL] GC finalizer
	var _current: Int;                         // Current channel number (0)
	var _count: Int;                           // Number of active channels (1+)
	var _channels: ImVector;                   // Draw channels (not resized down so _Count might be < Channels.Size)
	
}

@:hlNative("hlimgui", "drawlistsplitter_") @:forward
abstract ImDrawListSplitter(ImDrawListSplitterStruct) from ImDrawListSplitterStruct to ImDrawListSplitterStruct {
	
	static function init(): ImDrawListSplitterStruct {return null;}

	public inline function new() this = init();

	public function clear() {}
	public function clearFreeMemory() {}
	public function split(drawList: ImDrawList, count: Int) {}
	public function merge(drawList: ImDrawList) {}
	public function setCurrentChannel(drawList: ImDrawList, channelIdx: Int) {}
}