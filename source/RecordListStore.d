module Dumbo.RecordListStore;

import gtk.ListStore;
import gtk.TreeIter;
import gtkc.gobjecttypes;
import std.stdio;
import std.conv;

import Dumbo.DbTable;
import Dumbo.DbColumn;

class RecordListStore : ListStore
{
    this(DbTable table)
    {

        GType[] colTypes;
        foreach (column; table.getColumns()) {
            colTypes ~= GType.STRING;
        }
        super(colTypes);

        foreach(row; table.getRows()) {
            this.addRow(row);
        }
    }

    public void addRow(string[] rowData) {

        TreeIter iter = createIter();
        foreach (int i, rowValue; rowData) {
            setValue(iter, i, rowValue);
        }

        return;
    }
}

