// GtkTreeIter — The primary structure for accessing a structure. 
// see http://library.gnome.org/devel/gtk/stable/GtkTreeModel.html

use gtk
import gtk/[Gtk, _GObject]

_GtkTreeIterStruct: cover from GtkTreeIter {
  stamp: extern GInt
  user_data, user_data2, user_data3: extern GPointer
}

TreeIter: cover from _GtkTreeIterStruct* extends _GObject {
  new: static func -> This {
    gc_malloc(_GtkTreeIterStruct size) as This
  }
  
  clone: extern(gtk_tree_iter_copy) func -> This
  free: extern(gtk_tree_iter_free) func
}
