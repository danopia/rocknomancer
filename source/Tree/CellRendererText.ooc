// GtkCellRendererText — Renders text in a cell
// see http://library.gnome.org/devel/gtk/stable/GtkCellRendererText.html

use gtk
import gtk/Gtk

import source/Tree/CellRenderer

CellRendererText: cover from GtkCellRendererText* extends CellRenderer {
    new: extern(gtk_cell_renderer_text_new) static func -> This
    
    fixedHeightFromFont: GInt {
      set: extern(gtk_cell_renderer_text_set_fixed_height_from_font)
    }
}
