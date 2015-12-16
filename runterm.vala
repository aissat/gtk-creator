using Gtk;
using Vte;

class RunTerm : Gtk.Window {
	public static GLib.Pid child_pid;
	public static string shell;
	public static Vte.Terminal term;
	public static Vte.Pty pty;
	public static Gtk.ScrolledWindow scroll;
	
	public RunTerm(int sizex, int sizey, string cmd){
		this.title = ClassMain.name; //
		this.icon = ClassMain.logo; //
		this.window_position = WindowPosition.CENTER; //
		this.destroy.connect(Gtk.main_quit); //
		set_default_size(sizex, sizey); //Configure window
		
		var topbar = new Gtk.HeaderBar(); //
		topbar.set_title(ClassMain.name + " (RunTerm)"); //
		topbar.set_subtitle(ClassMain.version); //
		topbar.show_close_button = true; //
		this.set_titlebar(topbar); //Configure header bar
		
		try {
			pty = new Vte.Pty(Vte.PtyFlags.DEFAULT);
		} catch (Error e) {
			print(e.message + "\n");
			Posix.exit(1);
		}
		
		scroll = new Gtk.ScrolledWindow(null, null);
		scroll.set_policy(Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC);
		this.add(scroll);
		term = new Vte.Terminal();
		scroll.add(term);
		
		shell = cmd;
		term.set_emulation("xterm");
		term.set_encoding("UTF-8");
		term.pty_object = pty;
		
		try {
			term.fork_command_full(Vte.PtyFlags.DEFAULT, "~/", { shell }, null, SpawnFlags.SEARCH_PATH, null, out child_pid);
		} catch (Error e) {
			print(e.message + "\n");
			Posix.exit(1);
		}
		
	}
}
