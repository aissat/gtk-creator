class ClassMain : GLib.Object {
	public static WWindow mainWindow;
	public static string[] arguments;
	public static Gdk.Pixbuf logo;
	public const string name = "GTK+ Creator";
	public const string version = "v0.21dev";
	
	public static int main(string[] args){
		arguments = args;
		try {
			logo = new Gdk.Pixbuf.from_file_at_scale("/usr/share/icons/gtkcreator.png", 128, 128, true);
		} catch (Error e) {
			print(e.message + "\n");
			Posix.exit(1);
		}
		
		Gtk.init(ref args);
			
		if(args[1] == "-t"){
			var runTerm = new RunTerm(800, 600, args[2]);
			runTerm.show_all();
		} else if(args[1] == "-g"){
			var gitManager = new GitManager(800, 600);
			gitManager.show_all();
		} else {
			mainWindow = new WWindow(1024, 700, args[0]);
			mainWindow.show_all();
		}
		
		Gtk.main();
		return 0;
	}
} 
