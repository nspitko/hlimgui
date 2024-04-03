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

    #if multidriver
    var io = ImGui.getIO();
		io.ConfigFlags |= ViewportsEnable;
		io.BackendFlags |= ImGuiBackendFlags.PlatformHasViewports;
		io.BackendFlags |= ImGuiBackendFlags.RendererHasViewports;
		io.BackendFlags |= ImGuiBackendFlags.HasMouseHoveredViewport;


    // Set up the main window hooks.
    var v = ImGui.viewportSetMainViewport( hxd.Window.getInstance() );
		if( v != null )
		{
			var w= hxd.Window.getInstance();

			w.onMove = () -> {
				v.PlatformRequestMove = true;
			}

			@:privateAccess
			{
				var d = imguiDrawable;
				w.addEventTarget( ( e: hxd.Event ) -> { d.onMultiWindowEvent( w, e, v ); } );
			}


			w.addResizeEvent(() -> {
				v.PlatformRequestResize = true;
			});

		}

		#if hlsdl
		// This hint allows a focus click to also send events. Without this, you have to click a window
		// once before you can interact with it, which feels really bad.
		sdl.Sdl.setHint("SDL_MOUSE_FOCUS_CLICKTHROUGH", "1");
		io.ConfigDockingTransparentPayload = true;

		for( d in sdl.Sdl.getDisplays() )
		{
			ImGui.viewportAddMonitor( {
				x: d.right - d.left,
				y: d.bottom - d.top
			}, {
				x: d.left,
				y: d.top
			} );

		}
		#else
		// @todo: need to pass position in.
		for( m in hxd.Window.getMonitors() )
		{
			ImGui.viewportAddMonitor( { x: m.width, y: m.height }, { x: 0, y: 0 } );
		}
		#end


		ImGui.viewportSetPlatformCreateWindow( ( v: ImGuiViewport ) -> {
			@:privateAccess
			{
				#if hldx
				var w = new hxd.Window("ImGui Viewport", 100,100,false);
				var e = new h3d.Engine();
				e.window = w;
				var d3dDriver = new DirectXDriver();
				e.driver = d3dDriver;
				d3dDriver.window = w.window;
				d3dDriver.reset();
				d3dDriver.init(e.onCreate, !e.hardware);
				#elseif hlsdl

				var mainWindow = hxd.Window.inst;
				var w = new hxd.Window("ImGui Viewport", 100,100,false);
				w.displayMode = Borderless;
				var e = h3d.Engine.getCurrent();
				// Disable vsync on these windows; else we end up waiting for vblank for every individual window.
				w.vsync = false;


				@:privateAccess
				{
					w.window.visible = false;
					// !! HACK !!
					// Heaps always creates a new context when you create a window. That's perfectly reasonable
					// if multi driver was what we wanted, but it isn't, so slam the context.
					// Additionally, store off the created context so we can set it back during window destroy
					// since heaps always destroys the context alongside the window
					v.PlatformHandleRaw = cast w.window.glctx;
					w.window.glctx = mainWindow.window.glctx;

				}

				#end

				w.onClose = () -> {
					v.PlatformRequestClose = true;
					return false;
				}

				w.onMove = () -> {
					v.PlatformRequestMove = true;
				}

				// Get a handle to our drawable and add events. Yes it's gross.
				@:privateAccess
				{
					var d = imguiDrawable;
					w.addEventTarget( ( e: hxd.Event ) -> {
						d.onMultiWindowEvent( w, e, v );
						// Window events should NEVER propagate down; heaps isn't listening for them so we need to
						// do this to prevent the OS chime from playing on key press.
						// There is an argument for leaving this up to the implementer to decide (this behavior
						// may be desirable at times) but this is less annoying for now.
						e.propagate = false; }
					);
				}

        w.addResizeEvent(() -> {
          v.PlatformRequestResize = true;
        });

				v.PlatformHandle = w;
			}
		});

		ImGui.viewportSetPlatformDestroyWindow( ( v: ImGuiViewport ) -> {

      #if hlsdl
      // !! HACK !!
      // We stored off glctx so we could restore it here and destroy it when the window
      // is destroyed. We need to do this so we don't accidentally destoy our main
      // ctx, these are just junk contexts we created because heaps does it automatically
			@:privateAccess v.PlatformHandle.window.glctx = cast v.PlatformHandleRaw;
      #end

			if( v.PlatformHandle != null )
				v.PlatformHandle.close();

			v.RendererUserData = null;
			v.PlatformUserData = null;
			v.PlatformHandle = null;

		});

		ImGui.viewportSetPlatformShowWindow( ( v: ImGuiViewport ) -> {
			#if hlsdl
			@:privateAccess v.PlatformHandle.window.visible = true;
			#end
		});

		ImGui.viewportSetPlatformSetWindowPos( ( v: ImGuiViewport, size: ImVec2 ) -> {
			#if hldx
			var w: dx.Window = @:privateAccess v.PlatformHandle.window;
			w.setPosition( cast size.x, cast size.y );
			#elseif hlsdl
			@:privateAccess v.PlatformHandle.window.setPosition( cast size.x, cast size.y );
			#end
		});

		ImGui.viewportSetPlatformGetWindowPos( ( v: ImGuiViewport, pos: ImGuiVec2Struct ) -> {
			#if hlsdl
			@:privateAccess
			{
				var x = 0;
				var y = 0;
				sdl.Window.winGetPosition( v.PlatformHandle.window.win, x, y );
				pos.x = cast x;
				pos.y = cast y;
			}
			#else
			pos.x = 0;
			pos.y = 0;
			#end
		});

		ImGui.viewportSetPlatformSetWindowSize( ( v: ImGuiViewport, size: ImVec2 ) -> {
			if( v.PlatformHandle.width == size.x && v.PlatformHandle.height == size.y )
				return;

			v.PlatformHandle.resize( cast size.x, cast size.y );
		});

		ImGui.viewportSetPlatformGetWindowSize( ( v: ImGuiViewport, size: ImGuiVec2Struct ) -> {
			var window: hxd.Window = v.PlatformHandle;
			if( window != null )
			{
				size.x = window.width;
				size.y = window.height;
			}
		});

		ImGui.viewportSetPlatformSetWindowFocus( ( v: ImGuiViewport ) -> {
			// @todo
		});

		ImGui.viewportSetPlatformGetWindowFocus( ( v: ImGuiViewport ) -> {
			return v.PlatformHandle.isFocused;
		});

		ImGui.viewportSetPlatformGetWindowMinimized( ( v: ImGuiViewport ) -> {
			return false; // @todo
		});

		ImGui.viewportSetPlatformSetWindowTitle( ( v: ImGuiViewport, title: hl.Bytes ) -> {
			var str = @:privateAccess String.fromUTF8( title );
			v.PlatformHandle.title = str;
		});

		ImGui.viewportSetPlatformSetWindowAlpha( ( v: ImGuiViewport, alpha: Single ) -> {
			#if hlsdl
			@:privateAccess v.PlatformHandle.window.opacity = alpha;
			#end
		});

		ImGui.viewportSetRendererRenderWindow( ( v: ImGuiViewport, arg: Dynamic ) -> {

			if( !v.PlatformWindowCreated || v.PlatformHandle == null )
				return;

			var oldWin = hxd.Window.getInstance();

			var e: h3d.Engine = h3d.Engine.getCurrent();
			var w = v.PlatformHandle;

			w.setCurrent();

      var s2d = imguiDrawable.getScene();


			@:privateAccess
			{
				var oldW = e.width;
				var oldH = e.height;

				var oldScaleMode = s2d.scaleMode;

				e.window = w;
				e.resize(w.width, w.height);

				@:privateAccess s2d.window = w;


				s2d.width = w.width;
				s2d.height = w.height;
				s2d.scaleMode = Fixed(w.width, w.height, 1);
				s2d.render( e );
				s2d.width = oldW;
				s2d.height = oldH;

				//w.window.present();

				e.resize(oldW, oldH);
				e.window = oldWin;
				s2d.scaleMode = oldScaleMode;
			}

			oldWin.setCurrent();

		});


		ImGui.viewportSetRendererSwapBuffers( ( v: ImGuiViewport, arg: Dynamic ) -> {
			var oldWin = hxd.Window.getInstance();
			var w = v.PlatformHandle;
			w.setCurrent();
			@:privateAccess w.window.present();
			oldWin.setCurrent();
		});

		#end
  }

  override function setup() {
    super.setup();
    if (!imguiInitialized) initImgui();
  }

  override function onResize()
  {
    if (imguiScene != null) {
      imguiScene.checkResize();
      var io = ImGui.getIO();
      io.DisplaySize.x = imguiScene.width;
      io.DisplaySize.y = imguiScene.height;
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

    // Viewports
    var io = ImGui.getIO();
    if ((io.ConfigFlags & ImGuiConfigFlags.ViewportsEnable) != 0 )
    {
      ImGui.updatePlatformWindows();
      ImGui.renderPlatformWindowsDefault(null, e);
    }
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
    var io = ImGui.getIO();
    return if (
      io.WantCaptureMouse && (e.kind == EPush || e.kind == ERelease || e.kind == EWheel || e.kind == EMove || e.kind == ECheck) ||
      io.WantCaptureKeyboard && (e.kind == EKeyDown || e.kind == EKeyUp || e.kind == ETextInput)
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