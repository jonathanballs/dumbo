module RecordTreeStore;

private import gtk.ListStore;
private import gtk.TreeIter;
private import gtkc.gobjecttypes;

class RecordTreeStore : ListStore
{
    this()
    {
        super([GType.STRING, GType.STRING]);
    }
    
    public void addCountry(in string name, in string capital)
    {
        TreeIter iter = createIter();
        setValue(iter, 0, name);
        setValue(iter, 1, capital);
    }
}
