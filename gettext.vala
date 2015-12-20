/* gettext.vala
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

/** "Get-Text" dialog **/

using Gtk;

public class GetText : Gtk.Dialog {
	public static Gtk.Box mainbox;
	public static Gtk.Entry input;
	public static Gtk.Button submitBtn;
	
	public GetText (string ititle, string entrytext) {
		this.title = ititle;
		this.icon = ClassMain.logo;
		this.border_width = 5;
		
		Gtk.Box content = get_content_area () as Gtk.Box;
		
		mainbox = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);
		content.pack_start(mainbox, false, false, 0);
		
		input = new Gtk.Entry();
		input.placeholder_text = entrytext;
		mainbox.pack_start(input);
		
		submitBtn = new Gtk.Button.from_icon_name("dialog-ok", Gtk.IconSize.SMALL_TOOLBAR);
		submitBtn.clicked.connect(() => {
			this.close();
		});
		mainbox.pack_start(submitBtn, false, false, 2);
		
	}
}
