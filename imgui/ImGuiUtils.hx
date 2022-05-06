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
	public static inline function vec2(x: Single, y: Single) {
		var v = imVec2[vec2Slot++];
		if (vec2Slot == MAX_SLOTS) vec2Slot = 0;
		return v.set(x, y);
	}
	
	/**
		Retreive a preallocated ImVec4 and set its values to `x`, `y`, `z` and `w`.
	**/
	public static inline function vec4(x: Single, y: Single, z: Single, w: Single) {
		var v = imVec4[vec4Slot++];
		if (vec4Slot == MAX_SLOTS) vec4Slot = 0;
		return v.set(x, y, z, w);
	}

	public static var imVec2: Array<ImVec2S> = [for (i in 0...MAX_SLOTS) ({ x: 0, y: 0 })];
	
	public static var imVec4: Array<ImVec4S> = [for (i in 0...MAX_SLOTS) ({ x: 0, y: 0, z: 0, w: 0 })];

}
