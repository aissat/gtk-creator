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

class EditorWidget : Gtk.Box {
	public static Editor editor;
	public static Gtk.Revealer rvTBar;
	
	public EditorWidget(string runcommand){
		var mainbox = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
		this.pack_start(mainbox);
		
		var tbCode = new Gtk.HeaderBar();
		mainbox.pack_start(tbCode, false, false, 0);
		
		rvTBar = new Gtk.Revealer();
		mainbox.pack_start(rvTBar, false, false, 0);
	
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
		mainbox.pack_start(editor, true, true, 0);
			
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
	}
}
