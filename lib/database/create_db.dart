import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

///
/// FILE_PURPOSE: CREATE DATABASE TO STORE TODOS
///

class CreateDataBase {
  static CreateDataBase init = CreateDataBase._();
  CreateDataBase._();

  factory CreateDataBase() => init;

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'todo.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      onConfigure: _onConfigure,
    );
  }

  Future<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE categories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL
      );
    ''');

    await db.execute('''
      CREATE TABLE todos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT,
        isDone INTEGER NOT NULL,
        categoryId INTEGER,
        createdAt TEXT NOT NULL,
        closedAt TEXT,
        sortOrder INTEGER DEFAULT 0,
        FOREIGN KEY (categoryId) REFERENCES categories(id)
      );
    ''');
    await _preLoadCategoryData(db);
  }

  Future<void> _preLoadCategoryData(Database database) async {
    final batch = database.batch();

    final List<String> defaultcategoriesList = <String>[
      "All",
      "Work",
      "Personal",
      "Other",
    ];

    for (final category in defaultcategoriesList) {
      batch.insert('categories', {'name': category});
    }

    batch.insert('todos', {
      'title': 'Welcome to Todo App 🎯',
      'description': 'Swipe right to edit your first todo.',
      'isDone': 0,
      'categoryId': 1,
      'createdAt': DateTime.now().toString(),
      'closedAt': null
    });
    await batch.commit(noResult: true);
  }
}
