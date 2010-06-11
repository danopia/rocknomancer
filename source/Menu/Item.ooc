// GtkMenuItem — The widget used for item in menus
// see http://library.gnome.org/devel/gtk/stable/GtkMenuItem.html

use gtk
import gtk/[Gtk, Container, Widget]

import source/Menu/Menu

MenuItem: cover from GtkMenuItem* extends Container {
  new: extern(gtk_menu_item_new) static func -> This
  //new: extern(gtk_menu_item_new_with_label) static func~withLabel (label: GString) -> This
  new: extern(gtk_menu_item_new_with_mnemonic) static func~withMnemonic (label: GString) -> This
  
  new: static func~withLabelAndChild (label: GString, child: Menu) -> This {
    item := new(label)
    item submenu = child
    item
  }
  
  rightJustified: GBool {
    get: extern(gtk_menu_item_get_right_justified)
    set: extern(gtk_menu_item_set_right_justified)
  }
  
  label: GString {
    get: extern(gtk_menu_item_get_label)
    set: extern(gtk_menu_item_set_label)
  }
  
  underlined?: GBool {
    get: extern(gtk_menu_item_get_use_underline)
    set: extern(gtk_menu_item_set_use_underline)
  }
  
  submenu: Menu {
    get: extern(gtk_menu_item_get_submenu)
    set: extern(gtk_menu_item_set_submenu)
  }
  
  accelPath: GString {
    get: extern(gtk_menu_item_get_accel_path)
    set: extern(gtk_menu_item_set_accel_path)
  }
  
  
  select: extern(gtk_menu_item_select) func
  deselect: extern(gtk_menu_item_deselect) func
  activate: extern(gtk_menu_item_activate) func
}
