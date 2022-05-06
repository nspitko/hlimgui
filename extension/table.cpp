#include "utils.h"

HL_PRIM bool HL_NAME(begin_table)(vstring *id, int column, ImGuiTableFlags *flags, vimvec2 *outer_size, float *inner_width)
{
    return ImGui::BeginTable( convertString( id ), column, convertPtr( flags, 0 ), getImVec2( outer_size ), convertPtr( inner_width, 0.0f ) );
}

HL_PRIM void HL_NAME(end_table)()
{
    ImGui::EndTable();
}

HL_PRIM void HL_NAME(table_next_row)( ImGuiTableRowFlags *row_flags, float *min_row_height )
{
     ImGui::TableNextRow( convertPtr( row_flags, 0 ), convertPtr( min_row_height, 0.0f ) );
}

HL_PRIM void HL_NAME(table_next_column)()
{
    ImGui::TableNextColumn();
}

HL_PRIM void HL_NAME(table_set_column_index)(int column_index)
{
    ImGui::TableSetColumnIndex(column_index);
}

HL_PRIM void HL_NAME(table_setup_column)( vstring *id, ImGuiTableColumnFlags *flags, float *init_width_or_weight, ImGuiID *user_id )
{
    ImGui::TableSetupColumn( convertString(id), convertPtr(flags, 0), convertPtr(init_width_or_weight, 0.0f), convertPtr(user_id, 0 ) );
}

HL_PRIM void HL_NAME(table_setup_scroll_freeze)(int cols, int rows )
{
    ImGui::TableSetupScrollFreeze(cols, rows);
}

HL_PRIM void HL_NAME(table_headers_row)()
{
    ImGui::TableHeadersRow();
}

HL_PRIM void HL_NAME(table_header)( vstring *id )
{
    ImGui::TableHeader( convertString( id ) );
}

HL_PRIM ImGuiTableSortSpecs* HL_NAME(table_get_sort_specs)( vstring *id )
{
    return ImGui::TableGetSortSpecs();
}

HL_PRIM int HL_NAME(table_get_column_count)()
{
    return ImGui::TableGetColumnCount();
}

HL_PRIM int HL_NAME(table_get_column_index)()
{
    return ImGui::TableGetColumnIndex();
}

HL_PRIM int HL_NAME(table_get_row_index)()
{
    return ImGui::TableGetRowIndex();
}

HL_PRIM vbyte* HL_NAME(table_get_column_name)( int *column_n )
{
    return getVByteFromCStr( ImGui::TableGetColumnName( convertPtr( column_n, -1 ) ) );
}

HL_PRIM ImGuiTableColumnFlags HL_NAME(table_get_column_flags)()
{
    return ImGui::TableGetColumnFlags();
}

HL_PRIM void HL_NAME(table_set_column_enabled)( int column_n, bool enabled )
{
    ImGui::TableSetColumnEnabled( column_n, enabled );
}

HL_PRIM void HL_NAME(table_set_bgcolor)( ImGuiTableBgTarget target, ImU32 color, int *column_n )
{
    ImGui::TableSetBgColor( target, color, convertPtr( column_n, -1 ) );
}

#define _TIMTSORTSPECS _ABSTRACT(imtablesortspecs)

DEFINE_PRIM(_BOOL, begin_table, _STRING _I32 _REF(_I32) _IMVEC2 _REF(_I32));
DEFINE_PRIM(_VOID, end_table, _NO_ARG);
DEFINE_PRIM(_VOID, table_next_row, _REF(_I32) _REF(_F32) );
DEFINE_PRIM(_VOID, table_next_column, _NO_ARG);
DEFINE_PRIM(_VOID, table_set_column_index, _I32 );
DEFINE_PRIM(_VOID, table_setup_column, _STRING _REF(_I32) _REF(_F32) _REF(_I32) );
DEFINE_PRIM(_VOID, table_setup_scroll_freeze, _I32 _I32 );
DEFINE_PRIM(_VOID, table_headers_row, _NO_ARG );
DEFINE_PRIM(_VOID, table_header, _STRING );
DEFINE_PRIM(_TIMTSORTSPECS, table_get_sort_specs, _STRING );
DEFINE_PRIM(_I32, table_get_column_count, _NO_ARG );
DEFINE_PRIM(_I32, table_get_column_index, _NO_ARG );
DEFINE_PRIM(_I32, table_get_row_index, _NO_ARG );
DEFINE_PRIM(_STRING, table_get_column_name, _NO_ARG );
DEFINE_PRIM(_I32, table_get_column_flags, _NO_ARG );
DEFINE_PRIM(_VOID, table_set_column_enabled, _I32 _BOOL );
DEFINE_PRIM(_VOID, table_set_bgcolor, _I32 _I32 _REF(_I32) );

