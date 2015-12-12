using Gtk;
using Vte;

class Term : Gtk.ScrolledWindow {
	public static GLib.Pid child_pid;
	public static string shell;
	public static Vte.Terminal term;
	public static Vte.Pty pty;
	
	public Term(){
		term = new Vte.Terminal();
		this.add(term);
		
		this.set_policy(Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC);
		
		shell = Vte.get_user_shell();
		term.set_emulation("xterm");
		term.set_encoding("UTF-8");
		
		try {
			pty = new Vte.Pty(Vte.PtyFlags.DEFAULT);
		} catch (Error e) {
			print(e.message + "\n");
			Posix.exit(1);
		}
		term.pty_object = pty;
		
		try {
			term.fork_command_full(Vte.PtyFlags.DEFAULT, "~/", { shell }, null, SpawnFlags.SEARCH_PATH, null, out child_pid);
		} catch (Error e) {
			print(e.message + "\n");
			Posix.exit(1);
		}
		
		term.child_exited.connect(() => {
			try {
				term.reset(true, true);
				term.fork_command_full(Vte.PtyFlags.DEFAULT, "~/", { shell }, null, SpawnFlags.SEARCH_PATH, null, out child_pid);
			} catch (Error e) {
				print(e.message + "\n");
				Posix.exit(1);
			}
		});
	}
}
