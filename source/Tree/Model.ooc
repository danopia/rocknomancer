// GtkTreeModel — The tree interface used by GtkTreeView
// see http://library.gnome.org/devel/gtk/stable/GtkTreeModel.html

use gtk
import gtk/[Gtk, _GObject]

import source/Tree/[Iter, Path, ListStore] // ListStore for GType

TreeModel: cover from GtkTreeModel* extends _GObject {
  
  flags: GtkTreeModelFlags {
    get: extern(gtk_tree_model_get_flags)
  }
  
  columnCount: GInt {
    get: extern(gtk_tree_model_get_n_columns)
  }
  
  getColumnType: extern(gtk_tree_model_get_column_type) func (index: GInt) -> GType
  getIter: extern(gtk_tree_model_get_iter) func (iter: TreeIter, path: TreePath) -> GBool
  getIter: extern(gtk_tree_model_get_iter_from_string) func~fromString (iter: TreeIter, path_string: GString) -> GBool
  getPath: extern(gtk_tree_model_get_path) func (iter: TreeIter) -> TreePath
  getValue: extern(gtk_tree_model_get_value) func (iter: TreeIter, column: GInt, value: GtkValue*)
  firstIter: extern(gtk_tree_model_get_iter_first) func (iter: TreeIter) -> GBool
  nextIter: extern(gtk_tree_model_iter_next) func (iter: TreeIter) -> GBool
  iterChildren: extern(gtk_tree_model_iter_children) func (iter, parent: TreeIter) -> GBool
  iterHasChild?: extern(gtk_tree_model_iter_has_child) func (iter: TreeIter) -> GBool
  iterChildCount: extern(gtk_tree_model_iter_n_children) func (iter: TreeIter) -> GInt
  iterGetChild: extern(gtk_tree_model_iter_nth_child) func (iter, parent: TreeIter, index: GInt) -> GBool
  iterParent: extern(gtk_tree_model_iter_parent) func (iter, child: TreeIter) -> GBool
  refNode: extern(gtk_tree_model_ref_node) func (iter: TreeIter)
  unrefNode: extern(gtk_tree_model_unref_node) func (iter: TreeIter)
  get: extern(gtk_tree_model_get) func (iter: TreeIter, ...)
  // get_valist, foreach, row_* signals
}

GtkTreeModelFlags: extern enum {
  itersPersist: extern(GTK_TREE_MODEL_ITERS_PERSIST)
  listOnly:     extern(GTK_TREE_MODEL_LIST_ONLY)
}

GtkValue: cover from GValue {}
