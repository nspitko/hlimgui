#include "utils.h"

// Fix for casting void* -> vdynamic*
#define hl_call1fixed(ret,cl,t,v)\
	(cl->hasValue ? ((ret(*)(vdynamic*,t))cl->fun)((vdynamic*)cl->value,v) : ((ret(*)(t))cl->fun)(v))

typedef struct
{
	float x;
	float y;
	float u;
	float v;
	float r;
	float g;
	float b;
	float a;
} HeapVertex;

static vclosure* s_render_function = nullptr;
hl_type* hlt_imvec2;
hl_type* hlt_imvec4;
hl_type* hlt_rendercommand;
hl_type* hlt_renderdata;

typedef struct
{
	hl_type* t;
	vdynamic* texture_id;
	int index_offset;
	int elem_count;
	
	int clip_left;
	int clip_top;
	int clip_width;
	int clip_height;
	
	vclosure* callback;
	vdynamic* callback_data;
} vrendercommand;

typedef struct
{
	hl_type* t;
	HeapVertex* vertex_buffer;
	int vertex_buffer_size;
	vbyte* index_buffer;
	int index_buffer_size;
	varray* commands;
	int command_count;
} vrenderdata;

typedef struct
{
	hl_type* t;
	varray* lists;
	int size;
} vrenderlist;

static vrenderlist* render_list = nullptr;

// TODO: Also let data be provided as is.

void renderDrawLists(ImDrawData* draw_data)
{
	if (s_render_function == nullptr || render_list == nullptr) return;

	// Reallocate varray in case there's more draw lists than before.

	if (render_list->lists->size < draw_data->CmdListsCount)
	{
		varray* old = render_list->lists;
		render_list->lists = hl_alloc_array(hlt_renderdata, draw_data->CmdListsCount);
		// Copy over previously allocated data
		int size = hl_type_size(hlt_renderdata);
		memmove( (vbyte*)hl_aptr(render_list->lists,vbyte), (vbyte*)hl_aptr(old,vbyte), old->size * size);
	}
	
	// Store the amount draw lists to render, as varray is grow type and can contain invalid data if amount of draw lists shrink.
	render_list->size = draw_data->CmdListsCount;
	vrenderdata** hl_cmd_list_ptr = hl_aptr(render_list->lists, vrenderdata*);
	
	for (int n = 0; n < draw_data->CmdListsCount; n++)
	{
		const ImDrawList* cmd_list = draw_data->CmdLists[n];
		
		// Allocate render data storage and command list if not allocated before.
		if (hl_cmd_list_ptr[n] == nullptr) {
			hl_cmd_list_ptr[n] = (vrenderdata*)hl_alloc_obj(hlt_renderdata);
			hl_cmd_list_ptr[n]->commands = hl_alloc_array(hlt_rendercommand, cmd_list->CmdBuffer.size());
		}
		vrenderdata* hl_cmd_list = hl_cmd_list_ptr[n];

		// Process vertex buffer
		// Bytes are grow-only type.
		int nb_vertex = cmd_list->VtxBuffer.size();
		int vertex_buffer_size = sizeof(HeapVertex) * nb_vertex;
		if (hl_cmd_list->vertex_buffer_size < vertex_buffer_size)
			hl_cmd_list->vertex_buffer = (HeapVertex*)hl_alloc_bytes(vertex_buffer_size);
		hl_cmd_list->vertex_buffer_size = vertex_buffer_size;
		HeapVertex* vertex_buffer = hl_cmd_list->vertex_buffer;

		for (int v = 0; v < nb_vertex; v++)
		{
			auto& hl_vertex = vertex_buffer[v];
			const auto& imgui_vertex = cmd_list->VtxBuffer[v];
			hl_vertex.x = imgui_vertex.pos.x - draw_data->DisplayPos.x;
			hl_vertex.y = imgui_vertex.pos.y - draw_data->DisplayPos.y;
			hl_vertex.u = imgui_vertex.uv.x;
			hl_vertex.v = imgui_vertex.uv.y;
			convertColor(imgui_vertex.col, hl_vertex.r, hl_vertex.g, hl_vertex.b, hl_vertex.a);
		}

		// Process index buffer (just copy over)
		// Bytes are grow-only type.
		int index_buffer_size = cmd_list->IdxBuffer.size_in_bytes();
		if (hl_cmd_list->index_buffer_size < index_buffer_size)
			hl_cmd_list->index_buffer = hl_copy_bytes((vbyte*)cmd_list->IdxBuffer.begin(), index_buffer_size);
		else
			memmove((vbyte*)hl_cmd_list->index_buffer, (vbyte*)cmd_list->IdxBuffer.begin(), index_buffer_size);
		hl_cmd_list->index_buffer_size = index_buffer_size;
		
		// create the array for command buffer
		int command_count = cmd_list->CmdBuffer.size();

		if (hl_cmd_list->commands->size < command_count)
		{
			varray* old = hl_cmd_list->commands;
			hl_cmd_list->commands = hl_alloc_array(hlt_rendercommand, command_count);
			// Copy over previously allocated data
			int size = hl_type_size(hlt_rendercommand);
			memmove( hl_aptr(hl_cmd_list->commands,vbyte), hl_aptr(old,vbyte), old->size * size);
		}
		hl_cmd_list->command_count = command_count;

		vrendercommand** hl_commands = hl_aptr(hl_cmd_list->commands, vrendercommand*);

		for (int cmd_i = 0; cmd_i < cmd_list->CmdBuffer.size(); cmd_i++)
		{
			const ImDrawCmd* pcmd = &cmd_list->CmdBuffer[cmd_i];
			
			vrendercommand* hl_cmd_buffer = hl_commands[cmd_i] == nullptr ? (hl_commands[cmd_i] = (vrendercommand*)hl_alloc_obj(hlt_rendercommand)) : hl_commands[cmd_i];
			
			hl_cmd_buffer->texture_id = (vdynamic*)pcmd->GetTexID();
			hl_cmd_buffer->index_offset = pcmd->IdxOffset;
			hl_cmd_buffer->elem_count = pcmd->ElemCount;
			
			hl_cmd_buffer->clip_left   = int(pcmd->ClipRect.x - draw_data->DisplayPos.x);
			hl_cmd_buffer->clip_top    = int(pcmd->ClipRect.y - draw_data->DisplayPos.y);
			hl_cmd_buffer->clip_width  = int(pcmd->ClipRect.z - pcmd->ClipRect.x);
			hl_cmd_buffer->clip_height = int(pcmd->ClipRect.w - pcmd->ClipRect.y);
			
			// TODO: Handle ResetRenderState?
			if (pcmd->UserCallback != nullptr && pcmd->UserCallback != ImDrawCallback_ResetRenderState)
			{
				hl_cmd_buffer->callback = pcmd->UserCallback;
				hl_cmd_buffer->callback_data = (vdynamic*)pcmd->UserCallbackData;
			}
			else
			{
				hl_cmd_buffer->callback = NULL;
				hl_cmd_buffer->callback_data = NULL;
			}
		}
		
	}
	
	hl_call1fixed(void,s_render_function,vrenderlist*,render_list);
}

HL_PRIM void HL_NAME(set_render_callback)(vclosure* render_fn)
{
	if (s_render_function != nullptr) hl_remove_root(&s_render_function);
	s_render_function = render_fn;
	if (render_fn != nullptr) hl_add_root(&s_render_function);
}

HL_PRIM void HL_NAME(add_key_char)(int c)
{
	ImGuiIO& io = ImGui::GetIO();
	io.AddInputCharacter(c);
}

HL_PRIM void HL_NAME(add_key_event)(int c, bool down)
{
	ImGuiIO& io = ImGui::GetIO();
	io.AddKeyEvent(c, down);
}

HL_PRIM void HL_NAME(set_events)(float dt, float mouse_x, float mouse_y, float wheel, bool left_click, bool right_click)
{
	ImGuiIO& io = ImGui::GetIO();
	io.MousePos = ImVec2(mouse_x,mouse_y);
	io.MouseWheel = wheel;
	io.MouseDown[0] = left_click;
	io.MouseDown[1] = right_click;
}

HL_PRIM void HL_NAME(set_display_size)(int display_width, int display_height)
{
	ImGuiIO& io = ImGui::GetIO();

	io.DisplaySize = ImVec2(float(display_width), float(display_height));
}

HL_PRIM void HL_NAME(new_frame)()
{
	ImGui::NewFrame();
}

HL_PRIM void HL_NAME(end_frame)()
{
	ImGui::EndFrame();
}

HL_PRIM void HL_NAME(render)()
{
	ImGui::Render();

	ImDrawData* draw_data = ImGui::GetDrawData();
	renderDrawLists(draw_data);
}

/**
	Hack: Because we want to allocate ImVec2/4 classes on HL side, we need to hijack the hl_type of those classes somehow.
	And there's no API to obtain said classes. So we steal them from live instances.
**/
HL_PRIM void HL_NAME(initialize)(vimvec2* hl_vec2, vimvec4* hl_vec4, vrenderlist* renderlist, vrenderdata* renderdata, vrendercommand* rendercommand) {
	hlt_imvec2 = hl_vec2->t;
	hlt_imvec4 = hl_vec4->t;
	render_list = renderlist;
	hl_add_root(&render_list);
	hlt_renderdata = renderdata->t;
	hlt_rendercommand = rendercommand->t;
}

DEFINE_PRIM(_VOID, initialize, _IMVEC2 _IMVEC4 _TRENDERLIST _TRENDERDATA _TRENDERCOMMAND);
DEFINE_PRIM(_VOID, set_render_callback, _FUN(_VOID, _TRENDERLIST));
DEFINE_PRIM(_VOID, add_key_char, _I32);
DEFINE_PRIM(_VOID, add_key_event, _I32 _BOOL);
DEFINE_PRIM(_VOID, set_events, _F32 _F32 _F32 _F32 _BOOL _BOOL);
DEFINE_PRIM(_VOID, set_display_size, _I32 _I32);

DEFINE_PRIM(_VOID, new_frame, _NO_ARG);
DEFINE_PRIM(_VOID, end_frame, _NO_ARG);
DEFINE_PRIM(_VOID, render, _NO_ARG);
