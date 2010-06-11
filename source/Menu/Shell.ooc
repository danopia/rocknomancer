// GtkMenuShell — A base class for menu objects
// see http://library.gnome.org/devel/gtk/stable/GtkMenuShell.html

use gtk
import gtk/[Gtk, Container, Widget]

MenuShell: cover from GtkMenuShell* extends Container {

  append: extern(gtk_menu_shell_append) func (child: Widget)
  prepend: extern(gtk_menu_shell_prepend) func (child: Widget)
  insert: extern(gtk_menu_shell_insert) func (child: Widget, position: GInt)
  
  deactivate: extern(gtk_menu_shell_deactivate) func
  
  select: extern(gtk_menu_shell_select_item) func~item (item: Widget)
  select: extern(gtk_menu_shell_select_first) func~first (findSensitive: GBool)
  deselect: extern(gtk_menu_shell_deselect) func
  activate: extern(gtk_menu_shell_activate_item) func (item: Widget, forceDeactivate: GBool) // force the deactivation of the menu shell after the menu item is activated
  cancel: extern(gtk_menu_shell_cancel) func // Cancels the selection within the menu shell
  
  takeFocus: GBool {
    get: extern(gtk_menu_shell_get_take_focus)
    set: extern(gtk_menu_shell_set_take_focus)
  }
}

GtkMenuDirectionType: extern enum
{
  parent: extern(GTK_MENU_DIR_PARENT)
  child:  extern(GTK_MENU_DIR_CHILD)
  next:   extern(GTK_MENU_DIR_NEXT)
  prev:   extern(GTK_MENU_DIR_PREV)
}
