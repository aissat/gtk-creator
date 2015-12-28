/* git.vala
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

/** GUI GIT client (Work In Progress) **/

using Gtk;
using Vte;

class GitManager : Gtk.Window {
	public static GLib.Pid child_pid;
	public static Vte.Terminal term;
	public static Vte.Pty pty;
	public static Gtk.ScrolledWindow scroll;
	public static Gtk.Entry opEntry;
	public static Gtk.Box mainbox;
	
	public GitManager(int sizex, int sizey){
		this.title = ClassMain.name; //
		this.icon = ClassMain.logo; //
		this.window_position = WindowPosition.CENTER; //
		this.destroy.connect(Gtk.main_quit); //
		set_default_size(sizex, sizey); //Configure window
		
		var topbar = new Gtk.HeaderBar(); //
		topbar.set_title(ClassMain.name + " (Git Manager)"); //
		topbar.set_subtitle(ClassMain.version); //
		topbar.show_close_button = true; //
		this.set_titlebar(topbar); //Configure header bar
		
			var initBtn = new Gtk.Button.with_label("Init Repo");
			topbar.pack_start(initBtn);
			initBtn.clicked.connect(() => {
				runCmd({"git", "init"});
			});
			
			var raddBtn = new Gtk.Button.with_label("Add Rem. Repo*");
			topbar.pack_start(raddBtn);
			raddBtn.clicked.connect(() => {
				string rname = ClassMisc.random.to_string();
				string url = opEntry.text;
				string[] cmd = {"git", "remote", "add", rname, url};
				
				opEntry.text = "";
				runCmd(cmd);
			});
			
		mainbox = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
		this.add(mainbox);
		
		scroll = new Gtk.ScrolledWindow(null, null);
		scroll.set_policy(Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC);
		mainbox.pack_start(scroll);
		term = new Vte.Terminal();
		scroll.add(term);

		term.set_emulation("xterm");
		term.set_encoding("UTF-8");
		
		try {
			pty = new Vte.Pty(Vte.PtyFlags.DEFAULT);
		} catch (Error e) {
			print(e.message + "\n");
			Posix.exit(1);
		}
		term.pty_object = pty;
		
		runCmd({"echo", " * - uses Operaion Entry \n Warning: running new commands terminates previous"});
		
		opEntry = new Gtk.Entry();
		opEntry.placeholder_text = "Operation Entry";
		mainbox.pack_start(opEntry, false, false, 0);
		
		var firstbtns = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 3);
		mainbox.pack_start(firstbtns, false, false, 0);
			
			var listFilesBtn = new Gtk.Button.with_label("List");
			firstbtns.pack_start(listFilesBtn);
			listFilesBtn.clicked.connect(() => {
				runCmd({"ls"});
			});
			
			var getStatusBtn = new Gtk.Button.with_label("Status");
			firstbtns.pack_start(getStatusBtn);
			getStatusBtn.clicked.connect(() => {
				runCmd({"git", "status"});
			});
			
			var addBtn = new Gtk.Button.with_label("Add/Prepare*");
			firstbtns.pack_start(addBtn);
			addBtn.clicked.connect(() => {
				string files = opEntry.text;
				string[] gitadd = {"git", "add"};
				string[] afiles = files.split(" ", 0);	
				
				opEntry.text = "";
				runCmd(ClassMisc.str_arr_cmb(gitadd, afiles));
			});
			
			var remBtn = new Gtk.Button.with_label("Remove*");
			firstbtns.pack_start(remBtn);
			remBtn.clicked.connect(() => {
				string files = opEntry.text;
				string[] gitrem = {"git", "rm"};
				string[] afiles = files.split(" ", 0);	
				
				opEntry.text = "";
				runCmd(ClassMisc.str_arr_cmb(gitrem, afiles));
			});
			
		var secondbtns = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 3);
		mainbox.pack_start(secondbtns, false, false, 0);
			
			var commitBtn = new Gtk.Button.with_label("Commit*");
			secondbtns.pack_start(commitBtn);
			commitBtn.clicked.connect(() => {
				string text = opEntry.text;
				string[] cmd = {"git", "commit", "-m", text};
				
				opEntry.text = "";
				runCmd(cmd);
			});
			
			var pushBtn = new Gtk.Button.with_label("Push");
			secondbtns.pack_start(pushBtn);
			pushBtn.clicked.connect(() => {
				runCmd({"git", "push"});
			});
			
			var pullBtn = new Gtk.Button.with_label("Pull");
			secondbtns.pack_start(pullBtn);
			pullBtn.clicked.connect(() => {
				runCmd({"git", "pull"});
			});
			
			var shellBtn = new Gtk.Button.with_label("Run Shell");
			secondbtns.pack_start(shellBtn);
			shellBtn.clicked.connect(() => {
				string shell = Vte.get_user_shell();
				runCmd({shell});
			});
		
	}
	
	public void runCmd(string[] cmd){
		try {
			term.fork_command_full(Vte.PtyFlags.DEFAULT, "~/", (cmd), null, SpawnFlags.SEARCH_PATH, null, out child_pid);
		} catch (Error e) {
			print(e.message + "\n");
			Posix.exit(1);
		}
	}
	
	
	
}
