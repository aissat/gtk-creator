using Gtk;

class WWindow : Gtk.Window {
	public static Term term;
	public static Gtk.Stack modeStack;
	
	public WWindow(int sizex, int sizey, string runcommand){
		this.title = ClassMain.name;
		this.icon = ClassMain.logo;
		this.window_position = WindowPosition.CENTER;
		this.destroy.connect(Gtk.main_quit);
		set_default_size(sizex, sizey);
		
		var topbar = new Gtk.HeaderBar();
		topbar.set_title(ClassMain.name);
		topbar.set_subtitle(ClassMain.version);
		topbar.show_close_button = true;
		this.set_titlebar(topbar);
		
		var mainBox = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
		this.add(mainBox);
		
		var rvModeSwitch = new Gtk.Revealer();
		mainBox.pack_start(rvModeSwitch, false, false, 0);
		
		var modeBar = new Gtk.HeaderBar();
		rvModeSwitch.add(modeBar);
		
		var modeSwitcher = new Gtk.StackSwitcher();
		modeBar.pack_end(modeSwitcher);
		
		modeStack = new Gtk.Stack();
		modeSwitcher.stack = modeStack;
		mainBox.pack_start(modeStack);
		
		var aboutButton = new Gtk.Button.from_icon_name("gtk-about", Gtk.IconSize.SMALL_TOOLBAR);
		topbar.pack_end(aboutButton);
		
		var aboutDialog = new About(this);
		
			aboutButton.clicked.connect(() => {
				aboutDialog.present();
			});
		
		var rModeSwitch = new Gtk.Switch();
		topbar.pack_end(rModeSwitch);
		
		rModeSwitch.state_set.connect((state) => {
			rvModeSwitch.reveal_child = state;
			return false;
		});
		
		var boxCode = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
		modeStack.add_titled(boxCode, "Code", "Code");
			
			//builtin editor
			var editor = new EditorWidget(runcommand);
			boxCode.pack_start(editor);
				
		var boxGlade = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);
		modeStack.add_titled(boxGlade, "UI Designer", "UI Designer");
		
			//place for builtin glade
		
		var boxDoc = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
		modeStack.add_titled(boxDoc, "Documentation", "Documentation");
		
			//builtin documentation
			var valadoc = new ValaDoc();
			boxDoc.pack_start(valadoc);
			
		var boxTerm = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
		modeStack.add_titled(boxTerm, "Terminal", "Terminal");
			
			//builtin terminal
			term = new Term();
			boxTerm.pack_start(term);
			
	}
}

