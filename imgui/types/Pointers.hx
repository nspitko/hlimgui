package imgui.types;

// General Ptr storage
typedef ImFontPtr = hl.Abstract<"imfont">;
typedef ImFontAtlasPtr = hl.Abstract<"imfontatlas">;
typedef ImDrawListPtr = hl.Abstract<"imdrawlist">;
typedef ImStateStoragePtr = hl.Abstract<"imstatestorage">;
typedef ImContextPtr = hl.Abstract<"imcontext">;
typedef ImDragDropPayloadPtr = hl.Abstract<"imdnd">;
typedef ImGuiDockNode = hl.Abstract<"imguidocknode">;
typedef ImVector = hl.Abstract<"imvector">;
typedef HLFinalizer = hl.Abstract<"finalizer">; // Used for ImGui constructs that require finalizer being called when GCd.