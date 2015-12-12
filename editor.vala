using Gtk;

class Editor : Gtk.Box {
	public Gtk.Notebook notebook;
	
	public Editor(){
		var editBox = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
		this.pack_start(editBox);
				
		notebook = new Gtk.Notebook();
		editBox.pack_start(notebook);
		
		notebook.enable_popup = true;
		notebook.set_scrollable(true);
		
		notebook.append_page(new Gtk.SourceView());
	}
	
	public void addTab(string buf){
		notebook.append_page(new Gtk.SourceView(), new Gtk.Label("test"));
	}
}
