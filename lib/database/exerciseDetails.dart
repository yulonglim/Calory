import 'dart:convert';

class ExerciseDetails {

  final int exerciseId;
  final String exerciseName;
  final String description;

  const ExerciseDetails({
    required this.exerciseId,
    required this.exerciseName,
    required this.description,
  });

  static ExerciseDetails fromMap(Map<String, dynamic> map) {
    int exerciseId = map['exerciseId'];
    String exerciseName = map['exerciseName'];
    String description = map['description'];

    return ExerciseDetails(
        exerciseId: exerciseId,
        exerciseName: exerciseName,
        description: description);
  }


  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'exerciseId': exerciseId,
      'exerciseName': exerciseName,
      'description': description,
    };

    return map;
  }

  String toJsonEncoding() {
    return jsonEncode(this.toMap());
  }

  static ExerciseDetails fromJsonEncoding(String jsonEncoding) {
    return fromMap(jsonDecode(jsonEncoding));
  }

}