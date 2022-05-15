package imgui;

#if !hlimgui_disable_macro_helpers
#if macro
import haxe.macro.Expr;
using haxe.macro.Tools;
#end

/**
  A helper macro function to workaround `hl.Ref` only working with local variables.
  
  For void function please use `wrefv` variant.
  Always assigns-back the referenced variables. For conditional assign-back see `wrefc`.
  
  Usage:
  ```haxe
  // Use `_` or `__` to denote the position of the referenced value, and a follow-up arguments are treated as substitutes.
  wref(ImGui.inputDouble("Label", _), point.x);
  // alternatively use $(value to reference)
  wref(ImGui.inputDouble("Label", $(point.x)));
  ```
  Internally it would unroll into:
  ```haxe
  {
    var __tmp_0 = point.x;
    var result = ImGui.inputDouble("Label", __tmp_0);
    point.x = __tmp_0;
    result;
  }
  ```
**/
macro function wref(expr: Expr, names: Array<Expr>): Expr {
  return wref_gen(expr, false, true, names);
}

/**
  A `:Void`-compatible variant of `wref` method.
  
  Always assigns-back the referenced variables.
  
  Usage:
  ```haxe
  // Use `_` or `__` to denote the position of the referenced value, and a follow-up arguments are treated as substitutes.
  wrefv(ImGui.inputDouble("Label", _), point.x);
  // alternatively use $(value to reference)
  wrefv(ImGui.inputDouble("Label", $(point.x)));
  ```
  Internally it would unroll into:
  ```haxe
  {
    var __tmp_0 = point.x;
    ImGui.inputDouble("Label", __tmp_0);
    point.x = __tmp_0;
  }
  ```
**/
macro function wrefv(expr: Expr, names: Array<Expr>): Expr {
  return wref_gen(expr, true, true, names);
}

/**
  A conditional assign-back variant of `wref`. Only assigns referenced values back if called method returns `true`.
  Can only be used with methods that return a boolean.
  
  Usage:
  ```haxe
  // Use `_` or `__` to denote the position of the referenced value, and a follow-up arguments are treated as substitutes.
  wrefc(ImGui.inputDouble("Label", _), point.x);
  // alternatively use $(value to reference)
  wrefc(ImGui.inputDouble("Label", $(point.x)));
  ```
  Internally it would unroll into:
  ```haxe
  {
    var __tmp_0 = point.x;
    var result = ImGui.inputDouble("Label", __tmp_0);
    if (result) {
      point.x = __tmp_0;
    }
    result;
  }
  ```
**/
macro function wrefc(expr: Expr, names: Array<Expr>): Expr {
  return wref_gen(expr, false, false, names);
}

#if macro
private function wref_gen(expr: Expr, voidCall: Bool, alwaysAssignBack: Bool, names: Array<Expr>):Expr {
  var tmps:Array<String> = [];
  var tmpDecl:Array<Expr> = [];
  var tmpAssign:Array<Expr> = [];
  function allocTemp(e: Expr) {
    var tmpName = "__tmp_" + tmps.length;
    tmps.push(tmpName);
    tmpDecl.push(macro var $tmpName = @:privateAccess $e);
    tmpAssign.push(macro @:privateAccess $e = $i{tmpName});
    return macro $i{tmpName};
  }
  
  function repl(e:Expr) {
    switch (e.expr) {
      case ECall({ expr: EConst(CIdent("$")), pos: _}, params):
        // $(value) transformed into a reference.
        e.expr = allocTemp(params[0]).expr;
      case EConst(Constant.CIdent("_")), EConst(Constant.CIdent("__")):
        // `_` or `__` take from the rest of the expressions passed to the function.
        e.expr = allocTemp(names.shift()).expr;
      default:
        e.iter(repl);
    }
  }
  repl(expr);
  if (!voidCall) tmpDecl.push(macro var result = $e{expr});
  var result = 
    if (alwaysAssignBack || voidCall) {
      tmpDecl.concat(tmpAssign);
    } else {
      tmpDecl.push(macro if (result) $b{tmpAssign});
      tmpDecl;
    }
  if (!voidCall) result.push(macro result);
  return macro $b{result};
}

#end

#end