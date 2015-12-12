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
		
		this.license = License.license;
		this.wrap_license = true;
		
		this.response.connect ((response_id) => {
			if (response_id == Gtk.ResponseType.CANCEL || response_id == Gtk.ResponseType.DELETE_EVENT) {
				this.hide_on_delete ();
			}
		});
	}
}
