package imgui.types;

@:keep @:struct class ImGuiListClipperStruct
{
	@:noCompletion var finalizer: hl.Bytes; // [HL] GC callback for calling finalizer on the struct when it's freed.
	public var displayStart: Int;           // First item to display, updated by each call to Step()
	public var displayEnd: Int;             // End of items to display (exclusive)
	var itemsCount: Int;                    // [Internal] Number of items
	var itemsHeight: Single;                // [Internal] Height of item after a first step and item submission can calculate it
	var startPosY: Single;                  // [Internal] Cursor position at the time of Begin() or after table frozen rows are all processed
	var tempData: hl.Bytes;                 // [Internal] Internal data
}

/**
	Helper: Manually clip large list of items.
	If you have lots evenly spaced items and you have a random access to the list, you can perform coarse
	clipping based on visibility to only submit items that are in view.
	The clipper calculates the range of visible items and advance the cursor to compensate for the non-visible items we have skipped.
	(Dear ImGui already clip items based on their bounds but: it needs to first layout the item to do so, and generally
	 fetching/submitting your own data incurs additional cost. Coarse clipping using ImGuiListClipper allows you to easily
	 scale using lists with tens of thousands of items without a problem)
	Usage:
	```haxe
	var clipper = new ImGuiListClipper();
	clipper.begin(1000); // We have 1000 elements, evenly spaced.
	while (clipper.step())
		for (i in clipper.displayStart...clipper.displayEnd)
			ImGui.text("Line number " + i);
	```
	Generally what happens is:
	- Clipper lets you process the first element (DisplayStart = 0, DisplayEnd = 1) regardless of it being visible or not.
	- User code submit that one element.
	- Clipper can measure the height of the first element
	- Clipper calculate the actual range of elements to display based on the current clipping rectangle, position the cursor before the first visible element.
	- User code submit visible elements.
	- The clipper also handles various subtleties related to keyboard/gamepad navigation, wrapping etc.
**/
@:forward
@:hlNative("hlimgui", "imlistclipper_")
abstract ImGuiListClipper(ImGuiListClipperStruct) from ImGuiListClipperStruct to ImGuiListClipperStruct
{
	static function init(): ImGuiListClipperStruct { return null; }
	
	public inline function new() this = @:privateAccess init();
	
	/**
		@param itemCount: Use INT_MAX if you don't know how many items you have (in which case the cursor won't be advanced in the final step)
		@param itemsHeight: Use -1.0f to be calculated automatically on first step.
		Otherwise pass in the distance between your items, typically GetTextLineHeightWithSpacing() or GetFrameHeightWithSpacing().
	**/
	public inline extern function begin(itemCount: Int, itemsHeight: Single = -1.0) _begin(itemCount, itemsHeight);
	@:hlNative("hlimgui", "imlistclipper_begin") function _begin(itemCount: Int, itemsHeight: Single) {}
	
	/** Automatically called on the last call of Step() that returns false. **/
	public function end() {}
	
	/** Call until it returns false. The `displayStart`/`displayEnd` fields will be set and you can process/draw those items. **/
	public function step(): Bool { return false; }
	
	/**
		Call ForceDisplayRangeByIndices() before first call to Step() if you need a range of items to be displayed regardless of visibility.
		itemMax is exclusive e.g. use (42, 42+1) to make item 42 always visible BUT due to alignment/padding of certain items it is likely that an extra item may be included on either end of the display range.
	**/
	public function forceDisplayRangeByIndices(itemMin: Int, itemMax: Int) {}
}