import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/data.dart';

class DatabaseHelper {
    static final DatabaseHelper instance = DatabaseHelper._init();
    static Database? _database;

    DatabaseHelper._init();

    Future<Database> get database async {
        if (_database != null) return _database!;
        _database = await _initDB('task.db');
        return _database!;
    }

    Future<Database> _initDB(String filePath) async {
        final dbPath = await getDatabasesPath();
        final path = join(dbPath, filePath);

        return await openDatabase(path, version: 1, onCreate: _createDB);
    }

    Future _createDB(Database db, int version) async => await db.execute('''
        CREATE TABLE tasks (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          uid TEXT NOT NULL, 
          title TEXT NOT NULL,
          description TEXT,
          isCompleted INTEGER NOT NULL
        )
    ''');

    Future<int> create(Data task) async {
        final db = await instance.database;
        return await db.insert('tasks', task.toJson());
    }

    Future<List<Data>> readAllTasks(String userId) async {
        final db = await instance.database;
        final result = await db.query(
            'tasks',
            where: 'uid = ?',
            whereArgs: [userId],
            orderBy: 'id DESC',
        );
        return result.map((json) => Data.fromJson(json)).toList();
    }

    Future<int> update(Data task) async {
        final db = await instance.database;
        return db.update(
            'tasks',
            task.toJson(),
            where: 'id = ?',
            whereArgs: [task.id],
        );
    }

    Future<int> delete(int id) async {
        final db = await instance.database;
        return await db.delete(
            'tasks',
            where: 'id = ?',
            whereArgs: [id],
        );
    }
}