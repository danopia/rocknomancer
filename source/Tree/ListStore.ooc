// GtkListStore — A list-like data structure that can be used with the GtkTreeView
// see http://library.gnome.org/devel/gtk/stable/GtkListStore.html

use gtk
import gtk/Gtk

import source/Tree/[Model, Iter]

ListStore: cover from GtkListStore* extends TreeModel {
    //new: extern(gtk_list_store_new) static func (count: GInt, ...) -> This
    new: extern(gtk_list_store_newv) static func (count: GInt, types: GtkType*) -> This
    
    // Big ol' block of externs :D
    setColumnTypes: extern(gtk_list_store_set_column_types) func (count: GInt, types: GtkType*)
    set: extern(gtk_list_store_set) func (iter: TreeIter, ...)
    set: extern(gtk_list_store_set_value) func~value (iter: TreeIter, column: GInt, value: GtkValue*)
    set: extern(gtk_list_store_set_valuesv) func~values (iter: TreeIter, columns: GInt*, values: GtkValue*, count: GInt)
    remove: extern(gtk_list_store_remove) func (iter: TreeIter)
    insert: extern(gtk_list_store_insert) func (iter: TreeIter, position: GInt)
    insertBefore: extern(gtk_list_store_insert_before) func (iter, sibling: TreeIter)
    insertAfter: extern(gtk_list_store_insert_after) func (iter, sibling: TreeIter)
    prepend: extern(gtk_list_store_prepend) func (iter: TreeIter)
    append: extern(gtk_list_store_append) func (iter: TreeIter)
    clear: extern(gtk_list_store_clear) func
    iterIsValid?: extern(gtk_list_store_iter_is_valid) func (iter: TreeIter)
    reorder: extern(gtk_list_store_reorder) func (newOrder: GInt)
    swap: extern(gtk_list_store_swap) func (a, b: TreeIter)
    moveBefore: extern(gtk_list_store_move_before) func (iter, position: TreeIter)
    moveAfter: extern(gtk_list_store_move_after) func (iter, position: TreeIter)
    
    toModel: extern(GTK_TREE_MODEL) func -> TreeModel
}

GtkType: cover from GType extends Pointer {
  Invalid:    static extern(G_TYPE_INVALID) GtkType
  None:       static extern(G_TYPE_NONE) GtkType
  Interface:  static extern(G_TYPE_INTERFACE) GtkType
  Char:       static extern(G_TYPE_CHAR) GtkType
  UChar:      static extern(G_TYPE_UCHAR) GtkType
  Boolean:    static extern(G_TYPE_BOOLEAN) GtkType
  Int:        static extern(G_TYPE_INT) GtkType
  UInt:       static extern(G_TYPE_UINT) GtkType
  Long:       static extern(G_TYPE_LONG) GtkType
  ULong:      static extern(G_TYPE_ULONG) GtkType
  Int64:      static extern(G_TYPE_INT64) GtkType
  UInt64:     static extern(G_TYPE_UINT64) GtkType
  Enum:       static extern(G_TYPE_ENUM) GtkType
  Flags:      static extern(G_TYPE_FLAGS) GtkType
  Float:      static extern(G_TYPE_FLOAT) GtkType
  Double:     static extern(G_TYPE_DOUBLE) GtkType
  String:     static extern(G_TYPE_STRING) GtkType
  Pointer:    static extern(G_TYPE_POINTER) GtkType
  Boxed:      static extern(G_TYPE_BOXED) GtkType
  Param:      static extern(G_TYPE_PARAM) GtkType
  Object:     static extern(G_TYPE_OBJECT) GtkType
  GtkType:    static extern(G_TYPE_GTYPE) GtkType
}
