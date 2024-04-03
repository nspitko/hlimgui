#include "utils.h"
#include "imgui_internal.h"

//#define _TVIEWPORT _ABSTRACT(imguiviewport)

struct HLImGuiPlatformClosures
{
    vclosure *Platform_CreateWindow;
    vclosure *Platform_DestroyWindow;
    vclosure *Platform_ShowWindow;
    vclosure *Platform_SetWindowPos;
    vclosure *Platform_GetWindowPos;
    vclosure *Platform_SetWindowSize;
    vclosure *Platform_GetWindowSize;
	vclosure *Platform_SetWindowFocus;
	vclosure *Platform_GetWindowFocus;
	vclosure *Platform_GetWindowMinimized;
	vclosure *Platform_SetWindowTitle;
	vclosure *Platform_SetWindowAlpha;
	vclosure *Renderer_RenderWindow;
	vclosure *Renderer_SwapBuffers;
};

HLImGuiPlatformClosures HlClosures;
extern ImGuiContext*   GImGui;

void HlPlatform_CreateWindow(ImGuiViewport* vp) {
	hl_call1( void, HlClosures.Platform_CreateWindow, ImGuiViewport*, vp );
	hl_add_root( &vp->PlatformHandle );
	hl_add_root( &vp->PlatformHandleRaw );
}
void HlPlatform_DestroyWindow(ImGuiViewport* vp) {
	hl_call1( void, HlClosures.Platform_DestroyWindow, ImGuiViewport*, vp );
	hl_remove_root( &vp->PlatformHandle );
	hl_remove_root( &vp->PlatformHandleRaw );
}
void HlPlatform_ShowWindow(ImGuiViewport* vp) { hl_call1( void, HlClosures.Platform_ShowWindow, ImGuiViewport*, vp ); }
void HlPlatform_SetWindowPos(ImGuiViewport* vp, ImVec2 pos) {
	hl_call2( void, HlClosures.Platform_SetWindowPos, ImGuiViewport*, vp, vimvec2 *, (vimvec2 *)pos );

}
ImVec2 HlPlatform_GetWindowPos(ImGuiViewport* vp) {
	ImVec2 pos;
	hl_call2( void, HlClosures.Platform_GetWindowPos, ImGuiViewport*, vp, ImVec2 *, &pos );
	return pos;
}
void HlPlatform_SetWindowSize(ImGuiViewport* vp, ImVec2 size) {
	hl_call2( void, HlClosures.Platform_SetWindowSize, ImGuiViewport*, vp, vimvec2 *, (vimvec2 *)size );
}
ImVec2 HlPlatform_GetWindowSize(ImGuiViewport* vp) {
	ImVec2 size;
	// @todo: returning through hl_call doesn't appear to work?
	hl_call2(void, HlClosures.Platform_GetWindowSize, ImGuiViewport*, vp, ImVec2 *, &size );
	return size;
}
void HlPlatform_SetWindowFocus(ImGuiViewport* vp) { hl_call1( void, HlClosures.Platform_SetWindowFocus, ImGuiViewport*, vp); }
bool HlPlatform_GetWindowFocus(ImGuiViewport* vp) { return hl_call1( bool, HlClosures.Platform_GetWindowFocus, ImGuiViewport*, vp); }
bool HlPlatform_GetWindowMinimized(ImGuiViewport* vp) { return hl_call1( bool, HlClosures.Platform_GetWindowMinimized, ImGuiViewport*, vp); }
void HlPlatform_SetWindowTitle(ImGuiViewport* vp, const char* title) { hl_call2( bool, HlClosures.Platform_SetWindowTitle, ImGuiViewport*, vp, vbyte*, getVByteFromCStr( title ) ); }
void HlPlatform_SetWindowAlpha(ImGuiViewport* vp, float alpha) { hl_call2( bool, HlClosures.Platform_SetWindowAlpha, ImGuiViewport*, vp, float, alpha); }
void HlRenderer_RenderWindow(ImGuiViewport* vp, void* render_arg) {
	renderDrawLists( vp->DrawData );
	hl_call2( bool, HlClosures.Renderer_RenderWindow, ImGuiViewport*, vp, void*, render_arg);
}
void HlRenderer_SwapBuffers(ImGuiViewport* vp, void* render_arg) { hl_call2( bool, HlClosures.Renderer_SwapBuffers, ImGuiViewport*, vp, void*, render_arg); }

HL_PRIM void HL_NAME(viewport_set_platform_create_window)(vclosure *p)
{
	ImGuiContext& g = *GImGui;
	// Uncomment for debugging.
	//g.DebugLogFlags |= ImGuiDebugLogFlags_EventViewport;
	ImGuiPlatformIO &pio = ImGui::GetPlatformIO();
    HlClosures.Platform_CreateWindow = p;
	pio.Platform_CreateWindow = HlPlatform_CreateWindow;
	hl_add_root( &HlClosures.Platform_CreateWindow );
}

HL_PRIM void HL_NAME(viewport_set_platform_destroy_window)(vclosure *p)
{
	ImGuiPlatformIO &pio = ImGui::GetPlatformIO();
    HlClosures.Platform_DestroyWindow = p;
	pio.Platform_DestroyWindow = HlPlatform_DestroyWindow;
	hl_add_root( &HlClosures.Platform_DestroyWindow );
}

HL_PRIM void HL_NAME(viewport_set_platform_show_window)(vclosure *p)
{
	ImGuiPlatformIO &pio = ImGui::GetPlatformIO();
    HlClosures.Platform_ShowWindow = p;
	pio.Platform_ShowWindow = HlPlatform_ShowWindow;
	hl_add_root( &HlClosures.Platform_ShowWindow );
}

HL_PRIM void HL_NAME(viewport_set_platform_set_window_pos)(vclosure *p)
{
	ImGuiPlatformIO &pio = ImGui::GetPlatformIO();
    HlClosures.Platform_SetWindowPos = p;
	pio.Platform_SetWindowPos = HlPlatform_SetWindowPos;
	hl_add_root( &HlClosures.Platform_SetWindowPos );
}

HL_PRIM void HL_NAME(viewport_set_platform_get_window_pos)(vclosure *p)
{
	ImGuiPlatformIO &pio = ImGui::GetPlatformIO();
    HlClosures.Platform_GetWindowPos = p;
	pio.Platform_GetWindowPos = HlPlatform_GetWindowPos;
	hl_add_root( &HlClosures.Platform_GetWindowPos );
}

HL_PRIM void HL_NAME(viewport_set_platform_set_window_size)(vclosure *p)
{
	ImGuiPlatformIO &pio = ImGui::GetPlatformIO();
    HlClosures.Platform_SetWindowSize = p;
	pio.Platform_SetWindowSize = HlPlatform_SetWindowSize;
	hl_add_root( &HlClosures.Platform_SetWindowSize );
}

HL_PRIM void HL_NAME(viewport_set_platform_get_window_size)(vclosure *p)
{
	ImGuiPlatformIO &pio = ImGui::GetPlatformIO();
    HlClosures.Platform_GetWindowSize = p;
	pio.Platform_GetWindowSize = HlPlatform_GetWindowSize;
	hl_add_root( &HlClosures.Platform_GetWindowSize );
}

HL_PRIM void HL_NAME(viewport_set_platform_set_window_focus)(vclosure *p)
{
	ImGuiPlatformIO &pio = ImGui::GetPlatformIO();
    HlClosures.Platform_SetWindowFocus = p;
	pio.Platform_SetWindowFocus = HlPlatform_SetWindowFocus;
	hl_add_root( &HlClosures.Platform_SetWindowFocus );
}

HL_PRIM void HL_NAME(viewport_set_platform_get_window_focus)(vclosure *p)
{
	ImGuiPlatformIO &pio = ImGui::GetPlatformIO();
    HlClosures.Platform_GetWindowFocus = p;
	pio.Platform_GetWindowFocus = HlPlatform_GetWindowFocus;
	hl_add_root( &HlClosures.Platform_GetWindowFocus );
}

HL_PRIM void HL_NAME(viewport_set_platform_get_window_minimized)(vclosure *p)
{
	ImGuiPlatformIO &pio = ImGui::GetPlatformIO();
    HlClosures.Platform_GetWindowMinimized = p;
	pio.Platform_GetWindowMinimized = HlPlatform_GetWindowMinimized;
	hl_add_root( &HlClosures.Platform_GetWindowMinimized );
}

HL_PRIM void HL_NAME(viewport_set_platform_set_window_title)(vclosure *p)
{
	ImGuiPlatformIO &pio = ImGui::GetPlatformIO();
    HlClosures.Platform_SetWindowTitle = p;
	pio.Platform_SetWindowTitle = HlPlatform_SetWindowTitle;
	hl_add_root( &HlClosures.Platform_SetWindowTitle );
}

HL_PRIM void HL_NAME(viewport_set_platform_set_window_alpha)(vclosure *p)
{
	ImGuiPlatformIO &pio = ImGui::GetPlatformIO();
    HlClosures.Platform_SetWindowAlpha = p;
	pio.Platform_SetWindowAlpha = HlPlatform_SetWindowAlpha;
	hl_add_root( &HlClosures.Platform_SetWindowAlpha );
}

HL_PRIM void HL_NAME(viewport_set_renderer_render_window)(vclosure *p)
{
	ImGuiPlatformIO &pio = ImGui::GetPlatformIO();
    HlClosures.Renderer_RenderWindow = p;
	pio.Renderer_RenderWindow = HlRenderer_RenderWindow;
	hl_add_root( &HlClosures.Renderer_RenderWindow );
}

HL_PRIM void HL_NAME(viewport_set_renderer_swap_buffers)(vclosure *p)
{
	ImGuiPlatformIO &pio = ImGui::GetPlatformIO();
    HlClosures.Renderer_SwapBuffers = p;
	pio.Renderer_SwapBuffers = HlRenderer_SwapBuffers;
	hl_add_root( &HlClosures.Renderer_SwapBuffers );
}

// Actual viewport functions

HL_PRIM void HL_NAME(update_platform_windows)()
{
	ImGui::UpdatePlatformWindows();
}

HL_PRIM void HL_NAME(render_platform_windows_default)(void* platform_render_arg, void* renderer_render_arg)
{
	ImGui::RenderPlatformWindowsDefault(platform_render_arg, renderer_render_arg);
}

HL_PRIM void HL_NAME(viewport_add_monitor)( vimvec2 *size, vimvec2 *pos )
{
	ImGuiPlatformIO &pio = ImGui::GetPlatformIO();
	ImGuiPlatformMonitor m;
	m.DpiScale = 1.f;
	m.MainSize.x = size->x;
	m.MainSize.y = size->y;
	m.MainPos.x = pos->x;
	m.MainPos.y = pos->y;

	m.WorkSize = m.MainSize;
	m.WorkPos = m.MainPos;


	pio.Monitors.push_back( m );
}

HL_PRIM ImGuiViewport* HL_NAME(viewport_set_main_viewport)( vdynamic* HWND )
{
	ImGuiPlatformIO &pio = ImGui::GetPlatformIO();
	pio.Viewports[0]->PlatformHandle = HWND;
	return pio.Viewports[0];
}

DEFINE_PRIM(_VOID, viewport_set_platform_create_window, _FUN(_VOID, _STRUCT) );
DEFINE_PRIM(_VOID, viewport_set_platform_destroy_window, _FUN(_VOID, _STRUCT) );
DEFINE_PRIM(_VOID, viewport_set_platform_show_window, _FUN(_VOID, _STRUCT) );
DEFINE_PRIM(_VOID, viewport_set_platform_set_window_pos, _FUN(_VOID, _STRUCT _IMVEC2) );
DEFINE_PRIM(_VOID, viewport_set_platform_get_window_pos, _FUN(_VOID, _STRUCT _STRUCT) );
DEFINE_PRIM(_VOID, viewport_set_platform_set_window_size, _FUN(_VOID, _STRUCT _IMVEC2) );
DEFINE_PRIM(_VOID, viewport_set_platform_get_window_size, _FUN(_VOID, _STRUCT _STRUCT ) );
DEFINE_PRIM(_VOID, viewport_set_platform_set_window_focus, _FUN(_VOID, _STRUCT) );
DEFINE_PRIM(_VOID, viewport_set_platform_get_window_focus, _FUN(_BOOL, _STRUCT) );
DEFINE_PRIM(_VOID, viewport_set_platform_get_window_minimized, _FUN(_BOOL, _STRUCT) );
DEFINE_PRIM(_VOID, viewport_set_platform_set_window_title, _FUN(_VOID, _STRUCT _BYTES) );
DEFINE_PRIM(_VOID, viewport_set_platform_set_window_alpha, _FUN(_VOID, _STRUCT _F32) );
DEFINE_PRIM(_VOID, viewport_set_renderer_render_window, _FUN(_VOID, _STRUCT _DYN) );
DEFINE_PRIM(_VOID, viewport_set_renderer_swap_buffers, _FUN(_VOID, _STRUCT _DYN) );

DEFINE_PRIM(_VOID, viewport_add_monitor, _IMVEC2 _IMVEC2 );
DEFINE_PRIM(_STRUCT, viewport_set_main_viewport, _DYN );
///

DEFINE_PRIM(_VOID, update_platform_windows, _NO_ARG );
DEFINE_PRIM(_VOID, render_platform_windows_default, _DYN _DYN );

