import 'dart:convert';

class Feedback {

  final int workoutId;
  final int feedback;

  const Feedback({
    required this.workoutId,
    required this.feedback
  });

  static Feedback fromMap(Map<String, dynamic> map) {
    int workoutId = map['workoutId'];
    int feedback = map['feedback'];

    return Feedback(
        workoutId: workoutId,
        feedback: feedback);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'workoutId': workoutId,
      'feedback' : feedback
    };

    return map;
  }

  String toJsonEncoding() {
    return jsonEncode(this.toMap());
  }

  static Feedback fromJsonEncoding(String jsonEncoding) {
    return fromMap(jsonDecode(jsonEncoding));
  }

}