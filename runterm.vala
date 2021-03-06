/* runterm.vala
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

/** Just small terminal **/

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
			pty = new Vte.Pty.sync(Vte.PtyFlags.DEFAULT);
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
		//term.set_emulation("xterm");
		term.set_encoding("UTF-8");
		term.pty= pty;
		
		try {
			term.spawn_sync(Vte.PtyFlags.DEFAULT, "~/", { shell }, null, SpawnFlags.SEARCH_PATH, null, out child_pid);
		} catch (Error e) {
			print(e.message + "\n");
			Posix.exit(1);
		}
		
	}
}
