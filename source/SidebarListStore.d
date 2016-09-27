module Dumbo.SidebarListStore;

private import gtk.ListStore;
private import gtk.TreeIter;
private import gtkc.gobjecttypes;

class SidebarListStore : ListStore
{
    this()
    {
        super([GType.STRING]);

        TreeIter iter = createIter();
        setValue(iter, 0, "Tables");
        setValue(iter, 1, "Views");
    }

}

