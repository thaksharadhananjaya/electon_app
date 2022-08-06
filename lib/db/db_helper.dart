import 'dart:async';
import 'dart:io' as io;
import 'package:election_app/config.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import '../data/lga_data.dart';
import '../data/pol_data.dart';
import '../data/state_data.dart';
import '../data/ward_data.dart';

class DBHelper {
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(await getDatabasesPath(), "tdj.db");

    var theDb = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      try {
        print('object');
        await db.execute(
            "CREATE TABLE state(state_id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL UNIQUE);");
        await db.execute(
            "CREATE TABLE local_govt_name(lga_id INTEGER PRIMARY KEY AUTOINCREMENT,state_id INTEGER NOT NULL, lga_name TEXT NOT NULL UNIQUE)");
        await db.execute(
            "CREATE TABLE ward ( ward_id INTEGER PRIMARY KEY AUTOINCREMENT, lga_id INTEGER NOT NULL, state_id INTEGER NOT NULL ,ward_name TEXT NOT NULL)");
        await db.execute(
            "CREATE TABLE polling_unit ( pu_id INTEGER PRIMARY KEY AUTOINCREMENT, ward_id INTEGER NOT NULL,lga_id INTEGER NOT NULL,state_id INTEGER NOT NULL, pu_name TEXT NOT NULL, pu_code TEXT NOT NULL )");
      } catch (e) {
        print("hh: $e");
      }
    });
    return theDb;
  }

  void saveData() async {
    var dbClient = await db;

    try {
      await dbClient.transaction((txn) async {
        return await txn
            .rawInsert("INSERT INTO state (state_id, name) VALUES $STATE_DATA");
      });
      await dbClient.transaction((txn) async {
        return await txn.rawInsert(
            "INSERT INTO local_govt_name (lga_id, state_id, lga_name) VALUES $LGA_DATA");
      });

      await dbClient.transaction((txn) async {
        return await txn.rawInsert(
            "INSERT INTO `ward` (`ward_id`, `lga_id`, `state_id`, `ward_name`) VALUES $WARD_DATA");
      });
      await dbClient.transaction((txn) async {
        return await txn.rawInsert(
            POL_DATA);
      });
    } catch (e) {
      print(e);
    }
  }

  Future getState() async {
    var dbClient = await db;
    try {
      var data = await dbClient.rawQuery("SELECT name FROM state");
      List listData = [];
      for (var row in data) {
        listData.add(row['name']);
      }
      
      return listData;
    } catch (e) {
      print(e);
    }
  }

  Future getLGA(String stateVal) async {
    var dbClient = await db;
    try {
      var data = await dbClient.rawQuery(
          "SELECT lga_name FROM local_govt_name WHERE state_id = (SELECT state_id FROM state WHERE name = '$stateVal')");
      List listData = [];
      for (var row in data) {
        listData.add(row['lga_name']);
      }

      return listData;
    } catch (e) {
      print(e);
    }
  }

  Future getWard(String state, String lga) async {
    var dbClient = await db;
    try {
      var data =
          await dbClient.rawQuery("""SELECT ward_id, ward_name FROM ward WHERE 
    state_id = (SELECT `state_id` FROM state WHERE name = '$state') AND 
    lga_id = (SELECT `lga_id` FROM local_govt_name WHERE lga_name = '$lga') ORDER BY ward_name""");
    
      List listData = [[],[]];
      for (var row in data) {
        listData[0].add(row['ward_id']);
        listData[1].add(row['ward_name']);
      }

      return listData;
    } catch (e) {
      print(e);
    }
  }

  Future getPol(String state, String lga, int wardID) async {
    var dbClient = await db;
    try {
      var data = await dbClient.rawQuery( """SELECT pu_id, pu_name, pu_code FROM polling_unit WHERE 
    state_id = (SELECT state_id FROM state WHERE name = '$state') AND 
    lga_id = (SELECT lga_id FROM local_govt_name WHERE lga_name = '$lga') AND
    ward_id =  '$wardID' """);
      List listData = [];
      for (var row in data) {
        listData.add(row['pu_code']);
      }
print("data: $data");
      return listData;
    } catch (e) {
      print(e);
    }
  }
}
