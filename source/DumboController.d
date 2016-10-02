module Dumbo.DumboController;

import gtk.Main;
import std.stdio;

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
        DbTable table;

        try {
            table = databaseBackend.getTable(tableName);
        }
        catch (Exception ex) {
            writeln("Error opening table `" ~ tableName ~ "`. Aborting!");
            return;
        }

        this.mainWindow.recordListStore = new RecordListStore(table);
        this.mainWindow.recordTreeView.setCurrentTable(table);
        this.mainWindow.recordTreeView.setModel(this.mainWindow.recordListStore);
    }

    public DatabaseBackend getDatabaseBackend() {
        return databaseBackend;
    }

}

