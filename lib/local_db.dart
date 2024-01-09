import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Sqldb {
  static Database? _db;
  void printf() {
    print(_db);
  }

  Future<Database?> get db async {
    if (_db == null) {
      return _db = await intialdb();
    } else {
      return _db;
    }
  }

  intialdb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, "localdb.db");
    Database mydb = await openDatabase(path,
        onCreate: _oncreate, version: 1, onUpgrade: _onupgrade);
    return mydb;
  }

  _oncreate(Database db, int version) async {
    // await db.execute(''' CREATE TABLE "notes" (
    //       "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    //       "note" TEXT NOT NULL,
    //       "color" TEXT
    //       )''');
    // print("create database =================");

    //we create data base with batch  if we create more than table
    Batch batch = db.batch();
    batch.execute(''' CREATE TABLE "notes" (
          "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
          "note" TEXT NOT NULL,
          "color" TEXT
           )''');
    await batch.commit();
    print("on createa ====================");
  }

  _onupgrade(Database db, int oldversion, int newversion) async {
    await db.execute("ALTER TABLE notes ADD COLUMN color TEXT");
    print("upgrade =======================");
  }

  //SELECT
  getdata(String sql) async {
    Database? mydb = await db;
    Future<List> response = mydb!.rawQuery(sql);
    return response;
  }

  //DELETE
  deletedata(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

  //UPDATE
  updatedata(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  //INSERT
  insertdata(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  // delete database
  deletemydatabase() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, "localdb.db");
    await deleteDatabase(path);
  }
}
