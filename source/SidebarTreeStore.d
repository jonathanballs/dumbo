module Dumbo.SidebarTreeStore;

private import gtk.TreeStore;
private import gtk.TreeIter;
private import gtkc.gobjecttypes;

class SidebarTreeStore : TreeStore
{
    this()
    {
        super([GType.STRING]);

        TreeIter tableIter = createIter();
        setValue(tableIter, 0, "Tables");

        TreeIter noneIter;
        insert(noneIter, tableIter, 0); 
        setValue(noneIter, 0, "None");

        TreeIter viewsIter = createIter();
        setValue(viewsIter, 0, "Views");
    }

}

