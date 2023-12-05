#include "../../utils.h"
#include "../../lib/neo_sequencer/imgui_neo_sequencer.h"

// Cursed code to call C-side constructor to a style we allocated in HL
HL_PRIM void HL_NAME(ns_init_style)(ImGuiNeoSequencerStyle* hlStyle)
{
	if (hlStyle != nullptr)
	{
		new (hlStyle)ImGuiNeoSequencerStyle();
	}
}

HL_PRIM ImGuiNeoSequencerStyle* HL_NAME(ns_get_style)()
{
	return &ImGui::GetNeoSequencerStyle();
}
/*
HL_PRIM void HL_NAME(ns_set_style)( ImGuiNeoSequencerStyle *hlStyle )
{
	if (hlStyle != nullptr)
	{
		ImGui::GetNeoSequencerStyle() = *hlStyle;
	}
}
*/

HL_PRIM bool HL_NAME(ns_begin)( vstring* id, uint32_t* frame, uint32_t* startFrame, uint32_t* endFrame,  vimvec2* size, ImGuiNeoSequencerFlags* flags )
{
	return ImGui::BeginNeoSequencer( convertString(id), frame, startFrame, endFrame, getImVec2(size), convertPtr(flags, ImGuiNeoSequencerFlags_None) );
}

HL_PRIM void HL_NAME(ns_end)( )
{
	ImGui::EndNeoSequencer();
}

HL_PRIM bool HL_NAME(ns_begin_group)( vstring* label, bool* open )
{
	return ImGui::BeginNeoGroup( convertString(label), open );
}

HL_PRIM void HL_NAME(ns_end_group)( )
{
	ImGui::EndNeoGroup();
}
/*
HL_PRIM bool HL_NAME(ns_begin_timeline)( vstring* label, varray *keyframes, uint32_t keyframeCount, bool* open, ImGuiNeoTimelineFlags* flags )
{
	return ImGui::BeginNeoTimeline( convertString(label), (int32_t**)hl_aptr(keyframes,int32_t), keyframeCount, open, convertPtr(flags,ImGuiNeoTimelineFlags_None) );
}
*/

HL_PRIM bool HL_NAME(ns_begin_timeline)( vstring* label, bool* open, ImGuiNeoTimelineFlags* flags )
{
	return ImGui::BeginNeoTimelineEx( convertString(label), open, convertPtr(flags,ImGuiNeoTimelineFlags_None) );
}

HL_PRIM void HL_NAME(ns_end_timeline)( )
{
	ImGui::EndNeoTimeLine();
}

HL_PRIM void HL_NAME(ns_keyframe)( int32_t* value )
{
	ImGui::NeoKeyframe( value );
}

HL_PRIM bool HL_NAME(ns_is_keyframe_hovered)()
{
	return ImGui::IsNeoKeyframeHovered();
}

HL_PRIM bool HL_NAME(ns_is_keyframe_selected)()
{
	return ImGui::IsNeoKeyframeSelected();
}

HL_PRIM bool HL_NAME(ns_is_keyframe_right_clicked)()
{
	return ImGui::IsNeoKeyframeRightClicked();
}

HL_PRIM void HL_NAME(ns_clear_selection)()
{
	ImGui::NeoClearSelection();
}

HL_PRIM bool HL_NAME(ns_is_selecting)()
{
	return ImGui::NeoIsSelecting();
}

HL_PRIM bool HL_NAME(ns_has_selection)()
{
	return ImGui::NeoHasSelection();
}

HL_PRIM bool HL_NAME(ns_is_dragging_selection)()
{
	return ImGui::NeoIsDraggingSelection();
}

HL_PRIM bool HL_NAME(ns_can_delete_selection)()
{
	return ImGui::NeoCanDeleteSelection();
}

HL_PRIM bool HL_NAME(ns_is_keyframe_selection_right_clicked)()
{
	return ImGui::IsNeoKeyframeSelectionRightClicked();
}

HL_PRIM uint32_t HL_NAME(ns_get_keyframe_selection_size)()
{
	return ImGui::GetNeoKeyframeSelectionSize();
}

HL_PRIM varray* HL_NAME(ns_get_keyframe_selection)( )
{
	uint32_t size = ImGui::GetNeoKeyframeSelectionSize();

	varray* array = hl_alloc_array(&hlt_i32, size);

	int32_t* ptr = hl_aptr(array, int32_t);

	ImGui::GetNeoKeyframeSelection( ptr );

	return array;
}

HL_PRIM void HL_NAME(ns_set_selected_timeline)( vstring* timelineLabel )
{
	ImGui::SetSelectedTimeline( convertString( timelineLabel ) );
}

HL_PRIM bool HL_NAME(ns_is_timeline_selected)(ImGuiNeoTimelineIsSelectedFlags* flags)
{
	return ImGui::IsNeoTimelineSelected( convertPtr( flags, ImGuiNeoTimelineIsSelectedFlags_None ) );
}

/*
This function is just hardcoded to return false in the current API. ¯\_(ツ)_/¯
HL_PRIM bool HL_NAME(ns_begin_create_keyframe)(int32_t* frame)
{
	return ImGui::NeoBeginCreateKeyframe( frame );
}
*/

DEFINE_PRIM(_STRUCT, ns_get_style, _NO_ARG );
DEFINE_PRIM(_VOID, ns_init_style, _STRUCT );

DEFINE_PRIM(_BOOL, ns_begin, _STRING _REF(_I32) _REF(_I32) _REF(_I32) _IMVEC2 _REF(_I32) );
DEFINE_PRIM(_VOID, ns_end, _NO_ARG );
DEFINE_PRIM(_BOOL, ns_begin_group, _STRING _REF(_BOOL) );
DEFINE_PRIM(_VOID, ns_end_group, _NO_ARG );
DEFINE_PRIM(_BOOL, ns_begin_timeline, _STRING _REF(_BOOL) _REF(_I32) );
DEFINE_PRIM(_VOID, ns_end_timeline, _NO_ARG );
DEFINE_PRIM(_VOID, ns_keyframe, _REF(_I32) );
DEFINE_PRIM(_BOOL, ns_is_keyframe_hovered, _NO_ARG );
DEFINE_PRIM(_BOOL, ns_is_keyframe_selected, _NO_ARG );
DEFINE_PRIM(_BOOL, ns_is_keyframe_right_clicked, _NO_ARG );
DEFINE_PRIM(_VOID, ns_clear_selection, _NO_ARG );
DEFINE_PRIM(_BOOL, ns_is_selecting, _NO_ARG );
DEFINE_PRIM(_BOOL, ns_has_selection, _NO_ARG );
DEFINE_PRIM(_BOOL, ns_is_dragging_selection, _NO_ARG );
DEFINE_PRIM(_BOOL, ns_can_delete_selection, _NO_ARG );
DEFINE_PRIM(_BOOL, ns_is_keyframe_selection_right_clicked, _NO_ARG );
DEFINE_PRIM( _I32, ns_get_keyframe_selection_size, _NO_ARG );
DEFINE_PRIM( _ARR, ns_get_keyframe_selection, _NO_ARG );
DEFINE_PRIM(_VOID, ns_set_selected_timeline, _STRING );
DEFINE_PRIM(_BOOL, ns_is_timeline_selected, _REF(_I32) );
//DEFINE_PRIM(_BOOL, ns_begin_create_keyframe, _REF(_I32) );