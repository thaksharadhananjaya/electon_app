import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Ward {
  List<int> wardIds = [];
  List<String> wardNames = [];
}

class DBHelper {
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    String path = join(await getDatabasesPath(), "election2.db");

    var theDb = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      try {
        await db.execute(
            "CREATE TABLE userdata (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,file TEXT NOT NULL, remark TEXT NOT NULL,file_type TEXT NOT NULL ,lat DOUBLE NOT NULL,long DOUBLE NOT NULL)");
      } catch (e) {
        print("hh: $e");
      }
    });
    return theDb;
  }

  Future saveDataOffline(
      {
      String remark,
      String file,
      int type,
      double lat,
      double long}) async {
    var dbClient = await db;

    try {
      await dbClient.transaction((txn) async {
        return await txn.rawQuery(
            """INSERT INTO userdata
                (
                remark,
                file,
                file_type,
                lat,
                long
                )
                VALUES('$remark',  '$file', '$type', '$lat', '$long')""");
      });
    } catch (e) {
      print(e);
    }
  }

  Future getDataOffline() async {
    var dbClient = await db;
    try {
      var data = await dbClient.rawQuery("SELECT * FROM userdata");

      return data;
    } catch (e) {
      print(e);
    }
  }

  Future deleteDataOffline() async {
    var dbClient = await db;
    try {
      var data = await dbClient.rawQuery("DELETE FROM userdata");

      return data;
    } catch (e) {
      print(e);
    }
  }
}
