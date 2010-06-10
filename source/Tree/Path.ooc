// GtkTreePath — Points to a child of a tree
// see http://library.gnome.org/devel/gtk/stable/GtkTreeModel.html

use gtk
import gtk/[Gtk, _GObject]

import source/Tree/[Model, Iter]

TreePath: cover from GtkTreePath* extends _GObject {
    new: extern(gtk_tree_path_new) static func -> This
    new: extern(gtk_tree_path_new_from_string) static func~fromString (path: GString) -> This
    new: extern(gtk_tree_path_new_from_indices) static func~fromIndices (firstIndex: GInt, ...) -> This // last is -1
    
    first: extern(gtk_tree_path_new_first) static func -> This
    compare: extern(gtk_tree_path_compare) static func (a, b: This) -> GInt
    
    // Big ol' block of externs :D
    toString: extern(gtk_tree_path_to_string) func -> GString
    appendIndex: extern(gtk_tree_path_append_index) func (index: GInt)
    prependIndex: extern(gtk_tree_path_prepend_index) func (index: GInt)
    depth: GInt { get: extern(gtk_tree_path_get_depth) }
    indices: GInt* { get: extern(gtk_tree_path_get_indices) }
    free: extern(gtk_tree_path_free) func
    clone: extern(gtk_tree_path_copy) func -> TreePath
    next: extern(gtk_tree_path_next) func
    prev: extern(gtk_tree_path_prev) func
    up: extern(gtk_tree_path_up) func
    down: extern(gtk_tree_path_down) func
    ancestor?: extern(gtk_tree_path_is_ancestor) func (descendant: TreePath) -> GBool
    descendant?: extern(gtk_tree_path_is_descendant) func (ancestor: TreePath) -> GBool
}
