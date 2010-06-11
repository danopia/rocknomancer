use reincarnate
import reincarnate/App

app := App new()

use gtk
import gtk/[Gtk, Window, Button, VBox, Label, Image]

import source/Tree/ListStore
import source/ListView

import structs/ArrayList

main: func {
    win := Window new("Rocknomancer Package Manager")
    win setUSize(200, 200)
    win connect("delete_event", exit)
    
    box := VBox new(false, 8)
    
    label := Label new("Installed packages:")
    box packStart(label, false, false, 0)
    
    view := ListView new()
    view addColumn("Package", GType String)
    view addColumn("Version", GType String)
    view addColumn("Variant", GType String)
    view setup()
    
    for (info: ArrayList<String> in app installedPackages()) {
      view addRow(info)
    }
    
    box packStart(view view, true, true, 0)
    
    button := Button new("gtk-close")
    box packStart(button, false, false, 0)

    win setBorderWidth(8)
    win add(box)
    win showAll()
    Gtk main()
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
