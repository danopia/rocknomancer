// GtkTreeSelection — The selection object for GtkTreeView
// see http://library.gnome.org/devel/gtk/stable/GtkTreeSelection.html

use gtk
import gtk/[Gtk, _GObject]

import source/Tree/[View, Path, Iter, Model]

TreeSelection: cover from GtkTreeSelection* extends _GObject {
  
  mode: GtkSelectionMode {
    get: extern(gtk_tree_selection_get_mode)
    set: extern(gtk_tree_selection_set_mode)
  }
  
  // selectFunction, userData
  
  view: TreeView { get: extern(gtk_tree_selection_get_tree_view) }
  
  getSingle: extern(gtk_tree_selection_get_selected) func (model: TreeModel*, iter: TreeIter) -> GBool
}

GtkSelectionMode: extern enum
{
  none: extern(GTK_SELECTION_NONE) // Nothing can be selected
  single: extern(GTK_SELECTION_SINGLE)
  browse: extern(GTK_SELECTION_BROWSE)
  multiple: extern(GTK_SELECTION_MULTIPLE)
  extended: extern(GTK_SELECTION_EXTENDED) // Deprecated
}
