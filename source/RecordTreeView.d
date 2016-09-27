module RecordTreeView;

private import gtk.TreeView;
private import gtk.TreeViewColumn;
private import gtk.ListStore;
private import gtk.CellRendererText;
private import gtk.ListStore;

private import Dumbo.Backends.DatabaseBackend;

class RecordTreeView : TreeView
{
    
    this(ListStore store, DatabaseBackend backend)
    {        
        size_t i = 0;
        foreach (columnName; backend.getColumnNames("tableName")) {
            TreeViewColumn newColumn = new TreeViewColumn(
                    columnName, new CellRendererText(), "text", 0);
            appendColumn(newColumn);

            i++;
        }
        
        setModel(store);
    }
}
