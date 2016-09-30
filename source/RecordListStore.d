module Dumbo.RecordListStore;

import gtk.ListStore;
import gtk.TreeIter;
import gtkc.gobjecttypes;

import Dumbo.DbTable;
import Dumbo.DbColumn;

class RecordListStore : ListStore
{
    this(DbTable table)
    {
        GType[] colTypes;
        foreach (column; table.getColumns()) {
            colTypes ~= column.getTypeGType();
        }

        super(colTypes);
    }
}

