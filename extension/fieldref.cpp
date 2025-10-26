#include "utils.h"

/**
	Extra hack: Obtain a pointer to the `field` inside an `obj`. A crutch to HL inability to support field pointers.
	
	Modified version of hl_dyn_getp and corresponding private methods.
**/
hl_field_lookup* obj_resolve_field( hl_type_obj *o, int hfield ) {
	hl_runtime_obj *rt = o->rt;
	do {
		hl_field_lookup *f = hl_lookup_find(rt->lookup,rt->nlookup,hfield);
		if( f ) return f;
		rt = rt->parent;
	} while( rt );
	return NULL;
}

void* get_obj_field(vdynamic*d, int hfield) {
	switch( d->t->kind ) {
		case HDYNOBJ:
			{
				vdynobj *o = (vdynobj*)d;
				hl_field_lookup *f = hl_lookup_find(o->lookup,o->nfields,hfield);
				if( f == NULL ) return nullptr;
				return hl_is_ptr(f->t) ? (void*)(o->values + f->field_index) : (void*)(o->raw_data + f->field_index);
			}
			break;
		case HOBJ:
			{
				hl_field_lookup *f = obj_resolve_field(d->t->obj,hfield);
				if( f == NULL || f->field_index < 0 ) return nullptr;
				return (void*)((char*)d + f->field_index);
			}
			break;
		case HSTRUCT:
			{
				hl_field_lookup *f = obj_resolve_field(d->t->obj,hfield);
				if( f == NULL || f->field_index < 0 ) return nullptr;
				return (void*)((char*)d->v.ptr + f->field_index);
			}
			break;
		case HVIRTUAL:
			{
				vdynamic *v = ((vvirtual*)d)->value;
				hl_field_lookup *f;
				if( v )
					return get_obj_field(v, hfield);
				f = hl_lookup_find(d->t->virt->lookup,d->t->virt->nfields,hfield);
				if( f == NULL ) return nullptr;
				return (void*)((char*)d + d->t->virt->indexes[f->field_index]);
			}
		default:
			throw_error("Invalid field access");
			break;
	}
	return nullptr;
}

// vstring* is 2-char wide
HL_PRIM int hl_hash_vstring( uchar* name ) {
	int h = 0;
	// ASCII should be enough
	while( *name ) {
		h = 223 * h + (unsigned)*name;
		name++;
	}
	h %= 0x1FFFFF7B;
	return h;
}

HL_PRIM void* HL_NAME(fieldref_hash)(vdynamic* d, int hfield) {
	return get_obj_field(d, hfield);
}

HL_PRIM void* HL_NAME(fieldref)(vdynamic* d, vstring* field) {
	if (field == nullptr) return d;
	return get_obj_field(d, hl_hash_vstring(field->bytes));
}

HL_PRIM void* HL_NAME(fieldref_dyn)(vdynamic* d, vstring* field) {
    if (field == nullptr) return d;
    return get_obj_field(d, hl_hash_vstring(field->bytes));
}

HL_PRIM void* HL_NAME(fieldref_i8)(vdynamic* d, vstring* field) {
	if (field == nullptr) return d;
    return get_obj_field(d, hl_hash_vstring(field->bytes));
}

HL_PRIM void* HL_NAME(fieldref_i16)(vdynamic* d, vstring* field) {
	if (field == nullptr) return d;
    return get_obj_field(d, hl_hash_vstring(field->bytes));
}

HL_PRIM void* HL_NAME(fieldref_i32)(vdynamic* d, vstring* field) {
	if (field == nullptr) return d;
    return get_obj_field(d, hl_hash_vstring(field->bytes));
}

HL_PRIM void* HL_NAME(fieldref_i64)(vdynamic* d, vstring* field) {
	if (field == nullptr) return d;
    return get_obj_field(d, hl_hash_vstring(field->bytes));
}

HL_PRIM void* HL_NAME(fieldref_f32)(vdynamic* d, vstring* field) {
	if (field == nullptr) return d;
    return get_obj_field(d, hl_hash_vstring(field->bytes));
}

HL_PRIM void* HL_NAME(fieldref_f64)(vdynamic* d, vstring* field) {
	if (field == nullptr) return d;
    return get_obj_field(d, hl_hash_vstring(field->bytes));
}

HL_PRIM void* HL_NAME(fieldref_bool)(vdynamic* d, vstring* field) {
	if (field == nullptr) return d;
    return get_obj_field(d, hl_hash_vstring(field->bytes));
}

HL_PRIM void* HL_NAME(fieldref_bytes)(vdynamic* d, vstring* field) {
	if (field == nullptr) return d;
    return get_obj_field(d, hl_hash_vstring(field->bytes));
}

DEFINE_PRIM(_REF(_DYN), fieldref_dyn, _DYN _STRING);
DEFINE_PRIM(_REF(_I8), fieldref_i8, _DYN _STRING);
DEFINE_PRIM(_REF(_I16), fieldref_i16, _DYN _STRING);
DEFINE_PRIM(_REF(_I32), fieldref_i32, _DYN _STRING);
DEFINE_PRIM(_REF(_I64), fieldref_i64, _DYN _STRING);
DEFINE_PRIM(_REF(_F32), fieldref_f32, _DYN _STRING);
DEFINE_PRIM(_REF(_F64), fieldref_f64, _DYN _STRING);
DEFINE_PRIM(_REF(_BOOL), fieldref_bool, _DYN _STRING);
DEFINE_PRIM(_REF(_BYTES), fieldref_bytes, _DYN _STRING);
