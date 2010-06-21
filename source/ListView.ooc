use gtk
import gtk/Gtk

import source/Tree/[CellRenderer, CellRendererText, ListStore, View, Iter, Model, Selection]

import structs/ArrayList

ListView: class {
  columns := ArrayList<String> new()
  columnTypes := ArrayList<GtkType> new()
  store: ListStore
  view: TreeView
  
  addColumn: func (label: String, type: GtkType) {
    columns add(label)
    columnTypes add(type)
  }
  
  setup: func {
    store = ListStore new(columns size(), columnTypes toArray())
    view = TreeView new(store)
    
    index := 0
    for (column in columns) {
      renderer: CellRenderer = CellRendererText new()
      view insertColumn(-1, column, renderer, "text", index, null)
      
      index += 1
    }
    
    view selection mode = GtkSelectionMode single
  }
  
  addRow: func (cells: ArrayList<String>) {
    iter := TreeIter new()

    store append(iter)
    index := 0
    //values := ArrayList<GtkValue> new(cells size)
    for (cell in cells) {
      value := GtkValue new(columnTypes[index], cell& as Pointer)
      store set(iter, index, value)
      index += 1
    }
  }
  
  selectedRow: func -> TreeIter {
    iter := TreeIter new()
    view selection getSingle((store toModel())&, iter) toString() println()
    iter
  }
}
