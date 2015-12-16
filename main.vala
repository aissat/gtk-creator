/* main.vala
 *
 * Copyright (C) 2015 Nickolay Ilyushin <nickolay02@inbox.ru>
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

/** Main file **/

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
