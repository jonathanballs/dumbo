module Dumbo.SidebarTreeStore;

import gtk.TreeStore;
import gtk.TreeIter;
import gtkc.gobjecttypes;

import Dumbo.DumboController;

class SidebarTreeStore : TreeStore {

    DumboController controller;
    TreeIter tablesIter;
    TreeIter viewsIter;
    TreeIter triggersIter;

    this(DumboController mController)
    {
        super([GType.STRING]);

        this.controller = mController;

        // Tables
        tablesIter = createIter();
        setValue(tablesIter, 0, "Tables");

        TreeIter noneIter;
        insert(noneIter, tablesIter, 0); 
        setValue(noneIter, 0, "None");

        // Views
        viewsIter = createIter();
        setValue(viewsIter, 0, "Views");

        TreeIter viewsNoneIter;
        insert(viewsNoneIter, viewsIter, 0); 
        setValue(viewsNoneIter, 0, "None");


        // Triggers
        triggersIter = createIter();
        setValue(triggersIter, 0, "Triggers");

        TreeIter triggersNoneIter;
        insert(triggersNoneIter, triggersIter, 0); 
        setValue(triggersNoneIter, 0, "None");
    }

    public void update() {
        string[] tableNames = this.controller.getDatabaseBackend().getTableNames();

        int i = 0;
        foreach (tableName; tableNames) {
            TreeIter noneIter;
            insert(noneIter, tablesIter, 0); 
            setValue(noneIter, 0, tableName);
            i++;
        }

    }
}

