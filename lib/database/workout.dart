import 'dart:convert';

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

  String durationMMSS(int duration) {
    int mins = 0;
    int temp = duration;
    while (temp >= 60) {
      temp -= 60;
      mins++;
    }
    return mins.toString() + 'm ' + temp.toString() + 's';
  }

  String difficulty(int difficulty) {
    switch (difficulty) {
      case 0:
        {
          return 'Easy';
        }
      case 1:
        {
          return 'Normal';
        }
      case 2:
        {
          return 'Hard';
        }
      default:
        {
          return '';
        }
    }
  }

  String MuscleGroup(int muscle) {
    switch (muscle) {
      case 0:
        {
          return 'Upper Body';
        }
      case 1:
        {
          return 'Lower Body';
        }
      case 2:
        {
          return 'Core';
        }
      case 3:
        {
          return 'Balanced';
        }
      default:
        {
          return '';
        }
    }
  }

  @override
  String toString() {
    return 'Duration: ' +
        durationMMSS(this.workoutDuration) +
        '\n' +
        'Difficulty: ' +
        difficulty(this.difficultyLevel) +
        '\n' +
        'Muscle Group: ' +
        MuscleGroup(this.muscleGroup) +
        '\n' +
        workoutList!;
  }
}
