// GtkMenuBar — A subclass widget for GtkMenuShell which holds GtkMenuItem widgets
// see http://library.gnome.org/devel/gtk/stable/GtkMenuBar.html

use gtk
import gtk/[Gtk, Widget]

import source/Menu/[Shell, Item]

MenuBar: cover from GtkMenuBar* extends MenuShell {
  new: extern(gtk_menu_bar_new) static func -> This
  
  packDirection: GtkPackDirection {
    get: extern(gtk_menu_bar_get_pack_direction)
    set: extern(gtk_menu_bar_set_pack_direction)
  }
  
  childPackDirection: GtkPackDirection {
    get: extern(gtk_menu_bar_get_child_pack_direction)
    set: extern(gtk_menu_bar_set_child_pack_direction)
  }
}

GtkPackDirection: extern enum
{
  ltr: extern(GTK_PACK_DIRECTION_LTR)
  rtl: extern(GTK_PACK_DIRECTION_RTL)
  ttb: extern(GTK_PACK_DIRECTION_TTB)
  btt: extern(GTK_PACK_DIRECTION_BTT)
}
