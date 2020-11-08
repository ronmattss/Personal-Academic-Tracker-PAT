// test helper
import 'package:mysql1/mysql1.dart';
import 'package:personalacademictracker/Helpers/settings.dart';

class DatabaseHelper {
  Future<String> connectDB() async {
    String pass = SettingsDB.passowrd;
    var settings = new ConnectionSettings(
        host: '127.0.0.1',
        port: 3306,
        user: 'root',
        db: 'patdb',
        password: "ShadedShade");
    var conn = await MySqlConnection.connect(settings);
    var testPrint = await conn.query("SELECT * FROM patdb.accounttable;");
    for (var row in testPrint) {
      print("Username: ${row[0]} Password: ${row[1]}");
    }
    return conn.toString();
  }
}

/**
 * DESKTOP-CJ5D09Q
 * port 3306
 * Socket MySQL
 * user root 
 * 
 * var settings = new ConnectionSettings(
  host: 'localhost', 
  port: 3306,
  user: 'bob',
  password: 'wibble',
  db: 'mydb'
);
 * 
 */