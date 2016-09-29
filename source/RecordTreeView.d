module Dumbo.RecordTreeView;

import gtk.TreeView;
import gtk.TreeViewColumn;
import gtk.ListStore;
import gtk.CellRendererText;
import gtk.ListStore;

class RecordTreeView : TreeView
{

    this(ListStore store)
    {
        /*
        size_t i = 0;
        foreach (columnName; backend.getColumnNames("tableName")) {
            TreeViewColumn newColumn = new TreeViewColumn(
                    columnName, new CellRendererText(), "text", 0);
            appendColumn(newColumn);

            i++;
        }
        */

        setModel(store);
    }
}
