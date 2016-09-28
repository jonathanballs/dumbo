module Dumbo.SidebarTreeView;

import gtk.TreeView;
import gtk.TreeViewColumn;
import gtk.CellRendererText;
import gtk.TreeStore;
import gtk.StyleContext;
import gdk.RGBA;

class SidebarTreeView : TreeView
{
    
    this(TreeStore store)
    {        
        size_t i = 0;
        foreach (columnName; [""]) {
            TreeViewColumn newColumn = new TreeViewColumn(
                    columnName, new CellRendererText(), "text", 0);
            appendColumn(newColumn);

            i++;
        }

        this.setHeadersVisible(false);

        // Sets the colors. These are stolen from nautilus.
        RGBA color = new RGBA(222/256.0, 222/256.0, 222/256.0);
        this.overrideBackgroundColor(GtkStateFlags.NORMAL, color);
        color = new RGBA(122/256.0, 125/256.0, 129/256.0);
        this.overrideBackgroundColor(GtkStateFlags.SELECTED, color);

        setModel(store);
    }
}
