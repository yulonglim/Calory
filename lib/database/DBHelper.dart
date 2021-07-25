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
          "progress INTEGER, "
          "daysAWeek INTEGER)");

      await db.execute("CREATE TABLE $tableWorkouts ("
          "goalId INTEGER, "
          "workoutId INTEGER PRIMARY KEY AUTOINCREMENT,"
          "muscleGroup INTEGER,"
          "difficultyLevel INTEGER,"
          "workoutDate STRING,"
          "workoutDuration INTEGER,"
          "workoutList String,"
          "multiplier INTEGER, "
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

  Future<List<exerciseData>> getExercises(int type) async {
    final Database db = await database;
    final List<Map<String, Object?>> core = await db.query(tableCoreExercise);
    final List<Map<String, Object?>> upperBody = await db.query(tableUpperBody);
    final List<Map<String, Object?>> lowerBody = await db.query(tableLowerBody);
    List<exerciseData> exercise = <exerciseData>[];

    switch (type) {
      case 0: {
        for(int i = 0 ; i < core.length ; i++) {
          exercise.add(exerciseData.fromMap(core[i]));
        }
        return exercise;
      }
      case 1: {
        for(int i = 0 ; i < upperBody.length ; i++) {
          exercise.add(exerciseData.fromMap(upperBody[i]));
        }
        return exercise;
      }
      case 2: {
        for(int i = 0 ; i < lowerBody.length ; i++) {
          exercise.add(exerciseData.fromMap(lowerBody[i]));
        }
        return exercise;
      }
      default: {
        return exercise;
      }
    }
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

  Future<List<exerciseData>> generateExercises(int goal) async {
    final Database db = await database;
    final List<Map<String, Object?>> core = await db.query(tableCoreExercise);
    final List<Map<String, Object?>> upperBody = await db.query(tableUpperBody);
    final List<Map<String, Object?>> lowerBody = await db.query(tableLowerBody);
    final List<Map<String, Object?>> cardio = await db.query(tableCardio);

    List<exerciseData> exercise = <exerciseData>[];
    switch (goal) {
      case 0:
        {
          int firstRand = Random().nextInt(core.length);
          for (int i = 0; i < 3; i++) {
            if (firstRand >= core.length) {
              firstRand -= core.length;
            }
            exercise.add(exerciseData.fromMap(core[firstRand]));
            firstRand = firstRand + 1 + Random().nextInt(2);

            if (firstRand >= upperBody.length) {
              firstRand -= upperBody.length;
            }
            exercise.add(exerciseData.fromMap(upperBody[firstRand]));
            firstRand = firstRand + 1 + Random().nextInt(2);

            if (firstRand >= lowerBody.length) {
              firstRand -= lowerBody.length;
            }
            exercise.add(exerciseData.fromMap(lowerBody[firstRand]));
            firstRand = firstRand + 1 + Random().nextInt(2);
            exercise.add(
              exerciseData(
                  exerciseId: 'R1',
                  exerciseTime: 30,
                  exerciseName: 'Rest',
                  exerciseDescription:
                      'Use this time to prepare for the next exercise or to shake off any tension.'),
            );
          }

          return exercise;
        }
      case 1:
        {
          int firstRand = Random().nextInt(core.length);
          for (int i = 0; i < 4; i++) {
            if (i % 2 == 1) {
              if (firstRand >= core.length) {
                firstRand -= core.length;
              }
              exercise.add(exerciseData.fromMap(core[firstRand]));
            }
            firstRand = firstRand + 1 + Random().nextInt(2);
            if (firstRand >= upperBody.length) {
              firstRand -= upperBody.length;
            }
            exercise.add(exerciseData.fromMap(upperBody[firstRand]));
            firstRand = firstRand + 1 + Random().nextInt(2);
            if (firstRand >= lowerBody.length) {
              firstRand -= lowerBody.length;
            }
            exercise.add(exerciseData.fromMap(lowerBody[firstRand]));
            firstRand = firstRand + 1 + Random().nextInt(2);
            exercise.add(
              exerciseData(
                  exerciseId: 'R1',
                  exerciseTime: 30,
                  exerciseName: 'Rest',
                  exerciseDescription:
                      'Use this time to prepare for the next exercise or to shake off any tension.'),
            );
          }
          return exercise;
        }
      case 2:
        {
          int firstRand = Random().nextInt(core.length);
          for (int i = 0; i < 3; i++) {
            if (firstRand >= core.length) {
              firstRand -= core.length;
            }
            exercise.add(exerciseData.fromMap(core[firstRand]));
            firstRand = firstRand + 1 + Random().nextInt(2);

            if (firstRand >= upperBody.length) {
              firstRand -= upperBody.length;
            }
            exercise.add(exerciseData.fromMap(upperBody[firstRand]));
            firstRand = firstRand + 1 + Random().nextInt(2);

            if (firstRand >= lowerBody.length) {
              firstRand -= lowerBody.length;
            }
            exercise.add(exerciseData.fromMap(lowerBody[firstRand]));
            firstRand = firstRand + 1 + Random().nextInt(2);
            exercise.add(
              exerciseData(
                  exerciseId: 'R1',
                  exerciseTime: 30,
                  exerciseName: 'Rest',
                  exerciseDescription:
                      'Use this time to prepare for the next exercise or to shake off any tension.'),
            );
          }
          return exercise;
        }
      default:
        return exercise;
    }
  }

  Future<List<exerciseData>> generateExercisesByMuscles(
      int muscleGroup, int sets) async {
    final Database db = await database;
    final List<Map<String, Object?>> core = await db.query(tableCoreExercise);
    final List<Map<String, Object?>> upperBody = await db.query(tableUpperBody);
    final List<Map<String, Object?>> lowerBody = await db.query(tableLowerBody);
    final List<Map<String, Object?>> cardio = await db.query(tableCardio);

    List<exerciseData> exercise = <exerciseData>[];

    switch (muscleGroup) {
      case 0:
        {
          int firstRand = Random().nextInt(upperBody.length);
          for (int i = 0; i < 4 * sets; i++) {
            exercise.add(exerciseData.fromMap(upperBody[firstRand]));
            if (i % 2 == 1) {
              exercise.add(
                exerciseData(
                    exerciseId: 'R1',
                    exerciseTime: 30,
                    exerciseName: 'Rest',
                    exerciseDescription:
                        'Use this time to prepare for the next exercise or to shake off any tension.'),
              );
            }
            firstRand = firstRand + 1 + Random().nextInt(2);
            if (firstRand >= upperBody.length) {
              firstRand -= upperBody.length;
            }
          }

          return exercise;
        }
      case 1:
        {
          int firstRand = Random().nextInt(lowerBody.length);
          for (int i = 0; i < 4 * sets; i++) {
            exercise.add(exerciseData.fromMap(lowerBody[firstRand]));
            if (i % 2 == 1) {
              exercise.add(
                exerciseData(
                    exerciseId: 'R1',
                    exerciseTime: 30,
                    exerciseName: 'Rest',
                    exerciseDescription:
                        'Use this time to prepare for the next exercise or to shake off any tension.'),
              );
            }
            firstRand = firstRand + 1 + Random().nextInt(2);
            if (firstRand >= lowerBody.length) {
              firstRand -= lowerBody.length;
            }
          }
          return exercise;
        }
      case 2:
        {
          int firstRand = Random().nextInt(core.length);
          for (int i = 0; i < 4 * sets; i++) {
            exercise.add(exerciseData.fromMap(core[firstRand]));
            if (i % 2 == 1) {
              exercise.add(
                exerciseData(
                    exerciseId: 'R1',
                    exerciseTime: 30,
                    exerciseName: 'Rest',
                    exerciseDescription:
                        'Use this time to prepare for the next exercise or to shake off any tension.'),
              );
            }
            firstRand = firstRand + 1 + Random().nextInt(2);
            if (firstRand >= core.length) {
              firstRand = firstRand - core.length;
            }
          }
          return exercise;
        }
      default:
        return exercise;
    }
  }

  Future<List<exerciseData>> previousExercises (
      String exerciseList) async {
    final Database db = await database;
    final List<Map<String, Object?>> core = await db.query(tableCoreExercise);
    final List<Map<String, Object?>> upperBody = await db.query(tableUpperBody);
    final List<Map<String, Object?>> lowerBody = await db.query(tableLowerBody);
    final List<Map<String, Object?>> cardio = await db.query(tableCardio);
    List<exerciseData> exercise = <exerciseData>[];
    List<String> list = exerciseList.split('\n');
    for (int i = 0; i < list.length; i++) {
      for (int j = 0; j < core.length; j++) {
        if (exerciseData.fromMap(core[j]).exerciseName == list[i]) {
          exercise.add(exerciseData.fromMap(core[j]));
          continue;
        }
      }
      for (int j = 0; j < upperBody.length; j++) {
        if (exerciseData.fromMap(upperBody[j]).exerciseName == list[i]) {
          exercise.add(exerciseData.fromMap(upperBody[j]));
          continue;
        }
      }
      for (int j = 0; j < lowerBody.length; j++) {
        if (exerciseData.fromMap(lowerBody[j]).exerciseName == list[i]) {
          exercise.add(exerciseData.fromMap(lowerBody[j]));
          continue;
        }
      }
      for (int j = 0; j < cardio.length; j++) {
        if (exerciseData.fromMap(cardio[j]).exerciseName == list[i]) {
          exercise.add(exerciseData.fromMap(cardio[j]));
          continue;
        }
      }
    }
    return exercise;
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
