import 'package:sqf/model/datamodel.dart';
import 'package:sqflite/sqflite.dart';



class database_controller {
  static late Database database;
  static List<datamodel> mylist = [];
  static Future initdb() async {
    database = await openDatabase("employee", version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE user (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)');
    });
  }

  static Future addUser(String data) async {
    await database.rawInsert(
        'INSERT INTO user(name, value, num) VALUES("$data", 1234, 456.789)');

    print(database);
  }

  static Future getdata() async {
    final List value = await database.rawQuery("SELECT * FROM user");
    mylist = value.map((e) => datamodel(name: e['name'])).toList();
  }
}
