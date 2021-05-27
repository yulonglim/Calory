import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
//import 'package:sqflite_database_example/model/note.dart';

class ExerciseDatabase {
  static final ExerciseDatabase instance = ExerciseDatabase._init();

  static Database? _database;

  ExerciseDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('exercise.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }



  Future close() async {
    final db = await instance.database;

    db.close();
  }
}