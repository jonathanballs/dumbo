module Dumbo.DumboWindow;

import std.stdio;

import gtk.Main;
import gtk.MainWindow;
import gtk.MenuBar;
import gtk.Menu;
import gtk.MenuItem;
import gtk.AccelGroup;
import gtk.VBox;
import gtk.FileChooserDialog;
import gtk.Paned;
import gtk.Label;
import gtk.ScrolledWindow;

import Dumbo.Constants;
import Dumbo.RecordTreeView;
import Dumbo.RecordListStore;
import Dumbo.SidebarTreeStore;
import Dumbo.SidebarTreeView;
import Dumbo.DumboController;
import Dumbo.DbDatabase;

class DumboWindow : MainWindow {

    MenuBar menuBar;
    VBox mainBox;
    DumboController controller;
    SidebarTreeStore sidebarTreeStore;
    SidebarTreeView sidebarTreeView;
    RecordListStore recordListStore;
    RecordTreeView recordTreeView;

    this(DumboController controller) {
        this.controller = controller;

        // Set name and size
        super(Constants.programName);
        this.setDefaultSize(Constants.windowDefaultWidth,
                Constants.windowDefaultHeight);

        // Create main box 
        mainBox = new VBox(false, 0);

        // Create menubar
        mainBox.packStart(this.getMenuBar(),false,false,0);

        // Basic layout
        Paned paned = new Paned(Orientation.HORIZONTAL);

        // Sidebar view
        sidebarTreeStore = new SidebarTreeStore();
        sidebarTreeView = new SidebarTreeView(this.controller, sidebarTreeStore);

        ScrolledWindow sidebarScroll = new ScrolledWindow();
        sidebarScroll.setSizeRequest(Constants.sidebarMinimumWidth, -1);
        sidebarScroll.add(sidebarTreeView);
        paned.pack1(sidebarScroll, false, false);

        // Records view
        recordTreeView = new RecordTreeView();
        ScrolledWindow recordsScroll = new ScrolledWindow();
        recordsScroll.add(recordTreeView);
        recordsScroll.setSizeRequest(Constants.windowDefaultWidth - Constants.sidebarMinimumWidth, -1);
        paned.pack2(recordsScroll, false, false);

        mainBox.packStart(paned, true, true, 0);

        this.add(mainBox);

        return;
    }

    private MenuBar getMenuBar() {
        AccelGroup accelGroup = new AccelGroup();
        addAccelGroup(accelGroup);

        this.menuBar = new MenuBar();
        Menu fileMenu = menuBar.append("_File");
        fileMenu.append(new MenuItem(&onMenuActivate, "_Connect...",
                    "file.connect", true, accelGroup, 'c'));

        return this.menuBar;
    }

    void onMenuActivate(MenuItem menuItem) {
        string menuActionName = menuItem.getActionName();

        switch(menuActionName) {
            case "file.connect":
                FileChooserDialog dialog = new FileChooserDialog(
                        "Select Sqlite Database",
                        this,
                        FileChooserAction.OPEN,
                        ["Open", "Cancel"],
                        [ResponseType.OK, ResponseType.CANCEL]);
                dialog.run();
                dialog.hide();

                string fileName = dialog.getFilename();
                writeln("Opened " ~ fileName);

                break;
            
            default:
                writeln("Unsupported menu action " ~ menuActionName);
                break;
        }

        return;
    }


    void onOpenDatabase(DbDatabase dbDatabase) {
        sidebarTreeStore.setTableNames(dbDatabase.getTableNames());
    }
}

