package imgui.types;

@:keep
@:struct class ImVector {
  
  public var size: Int;
  public var capacity: Int;
  public var data: hl.Bytes;
  
}