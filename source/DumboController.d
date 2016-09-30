module Dumbo.DumboController;

import gtk.Main;

import Dumbo.DumboWindow;
import Dumbo.Backends.DatabaseBackend;
import Dumbo.Backends.SqliteBackend;
import Dumbo.RecordListStore;
import Dumbo.DbDatabase;
import Dumbo.DbTable;
import Dumbo.DbColumn;

class DumboController {

    string[] args;
    DumboWindow mainWindow;
    DatabaseBackend databaseBackend;

    public void start() {
        Main.init(args);

        mainWindow = new DumboWindow(this);
        mainWindow.showAll();

        openDatabase("dev.db");

        Main.run();
    }

    public void setArgs(ref string[] args) {
        this.args = args;
    }

    public void openDatabase(string location) {
        databaseBackend = new SqliteBackend(location);
        DbDatabase dbDatabase = new DbDatabase(location, databaseBackend.getTableNames());
        mainWindow.onOpenDatabase(dbDatabase);
    }

    public void displayTable(string tableName) {
        DbTable table = databaseBackend.getTable(tableName);
        this.mainWindow.recordListStore = new RecordListStore(table);
        this.mainWindow.recordTreeView.setCurrentTable(table);
    }

    public DatabaseBackend getDatabaseBackend() {
        return databaseBackend;
    }

}

