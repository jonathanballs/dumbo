import gtk.MainWindow;
import gtk.Box;
import gtk.Main;

import Dumbo.DumboWindow;

void main(string[] args)
{
    Main.init(args);
    MainWindow win = new DumboWindow();
 
    //auto countryListStore = new RecordTreeStore();
    //auto countryTreeView = new RecordTreeView(countryListStore, new SqliteBackend("test.db"));
    //box.packStart(countryTreeView, true, true, 0);
 
    win.showAll();
    Main.run();
}

