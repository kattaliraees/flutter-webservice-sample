
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import './user_table.dart';




class PersistentStore {
  
  Database? db;

  static final PersistentStore defaultStore =  PersistentStore();
  
  Future<Database?> get database async {
    if (db != null) {
      return db;
    }
      // if _database is null we instantiate it
      db = await initDB();
      return db;
  }

  initDB() async {
    Database qeMobileDB = await openDatabase(
        await dbPath,
        version: 1,
        onCreate: _onCreate);
    return qeMobileDB;
  }

  static Future<String> get dbPath async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "QEMobileDB.db");
    print('DB Path: $path');
    return path;
  }
  void _onCreate(Database db, int version) async {
    // All Table creation
    await db.execute(userTableCreateQuery);
    //await db.execute(addressTableCreateQuery);
  }
}

class Tables {
  static const kUsers = 'USERS';
}