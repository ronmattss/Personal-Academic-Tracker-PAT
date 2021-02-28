// test helper
import 'package:mysql1/mysql1.dart';
import 'package:personalacademictracker/Helpers/settings.dart';

class DatabaseHelper {
  MySqlConnection connection;
  //Future<Results> queryResults;
  Future<Results> connectDB(String query) async {
    Results queryResult;
    String pass = SettingsDB.passowrd;
    var settings = new ConnectionSettings(
        host: '127.0.0.1',
        port: 3306,
        user: 'root',
        db: 'patdb',
        password: pass);
     connection = await MySqlConnection.connect(settings);
    var testPrint = await connection.query(
        "SELECT * FROM patdb.profile_table;"); // gonna need a SQL String for custom SQL statements
    for (var row in testPrint) {
      // prints
      // print("Username: ${row[0]} Password: ${row[1]} Last Name:${row[2]} First Name:${row[3]} Middle Name:${row[4]} Date:${row[5]}");
      print(row.values);
    }

    queryResult = await connection.query(query);
   // connection.close();
    return queryResult;
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
