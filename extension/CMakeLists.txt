cmake_minimum_required(VERSION 3.10)

set(TARGET_NAME hlimgui)
set(TARGET_EXT .hdll)

project(${TARGET_NAME})

option(NODE_EDITOR "Include imgui-node-editor (required to use NodeEditor.hx)" ON)
option(NEO_SEQUENCER "Include imgui-neo_sequencer (required to use NeoSequencer.hx)" ON)
option(MARKDOWN "Include markdown support (required to use Imgui.TextMarkdown)" ON)

file(GLOB SOURCES "*.cpp")
file(GLOB IMGUI_SOURCES "lib/imgui/*.cpp")

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

if( NODE_EDITOR )
    file(GLOB IMGUI_NODE_EDITOR_EXTENSION_SOURCES "addons/node_editor/*.cpp")
    file(GLOB IMGUI_NODE_EDITOR_SOURCES "lib/imgui-node-editor/*.cpp")

    list(APPEND SOURCES ${IMGUI_NODE_EDITOR_EXTENSION_SOURCES})
    list(APPEND IMGUI_SOURCES ${IMGUI_NODE_EDITOR_SOURCES})
endif()

if( NEO_SEQUENCER )
    file(GLOB IMGUI_NEO_SEQUENCER_EXTENSION_SOURCES "addons/neo_sequencer/*.cpp")
    file(GLOB IMGUI_NEO_SEQUENCER_SOURCES "lib/neo_sequencer/*.cpp")

    list(APPEND SOURCES ${IMGUI_NEO_SEQUENCER_EXTENSION_SOURCES})
    list(APPEND IMGUI_SOURCES ${IMGUI_NEO_SEQUENCER_SOURCES})
endif()

if( MARKDOWN )
    file(GLOB IMGUI_MARKDOWN_EXTENSION_SOURCES "addons/markdown/*.cpp")
    list(APPEND SOURCES ${IMGUI_MARKDOWN_EXTENSION_SOURCES})
endif()


add_library(${TARGET_NAME}${TARGET_EXT} SHARED ${SOURCES} ${IMGUI_SOURCES})

add_compile_definitions(IMGUI_USER_CONFIG="../../imgui_config.h")

set_target_properties(${TARGET_NAME}${TARGET_EXT}
    PROPERTIES
    PREFIX ""
    OUTPUT_NAME ${TARGET_NAME}
    SUFFIX ${TARGET_EXT}
)

IF (WIN32)
target_include_directories(${TARGET_NAME}${TARGET_EXT} PUBLIC $ENV{HASHLINKPATH}/include lib/imgui/ )
target_link_libraries(${TARGET_NAME}${TARGET_EXT} $ENV{HASHLINKPATH}/libhl.lib)
ELSEIF (APPLE)
find_library(APPLICATION_SERVICES_FRAMEWORK ApplicationServices REQUIRED)
set(HLPATH /usr/local)
target_include_directories(${TARGET_NAME}${TARGET_EXT} PUBLIC ${HLPATH}/include lib/imgui/)
target_link_libraries(${TARGET_NAME}${TARGET_EXT} ${HLPATH}/lib/libhl.dylib ${APPLICATION_SERVICES_FRAMEWORK})
ELSE()
target_include_directories(${TARGET_NAME}${TARGET_EXT} PUBLIC $ENV{HASHLINKPATH}/include lib/imgui/ )
target_link_libraries(${TARGET_NAME}${TARGET_EXT} hl)
ENDIF()

add_custom_command(TARGET ${TARGET_NAME}${TARGET_EXT} POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:${TARGET_NAME}${TARGET_EXT}> ../..
)
