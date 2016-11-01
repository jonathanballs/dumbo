module Dumbo.SidebarTreeStore;

import gtk.TreeStore;
import gtk.TreeIter;
import gtkc.gobjecttypes;

import Dumbo.DumboController;
import Dumbo.DumboViewType;


class SidebarTreeStore : TreeStore {

    TreeIter tablesIter;
    TreeIter viewsIter;
    TreeIter triggersIter;

    this()
    {
        // We'll only be storing lists of table/view/trigger names
        super([GType.STRING]);


        // Tables
        tablesIter = createIter();
        setValue(tablesIter, 0, "Tables");
        this.setTableNames(["None"]);

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

    public void setTableNames(string[] tableNames) {

        // Remove old table names
        TreeIter oldTableName;
        foreach(i; 0 .. this.iterNChildren(tablesIter)) {
            iterNthChild(oldTableName, tablesIter, i);
            this.remove(oldTableName);
        }


        foreach (int i, tableName; tableNames) {
            TreeIter tableNameIter;
            insert(tableNameIter, tablesIter, -1); 
            setValue(tableNameIter, 0, tableName);
        }
    }
}

