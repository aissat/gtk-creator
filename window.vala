using Gtk;

class WWindow : Gtk.Window {
	public static Editor editor; //Editor widget
	public static Term term; //Terminal widget
	public static Gtk.Revealer rvTBar; //Revealer for editor
	public static Gtk.Stack modeStack; //Main stack
	
	public WWindow(int sizex, int sizey, string runcommand){
		this.title = ClassMain.name; //
		this.icon = ClassMain.logo; //
		this.window_position = WindowPosition.CENTER; //
		this.destroy.connect(Gtk.main_quit); //
		set_default_size(sizex, sizey); //Configure window
		
		var topbar = new Gtk.HeaderBar(); //
		topbar.set_title(ClassMain.name); //
		topbar.set_subtitle(ClassMain.version); //
		topbar.show_close_button = true; //
		this.set_titlebar(topbar); //Configure header bar
		
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
			var tbCode = new Gtk.HeaderBar();
			boxCode.pack_start(tbCode, false, false, 0);
			
			rvTBar = new Gtk.Revealer();
			boxCode.pack_start(rvTBar, false, false, 0);
		
			var cmdBar = new Gtk.HeaderBar();
			rvTBar.child = cmdBar;
				
				var eCmdRun = new Gtk.Entry();
				eCmdRun.placeholder_text = "Run Command";
				cmdBar.pack_end(eCmdRun);
				
				var eCmdCmp = new Gtk.Entry();
				eCmdCmp.placeholder_text = "Compiler Command";
				cmdBar.pack_end(eCmdCmp);
				
				var eCmdDir = new Gtk.Entry();
				eCmdDir.placeholder_text = "Directory";
				cmdBar.pack_end(eCmdDir);
			
			editor = new Editor();
			boxCode.pack_start(editor, true, true, 0);
				
				var funcBtns = new Gtk.ButtonBox(Gtk.Orientation.HORIZONTAL);
				funcBtns.layout_style = Gtk.ButtonBoxStyle.EXPAND;
				tbCode.pack_start(funcBtns);
				
				var tbCodeOpen = new Gtk.Button.from_icon_name("document-open", Gtk.IconSize.SMALL_TOOLBAR);
				funcBtns.add(tbCodeOpen);
				
				tbCodeOpen.clicked.connect(() => {
					editor.addTab("123");
				});
				
				var tbCodeReload = new Gtk.Button.from_icon_name("reload", Gtk.IconSize.SMALL_TOOLBAR);
				funcBtns.add(tbCodeReload);
				
				var tbCodeSave = new Gtk.Button.from_icon_name("document-save", Gtk.IconSize.SMALL_TOOLBAR);
				funcBtns.add(tbCodeSave);

				// pack_start
				// pack_end
				
				var tpsIcon = new Gtk.Image.from_icon_name("up", Gtk.IconSize.SMALL_TOOLBAR);
				var tabPanelSwitch = new Gtk.Button();
				
				tabPanelSwitch.image = tpsIcon;
				tabPanelSwitch.clicked.connect(() => {
					if(rvTBar.child_revealed == false){
						rvTBar.reveal_child = true;
						tpsIcon = new Gtk.Image.from_icon_name("down", Gtk.IconSize.SMALL_TOOLBAR);
						tabPanelSwitch.image = tpsIcon;
					} else {
						rvTBar.reveal_child = false;
						tpsIcon = new Gtk.Image.from_icon_name("up", Gtk.IconSize.SMALL_TOOLBAR);
						tabPanelSwitch.image = tpsIcon;
					}
				});
				
				tbCode.pack_end(tabPanelSwitch);
				
				var btnsBuild = new Gtk.ButtonBox(Gtk.Orientation.HORIZONTAL);
				btnsBuild.layout_style = Gtk.ButtonBoxStyle.EXPAND;
				tbCode.pack_end(btnsBuild);
				
				var tbCodeMake = new Gtk.Button.from_icon_name("system-run", Gtk.IconSize.SMALL_TOOLBAR);
				tbCodeMake.clicked.connect(() => {
					Posix.system(runcommand + " -t " + eCmdCmp.text + " &");
				});
				btnsBuild.add(tbCodeMake);
				
				var tbCodeRun = new Gtk.Button.from_icon_name("player_play", Gtk.IconSize.SMALL_TOOLBAR);
				tbCodeRun.clicked.connect(() => {
					string torun = "'" + eCmdDir.text + eCmdRun.text + "'" + " &";
					Posix.system(runcommand + " -t " + torun);
				});
				btnsBuild.add(tbCodeRun);
				
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

