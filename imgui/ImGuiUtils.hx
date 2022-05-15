package imgui;

import imgui.ImGui;

/**
	Helper with pre-allocated generic ImGui types to reduce allocation count.
	
	Those are expected to be fire-and-forget type and should be available for reuse right after a function call.
**/
class ImTypeCache {
	// TODO: Make it a pool with newFrame() resets.
	
	static inline var MAX_SLOTS = 10;
	static var vec2Slot: Int = 0;
	static var vec4Slot: Int = 0;
	
	/**
		Retreive a preallocated ImVec2 and set its values to `x` and `y`.
	**/
	public static inline function vec2(x: Single, y: Single): ImVec2 {
		var v = imVec2[vec2Slot++];
		if (vec2Slot == MAX_SLOTS) vec2Slot = 0;
		return v.set(x, y);
	}
	
	/**
		Retreive a preallocated ImVec4 and set its values to `x`, `y`, `z` and `w`.
	**/
	public static inline function vec4(x: Single, y: Single, z: Single, w: Single): ImVec4 {
		var v = imVec4[vec4Slot++];
		if (vec4Slot == MAX_SLOTS) vec4Slot = 0;
		return v.set(x, y, z, w);
	}
	
	/**
		Retreive a preallocated ImVec4 and set its values RGBA value of `col`.
	**/
	public static inline function vec4c(col: Int): ImVec4 {
		var v = imVec4[vec4Slot++];
		if (vec4Slot == MAX_SLOTS) vec4Slot = 0;
		return v.setColor(col);
	}
	
	/**
		Retreive a preallocated ImVec4 and set its values RGB value of `col` and and A of `alpha`.
	**/
	public static inline function vec4ca(col: Int, alpha: Float = 1.0): ImVec4 {
		var v = imVec4[vec4Slot++];
		if (vec4Slot == MAX_SLOTS) vec4Slot = 0;
		return v.setColorRGB(col, alpha);
	}

	public static var imVec2: Array<ImVec2> = [for (i in 0...MAX_SLOTS) ({ x: 0, y: 0 })];
	
	public static var imVec4: Array<ImVec4> = [for (i in 0...MAX_SLOTS) ({ x: 0, y: 0, z: 0, w: 0 })];

	// Temporary storage for methods that take NativeArray of small size
	
	public static extern inline overload function array(val: Int) { var tmp = arrInt1; tmp[0] = val; return tmp; }
	public static extern inline overload function array(val: Single) { var tmp = arrSingle1; tmp[0] = val; return tmp; }
	public static extern inline overload function array(val: Float) { var tmp = arrFloat1; tmp[0] = val; return tmp; }
	public static extern inline overload function array(val1: Int, val2: Int) { var tmp = arrInt2; tmp[0] = val1; tmp[1] = val2; return tmp; }
	public static extern inline overload function array(val1: Single, val2: Single) { var tmp = arrSingle2; tmp[0] = val1; tmp[1] = val2; return tmp; }
	public static extern inline overload function array(val1: Float, val2: Float) { var tmp = arrFloat2; tmp[0] = val1; tmp[1] = val2; return tmp; }
	public static extern inline overload function array(val1: Int, val2: Int, val3: Int) { var tmp = arrInt3; tmp[0] = val1; tmp[1] = val2; tmp[2] = val3; return tmp; }
	public static extern inline overload function array(val1: Single, val2: Single, val3: Single) { var tmp = arrSingle3; tmp[0] = val1; tmp[1] = val2; tmp[2] = val3; return tmp; }
	public static extern inline overload function array(val1: Float, val2: Float, val3: Float) { var tmp = arrFloat3; tmp[0] = val1; tmp[1] = val2; tmp[2] = val3; return tmp; }
	public static extern inline overload function array(val1: Int, val2: Int, val3: Int, val4: Int) { var tmp = arrInt4; tmp[0] = val1; tmp[1] = val2; tmp[2] = val3; tmp[3] = val4; return tmp; }
	public static extern inline overload function array(val1: Single, val2: Single, val3: Single, val4: Single) { var tmp = arrSingle4; tmp[0] = val1; tmp[1] = val2; tmp[2] = val3; tmp[3] = val4; return tmp; }
	public static extern inline overload function array(val1: Float, val2: Float, val3: Float, val4: Float) { var tmp = arrFloat4; tmp[0] = val1; tmp[1] = val2; tmp[2] = val3; tmp[3] = val4; return tmp; }
	
	static var arrSingle1 = new hl.NativeArray<Single>(1);
	static var arrSingle2 = new hl.NativeArray<Single>(2);
	static var arrSingle3 = new hl.NativeArray<Single>(3);
	static var arrSingle4 = new hl.NativeArray<Single>(4);
	
	static var arrFloat1 = new hl.NativeArray<Float>(1);
	static var arrFloat2 = new hl.NativeArray<Float>(2);
	static var arrFloat3 = new hl.NativeArray<Float>(3);
	static var arrFloat4 = new hl.NativeArray<Float>(4);
	
	static var arrInt1 = new hl.NativeArray<Int>(1);
	static var arrInt2 = new hl.NativeArray<Int>(2);
	static var arrInt3 = new hl.NativeArray<Int>(3);
	static var arrInt4 = new hl.NativeArray<Int>(4);

}
