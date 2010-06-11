use reincarnate
import reincarnate/[App, Package, Usefile]

use gtk
import gtk/[Gtk, Window, Button, VBox, HBox, Label]

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
      addColumn("Package", GType String).
      addColumn("Version", GType String).
      setup()
    lstPackage view headersVisible? = false
    populateList()
    
    // Create buttons
    btnUpdate = Button new("Update").
      connect("clicked", update)
      
    btnReinstall = Button new("Reinstall").
      connect("clicked", reinstall)
      
    btnRemove = Button new("Uninstall").
      connect("clicked", remove)
    
    btnClose = Button new("gtk-close").
      connect("clicked", close)
    
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
  
  update: func {
    app update(usefile["_Slug"])
  }
  
  remove: func {
    app remove(usefile["_Slug"])
    close()
  }
  
  reinstall: func {
    app remove(usefile["_Slug"])
    app install(usefile["_Slug"])
  }
  
  close: func {
    wnd destroy()
  }
}
