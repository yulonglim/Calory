import 'dart:convert';

class Workout {

  final int? goalId;
  final int? workoutId;
  final int muscleGroup;
  final int difficultyLevel;
  final String workoutDate;
  final int workoutDuration;
  final int status; //Acts like a boolean with value of 0 (incomplete) or 1 (complete)

  const Workout({
    this.goalId,
    this.workoutId,
    required this.muscleGroup,
    required this.difficultyLevel,
    required this.workoutDate,
    required this.workoutDuration,
    this.status = 0
  });

  static Workout fromMap(Map<String, dynamic> map) {
    int? goalId = map['goalId'];
    int workoutId = map['workoutId'];
    int muscleGroup = map['muscleGroup'];
    int difficultyLevel = map['difficultyLevel'];
    String workoutDate = map['workoutDate'];
    int workoutDuration = map['workoutDuration'];
    int status = map['status'];

    return Workout(goalId: goalId,
                  workoutId: workoutId,
                  muscleGroup: muscleGroup,
                  difficultyLevel: difficultyLevel,
                  workoutDate: workoutDate,
                  workoutDuration: workoutDuration,
                  status: status);
  }


  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'goalId': goalId,
      'workoutId': workoutId,
      'muscleGroup': muscleGroup,
      'difficultyLevel': difficultyLevel,
      'workoutDate': workoutDate,
      'workoutDuration': workoutDuration,
      'status': status
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

}