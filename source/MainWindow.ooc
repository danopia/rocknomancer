use reincarnate
import reincarnate/App

use gtk
import gtk/[Gtk, Window, Button, VBox, Label]

import source/Tree/ListStore
import source/ListView

import source/Menu/[Bar, Item, Menu]

import structs/ArrayList

MainWindow: class {
  app: App
  
  wnd: Window
  mnuBar: MenuBar
  mnuFile, mnuEdit, mnuHelp: Menu
  box: VBox
  lblInstalled: Label
  lstInstalled: ListView
  btnClose: Button
  
  init: func (=app) {
    // Create the widgets
    
    mnuFile = Menu new().
      append(MenuItem new("New")).
      append(MenuItem new("Save")).
      append(MenuItem new("Close")).
      append(MenuItem new("Exit"))
    
    mnuEdit = Menu new().
      append(MenuItem new("Undo")).
      append(MenuItem new("Redo"))
    
    mnuHelp = Menu new().
      append(MenuItem new("Online docs")).
      append(MenuItem new("About"))
    
    mnuBar = MenuBar new().
      append(MenuItem new("File", mnuFile)).
      append(MenuItem new("Edit", mnuEdit)).
      append(MenuItem new("Help", mnuHelp))
    
    lblInstalled = Label new("Installed packages:")
    
    lstInstalled = ListView new().
      addColumn("Package", GType String).
      addColumn("Version", GType String).
      addColumn("Variant", GType String).
      setup()
    populateList()
    
    btnClose = Button new("gtk-close").
      connect("clicked", exit)
    
    // Lay them out
    box = VBox new(false, 8).
      packStart(mnuBar, false, false, 0).
      packStart(lblInstalled, false, false, 0).
      packStart(lstInstalled view, true, true, 0).
      packStart(btnClose, false, false, 0)
    
    // Create window
    wnd = Window new("Rocknomancer Package Manager").
      setUSize(200, 300).
      connect("delete_event", exit).
      setBorderWidth(8).
      add(box).
      showAll()
  }
  
  populateList: func {
    for (info: ArrayList<String> in app installedPackages()) {
      lstInstalled addRow(info)
    }
  }
}

exit: extern func



/*

entry: Entry

// Using this until yajit supports 64-bit platforms
handler: func {
    "You tricked me 1!" println()
    entry text println()
}

main: func {
    win := Window new("Rocknomancer Package Manager")
    win setUSize(400, 550)
    win connect("delete_event", exit)
    
    box := VBox new(true, 16)
    
    entry = Entry new()
    box add(entry)
    
    button := Button new("Click me 1!")
    button connect("clicked", handler) // .setBorderWidth(50)
    
    box add(button)
    
    button2 := Button new("Click me 2!")
    button2 connect("clicked", func {
        "You tricked me 2!" println()
    })
    
    box add(button2)
    
    win setBorderWidth(16)
    win add(box)
    win showAll()
    Gtk main()
}

exit: extern func
*/
