module Dumbo.DumboController;

import gtk.MainWindow;
import gtk.Box;
import gtk.Main;

import Dumbo.DumboWindow;
import Dumbo.Backends.SqliteBackend;

class DumboController {

    private string[] args;

    public void start() {
        Main.init(args);
        MainWindow win = new DumboWindow(this);

        win.showAll();
        Main.run();
    }

    public void setArgs(ref string[] args) {
        this.args = args;
    }

}

