/* valadoc.vala
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

/** Documentation browser **/

using Gtk;
using WebKit;

class ValaDoc : Gtk.Box {
	public static WebKit.WebView webview;
	
	public ValaDoc() {
		var mainbox = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
		this.pack_start(mainbox);
		
		var topbar = new Gtk.HeaderBar();
		mainbox.pack_start(topbar, false, false, 0);
			
			var forback = new Gtk.ButtonBox(Gtk.Orientation.HORIZONTAL);
			forback.layout_style = Gtk.ButtonBoxStyle.EXPAND;
			topbar.pack_start(forback);
			
				var back = new Gtk.Button.from_icon_name("stock_left", Gtk.IconSize.SMALL_TOOLBAR);
				forback.add(back);
				back.clicked.connect(() => {
					webview.go_back();
				});
				
				var forward = new Gtk.Button.from_icon_name("stock_right", Gtk.IconSize.SMALL_TOOLBAR);
				forback.add(forward);
				forward.clicked.connect(() => {
					webview.go_forward();
				});
			
			//start
			//end
			
			var linkBtns = new Gtk.ButtonBox(Gtk.Orientation.HORIZONTAL);
			linkBtns.layout_style = Gtk.ButtonBoxStyle.EXPAND;
			topbar.pack_end(linkBtns);
				
				var duckduckgoBtn = new Gtk.Button.with_label("Search");
				linkBtns.add(duckduckgoBtn);
				duckduckgoBtn.clicked.connect(() => {
					webview.load_uri("http://duckduckgo.com/");
				});
				
				var valasiteBtn = new Gtk.Button.with_label("Vala Official Page");
				linkBtns.add(valasiteBtn);
				valasiteBtn.clicked.connect(() => {
					webview.load_uri("http://wiki.gnome.org/Projects/Vala");
				});
				
				var valadocBtn = new Gtk.Button.with_label("ValaDoc");
				linkBtns.add(valadocBtn);
				valadocBtn.clicked.connect(() => {
					webview.load_uri("http://valadoc.org");
				});
				
				var valasamplesBtn = new Gtk.Button.with_label("Vala Samples");
				linkBtns.add(valasamplesBtn);
				valasamplesBtn.clicked.connect(() => {
					webview.load_uri("http://wiki.gnome.org/Projects/Vala/Documentation#Sample_Code");
				});
				
				var valatutBtn = new Gtk.Button.with_label("Vala Tutorial");
				linkBtns.add(valatutBtn);
				valatutBtn.clicked.connect(() => {
					webview.load_uri("http://wiki.gnome.org/Projects/Vala/Tutorial");
				});
			
		webview = new WebKit.WebView();
		webview.zoom_level += 0.05;
		mainbox.pack_start(webview);
		
		webview.load_uri("http://valadoc.org");
	}
}
