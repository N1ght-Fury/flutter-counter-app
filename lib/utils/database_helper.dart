import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/counter.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  String tblCounter = 'tbl_counter';
  String colId = 'id';
  String colTitle = 'title';
  String colValue = 'value';
  String colInc = 'increment';
  String colDec = 'decrement';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }

    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }

    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'Counters.db';

    var counterDatabase = await openDatabase(path, version: 1, onCreate: _createDb);

    return counterDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $tblCounter($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $colValue INTEGER, $colInc INTEGER, $colDec INTEGER)');
    //await db.insert(tblCounter, Counter('Counter', 0, 1, 1).toMap());
  }

  Future<List<Map<String, dynamic>>> getCounterMapList() async {
    Database db = await this.database;
    var result =db.rawQuery('SELECT * FROM $tblCounter ORDER BY $colTitle ASC');

    return result;
  }

  Future<int> insertCounter(Counter counter) async {
    Database db = await this.database;
    var result = await db.insert(tblCounter, counter.toMap());
    return result;
  }

  Future<int> updateCounter(Counter counter) async {
    Database db = await this.database;
    var result = db.update(tblCounter, counter.toMap(),
        where: '$colId = ?', whereArgs: [counter.id]);
    return result;
  }

  Future<int> deleteCounter(int id) async {
    Database db = await this.database;
    var result = db.rawDelete('DELETE FROM $tblCounter WHERE $colId = $id');
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) FROM $tblCounter');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Counter>> getCounterList() async {
    var counterMapList = await getCounterMapList();
    int count = counterMapList.length;

    List<Counter> counterList = List<Counter>();

    for (int i = 0; i < count; i++) {
      counterList.add(Counter.fromMapObject(counterMapList[i]));
    }

    return counterList;
  }
}
