#include "utils.h"

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
