package imgui;

import haxe.macro.Expr;
import haxe.macro.Context;
using haxe.macro.Tools;

// Here be dragons

@:noCompletion
class _ImGuiInternalMacro {
  #if macro
  public static function buildFlatStruct() {
    var fields = Context.getBuildFields();
    var nfields = [];
    var props = [];
    var local = Context.getLocalType().toComplexType();
    var prefix = Context.getLocalClass().get().name.toLowerCase();
    var module:Array<TypeDefinition> = [];
    
    for (field in fields) {
      var flattened = false;
      if (field.meta != null) {
        for (meta in field.meta) {
          switch (meta.name) {
            case ":flatten":
              var inject = flatten(field, prefix, "");
              for (f in inject.fields) nfields.push(f);
              for (f in inject.props) props.push(f);
              module.push(inject.type);
              flattened = true;
            case ":flattenMap":
              if (!field.kind.match(FVar(_, _))) throw ":flattenMap requires flattened field to be a variable!";
              if (meta.params.length<1) throw ":flattenMap needs an abstract enum to map with!";
              var ct: ComplexType = field.kind.getParameters()[0];
              var subName = ct.toString().split(".").pop() + "_" + field.name;
              switch (Context.getType(meta.params[0].toString())) {
                case TAbstract(_.get() => t, _) if (t.meta.has(":enum") && t.type.followWithAbstracts().toString() == "Int"):
                  var names = t.impl.get().statics.get();
                  var subFields: Array<Field> = [];
                  for (f in names) {
                    if (f.name == "COUNT") continue; // Ignore the count enum
                    var fakeField: Field = {
                      name: f.name,
                      pos: f.pos,
                      access: [],
                      doc: f.doc,
                      kind: FVar(ct, null)
                    };
                    
                    var inject = flatten(fakeField, prefix, "_" + field.name.toLowerCase());
                    module.push(inject.type);
                    for (f in inject.fields) nfields.push(f);
                    for (f in inject.props) subFields.push(f);
                  }
                  var subType: ComplexType = TPath({ pack: ["imgui", "_internal", prefix], name: "FlatImpl", sub: subName });
                  module.push({
                    pack: ["imgui", "_internal", prefix, "FlatImpl"],
                    name: subName,
                    fields: subFields,
                    pos: field.pos,
                    kind: TDAbstract(local, [local]),
                  });
                  props.push({
                    name: field.name,
                    pos: field.pos,
                    access: [APublic],
                    kind: FProp("get", "never", subType)
                  });
                  props.push({
                    name: "get_" + field.name,
                    pos: field.pos,
                    access: [APrivate, AInline],
                    kind: FFun({
                      args: [],
                      ret: subType,
                      expr: macro return (this:$subType)
                    })
                  });
                default: throw ":flattenMap map enum should be an enum abstract(Int)!";
              }
              flattened = true;
          }
        }
      }
      if (!flattened) {
        if (!field.access.contains(APublic) && !field.access.contains(AStatic)) field.access.push(APublic);
        nfields.push(field);
      }
    }
    var pos = Context.getLocalClass().get().pos;
    Context.defineModule("imgui._internal." + prefix + ".FlatImpl", module, [
      {
        path: [{ pos: pos, name: "imgui" }, { pos: pos, name: "ImGui" }],
        mode: INormal
      }
    ]);
    return nfields.concat(props);
  }
  
  static function flatten(base: Field, prefix: String, postfix: String):{ type: TypeDefinition, fields: Array<Field>, props: Array<Field> } {
    var ret: Array<Field> = [];
    var cl = Context.getLocalType();
    var localFields: Array<Field> = [];
    var baseName: String;
    var baseType: ComplexType;
    switch (base.kind) {
      case FVar(t, _):
        switch (t.toType().followWithAbstracts()) {
            
          case TAnonymous(_.get().fields => fields), TInst(_.get().fields.get() => fields, _):
            baseName = t.toString().split(".").pop() + "_" + base.name;
            baseType = t;
            var setExprs:Array<Expr> = [];
            var setArgs:Array<FunctionArg> = [];
            var copyExprs: Array<Expr> = [];
            for (f in fields) {
              if (!f.isPublic || f.meta.has(":deprecated") || !f.kind.match(FVar(_, _))) continue;
              var flatName = base.name + "_" + f.name;
              var ct = f.type.toComplexType();
              ret.push({
                name: flatName,
                kind: FVar(ct),
                pos: base.pos,
                doc: f.doc,
                access: [APrivate]
              });
              
              localFields.push({
                name: f.name,
                pos: base.pos,
                kind: FProp("get", "set", ct),
                access: [APublic],
                doc: f.doc
              });
              localFields.push({
                name: "get_" + f.name,
                pos: base.pos,
                kind: FFun({
                  args: [],
                  ret: ct,
                  expr: macro return @:privateAccess this.$flatName
                }),
                access: [APrivate, AInline]
              });
              localFields.push({
                name: "set_" + f.name,
                pos: base.pos,
                kind: FFun({
                  args: [{name: "value", type: ct }],
                  ret: ct,
                  expr: macro return @:privateAccess this.$flatName = value
                }),
                access: [APrivate, AInline]
              });
              var fname = f.name;
              setExprs.push(macro @:privateAccess this.$flatName = $i{fname});
              setArgs.push({ name: f.name, type: ct });
              copyExprs.push(macro @:privateAccess this.$flatName = from.$fname);
            }
            localFields.push({
              name: "set",
              pos: base.pos,
              kind: FFun({
                args: setArgs,
                ret: macro :Void,
                expr: macro $b{setExprs}
              }),
              access: [APublic, AInline]
            });
            localFields.push({
              name: "copyFrom",
              pos: base.pos,
              kind: FFun({
                args: [{ name: "from",  type: t }],
                ret: macro :Void,
                expr: macro $b{copyExprs}
              }),
              access: [APublic, AInline]
            });
          case v:
            trace(v);
            throw "assert";
        }
      default: throw "assert";
    }
    
    var wrapperType = ComplexType.TPath({ pack: ["imgui", "_internal", prefix], name: "FlatImpl", sub: baseName+postfix });
    
    var type: TypeDefinition = {
      pack: ["imgui", "_internal", prefix, "FlatImpl"],
      fields: localFields,
      kind: TDAbstract(cl.toComplexType(), [cl.toComplexType()]),
      pos: base.pos,
      name: baseName+postfix
    };
    return {
      type: type,
      fields: ret,
      props: [
        {
          name: base.name,
          pos: base.pos,
          kind: FProp("get", "never", wrapperType),
          access: [APublic],
          doc: base.doc
        },
        {
          name: "get_" + base.name,
          pos: base.pos,
          kind: FFun({
            args: [],
            expr: macro return (this:$wrapperType)
          }),
          access: [APrivate, AInline]
        }
      ]
    };
  }
  #end
}