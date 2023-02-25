package imgui;
#if macro
import haxe.macro.Expr;
import haxe.macro.Context;
using haxe.macro.ExprTools;

typedef FieldRefPtr<T> = Dynamic;
#else
typedef FieldRefPtr<T> = hl.Ref<T>;

@:noCompletion
@:hlNative("hlimgui")
class FieldRefNative {
  
  public static function fieldref_i8(data: Dynamic, field: String): hl.Ref<hl.UI8> { return null; }
  public static function fieldref_i16(data: Dynamic, field: String): hl.Ref<hl.UI16> { return null; }
  public static function fieldref_i32(data: Dynamic, field: String): hl.Ref<Int> { return null; }
  public static function fieldref_i64(data: Dynamic, field: String): hl.Ref<hl.I64> { return null; }
  
  public static function fieldref_f32(data: Dynamic, field: String): hl.Ref<Single> { return null; }
  public static function fieldref_f64(data: Dynamic, field: String): hl.Ref<Float> { return null; }
  
  public static function fieldref_bool(data: Dynamic, field: String): hl.Ref<Bool> { return null; }
  public static function fieldref_bytes(data: Dynamic, field: String): hl.Ref<hl.Bytes> { return null; }
  
  public static function fieldref_dyn(data: Dynamic, field: String): hl.Ref<Dynamic> { return null; }
  
  // TODO: @:struct support?
}

#end

@:forward
abstract FieldRef<T>(FieldRefPtr<T>) from FieldRefPtr<T> to FieldRefPtr<T> {
  
  @:from
  public static macro function make<T>(e: ExprOf<T>) {
    // imgui.FieldRef.fieldref()
    // var expected = haxe.macro.Context.getExpectedType();
    // if (expected == null) throw "FieldRef need an expected type!";
    // trace($type T);
    var te = Context.typeExpr(e);
    
    var method = "dyn";
    switch (te.t) {
      case TAbstract(t, params):
        switch (t.toString()) {
          case "Int": method = "i32";
          case "hl.UI8": method = "i8";
          case "hl.UI16": method = "i16";
          case "hl.I64": method = "i64";
          case "Single": method = "f32";
          case "Float": method = "f64";
          case "Bool": method = "bool";
          case "hl.Bytes": method = "bytes";
        }
      default:
        // trace(te.t);
    }
    method = "fieldref_" + method;
    e = Context.getTypedExpr(te);
    
    switch (e.expr) {
      case EParenthesis(pe): e = pe;
      default:
    }
    switch (e.expr) {
      case EConst(CIdent("null")):
        return e; // null pass
      case EField(d, field, _):
        return macro imgui.FieldRef.FieldRefNative.$method($d, $v{field});
      case EConst(Constant.CIdent(fname)):
        var tvars = haxe.macro.Context.getLocalTVars();
        if (tvars.exists(fname) || fname == "this") return macro hl.Ref.make($e);
        else return macro imgui.FieldRef.FieldRefNative.$method(this, $v{fname}); // Omitted `this.`
      default:
        throw "Cannot make FieldRef from this expression! Supported types: Local variables and instance fields. Use `wref` for properties.";
    }
    return e;
  }
  
}