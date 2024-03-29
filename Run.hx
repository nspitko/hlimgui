import haxe.io.Path;
import sys.FileSystem;
import sys.io.File;
using StringTools;

typedef Command = {
	var name: String;
	@:optional var args: String;
	var help: String;
	function exec(args: Array<String>, flags: Array<String>): Void;
}

class Run {
	
	static inline final HLIMGUI_HDLL = "hlimgui.hdll";
	
	static var libPath: String = Sys.getCwd();
	static var callPath: String;
	
	static var linearCommands: Array<Command> = [
		{
			name: "update",
			help: "Update the git submodules",
			exec: (_, _) -> {
				Sys.println("Updating submodules...");
				Sys.command("git", ["submodule", "init"]);
				Sys.command("git", ["submodule", "update"]);
			}
		},
		{
			name: "build",
			args: "[flags] [hdll_path]",
			help: "Build the extension hdll file.
    Flags:
      \u001B[93m-u  | --update\u001B[0m      Update the git submodules (equivalent to running `haxelib run hlimgui update` beforehand)
      \u001B[93m-r  | --release\u001B[0m     Build with Release configuration, defaults to Debug.
      \u001B[93m-ni | --no-install\u001B[0m  Do not run the `install` command after build finished.
    Args:
      \u001B[93m[hdll_path]\u001B[0m         See the `install [output]` argument description.",
			exec: function(args: Array<String>, flags: Array<String>) {
				
				if (flags.contains("-u") || flags.contains("--update")) commands["update"].exec([], []);
				
				Sys.println("Building the extension...");
				if (!FileSystem.isDirectory("extension/build")) FileSystem.createDirectory("extension/build");
				Sys.setCwd(Path.join([libPath, "extension", "build"]));
				Sys.command("cmake", [".."]);
				var buildArgs = ["--build", "."];
				if (flags.contains("-r") || flags.contains("--release")) {
					buildArgs.push("--config");
					buildArgs.push("Release");
				}
				Sys.command("cmake", buildArgs);
				Sys.setCwd(libPath);
				
				if (!flags.contains("-n") && !flags.contains("--no-install")) {
					commands["install"].exec(args, []);
				}
			}
		},
		{
			name: "install",
			args: "[output]",
			help: "Copy the .hdll file to [output] or hl.exe location
    Args:
      \u001B[93m[output]\u001B[0m            The directory to which copy the generated .hdll file.
                          If not given, will try to copy it to the location of `hl.exe` by
                          looking for it `HASHLINK_BIN`, `HASHLINK_PATH` and `HASHLINKPATH`
                          environment variables, then in `PATH`.",
			exec: (args, _) -> {
				final hdllPath = Path.join([libPath, HLIMGUI_HDLL]);
				if (!FileSystem.exists(hdllPath)) {
					Sys.println("Extension is not built or failed to produce the .hdll file! Use `build` command.");
					return;
				}
				var outputPath = null;
				if (args.length == 0) {
					outputPath = Sys.getEnv("HASHLINK_BIN") ?? Sys.getEnv("HASHLINK_PATH") ?? Sys.getEnv("HASHLINKPATH");
					if (outputPath == null) {
						for (dir in Sys.getEnv("PATH").split(";")) {
							if (FileSystem.exists(Path.join([dir, "hl.exe"]))) {
								outputPath = dir;
								break;
							}
						}
					}
					if (outputPath == null) Sys.println("Warning: Could not locate hl.exe, .hdll file won't be copied for easy access!");
				} else {
					outputPath = args.shift();
					if (!Path.isAbsolute(outputPath)) outputPath = Path.join([callPath, outputPath]); // Make sure . / .. paths resolve correctly
				}
				if (outputPath != null) {
					if (!FileSystem.isDirectory(outputPath)) FileSystem.createDirectory(outputPath);
					File.copy(hdllPath, Path.join([outputPath, HLIMGUI_HDLL]));
					Sys.println("Copying file to " + outputPath);
				}
			}
		},
		{
			name: "help",
			args: "[command]",
			help: "Print this text
    Args:
      \u001B[93mcommand\u001B[0m             Only print help for specific command.",
			exec: (args, _) -> help(args)
		}
	];
	static var commands: Map<String, Command> = [
		for (cmd in linearCommands) cmd.name => cmd
	];
	
	static function main() {
		var args = Sys.args();
		callPath = args.pop();
		
		var flags: Array<String> = [];
		var i = 0;
		while (i < args.length) {
			if (args[i].charCodeAt(0) == '-'.code) {
				flags.push(args[i].toLowerCase());
				args.splice(i, 1);
			} else i++;
		}
		
		if (args.length == 0) {
			help(args);
			return;
		}
		var commandName = args.shift();
		var command = commands[commandName];
		if (command == null) {
			Sys.println('Unknown command: ${commandName}');
			help(args);
			return;
		}
		
		command.exec(args, flags);
	}
	
	static function help(args: Array<String>) {
		if (args.length > 0) {
			var cmd = commands[args[0]];
			if (cmd == null) {
				Sys.println("Help not found for command \"" + args[0] + "\", no such command!");
			} else {
				Sys.println('Usage: haxelib run hlimgui \u001B[94m${cmd.name} \u001B[93m${cmd.args}\u001B[0m');
				Sys.println(("  \u001B[94m" + cmd.name + "\u001B[93m " + (cmd.args ?? "")).rtrim() + "\u001B[0m - " + cmd.help);
			}
			return;
		}
		Sys.println("Usage: haxelib run hlimgui \u001B[94m<command> \u001B[93m<args>\u001B[0m");
		Sys.println("Available commands:");
		for (cmd in linearCommands) {
			Sys.println(("  \u001B[94m" + cmd.name + "\u001B[93m " + (cmd.args ?? "")).rtrim() + "\u001B[0m - " + cmd.help);
		}
	}
}