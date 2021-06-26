import 'dart:core';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/database/exercise_data.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
//import 'package:path_provider/path_provider.dart';

import 'goal.dart';
import 'workout.dart';
//import 'package:sqflite_database_example/model/note.dart';

class DBHelper {
  static const String tableGoals = 'goals';
  static const String tableWorkouts = 'workouts';

  static const String tableUpperBody = 'upperBodyData';
  static const String tableLowerBody = 'lowerBodyData';
  static const String tableCoreExercise = 'coreExerciseData';
  static const String tableCardio = 'cardioData';

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

    return openDatabase(join(await getDatabasesPath(), 'calory.db'), version: 3,
        onCreate: (db, version) async {
      await db.execute("CREATE TABLE $tableGoals("
          "goalId INTEGER PRIMARY KEY AUTOINCREMENT, "
          "goal INTEGER, "
          "difficultyLevel INTEGER, "
          "startDate TEXT, "
          "endDate TEXT, "
          "multiplier INTEGER, "
          "progress INTEGER)");

      await db.execute("CREATE TABLE $tableWorkouts ("
          "goalId INTEGER, "
          "workoutId INTEGER PRIMARY KEY AUTOINCREMENT,"
          "muscleGroup INTEGER,"
          "difficultyLevel INTEGER,"
          "workoutDate STRING,"
          "workoutDuration INTEGER,"
          "status INTEGER,"
          "FOREIGN KEY (goalId) REFERENCES $tableGoals (goalId))");

      await db.execute("CREATE TABLE $tableUpperBody("
          "exerciseId STRING PRIMARY KEY, "
          "exerciseValue INTEGER, "
          "exerciseTime INTEGER, "
          "exerciseName STRING,"
          "exerciseDescription STRING)");

      await db.execute("CREATE TABLE $tableLowerBody("
          "exerciseId STRING PRIMARY KEY, "
          "exerciseValue INTEGER, "
          "exerciseTime INTEGER, "
          "exerciseName STRING,"
          "exerciseDescription STRING)");

      await db.execute("CREATE TABLE $tableCoreExercise("
          "exerciseId STRING PRIMARY KEY, "
          "exerciseValue INTEGER, "
          "exerciseTime INTEGER, "
          "exerciseName STRING,"
          "exerciseDescription STRING)");

      await db.execute("CREATE TABLE $tableCardio("
          "exerciseId STRING PRIMARY KEY, "
          "exerciseValue INTEGER, "
          "exerciseTime INTEGER, "
          "exerciseName STRING,"
          "exerciseDescription STRING)");
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

  Future<void> updateWorkout(Workout workout) async {
    Database db = await database;
    await db.update(
      tableGoals,
      workout.toMap(),
      where: 'workoutId = ?',
      whereArgs: [workout.workoutId],
    );
  }

  Future<void> insertExerciseData(
      String table, List<exerciseData> exerciseList) async {
    Database db = await database;
    var count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM ' + table));
    if (count == 0) {
      for (int i = 0; i < exerciseList.length; i++) {
        await db.insert(table, exerciseList[i].toMap());
      }
    }
  }

  Future<List<Goal>> getGoals() async {
    final Database db = await database;
    final List<Map<String, Object?>> maps = await db.query(tableGoals);

    List<Goal> goals =
        List.generate(maps.length, (index) => Goal.fromMap(maps[index]));

    return goals;
  }

  Future<List<Workout>> getWorkOut() async {
    final Database db = await database;
    final List<Map<String, Object?>> maps = await db.query(tableWorkouts);

    List<Workout> workout =
        List.generate(maps.length, (index) => Workout.fromMap(maps[index]));

    return workout;
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

  Future<void> deleteAllWorkOuts() async {
    Database db = await database;
    for (int i = 0; i < 100; i++) {
      await db.delete(
        tableWorkouts,
        where: "workoutId = ?",
        whereArgs: [i],
      );
    }
  }

  Future<List<exerciseData>> getExercises(int goal) async {
    final Database db = await database;
    final List<Map<String, Object?>> core = await db.query(tableCoreExercise);
    final List<Map<String, Object?>> upperBody = await db.query(tableUpperBody);
    final List<Map<String, Object?>> lowerBody = await db.query(tableLowerBody);
    final List<Map<String, Object?>> cardio = await db.query(tableCardio);

    List<exerciseData> exercise = <exerciseData>[];
    switch (goal) {
      case 0:
        {
          for (int i = 0; i < 3; i++) {
            exercise.add(
                exerciseData.fromMap(core[Random().nextInt(core.length - 1)]));
            exercise.add(exerciseData
                .fromMap(upperBody[Random().nextInt(upperBody.length - 1)]));
            exercise.add(exerciseData
                .fromMap(lowerBody[Random().nextInt(lowerBody.length - 1)]));
          }

          return exercise;
        }
      case 1:
        {
          for (int i = 0; i < 4; i++) {
            if (i % 2 == 1) {
              exercise.add(exerciseData
                  .fromMap(core[Random().nextInt(core.length - 1)]));
            }
            exercise.add(exerciseData
                .fromMap(upperBody[Random().nextInt(upperBody.length - 1)]));
            exercise.add(exerciseData
                .fromMap(lowerBody[Random().nextInt(lowerBody.length - 1)]));
          }
          return exercise;
        }
      case 2:
        {
          for (int i = 0; i < 3; i++) {
            exercise.add(
                exerciseData.fromMap(core[Random().nextInt(core.length - 1)]));
            exercise.add(exerciseData
                .fromMap(upperBody[Random().nextInt(upperBody.length - 1)]));
            exercise.add(exerciseData
                .fromMap(lowerBody[Random().nextInt(lowerBody.length - 1)]));
          }
          return exercise;
        }
      default:
        return exercise;
    }
  }

  Future<List<exerciseData>> getExercisesMuscles(int muscleGroup) async {
    final Database db = await database;
    final List<Map<String, Object?>> core = await db.query(tableCoreExercise);
    final List<Map<String, Object?>> upperBody = await db.query(tableUpperBody);
    final List<Map<String, Object?>> lowerBody = await db.query(tableLowerBody);
    final List<Map<String, Object?>> cardio = await db.query(tableCardio);

    List<exerciseData> exercise = <exerciseData>[];
    switch (muscleGroup) {
      case 0:
        {
          for (int i = 0; i < 4; i++) {
            exercise.add(exerciseData
                .fromMap(upperBody[Random().nextInt(upperBody.length - 1)]));
          }

          return exercise;
        }
      case 1:
        {
          for (int i = 0; i < 4; i++) {
            exercise.add(exerciseData
                .fromMap(lowerBody[Random().nextInt(lowerBody.length - 1)]));
          }
          return exercise;
        }
      case 2:
        {
          for (int i = 0; i < 4; i++) {
            exercise.add(
                exerciseData.fromMap(core[Random().nextInt(core.length - 1)]));
          }
          return exercise;
        }
      default:
        return exercise;
    }
  }

  Future<void> deleteAll() async {
    Database db = await database;
    for (int i = 0; i < 100; i++) {
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
    }
  }
}
