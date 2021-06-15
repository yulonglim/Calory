import 'dart:convert';

class Exercise {

  final int workoutId;
  final int exerciseId;
  final int? exerciseValue;
  final int exerciseTime;

  const Exercise({
    required this.workoutId,
    required this.exerciseId,
    this.exerciseValue,
    required this.exerciseTime,
  });

  static Exercise fromMap(Map<String, dynamic> map) {
    int workoutId = map['workoutId'];
    int exerciseId = map['exerciseId'];
    int exerciseValue = map['exerciseValue'];
    int exerciseTime = map['exerciseTime'];

    return Exercise(
        workoutId: workoutId,
        exerciseId: exerciseId,
        exerciseValue: exerciseValue,
        exerciseTime: exerciseTime);
  }


  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'workoutId': workoutId,
      'exerciseId': exerciseId,
      'exerciseValue': exerciseValue,
      'exerciseTime': exerciseTime,
    };

    return map;
  }

  String toJsonEncoding() {
    return jsonEncode(this.toMap());
  }

  static Exercise fromJsonEncoding(String jsonEncoding) {
    return fromMap(jsonDecode(jsonEncoding));
  }

}