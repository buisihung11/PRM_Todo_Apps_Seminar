// singleton class to manage the database
import 'dart:io';

import 'package:TodoApp_Seminar_PRM/database/categoryModel.dart'
    as categoryModel;
import 'package:TodoApp_Seminar_PRM/database/todoModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  // This is the actual database filename that is saved in the docs directory.
  static final _databaseName = "MyDatabase.db";
  // Increment this version when you need to change the schema.
  static final _databaseVersion = 1;

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database.
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // open the database
  _initDatabase() async {
    // The path_provider plugin gets the right directory for Android or iOS.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    // Open the database. Can also add an onUpdate callback parameter.
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL string to create the database
  Future _onCreate(Database db, int version) async {
    await db.execute('''
              CREATE TABLE $tableTodos (
                $columnId INTEGER PRIMARY KEY,
                $columnContent TEXT NOT NULL,
                $columnHasDone INTEGER NOT NULL,
                $columnDeadline TEXT NOT NULL,
              )
              ''');
    await db.execute('''
              CREATE TABLE ${categoryModel.tableCategories} (
                $columnId INTEGER PRIMARY KEY,
                $columnContent TEXT NOT NULL,
                $columnHasDone INTEGER NOT NULL,
                $columnDeadline TEXT NOT NULL,
              )
              ''');
  }

  // Database helper methods:

  // Future<int> insert(Word word) async {
  //   Database db = await database;
  //   int id = await db.insert(tableWords, word.toMap());
  //   return id;
  // }

  // Future<Word> queryWord(int id) async {
  //   Database db = await database;
  //   List<Map> maps = await db.query(tableWords,
  //       columns: [columnId, columnWord, columnFrequency],
  //       where: '$columnId = ?',
  //       whereArgs: [id]);
  //   if (maps.length > 0) {
  //     return Word.fromMap(maps.first);
  //   }
  //   return null;
  // }

  // TODO: queryAllWords()
  // TODO: delete(int id)
  // TODO: update(Word word)
}
