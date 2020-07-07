// singleton class to manage the database
import 'package:TodoApp_Seminar_PRM/database/todoModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'categoryModel.dart';

class DatabaseHelper {
  // This is the actual database filename that is saved in the docs directory.
  static final _databaseName = "MyDatabase.db";

  // Increment this version when you need to change the schema.
  static final _databaseVersion = 2;

  // Make this a singleton class.
  DatabaseHelper._();

  static final DatabaseHelper db = DatabaseHelper._();

  // Only allow a single open connection to the database.
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // open the database
  Future<Database> _initDatabase() async {
    // The path_provider plugin gets the right directory for Android or iOS.
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, _databaseName);
//    await deleteDatabase(path);
    // Open the database. Can also add an onUpdate callback parameter.
    print("DB Path: " + path);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: (db, a, b) async {
        print('On upgrade');
        await db.delete(tableTodos);
        await db.delete(tableCategories);
      },
      onOpen: _onOpen,
    );
  }

  // SQL string to create the database
  Future _onCreate(Database db, int version) async {
    try {
      print('CREATINGGGGG TABLE');
      await db.execute(
        "CREATE TABLE $tableTodos(_id INTEGER PRIMARY KEY,  $columnContent TEXT NOT NULL, $columnHasDone INTEGER NOT NULL,$columnDeadline TEXT NOT NULL, $columnCategoryId INTEGER NOT NULL)",
      );
      await db.execute(
        "CREATE TABLE categories(_id INTEGER PRIMARY KEY,name TEXT NOT NULL)",
      );
      populateData(db);
      print('Created table');
    } catch (e) {
      print(e);
    }
  }

  _onOpen(Database db) async {
    // Database is open, print its version
    print('On open');
  }

  // Database helper methods:

  Future<int> insert(Category category) async {
    Database db = await database;
    int id = await db.insert(tableCategories, category.toMap());
    return id;
  }

  Future<List<Category>> getCategories() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db.query(tableCategories);
    return List.generate(results.length, (i) {
      return Category.fromMap(results[i]);
    });
  }

  Future<Todo> addTodo(Todo todo) async {
    Database db = await database;
    int id = await db.insert(tableTodos, todo.toMap());
    todo.id = id;
    return todo;
  }

  Future<int> updateTodo(Todo todo) async {
    Database db = await database;
    int id = await db.update(
      tableTodos,
      todo.toMap(),
      where: '_id = ?',
      whereArgs: [todo.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    final results = await this.getAllTodos(todo.categoryId);

    return id;
  }

  Future<List<Todo>> getAllTodos(int categoryId) async {
    final db = await database;
    List<Map<String, dynamic>> results = await db.query(
      tableTodos,
      where: '$columnCategoryId = ?',
      whereArgs: [categoryId],
    );
    return List.generate(results.length, (i) {
      return Todo.fromMap(results[i]);
    });
  }

  Future<List<Category>> getAllCategories() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db.query(
      tableCategories,
    );
    return List.generate(results.length, (i) {
      return Category.fromMap(results[i]);
    });
  }

  Future<Category> queryTodo(int id) async {
    final Database db = await database;
    List<Map> maps = await db.query(tableCategories,
        columns: [
          "_id",
          columnName,
        ],
        where: '_id = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Category.fromMap(maps.first);
    }
    return null;
  }

// TODO: queryAllWords()
// TODO: delete(int id)
// TODO: update(Word word)

  populateData(Database db) async {
    List<Category> listCategories = [
      Category(name: 'Music'),
      Category(name: 'Work'),
      Category(name: 'Excercise'),
      Category(name: 'Travel'),
      Category(name: 'Study'),
    ];
    for (var category in listCategories) {
      await db.insert(tableCategories, category.toMap());
    }

    await db.insert(
      tableTodos,
      new Todo(
              categoryId: 1,
              content: "Mua do",
              deadline: "12/02/2020",
              hasDone: false)
          .toMap(),
    );
    await db.insert(
      tableTodos,
      new Todo(
        categoryId: 4,
        content: "Mua sua",
        deadline: "12/02/2020",
        hasDone: true,
      ).toMap(),
    );
    await db.insert(
      tableTodos,
      new Todo(
        categoryId: 2,
        content: "Lam bai tap",
        deadline: "12/02/2020",
        hasDone: false,
      ).toMap(),
    );
  }
}
