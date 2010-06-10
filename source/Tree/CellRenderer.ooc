// GtkCellRenderer — An object for rendering a single cell on a GdkDrawable
// see http://library.gnome.org/devel/gtk/stable/GtkCellRenderer.html

use gtk
import gtk/[Gtk, _GObject]

CellRenderer: cover from GtkCellRenderer* extends _GObject {

    visible: GBool {
      get: extern(gtk_cell_renderer_get_visible)
      set: extern(gtk_cell_renderer_set_visible)
    }
    
    sensitive: GBool {
      get: extern(gtk_cell_renderer_get_sensitive)
      set: extern(gtk_cell_renderer_set_sensitive)
    }
}
