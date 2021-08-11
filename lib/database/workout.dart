import 'dart:convert';

import 'package:flutter_app/Functions.dart';

class Workout {
  final int? goalId;
  final int? workoutId;
  final int muscleGroup;
  final int difficultyLevel;
  final String workoutDate;
  final int workoutDuration;
  final String? workoutList;
  final int multiplier;

  const Workout(
      {this.goalId,
      this.workoutId,
      required this.muscleGroup,
      required this.difficultyLevel,
      required this.workoutDate,
      required this.workoutDuration,
      required this.workoutList,
      required this.multiplier});

  static Workout fromMap(Map<String, dynamic> map) {
    int? goalId = map['goalId'];
    int workoutId = map['workoutId'];
    int muscleGroup = map['muscleGroup'];
    int difficultyLevel = map['difficultyLevel'];
    String workoutDate = map['workoutDate'];
    int workoutDuration = map['workoutDuration'];
    String? workoutList = map['workoutList'];
    int multiplier = map['multiplier'];

    return Workout(
        goalId: goalId,
        workoutId: workoutId,
        muscleGroup: muscleGroup,
        difficultyLevel: difficultyLevel,
        workoutDate: workoutDate,
        workoutDuration: workoutDuration,
        workoutList: workoutList,
        multiplier: multiplier
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'goalId': goalId,
      'workoutId': workoutId,
      'muscleGroup': muscleGroup,
      'difficultyLevel': difficultyLevel,
      'workoutDate': workoutDate,
      'workoutDuration': workoutDuration,
      'workoutList': workoutList,
      'multiplier' : multiplier
    };

    if (this.goalId != null) {
      map['goalId'] = this.goalId;
    }
    if (this.workoutId != null) {
      map['workoutId'] = this.workoutId;
    }

    return map;
  }

  String toJsonEncoding() {
    return jsonEncode(this.toMap());
  }

  static Workout fromJsonEncoding(String jsonEncoding) {
    return fromMap(jsonDecode(jsonEncoding));
  }

  String filterRest(String workoutList) {
    List<String> temp = workoutList.split('\n');
    String result = '';
    for (int i = 0 ; i < temp.length ; i++) {
      if(temp[i] != 'Rest'){
        result += '\n' + temp[i];
      }
    }
    return result;
  }

  @override
  String toString() {
    return 'Duration: ' +
        Functions().durationMMSS(this.workoutDuration) +
        '\n' +
        'Difficulty: ' +
        Functions().difficultyToString(this.difficultyLevel) +
        '\n' +
        'Muscle Group: ' +
        Functions().muscleGroup(this.muscleGroup) +
        '\n' +
        filterRest(this.workoutList!);
  }
}
