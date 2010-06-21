// GtkTreeView — A widget for displaying both trees and lists
// see http://library.gnome.org/devel/gtk/stable/GtkTreeView.html

use gtk
import gtk/[Gtk, Container]

import source/Tree/[ListStore, CellRenderer, Model, Selection]

TreeView: cover from GtkTreeView* extends Container {
    new: extern(gtk_tree_view_new) static func -> This
    new: extern(gtk_tree_view_new_with_model) static func~withModel (model: TreeModel) -> This
    
    levelIndentation: GInt {
        get: extern(gtk_tree_view_get_level_indentation)
        set: extern(gtk_tree_view_set_level_indentation)
    }
    
    showExpanders: GBool {
        get: extern(gtk_tree_view_get_show_expanders)
        set: extern(gtk_tree_view_set_show_expanders)
    }
    
    model: TreeModel {
        get: extern(gtk_tree_view_get_model)
        set: extern(gtk_tree_view_set_model)
    }
    
    selection: TreeSelection {
        get: extern(gtk_tree_view_get_selection)
    }
    
    // H/V adjust goes here
    
    headersVisible?: GBool {
        get: extern(gtk_tree_view_get_headers_visible)
        set: extern(gtk_tree_view_set_headers_visible)
    }
    
    columnsAutosize: extern(gtk_tree_view_columns_autosize) func
    
    headersClickable?: GBool {
        get: extern(gtk_tree_view_get_headers_clickable)
        set: extern(gtk_tree_view_set_headers_clickable)
    }
    
    rulesHint: GBool {
        get: extern(gtk_tree_view_get_rules_hint)
        set: extern(gtk_tree_view_set_rules_hint)
    }
    
    // append/remove/insert_column goes here, once we have TreeViewColumn
    
    insertColumn: extern(gtk_tree_view_insert_column_with_attributes) func~withAttributes (position: GInt, title: GString, cell: CellRenderer, ...)
    
    // insert_col_with_data_func, get_col, get_columns, move_col_after, expander_col, col_drag_func
    
    scrollTo: extern(gtk_tree_view_scroll_to_point) func~point (x, y: GInt)
    // scrollTo~cell
    
    // set_cursor, set_cursor_on_cell, get_cursor, row_activated
    
    expandAll: extern(gtk_tree_view_expand_all) func
    collapseAll: extern(gtk_tree_view_collapse_all) func
    
    // expand_to_path, expand_row, collapse_row (figure out what TreePath is)
    // map_expanded_rows, row_expanded
    
    reorderable?: GBool {
        get: extern(gtk_tree_view_get_reorderable)
        set: extern(gtk_tree_view_set_reorderable)
    }
    
    // path_at_pos, cell_area, bg_area, visible_rect, visible_range
    // *_coords

    rubberBanding: GBool {
        get: extern(gtk_tree_view_get_rubber_banding)
        set: extern(gtk_tree_view_set_rubber_banding)
    }
    rubberBandingActive?: extern(gtk_tree_view_is_rubber_banding_active) func -> GBool

    treeLines?: GBool {
        get: extern(gtk_tree_view_get_enable_tree_lines)
        set: extern(gtk_tree_view_set_enable_tree_lines)
    }
    // grid_lines
    
    // tooltip_*
}
