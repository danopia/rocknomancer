// GtkListStore — A list-like data structure that can be used with the GtkTreeView
// see http://library.gnome.org/devel/gtk/stable/GtkListStore.html

use gtk
import gtk/Gtk

import source/Tree/[Model, Iter]

ListStore: cover from GtkListStore* extends TreeModel {
    new: extern(gtk_list_store_new) static func (count: GInt, ...) -> This
    
    // Big ol' block of externs :D
    setColumnTypes: extern(gtk_list_store_set_column_types) func (count: GInt, types: GType*)
    set: extern(gtk_list_store_set) func (iter: TreeIter, ...)
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
}

GType: extern enum {
  Invalid:    extern(G_TYPE_INVALID)
  None:       extern(G_TYPE_NONE)
  Interface:  extern(G_TYPE_INTERFACE)
  Char:       extern(G_TYPE_CHAR)
  UChar:      extern(G_TYPE_UCHAR)
  Boolean:    extern(G_TYPE_BOOLEAN)
  Int:        extern(G_TYPE_INT)
  UInt:       extern(G_TYPE_UINT)
  Long:       extern(G_TYPE_LONG)
  ULong:      extern(G_TYPE_ULONG)
  Int64:      extern(G_TYPE_INT64)
  UInt64:     extern(G_TYPE_UINT64)
  Enum:       extern(G_TYPE_ENUM)
  Flags:      extern(G_TYPE_FLAGS)
  Float:      extern(G_TYPE_FLOAT)
  Double:     extern(G_TYPE_DOUBLE)
  String:     extern(G_TYPE_STRING)
  Pointer:    extern(G_TYPE_POINTER)
  Boxed:      extern(G_TYPE_BOXED)
  Param:      extern(G_TYPE_PARAM)
  Object:     extern(G_TYPE_OBJECT)
  GType:      extern(G_TYPE_GTYPE)
}
