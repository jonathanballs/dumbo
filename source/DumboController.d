module Dumbo.DumboController;

import gtk.Main;

import Dumbo.DumboWindow;
import Dumbo.Backends.DatabaseBackend;
import Dumbo.Backends.SqliteBackend;

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
        mainWindow.onNewDatabase();
    }

    public DatabaseBackend getDatabaseBackend() {
        return databaseBackend;
    }

}

