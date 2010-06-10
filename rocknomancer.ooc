use reincarnate
import reincarnate/App

app := App new()

use gtk
import gtk/[Gtk, Window, Button, VBox, Entry, Image]

import source/Tree/[CellRenderer, CellRendererText, ListStore, View, Iter, Model]

import structs/ArrayList

create_and_fill_model: func -> ListStore {
  store := ListStore new(3, GType String, GType String, GType String)
  iter := TreeIter new()

  for (info: ArrayList<String> in app installedPackages()) {
    store append(iter)
    store set(iter, 0, info[0], 1, info[1], 2, info[2], -1)
  }
  
  return store
}

create_view_and_model: func -> TreeView {
  view := TreeView new()
  renderer: CellRenderer

  /* --- Column #1 --- */

  renderer = CellRendererText new()
  view insertColumn(-1, "Package", renderer, "text", 0, null);

  /* --- Column #2 --- */

  renderer = CellRendererText new()
  view insertColumn(-1, "Version", renderer, "text", 1, null);

  /* --- Column #2 --- */

  renderer = CellRendererText new()
  view insertColumn(-1, "Variant", renderer, "text", 2, null);

  view model = create_and_fill_model()

  /* The tree view has acquired its own reference to the
   *  model, so we can drop ours. That way the model will
   *  be freed automatically when the tree view is destroyed */

  //g_object_unref(model)

  return view
}

main: func {
    win := Window new("Rocknomancer Package Manager")
    win setUSize(400, 550)
    win connect("delete_event", exit)
    
    view := create_view_and_model()

    win setBorderWidth(16)
    win add(view)
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
