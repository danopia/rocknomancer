use gtk
import gtk/Gtk

import source/Tree/[CellRenderer, CellRendererText, ListStore, View, Iter, Model]

import structs/ArrayList

ListView: class {
  columns := ArrayList<String> new()
  columnTypes := ArrayList<GType> new()
  store: ListStore
  view: TreeView
  
  addColumn: func (label: String, type: GType) {
    columns add(label)
    columnTypes add(type)
    version(64) { columnTypes add(0) }
  }
  
  setup: func {
    store = ListStore new(columns size(), columnTypes toArray())
    "2" println()
    view = TreeView new(store)
    "3" println()
    
    index := 0
    for (column in columns) {
      renderer: CellRenderer = CellRendererText new()
      view insertColumn(-1, column, renderer, "text", index, null)
      
      index += 1
    }
  }
  
  addRow: func (cells: ArrayList<String>) {
    iter := TreeIter new()

    store append(iter)
    index := 0
    index2 := 0
    //values := ArrayList<GtkValue> new(cells size)
    for (cell in cells) {
      value := GtkValue new(columnTypes[index2], cell& as Pointer)
      store set(iter, index, value)
      index += 1
      index2 += 1
      version(64) { index2 += 1 }
    }
  }
}
