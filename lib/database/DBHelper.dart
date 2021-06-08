import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'goal.dart';
//import 'package:sqflite_database_example/model/note.dart';

class DBHelper {
  static final _dbName = 'calory.db';
  static final _dbVersion = 1;

  static final DBHelper instance = DBHelper._init();

  static Database? _database;

  DBHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB();
    return _database!;
  }

  _initDB() async {
    Directory directory  = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);

    return await openDatabase(path, version: _dbVersion, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final doubleType = 'DOUBLE NOT NULL';
    final integerType = 'INTEGER NOT NULL';
    final datetimeType = 'DATETIME NOT NULL';

    await db.execute('''
      CREATE TABLE $tableGoals ( 
        ${GoalFields.goalId} $idType, 
        ${GoalFields.goal} $textType,
        ${GoalFields.difficultyLevel} $textType,
        ${GoalFields.startDate} $datetimeType,
        ${GoalFields.endDate} $datetimeType,
        ${GoalFields.multiplier} $integerType,
        ${GoalFields.progress} $doubleType
        )
      ''');
  }

  Future<Goal> create(Goal goal) async {
    final db = await instance.database;

    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(tableGoals, goal.toJson());
    return goal.copy(goalId: id);
  }

  Future<Goal> readGoal(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableGoals,
      columns:GoalFields.values,
      where: '${GoalFields.goalId} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Goal.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Goal>> readAllGoals() async {
    final db = await instance.database;

    final orderBy = '${GoalFields.startDate} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tableGoals, orderBy: orderBy);

    return result.map((json) => Goal.fromJson(json)).toList();
  }

  Future<int> update(Goal goal) async {
    final db = await instance.database;

    return db.update(
      tableGoals,
      goal.toJson(),
      where: '${GoalFields.goalId} = ?',
      whereArgs: [goal.goalId],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableGoals,
      where: '${GoalFields.goalId} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }

  insert() {}
}