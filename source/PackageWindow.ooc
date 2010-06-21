use reincarnate
import reincarnate/[App, Package, Usefile]

use gtk
import gtk/[Gtk, Widget, Window, Button, VBox, HBox, Label]

import source/Tree/ListStore
import source/ListView

import structs/[ArrayList, HashMap]

PackageWindow: class {
  app: App
  usefile: Usefile
  
  wnd: Window
  box: VBox
  lblPackage: Label
  lstPackage: ListView
  
  boxButtons: HBox
  btnUpdate: Button
  btnReinstall: Button
  btnRemove: Button
  btnClose: Button
  
  init: func~fromString (.app, name: String) {
    usefile := app yard getUsefile(name)
    init(app, usefile)
  }
  
  init: func (=app, =usefile) {
    // Create the widgets
    
    lblPackage = Label new("Package details:")
    
    lstPackage = ListView new().
      addColumn("Package", GtkType String).
      addColumn("Version", GtkType String).
      setup()
    lstPackage view headersVisible? = false
    populateList()
    
    // Create buttons
    btnUpdate = Button new("Update").
      connect("clicked", update, this as Pointer)
      
    btnReinstall = Button new("Reinstall").
      connect("clicked", reinstall, this as Pointer)
      
    btnRemove = Button new("Uninstall").
      connect("clicked", remove, this as Pointer)
    
    btnClose = Button new("gtk-close").
      connect("clicked", close, this as Pointer)
    
    // Lay the buttons out
    boxButtons = HBox new(true, 4).
      add(btnUpdate).
      add(btnReinstall).
      add(btnRemove).
      add(btnClose)
    
    // Lay everything out
    box = VBox new(false, 8).
      packStart(lblPackage, false, false, 0).
      packStart(lstPackage view, true, true, 0).
      packStart(boxButtons, false, false, 0)
    
    // Create window
    wnd = Window new("%s - Package Details" format(usefile["Name"])).
      setUSize(400, 350).
      connect("delete_event", close).
      setBorderWidth(8).
      add(box).
      showAll()
  }
  
  populateList: func {
    for (key: String in usefile keys) {
      lstPackage addRow([key, usefile[key]] as ArrayList<String>)
    }
  }
  
  update: static func (button: Button, this: This) {
    this app update(this usefile["_Slug"] as String)
  }
  
  remove: static func (button: Button, this: This) {
    this app remove(this usefile["_Slug"] as String)
    close(button as Widget, this)
  }
  
  reinstall: static func (button: Button, this: This) {
    this app remove(this usefile["_Slug"] as String)
    this app install(this usefile["_Slug"] as String)
  }
  
  close: static func (trigger: Widget, this: This) {
    this wnd destroy()
  }
}
