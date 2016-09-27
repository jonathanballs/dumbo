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

import Dumbo.Constants;

class DumboWindow : MainWindow {

    MenuBar menuBar;

    this() {

        // Set name and size
        super(Constants.programName);
        this.setDefaultSize(Constants.windowDefaultWidth,
                Constants.windowDefaultHeight);

        // Create basic layout
        VBox mainBox = new VBox(false, 0);

        // Create menubar
        mainBox.packStart(this.getMenuBar(),false,false,0);

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

}

