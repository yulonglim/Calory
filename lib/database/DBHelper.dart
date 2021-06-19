import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'goal.dart';
import 'workout.dart';
import 'exercise.dart';
import 'feedbacks.dart';
//import 'package:sqflite_database_example/model/note.dart';

class DBHelper {
  static const String tableGoals = 'goals';
  static const String tableWorkouts = 'workouts';
  static const String tableExercises = 'exercises';
  static const String tableFeedback = 'feedback';

  DBHelper._();

  static final DBHelper _instance = DBHelper._();

  factory DBHelper() => _instance;

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    WidgetsFlutterBinding.ensureInitialized();

    return openDatabase(join(await getDatabasesPath(), 'calory.db'), version: 1,
        onCreate: (db, version) async {
          await db.execute(
              "CREATE TABLE $tableGoals("
                  "goalId INTEGER PRIMARY KEY AUTOINCREMENT, "
                  "goal INTEGER, "
                  "difficultyLevel INTEGER, "
                  "startDate TEXT, "
                  "endDate TEXT, "
                  "multiplier INTEGER, "
                  "progress INTEGER)"
          );
          await db.execute(
              "CREATE TABLE $tableWorkouts ("
                  "goalId INTEGER, "
                  "workoutId INTEGER PRIMARY KEY AUTOINCREMENT,"
                  "muscleGroup INTEGER,"
                  "difficultyLevel INTEGER,"
                  "workoutDate STRING,"
                  "workoutDuration INTEGER,"
                  "FOREIGN KEY (goalId) REFERENCES $tableGoals (goalId))"
          );
          print("hello");
          await db.execute(
              "CREATE TABLE $tableExercises ("
                  "workoutId INTEGER ,"
                  "exerciseId INTEGER PRIMARY KEY AUTOINCREMENT,"
                  "exerciseValue INTEGER,"
                  "exerciseTime INTEGER,"
                  "FOREIGN KEY (workoutId) REFERENCES $tableWorkouts (workoutId))"
          );

          await db.execute(
              "CREATE TABLE $tableFeedback ("
                  "workoutId INTEGER,"
                  "feedback INTEGER,"
                  "FOREIGN KEY (workoutId) REFERENCES $tableWorkouts (workoutId))"
          );

        });
  }

  Future<void> insertGoal(Goal goal) async {
    Database db = await database;
    await db.insert(tableGoals, goal.toMap());
  }

  Future<void> insertWorkout(Workout workout) async {
    Database db = await database;
    await db.insert(tableWorkouts, workout.toMap());
  }

  Future<void> insertExercise(Exercise exercise) async {
    Database db = await database;
    await db.insert(tableExercises, exercise.toMap());
  }

  Future<void> insertFeedback(Feedbacks feedback) async {
    Database db = await database;
    await db.insert(tableFeedback, feedback.toMap());
  }

  Future<List<Goal>> getGoals() async {
    final Database db = await database;
    final List<Map<String, Object?>> maps = await db.query(tableGoals);

    List<Goal> goals =
    List.generate(maps.length, (index) => Goal.fromMap(maps[index]));

    return goals;
  }

  Future<void> updateGoal(Goal goal) async {
    Database db = await database;
    await db.update(
      tableGoals,
      goal.toMap(),
      where: 'goalId = ?',
      whereArgs: [goal.goalId],
    );
  }
  Future<void> deleteGoal(int goalId) async {
    Database db = await database;
    await db.delete(
      tableGoals,
      where: "goalId = ?",
      whereArgs: [goalId],
    );
  }
  Future<void> deleteAll() async {
    Database db = await database;
    for(int i = 0 ; i < 100; i++) {
      await db.delete(
        tableGoals,
        where: "goalId = ?",
        whereArgs: [i],
      );
      await db.delete(
        tableWorkouts,
        where: "workoutId = ?",
        whereArgs: [i],
      );
      await db.delete(
        tableExercises,
        where: "exerciseId = ?",
        whereArgs: [i],
      );
      await db.delete(
        tableFeedback,
        where: "workoutId = ?",
        whereArgs: [i],
      );
    }
  }

// static final _dbName = 'calory.db';
// static final _dbVersion = 1;
//
// static final DBHelper instance = DBHelper._init();
//
// static Database? _database;
//
// DBHelper._init();
//
// Future<Database> get database async {
//   if (_database != null) return _database!;
//
//   _database = await _initDB();
//   return _database!;
// }
//
// Future<Database> _initDB() async {
//   Directory directory  = await getApplicationDocumentsDirectory();
//   String path = join(directory.path, _dbName);
//
//   return await openDatabase(path, version: _dbVersion, onCreate: _createDB);
// }
//
// Future _createDB(Database db, int version) async {
//   final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
//   final textType = 'TEXT NOT NULL';
//   final doubleType = 'DOUBLE NOT NULL';
//   final integerType = 'INTEGER NOT NULL';
//   final datetimeType = 'DATETIME NOT NULL';
//
//   await db.execute('''
//     CREATE TABLE $tableGoals (
//       ${GoalFields.goalId} $idType,
//       ${GoalFields.goal} $textType,
//       ${GoalFields.difficultyLevel} $textType,
//       ${GoalFields.startDate} $datetimeType,
//       ${GoalFields.endDate} $datetimeType,
//       ${GoalFields.multiplier} $integerType,
//       ${GoalFields.progress} $doubleType
//       )
//     ''');
// }
//
// Future<Goal> create(Goal goal) async {
//   final db = await instance.database;
//
//   // final json = note.toJson();
//   // final columns =
//   //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
//   // final values =
//   //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
//   // final id = await db
//   //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');
//
//   final id = await db.insert(tableGoals, goal.toJson());
//   return goal.copy(goalId: id);
// }
//
// Future<Goal> readGoal(int id) async {
//   final db = await instance.database;
//
//   final maps = await db.query(
//     tableGoals,
//     columns:GoalFields.values,
//     where: '${GoalFields.goalId} = ?',
//     whereArgs: [id],
//   );
//
//   if (maps.isNotEmpty) {
//     return Goal.fromJson(maps.first);
//   } else {
//     throw Exception('ID $id not found');
//   }
// }
//
// Future<List<Goal>> readAllGoals() async {
//   final db = await instance.database;
//
//   final orderBy = '${GoalFields.startDate} ASC';
//   // final result =
//   //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');
//
//   final result = await db.query(tableGoals, orderBy: orderBy);
//
//   return result.map((json) => Goal.fromJson(json)).toList();
// }
//
// Future<int> update(Goal goal) async {
//   final db = await instance.database;
//
//   return db.update(
//     tableGoals,
//     goal.toJson(),
//     where: '${GoalFields.goalId} = ?',
//     whereArgs: [goal.goalId],
//   );
// }
//
// Future<int> delete(int id) async {
//   final db = await instance.database;
//
//   return await db.delete(
//     tableGoals,
//     where: '${GoalFields.goalId} = ?',
//     whereArgs: [id],
//   );
// }
//
// Future close() async {
//   final db = await instance.database;
//
//   db.close();
// }
//
// Future insert() async{
//
// }
}