module Dumbo.RecordTreeView;

import gtk.TreeView;
import gtk.TreeViewColumn;
import gtk.ListStore;
import gtk.CellRendererText;
import gtk.ListStore;

import Dumbo.DumboController;
import Dumbo.DbTable;

class RecordTreeView : TreeView
{

    public void setCurrentTable(DbTable table) {

        // Remove old columns
        int noColumns = getNColumns();
        foreach(i; 0 .. noColumns) {
            auto column = getColumn(0);
            removeColumn(column);
        }

        foreach (int i, columnName; table.getColumnNames()) {
            TreeViewColumn newColumn = new TreeViewColumn(
                    columnName, new CellRendererText(), "text", i);
            newColumn.setResizable(true);
            appendColumn(newColumn);
        }
    }
}

