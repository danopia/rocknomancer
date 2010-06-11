use reincarnate
import reincarnate/[App, Package, Usefile]

use gtk
import gtk/[Gtk, Window, Button, VBox, Label]

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
  btnClose: Button
  
  init: func~fromString (.app, name: String) {
    usefile := app yard getUsefile(name)
    init(app, usefile)
  }
  
  init: func (=app, =usefile) {
    // Create the widgets
    
    lblPackage = Label new("Installed packages:")
    
    lstPackage = ListView new().
      addColumn("Package", GType String).
      addColumn("Version", GType String).
      setup()
    lstPackage view headersVisible? = false
    populateList()
    
    btnClose = Button new("gtk-close").
      connect("clicked", close)
    
    // Lay them out
    box = VBox new(false, 8).
      packStart(lblPackage, false, false, 0).
      packStart(lstPackage view, true, true, 0).
      packStart(btnClose, false, false, 0)
    
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
  
  close: func {
    wnd destroy()
  }
}
