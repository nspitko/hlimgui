import imgui.ImGuiDrawable;
import imgui.ImGui;

// Sample with a simplified ImGuiApp that handles imgui presentation and update automatically
class Main extends imgui.ImGuiApp {
    
    override function update(dt:Float) {
        ImGui.showDemoWindow();
    }
    
    static function main() {
        new Main();
    }
    
}

// Sample with just ImGuiDrawable and manual handling of imgui presentation and update:
/*
class Main extends hxd.App
{
    var drawable:ImGuiDrawable;

    override function init() 
    {
        this.drawable = new ImGuiDrawable(this.s2d);
    }

    override function update(dt:Float)
    {
        drawable.update(dt);

        ImGui.newFrame();

        ImGui.showDemoWindow();

        ImGui.render();
    }

    override function onResize()
    {
        ImGui.setDisplaySize(this.s2d.width, this.s2d.height);
    }

    static function main() 
    {
        new Main();
    }
}
*/