/* dialogs.vala
 *
 * Copyright (C) 2015-2016 Nickolay Ilyushin <nickolay02@inbox.ru>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
 
 /** Just file class for dialogs **/
 

using Gtk;

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

