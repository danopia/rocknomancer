use reincarnate
import reincarnate/App

app := App new()

use gtk
import gtk/Gtk

import structs/ArrayList

import source/MainWindow

main: func {
    mainWindow := MainWindow new(app)
    Gtk main()
}
