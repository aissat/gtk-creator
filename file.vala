/* file.vala
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

/** Just class for Read/Write operations with files **/

/** 
class ClassFile{
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
