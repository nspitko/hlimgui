#include "utils.h"

HL_PRIM ImGuiIO* HL_NAME(get_io)()
{
	return &ImGui::GetIO();
}

HL_PRIM void HL_NAME(io_add_key_event)(ImGuiIO* hl_io, ImGuiKey key, bool down )
{
	hl_io->AddKeyEvent(key, down);
}

HL_PRIM void HL_NAME(io_add_key_analog_event)(ImGuiIO* hl_io, ImGuiKey key, bool down, float v )
{
	hl_io->AddKeyAnalogEvent(key, down, v);
}

HL_PRIM void HL_NAME(io_add_mouse_pos_event)(ImGuiIO* hl_io, float x, float y )
{
	hl_io->AddMousePosEvent(x, y);
}

HL_PRIM void HL_NAME(io_add_mouse_button_event)(ImGuiIO* hl_io, int button, bool down )
{
	hl_io->AddMouseButtonEvent(button, down);
}

HL_PRIM void HL_NAME(io_add_mouse_wheel_event)(ImGuiIO* hl_io, float wheel_x, float wheel_y )
{
	hl_io->AddMouseWheelEvent(wheel_x, wheel_y);
}

HL_PRIM void HL_NAME(io_add_mouse_viewport_event)(ImGuiIO* hl_io, ImGuiID id )
{
	hl_io->AddMouseViewportEvent(id);
}

HL_PRIM void HL_NAME(io_add_focus_event)(ImGuiIO* hl_io, bool focused )
{
	hl_io->AddFocusEvent(focused);
}

HL_PRIM void HL_NAME(io_add_input_character)(ImGuiIO* hl_io, unsigned int c )
{
	hl_io->AddInputCharacter(c);
}

HL_PRIM void HL_NAME(io_add_input_character_utf16)(ImGuiIO* hl_io, int c )
{
    // Cast to suppress the warning
	hl_io->AddInputCharacterUTF16((ImWchar16)c);
}

HL_PRIM void HL_NAME(io_add_input_characters_utf8)(ImGuiIO* hl_io, vstring* chars )
{
	hl_io->AddInputCharactersUTF8( convertString(chars) );
}

HL_PRIM void HL_NAME(io_set_key_event_native_data)(ImGuiIO* hl_io, ImGuiKey key, int native_keycode, int native_scancode, int native_legacy )
{
	hl_io->SetKeyEventNativeData( key, native_keycode, native_scancode, native_legacy );
}

HL_PRIM void HL_NAME(io_set_app_accepting_events)(ImGuiIO* hl_io, bool accepting_events )
{
	hl_io->SetAppAcceptingEvents( accepting_events );
}

HL_PRIM void HL_NAME(io_clear_input_characters)(ImGuiIO* hl_io  )
{
	hl_io->ClearInputCharacters( );
}

HL_PRIM void HL_NAME(io_clear_input_keys)(ImGuiIO* hl_io  )
{
	hl_io->ClearInputKeys( );
}



DEFINE_PRIM(_STRUCT, get_io, _NO_ARG);
DEFINE_PRIM(_VOID, io_add_key_event, _STRUCT _I32 _BOOL );
DEFINE_PRIM(_VOID, io_add_key_analog_event, _STRUCT _I32 _BOOL _F32 );
DEFINE_PRIM(_VOID, io_add_mouse_pos_event, _STRUCT _F32 _F32 );
DEFINE_PRIM(_VOID, io_add_mouse_button_event, _STRUCT _I32 _BOOL );
DEFINE_PRIM(_VOID, io_add_mouse_wheel_event, _STRUCT _F32 _F32 );
DEFINE_PRIM(_VOID, io_add_mouse_viewport_event, _STRUCT _I32 );
DEFINE_PRIM(_VOID, io_add_focus_event, _STRUCT _BOOL );
DEFINE_PRIM(_VOID, io_add_input_character, _STRUCT _I32 );
DEFINE_PRIM(_VOID, io_add_input_character_utf16, _STRUCT _I32 );
DEFINE_PRIM(_VOID, io_add_input_characters_utf8, _STRUCT _STRING );

DEFINE_PRIM(_VOID, io_set_key_event_native_data, _STRUCT _I32 _I32 _I32 _I32 );
DEFINE_PRIM(_VOID, io_set_app_accepting_events, _STRUCT _BOOL );
DEFINE_PRIM(_VOID, io_clear_input_characters, _STRUCT );
DEFINE_PRIM(_VOID, io_clear_input_keys, _STRUCT );


//
// Legacy IO functions. These will be removed later.
//

static std::string ini_filename;

HL_PRIM bool HL_NAME(want_capture_mouse)()
{
    return ImGui::GetIO().WantCaptureMouse;
}

HL_PRIM bool HL_NAME(want_capture_keyboard)()
{
    return ImGui::GetIO().WantCaptureKeyboard;
}

HL_PRIM void HL_NAME(set_ini_filename)(vstring* filename)
{
    if (filename == nullptr)
    {
        ImGui::GetIO().IniFilename = NULL;
    }
    else
    {
        ini_filename = convertString(filename);
    }
    ImGui::GetIO().IniFilename = ini_filename.c_str();
}

HL_PRIM void HL_NAME(set_config_flags)(ImGuiConfigFlags* flags)
{
    ImGui::GetIO().ConfigFlags = convertPtr(flags, 0);
}

HL_PRIM int HL_NAME(get_config_flags)()
{
    return ImGui::GetIO().ConfigFlags;
}

HL_PRIM void HL_NAME(set_user_data)(vdynamic* data) {
    ImGuiIO& io = ImGui::GetIO();
    // Remove previous user-data from GC root
    if (io.UserData != NULL) hl_remove_root(&io.UserData);
    // Add new data to GC root
    if (data != NULL) hl_add_root(&data);
    // Store the user-data to ImGui
    io.UserData = &data;
}

HL_PRIM vdynamic* HL_NAME(get_user_data)() {
    ImGuiIO& io = ImGui::GetIO();
    return (vdynamic*)&io.UserData;
}



DEFINE_PRIM(_BOOL, want_capture_mouse, _NO_ARG);
DEFINE_PRIM(_BOOL, want_capture_keyboard, _NO_ARG);
DEFINE_PRIM(_VOID, set_ini_filename, _STRING);
DEFINE_PRIM(_VOID, set_user_data, _DYN);
DEFINE_PRIM(_DYN, get_user_data, _NO_ARG);

DEFINE_PRIM_PROP(_I32,config_flags,_REF(_I32));
