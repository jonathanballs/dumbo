module Dumbo.RecordTreeView;

import gtk.TreeView;
import gtk.TreeViewColumn;
import gtk.ListStore;
import gtk.CellRendererText;
import gtk.ListStore;

import Dumbo.DumboController;

class RecordTreeView : TreeView
{

    DumboController controller;

    this(DumboController controller, ListStore store)
    {
        this.controller = controller;
        setModel(store);
    }

    public void setCurrentTable(string tableName) {

        // Remove old columns
        int noColumns = getNColumns();
        foreach(i; 0 .. noColumns) {
            auto column = getColumn(0);
            removeColumn(column);
        }

        size_t i = 0;
        foreach (columnName; controller.getDatabaseBackend().getColumnNames(tableName)) {
            TreeViewColumn newColumn = new TreeViewColumn(
                    columnName, new CellRendererText(), "text", 0);
            appendColumn(newColumn);

            i++;
        }
    }
}

