/* about.vala
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

/** About dialog **/

using Gtk;

class About : Gtk.AboutDialog {
	public About(WWindow win){
		this.set_destroy_with_parent(true);
		this.set_transient_for(win);
		this.set_modal(true);
		
		this.artists = {"Nickolay Ilyushin (UI)", "TyanNN (icon)"};
		this.authors = {"Nickolay Ilyushin (all code)"};
		this.documenters = null;
		this.translator_credits = null;
		
		this.program_name = ClassMain.name;
		this.comments = "GTK+ IDE for Vala language with many features";
		this.copyright = "Copyright © 2016 Nickolay Ilyushin, TyanNN";
		this.version = ClassMain.version;
		
		this.logo = ClassMain.logo;
		this.website = "https://github.com/handicraftsman/gtk-creator";
		this.website_label = "GitHub repo";
		
		this.license = License.license;
		this.wrap_license = true;
		
		this.response.connect ((response_id) => {
			if (response_id == Gtk.ResponseType.CANCEL || response_id == Gtk.ResponseType.DELETE_EVENT) {
				this.hide_on_delete ();
			}
		});
	}
}
