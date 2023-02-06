# Heaps/HashLink native binding for [Dear ImGui](https://github.com/ocornut/imgui)

## Build & Install
First, make sure that HashLink, CMake and a C/C++ compiler are installed on your system. This version of hlimgui uses submodules. Get them prepared like this:

```
git submodule init
git submodule update
```

Then the native extension needs to be built with these commands:

```
cd extension
mkdir build
cd build

cmake ..
cmake --build .
```
It builds a target `hdll` file, which you can copy to the root of the project.

Another method is to build it inside Visual Studio Code with `CMake Tools` extension installed, so you don't have to deal with the command line.

To add this library to your project, you need to include these files:

- The previously compiled `hlimgui.hdll` file.
- `imgui/ImGuiDrawable.hx`: this class derives from the standard Heaps `Drawable` class and contains/displays all ImGui widgets.
- `imgui/ImGui.hx`: interface to the native extension.
- `imgui/ImGuiMacro.hx`: Useful helper macros for wrapping `hl.Ref`.
- `imgui/NodeEditor.hx`: Wrapper for the imgui-node-editor extension.
- `imgui/FieldRef.hx`: The macro-helper that emulates missing `$fieldref` opcode for HL that is required for usage of this library.

See `Main.hx` to see how to implement this library.

## Supported ImGui features
Most of the ImGui functionalities are supported and bound. Look at [https://github.com/ocornut/imgui](https://github.com/ocornut/imgui) to get documentation on exposed functions AND how ImGui works.

Here is a list of unsupported features and changes:

- ImGui has several functions which take a variable number of parameters in order to format strings. This feature isn't supported in Haxe, so all string formatting must be done in Haxe before passing it to ImGui.

- The function `setIniFilename` doesn't exist in ImGui, it has been added to modify the filename of the default ini file saved by ImGui (pass null to turn off this feature).

## References
Input function often take a `Ref<T>` / `imgui.FieldRef<T>` argument.
Those are equivalent to `hl.Ref` however offer an extra feature of referencing an class instance or static field, not only local variables.

However the limitation of `Ref` is that it does not work properties (`get_x` / `set_y`), in which case you will have to manually load said values into local variables or use the wrapper function:
```haxe
import imgui.ImGuiMacro.*; // Import the `wref` / `wrefv` and `wrefc` macro functions into global scope.
// In order to denote which values should be converted into a reference,
// either use `$(path.to.field)` notation or use `_` and insert the value after the initial call.
// Names are shorthands to:
// wref - With Reference
// wrefv - With Reference (Void call)
// wrefc - With Reference (Conditional assign)

var myString = "Hello!", edited: Boolean;

// Will assign myString regardless of inputText return value.
// `wref` will assign referenced values back regardless of the returned value.
// Wrapper return value is equivalent to wrapped function return value. Incompatible with `:Void` methods.
edited = wref(ImGui.inputText('Text input', $(myString))); // With `$(value)` notation
edited = wref(ImGui.inputText('Text input', _), myString); // With `_` notation

// same as `wref` - `wrefv` will assign value back regardless, but compatible with `:Void` methods.
static var show: Boolean = true;
wrefv(ImGui.showDemoWindow($(edited)));
// Will result in an error! `wrefv` does not return a value.
// edited = wrefv(ImGui.inputText('Text input', $(myString)));

// Compared to `wref` - `wrefc` only assigns back the value if wrapped method returns true.
// Note that it works only with methods that return a boolean.
// Useful when property does some extra logic when it's changes and you don't want it to trigger every frame.
edited = wrefc(ImGui.inputText('Text input', $(myString)));
```

## Heaps integration
This library comes with a built-in Heaps support with the following features:
* `imgui.ImGuiApp` is a quick-start `hxd.App` version that overlays ImGui elements as a separate scene.
* `imgui.ImGuiDrawable` is a primary renderer for ImGui content and can be used to set up your own ImGui integration if `ImGuiApp` is not viable.
* `imgui.ImTextureID` is mapped to `h3d.mat.Texture`.
* A number of methods that take `h2d.Tile` instead of `ImTextureID` for easier image rendering.

## Bugs
If you find bugs, please report them on the GitHub project page. Most of the bound functions have been tested, but as it's a new library some bugs might remain.

## Thanks
* haddock7: I would like to thanks [Aidan63](https://github.com/Aidan63/linc_imgui) for their Haxe/cpp binding. I have borrowed all the structure declaration code which remains the same between the two bindings.
* This is a fork of [haddock7's](https://github.com/haddock7/hlimgui) imgui port for HashLink with advanced usage of HL/Haxe specifics accounted for, thanks to him for initial port of the library.
