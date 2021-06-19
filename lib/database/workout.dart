import 'dart:convert';

class Workout {

  final int? goalId;
  final int workoutId;
  final int muscleGroup;
  final int difficultyLevel;
  final String workoutDate;
  final int workoutDuration;

  const Workout({
    this.goalId,
    required this.workoutId,
    required this.muscleGroup,
    required this.difficultyLevel,
    required this.workoutDate,
    required this.workoutDuration,
  });

  static Workout fromMap(Map<String, dynamic> map) {
    int goalId = map['goalId'];
    int workoutId = map['workoutId'];
    int muscleGroup = map['muscleGroup'];
    int difficultyLevel = map['difficultyLevel'];
    String workoutDate = map['workoutDate'];
    int workoutDuration = map['workoutDuration'];

    return Workout(goalId: goalId,
                  workoutId: workoutId,
                  muscleGroup: muscleGroup,
                  difficultyLevel: difficultyLevel,
                  workoutDate: workoutDate,
                  workoutDuration: workoutDuration);
  }


  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'goalId': goalId,
      'workoutId': workoutId,
      'muscleGroup': muscleGroup,
      'difficultyLevel': difficultyLevel,
      'workoutDate': workoutDate,
      'workoutDuration': workoutDuration,
    };

    if (this.goalId != null) {
      map['goalId'] = this.goalId;
    }

    return map;
  }

  String toJsonEncoding() {
    return jsonEncode(this.toMap());
  }

  static Workout fromJsonEncoding(String jsonEncoding) {
    return fromMap(jsonDecode(jsonEncoding));
  }

}