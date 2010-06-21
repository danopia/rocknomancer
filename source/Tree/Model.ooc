// GtkTreeModel — The tree interface used by GtkTreeView
// see http://library.gnome.org/devel/gtk/stable/GtkTreeModel.html

use gtk
import gtk/[Gtk, _GObject]

import source/Tree/[Iter, Path, ListStore] // ListStore for GType

TreeModel: cover from GtkTreeModel* extends _GObject {
  
  flags: GtkTreeModelFlags {
    get: extern(gtk_tree_model_get_flags)
  }
  
  columnCount: GInt {
    get: extern(gtk_tree_model_get_n_columns)
  }
  
  getColumnType: extern(gtk_tree_model_get_column_type) func (index: GInt) -> GType
  getIter: extern(gtk_tree_model_get_iter) func (iter: TreeIter, path: TreePath) -> GBool
  getIter: extern(gtk_tree_model_get_iter_from_string) func~fromString (iter: TreeIter, path_string: GString) -> GBool
  getPath: extern(gtk_tree_model_get_path) func (iter: TreeIter) -> TreePath
  getValue: extern(gtk_tree_model_get_value) func (iter: TreeIter, column: GInt, value: GtkValue)
  firstIter: extern(gtk_tree_model_get_iter_first) func (iter: TreeIter) -> GBool
  nextIter: extern(gtk_tree_model_iter_next) func (iter: TreeIter) -> GBool
  iterChildren: extern(gtk_tree_model_iter_children) func (iter, parent: TreeIter) -> GBool
  iterHasChild?: extern(gtk_tree_model_iter_has_child) func (iter: TreeIter) -> GBool
  iterChildCount: extern(gtk_tree_model_iter_n_children) func (iter: TreeIter) -> GInt
  iterGetChild: extern(gtk_tree_model_iter_nth_child) func (iter, parent: TreeIter, index: GInt) -> GBool
  iterParent: extern(gtk_tree_model_iter_parent) func (iter, child: TreeIter) -> GBool
  refNode: extern(gtk_tree_model_ref_node) func (iter: TreeIter)
  unrefNode: extern(gtk_tree_model_unref_node) func (iter: TreeIter)
  get: extern(gtk_tree_model_get) func (iter: TreeIter, ...)
  // get_valist, foreach, row_* signals
}

GtkTreeModelFlags: extern enum {
  itersPersist: extern(GTK_TREE_MODEL_ITERS_PERSIST)
  listOnly:     extern(GTK_TREE_MODEL_LIST_ONLY)
}

_GtkValue: cover from GValue {}
GtkValue: cover from _GtkValue* extends _GObject {

  new: static func -> This {
    gc_malloc(_GtkValue size) as This
  }
  new: static func~withType (type: GType) -> This {
    val := new()
    val type = type
    val
  }
  new: static func~withTypeAndValue (type: GType, value: Pointer) -> This {
    val := new()
    val type = type
    val set(type, value)
    val
  }
  
  compatible?: extern(g_value_type_compatible) static func (a, b: GType) -> GBool
  transformable?: extern(g_value_type_transformable) static func (a, b: GType) -> GBool
  
  inited?: extern(G_TYPE_CHECK_VALUE) func -> Bool
  
  type: GType {
    get: extern(G_VALUE_TYPE)
    set: extern(g_value_init)
  }
  
  copyTo: extern(g_value_copy) func (target: GtkValue) // target has same type
  reset: extern(g_value_reset) func -> This // remove value only
  unset: extern(g_value_unset) func // remove value/type; needs to be inited again
  fitsPointer?: extern(g_value_fits_pointer) func -> GBool
  transformTo: extern(g_value_transform) func (destination: GtkValue) -> GBool
  toString: extern(g_strdup_value_contents) func -> GString
  
  clone: func -> This {
    other := This new(this type)
    this copyTo(other)
    other
  }
  
  compatibleWith?: func~GtkValue (other: GtkValue) -> GBool {
    This compatible?(this type, other type)
  }
  compatibleWith?: func~GType (other: GType) -> GBool {
    This compatible?(this type, other)
  }
  
  transformableTo?: func~GtkValue (other: GtkValue) -> GBool {
    This transformable?(this type, other type)
  }
  transformableTo?: func~GType (other: GType) -> GBool {
    This transformable?(this type, other)
  }
  
  
  set: func~generic <T> (T: Class, value: T) {
    match T {
      case GBool => gbool = value as GBool
      case GChar => gchar = value as GChar
      //case GUChar => guchar = value as GUChar
      case GInt => gint = value as GInt
      case GUInt => guint = value as GUInt
      case GLong => glong = value as GLong
      case GULong => gulong = value as GULong
      //case GInt64 => gint64 = value as GInt64
      //case GUInt64 => guint64 = value as GUInt64
      case GFloat => gfloat = value as GFloat
      //case GDouble => gdouble = value as GDouble
      case GString => gstring = value as GString
      case GPointer => gpointer = value as GPointer
      case GType => gtype = value as GType
    }
  }
  
  set: func~GType (type: GType, value: Pointer) {
    match type {
      case GType Boolean => gbool = (value as GBool*)@
      case GType Char => gchar = (value as GChar*)@
      //case GType UChar => guchar = (value as GUChar*)@
      case GType Int => gint = (value as GInt*)@
      case GType UInt => guint = (value as GUInt*)@
      case GType Long => glong = (value as GLong*)@
      case GType ULong => gulong = (value as GULong*)@
      //case GType Int64 => gint64 = (value as GInt64*)@
      //case GType UInt64 => guint64 = (value as GUInt64*)@
      case GType Float => gfloat = (value as GFloat*)@
      //case GType Double => gdouble = (value as GDouble*)@
      case GType String => gstring = (value as GString*)@
      case GType Pointer => gpointer = (value as GPointer*)@
      case GType GType => gtype = (value as GType*)@
    }
  }
  
  set: func~auto (value: Pointer) {
    set(this type, value)
  }
  
  
  // Individual type setters (this is stupid imo)
  // See <http://library.gnome.org/devel/gobject/stable/gobject-Standard-Parameter-and-Value-Types.html>
  
  gbool: GBool {
    get: extern(g_value_get_boolean)
    set: extern(g_value_set_boolean)
  }
  gchar: GChar {
    get: extern(g_value_get_char)
    set: extern(g_value_set_char)
  }
  /*guchar: GUChar {
    get: extern(g_value_get_uchar)
    set: extern(g_value_set_uchar)
  }*/
  gint: GInt {
    get: extern(g_value_get_int)
    set: extern(g_value_set_int)
  }
  guint: GUInt {
    get: extern(g_value_get_uint)
    set: extern(g_value_set_uint)
  }
  glong: GLong {
    get: extern(g_value_get_long)
    set: extern(g_value_set_long)
  }
  gulong: GULong {
    get: extern(g_value_get_ulong)
    set: extern(g_value_set_ulong)
  }
  /*gint64: GInt64 {
    get: extern(g_value_get_int64)
    set: extern(g_value_set_int64)
  }*/
  /*guint64: GUInt64 {
    get: extern(g_value_get_uint64)
    set: extern(g_value_set_uint64)
  }*/
  gfloat: GFloat {
    get: extern(g_value_get_float)
    set: extern(g_value_set_float)
  }
  /*gdouble: GDouble {
    get: extern(g_value_get_double)
    set: extern(g_value_set_double)
  }*/
  genum: GInt {
    get: extern(g_value_get_enum)
    set: extern(g_value_set_enum)
  }
  gflags: GUInt {
    get: extern(g_value_get_flags)
    set: extern(g_value_set_flags)
  }
  gstring: GString {
    get: extern(g_value_get_string)
    set: extern(g_value_set_string)
  }
  gstringSetStatic: extern(g_value_take_string) func (string: GString) // "The string is assumed to be static, and is thus not duplicated when setting the GValue."
  gstringTake: extern(g_value_take_string) func (string: GString) // GValue "takes ownership"
  gstringDup: extern(g_value_dup_string) func -> GString
  // param <http://library.gnome.org/devel/gobject/stable/gobject-GParamSpec.html#GParamSpec>
  // boxed <http://library.gnome.org/devel/glib/stable/glib/glib-Basic-Types.html#gconstpointer>
  gpointer: GPointer {
    get: extern(g_value_get_pointer)
    set: extern(g_value_set_pointer)
  }
  // object (pointer again, w/ take/dup)
  gtype: GType {
    get: extern(g_value_get_gtype)
    set: extern(g_value_set_gtype)
  }
  
}
