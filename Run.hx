import sys.io.File;

class Run {


	static inline final HLIMGUI_HDLL = "hlimgui.hdll";

	static function main() {
		var args = Sys.args();

		var originalPath = args.pop();
		var haxelibPath = Sys.getCwd();

        switch( args.shift() ) {
            case "build":
                Sys.command("git submodule init");
                Sys.command("git submodule update");
                Sys.command("cd extension");
                Sys.command("mkdir build");
                Sys.command("cd build");
                Sys.command("cmake ..");
                Sys.command("cmake --build .");
                File.copy(haxelibPath+"/"+HLIMGUI_HDLL,originalPath+"/"+HLIMGUI_HDLL);
            }
    }
}