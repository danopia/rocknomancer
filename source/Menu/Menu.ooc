// GtkMenu — A menu widget
// see http://library.gnome.org/devel/gtk/stable/GtkMenu.html

use gtk
import gtk/[Gtk, Widget]

import source/Menu/[Shell, Item]

Menu: cover from GtkMenu* extends MenuShell {
  new: extern(gtk_menu_new) static func -> This
  
  // screen
  
  reorderChild: extern(gtk_menu_reorder_child) func (child: Widget, position: GInt)
  attach: extern(gtk_menu_attach) func (child: Widget, leftAttach, rightAttach, topAttach, bottomAttach: GUInt)
  popup: extern(gtk_menu_popup) func (parentShell: MenuShell, parentItem: MenuItem, function: Func, data: GPointer, button, activateTime: GUInt) // (menu: Menu, x, y: GInt*, pushIn: GBool*, userData: GPointer) || last should be GUInt32
  popdown: extern(gtk_menu_popdown) func
  reposition: extern(gtk_menu_reposition) func
  // accelGroup, accelPath
  
  attachToWidget: extern(gtk_menu_attach_to_widget) func (attachWidget: Widget, detacher: Func) // (attachWidget: Widget, menu: Menu)
  detach: extern(gtk_menu_detach) func
  attachedWidget: Widget { get: extern(gtk_menu_get_attach_widget) }
  // GList* gtk_menu_get_for_attach_widget (GtkWidget *widget)
  
  getActive: extern(gtk_menu_get_active) func -> Widget
  setActive: extern(gtk_menu_set_active) func (index: GUInt)
  
  title: GString {
    get: extern(gtk_menu_get_title)
    set: extern(gtk_menu_set_title)
  }
  
  monitor: GInt {
    get: extern(gtk_menu_get_monitor)
    set: extern(gtk_menu_set_monitor)
  }
  
  toreoff?: GBool {
    get: extern(gtk_menu_get_tearoff_state)
    set: extern(gtk_menu_set_tearoff_state)
  }
  
  reserveToggleSize?: GBool {
    get: extern(gtk_menu_get_reserve_toggle_size)
    set: extern(gtk_menu_set_reserve_toggle_size)
  }
  
  
  popup: func~short (button: GUInt, activateTime: GUInt) { // last should be GUInt32
    popup(null, null, null, null, button, activateTime)
  }
}
