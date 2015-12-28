/* main.vala
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

/** Main file **/
using Gtk;

class ClassMain : GLib.Object {
	public static WWindow mainWindow;
	
	public static string[] arguments;
	public static Gdk.Pixbuf logo;
	
	public const string name = "GTK+ Creator";
	public const string version = "(dev version)";
	
	public static bool print_version = false;
	public static bool use_git = false; 
	public static string term_args = "";
	public static string dir = "";
	
	public const GLib.OptionEntry[] poss_options = {
		// --version
		{ "version", 'v', 0, OptionArg.NONE, ref print_version, "Display version", null},
		{ "git", 'g', 0, OptionArg.NONE, ref use_git, "Start git-client", null },
		{ "term", 't', 0, OptionArg.STRING, ref term_args, "Start small terminal with command CMD", "CMD" },
		{ "dir", 'd', 0, OptionArg.STRING, ref dir, "Start at directory DIR", "DIR" },
		
		{ null }
	};
	
	public static int main(string[] args){
		arguments = args;
		try {
			logo = new Gdk.Pixbuf.from_file_at_scale("/usr/share/icons/gtkcreator.png", 128, 128, true);
			Gtk.init_with_args(ref args, null, poss_options, null);
			
			var opt_context = new OptionContext("");
			opt_context.set_help_enabled(true);
			opt_context.add_main_entries(poss_options, null);
			opt_context.parse(ref args);
		} catch (Error e) {
			print(e.message + "\n");
			Posix.exit(1);
		}
		
		GLib.Thread<int> thr_randomizer = new GLib.Thread<int>("randomizer", ClassMisc.randomizer);
		
		if(print_version){ 
			print(@"Name: $name \nVersion: $version\n"); 
			print("Copyright (C) 2015-2016 Nickolay Ilyushin <nickolay02@inbox.ru>\n");
			print("This is free software, and you are welcome to redistribute it under GNU GPLv3 license\n");
			return 0; 
		} else if(use_git){
			var gitManager = new GitManager(800, 600);
			gitManager.show_all();
		} else if(term_args != ""){
			var runTerm = new RunTerm(800, 600, term_args);
			runTerm.show_all();
		} else {
			mainWindow = new WWindow(1024, 700, args[0]);
			mainWindow.show_all();
		}
		
		Gtk.main();
		return 0;
	}
} 
