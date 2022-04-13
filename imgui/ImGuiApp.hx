package imgui;

#if heaps
import imgui.ImGui;

/**
  A simplified Heaps App that can be used to get Imgui integrated without much hassle.
  
  It uses a separate 2D scene to render ImGui contents, as well as prioritises imgui as recepient for input events.
  
  Usage example:
  ```haxe
  class MyGameApp extends #if hlimgui imgui.ImGuiApp #else hxd.App #end {
    
    // Use your regular App setup.
    
  }
  ```
**/
class ImGuiApp extends hxd.App {
  
  var imguiInitialized = false;
  var imguiScene: ImGuiScene;
  var imguiDrawable: imgui.ImGuiDrawable;
  
  /**
    Called right after ImGui.newFrame(), note that none of Heaps event loop processing happened yet.
  **/
  function onNewFrame() { }
  /**
    Called right before ImGui.render() allowing to inject some extra ImGui code right before rendering.
  **/
  function beforeRender() { }
  
  function initImgui() {
    imguiInitialized = true;
    var s = new ImGuiScene();
    imguiScene = s;
    sevents.addScene(s, 0);
    // Drawable have to be initialized after scene was added to the scene events.
    imguiDrawable = s.init();
  }
  
  override function setup() {
    super.setup();
    if (!imguiInitialized) initImgui();
  }
  
  override function onResize()
  {
    if (imguiScene != null) {
      imguiScene.checkResize();
      ImGui.setDisplaySize(imguiScene.width, imguiScene.height);
    }
    super.onResize();
  }
  
  override function setScene2D(s2d:h2d.Scene, disposePrevious:Bool = true)
  {
    // Ensure that if we set new s2d - imgui scene still prioritized by input events.
    super.setScene2D(s2d, disposePrevious);
    sevents.removeScene(imguiScene);
    sevents.addScene(imguiScene, 0);
  }
  
  override function init()
  {
    if (!imguiInitialized) initImgui();
    super.init();
  }
  
  // Main loop is completely overriden because Heaps have no proper way to inject non-standard scenes into an update loop.
  override function mainLoop() {
    hxd.Timer.update();
    if (imguiDrawable != null) imguiDrawable.update(hxd.Timer.dt);
    ImGui.newFrame();
    onNewFrame();
    sevents.checkEvents();
    if( isDisposed ) return;
    update(hxd.Timer.dt);
    if( isDisposed ) return;
    var dt = hxd.Timer.dt; // fetch again in case it's been modified in update()
    if( s2d != null ) s2d.setElapsedTime(dt);
    if( s3d != null ) s3d.setElapsedTime(dt);
    if( imguiScene != null ) imguiScene.setElapsedTime(dt);
    engine.render(this);
  }
  
  override public function render(e:h3d.Engine)
  {
    super.render(e);
    beforeRender();
    ImGui.render();
    imguiScene.render(e);
  }
  
  override function dispose()
  {
    if (imguiScene != null) imguiScene.dispose();
    super.dispose();
  }
}

private class ImGuiScene extends h2d.Scene {
  
  var overlay:h2d.Interactive;
  var drawable:imgui.ImGuiDrawable;
  
  public function new() {
    super();
    overlay = new h2d.Interactive(width, height, this);
    overlay.cursor = Default;
  }
  
  public function init() {
    drawable = new imgui.ImGuiDrawable(this);
    return drawable;
  }
  
  override public function handleEvent( e : hxd.Event, last : hxd.SceneEvents.Interactive ) : hxd.SceneEvents.Interactive {
    if (last == overlay) return null;
    @:privateAccess drawable.onEvent(e);
    return if (
      ImGui.wantCaptureMouse() && (e.kind == EPush || e.kind == ERelease || e.kind == EWheel || e.kind == EMove || e.kind == ECheck) ||
      ImGui.wantCaptureKeyboard() && (e.kind == EKeyDown || e.kind == EKeyUp || e.kind == ETextInput)
    ) overlay;
    else null;
  }
  
  override public function checkResize() {
    super.checkResize();
    overlay.width = width;
    overlay.height = height;
  }
  
  override public function addEventListener(f:hxd.Event -> Void)
  {
    return; // Prevent drawable from adding listeners as we manually handle it.
  }
  
}
#end