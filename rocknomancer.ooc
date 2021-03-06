use reincarnate
import reincarnate/App

app := App new()

use gtk
import gtk/Gtk

import structs/ArrayList

import source/[MainWindow, PackageWindow]

main: func {
    mainWindow := MainWindow new(app)
    
    Gtk main()
}
