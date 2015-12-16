/* term.vala
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

/** Terminal **/

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
