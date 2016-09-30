module Dumbo.RecordListStore;

import gtk.ListStore;
import gtk.TreeIter;
import gtkc.gobjecttypes;

import Dumbo.DbTable;

class RecordListStore : ListStore
{
    this(DbTable table)
    {
        super([GType.STRING, GType.STRING]);
    }
}

