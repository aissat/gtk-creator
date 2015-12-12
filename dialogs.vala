
using Gtk;
/**
class dialogs {
	public static string openDialog(){
		string output;
		var dialog = new Gtk.FileChooserDialog("Open File", ClassMain.mainWindow,
			Gtk.FileChooserAction.OPEN,
			"Cancel", Gtk.ResponseType.CANCEL,
			"Open", Gtk.ResponseType.ACCEPT);
		if(dialog.run() == Gtk.ResponseType.ACCEPT) {
			output = (dialog.get_filename());
			dialog.destroy();
			return output;
		}
		return "";
	}

	public static string saveDialog(){
		string output = "";
		var dialog = new Gtk.FileChooserDialog("Save To File", ClassMain.mainWindow,
			Gtk.FileChooserAction.SAVE,
			"Cancel", Gtk.ResponseType.CANCEL,
			"Save", Gtk.ResponseType.OK);
		if(dialog.run() == Gtk.ResponseType.OK) {
			output = (dialog.get_filename());
			dialog.destroy();
		}
		print(output+"\n");
		return output;
	}
}
**/
