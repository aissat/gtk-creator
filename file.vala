/** 
class ClassFile : GLib.Object {
	public static string read(string filename){
		var file = File.new_for_path(filename);
		string output = "";

		if(!file.query_exists()){
			stderr.printf("File '%s' doesn't exist\n", file.get_path());
			Posix.exit(1);
		}

		try {
			var dis = new DataInputStream(file.read());
			string line;

			while((line = dis.read_line(null)) != null) {
				output = output + line + "\n";
			}
		} catch(Error e){
			error("%s", e.message);
		}
		return output;
	}
	public static void write(string filename, string toWrite){
		print(filename+"\n");
		try {
			var file = File.new_for_path(filename);

			if(file.query_exists()){
				file.delete();
			}

			var dos = new DataOutputStream(file.create(FileCreateFlags.REPLACE_DESTINATION));

			dos.put_string(toWrite);
		} catch(Error e){
			error(e.message + "\n");
		}
	}
}
**/
