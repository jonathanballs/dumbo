module Dumbo.SidebarTreeStore;

private import gtk.TreeStore;
private import gtk.TreeIter;
private import gtkc.gobjecttypes;

class SidebarTreeStore : TreeStore
{
    this()
    {
        super([GType.STRING]);

        // Tables
        TreeIter tableIter = createIter();
        setValue(tableIter, 0, "Tables");

        // Foreach table
        TreeIter noneIter;
        insert(noneIter, tableIter, 0); 
        setValue(noneIter, 0, "None");

        // Views
        TreeIter viewsIter = createIter();
        setValue(viewsIter, 0, "Views");

        TreeIter viewsNoneIter;
        insert(viewsNoneIter, viewsIter, 0); 
        setValue(viewsNoneIter, 0, "None");


        // Triggers
        TreeIter triggersIter = createIter();
        setValue(triggersIter, 0, "Triggers");

        TreeIter triggersNoneIter;
        insert(triggersNoneIter, triggersIter, 0); 
        setValue(triggersNoneIter, 0, "None");
    }
}

