module Dumbo.SidebarTreeView;

import std.stdio;
import gtk.TreeView;
import gtk.TreeViewColumn;
import gtk.TreeModelIF;
import gtk.TreeStore;
import gtk.TreePath;
import gtk.TreeIter;
import gobject.Value;
import gtk.CellRendererText;
import gtk.StyleContext;
import gdk.RGBA;

import Dumbo.Constants;
import Dumbo.DumboViewType;
import Dumbo.DumboController;

class SidebarTreeView : TreeView
{
    DumboController controller;

    this(DumboController controller, TreeStore store)
    {        
        auto cellRenderer = new CellRendererText();
        cellRenderer.setPadding(Constants.sidebarItemHPadding, Constants.sidebarItemVPadding);

        // A column for holding table/view names
        TreeViewColumn newColumn = new TreeViewColumn(
                "name", cellRenderer, "text", 0);
        appendColumn(newColumn);

        this.setActivateOnSingleClick(true);
        this.addOnRowActivated(&rowActivatedCallback);

        this.setHeadersVisible(false);
        // Sets the colors. These are stolen from nautilus.
        RGBA color = new RGBA(222/256.0, 222/256.0, 222/256.0);
        this.overrideBackgroundColor(GtkStateFlags.NORMAL, color);
        color = new RGBA(122/256.0, 125/256.0, 129/256.0);
        this.overrideBackgroundColor(GtkStateFlags.SELECTED, color);

        this.controller = controller;
        setModel(store);
    }

    private void rowActivatedCallback(TreePath path, TreeViewColumn column, TreeView treeView) {
        TreeIter iter = new TreeIter();
        TreeModelIF store = treeView.getModel();
        store.getIter(iter, path);

        // Shitty hack
        int[] indices = path.getIndices();
        if (indices.length == 2 && indices[0] == 0) {
            controller.displayTable(iter.getValueString(0));
        }
    }
}

