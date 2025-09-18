# Heaps/HashLink native binding for [Dear ImGui](https://github.com/ocornut/imgui)

## Build & Install
First, make sure that HashLink, CMake and a C/C++ compiler are installed on your system.

### Building extension automatically
1. Install the library to haxelib.
  - With haxelib directly: `haxelib git hlimgui https://github.com/nspitko/hlimgui.git`
  - By cloning it to another directory and using `haxelib dev hlimgui path/to/hlimgui`
  - With lix: See https://github.com/lix-pm/lix.client#local-development
  - With [gsm](https://github.com/tobil4sk/haxe-git-submodule-manager): `haxelib --global run gsm add hlimgui https://github.com/nspitko/hlimgui`
2. Make sure your `hl.exe` is in the `PATH` or one of the following environment variables point at the directory where it's located.
3. Run `haxelib run hlimgui build -u` to update submodules (`-u` flag) and compile the .hdll file.
4. Add `-lib hlimgui` to your `build.hxml`
5. When shipping, make sure to copy the `hlimgui.hdll` from hashlink directory or run `haxelib run hlimgui install path/to/output/dir`

Note: by default `build` command compiles in debug mode, use `-r` flag to compile in release mode.

### Building extension manually
This version of hlimgui uses submodules. Get them prepared like this:

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

To add this library to your project, there are a few steps.
1) Copy the previously compiled `hlimgui.hdll` file to your project folder.
2) Add the library to your project as a haxelib.
   - With haxelib: `haxelib dev hlimgui path/to/hlimgui`
   - With lix: See https://github.com/lix-pm/lix.client#local-development
   - With [gsm](https://github.com/tobil4sk/haxe-git-submodule-manager): `haxelib --global run gsm add hlimgui https://github.com/nspitko/hlimgui`
3) Add `-lib hlimgui` to your `build.hxml`

Alternatively, you can just copy the files directly into your project instead, though this has some drawbacks and is generally not recommended. At the time of writing it is known to negatively impact the language server and prevent symbol renaming, among other things. If you still want to take this path, you'll need to copy these files:
- `imgui/ImGuiDrawable.hx`: this class derives from the standard Heaps `Drawable` class and contains/displays all ImGui widgets.
- `imgui/ImGui.hx`: interface to the native extension.
- `imgui/ImGuiMacro.hx`: Useful helper macros for wrapping `hl.Ref`.
- `imgui/NodeEditor.hx`: Wrapper for the imgui-node-editor extension, if used.
- `imgui/FieldRef.hx`: The macro-helper that emulates missing `$fieldref` opcode for HL that is required for usage of this library.

See `Main.hx` to see how to implement this library.

## Supported ImGui features
Most of the ImGui functionalities are supported and bound. Look at [https://github.com/ocornut/imgui](https://github.com/ocornut/imgui) to get documentation on exposed functions AND how ImGui works.

Here is a list of unsupported features and changes:

- ImGui has several functions which take a variable number of parameters in order to format strings. This feature isn't supported in Haxe, so all string formatting must be done in Haxe before passing it to ImGui.

- The function `setIniFilename` doesn't exist in ImGui, it has been added to modify the filename of the default ini file saved by ImGui (pass null to turn off this feature).

## Viewports
ImGui viewports are implemented with a mostly identical API, with a few minor exceptions. The default heaps base includes built-in support when using `-D multidriver`, else it can be used as a reference implementation.

#### Wayland specific quirks
Viewports do not (and may never) work in wayland due to it's lack of support for setting window size/position. You may be able to work around this by setting `sdl.Sdl.setHint("SDL_VIDEODRIVER", "x11");`, in environments that support XWayland. There are still bugs here but it should be *usable*.

(As of SDL3 this is `SDL_VIDEO_DRIVER`, so if/when sdl3 gets merged into hashlink you'll want to adjust accordingly)

## References
Input functions often take a `Ref<T>` / `imgui.FieldRef<T>` argument.
Those are equivalent to `hl.Ref` however offer an extra feature of referencing a class instance or static field, not only local variables.

```haxe
var myString = "Hello!", edited: Boolean;

// myString is automatically converted into a ref, imgui will update it when the user changes the value.
edited = ImGui.inputText('Text input', myString );
```

However the limitation of `Ref` is that it does not work on properties (`get_x` / `set_y`), in which case you will have to manually load said values into local variables or use the wrapper function:

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

Mulit-window viewport support can be added with `-D multidriver`

## Bugs
If you find bugs, please report them on the GitHub project page. Most of the bound functions have been tested, but as it's a new library some bugs might remain.

## Thanks
* haddock7: I would like to thanks [Aidan63](https://github.com/Aidan63/linc_imgui) for their Haxe/cpp binding. I have borrowed all the structure declaration code which remains the same between the two bindings.
* This is a fork of [haddock7's](https://github.com/haddock7/hlimgui) imgui port for HashLink with advanced usage of HL/Haxe specifics accounted for, thanks to him for initial port of the library.
