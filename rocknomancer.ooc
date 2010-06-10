//use reincarnate

use gtk
import gtk/[Gtk, Window, Button, VBox, Entry, Image]

import source/Tree/[CellRenderer, CellRendererText, ListStore, View, Iter, Model]

create_and_fill_model: func -> ListStore {
  store := ListStore new(2, GType String, GType UInt)
  iter := TreeIter new()

  /* Append a row and fill in some data */
  store append(iter)
  store set(iter, 0, "Heinz El-Mann", 1, 51, -1)
  
  /* append another row and fill in some data */
  store append(iter)
  store set(iter, 0, "Jane Doe", 1, 23, -1)
  
  /* ... and a third row */
  store append(iter)
  store set(iter, 0, "Joe Bungop", 1, 91, -1)
  
  return store
}

create_view_and_model: func -> TreeView {
  view := TreeView new()
  renderer: CellRenderer

  /* --- Column #1 --- */

  renderer = CellRendererText new()
  view insertColumn(-1, "Name", renderer, "text", 0, null);

  /* --- Column #2 --- */

  renderer = CellRendererText new()
  view insertColumn(-1, "Age", renderer, "text", 1, null);

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
