import 'dart:convert';

class Feedbacks {

  final int workoutId;
  final int feedback;

  const Feedbacks({
    required this.workoutId,
    required this.feedback
  });

  static Feedbacks fromMap(Map<String, dynamic> map) {
    int workoutId = map['workoutId'];
    int feedback = map['feedback'];

    return Feedbacks(
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

  static Feedbacks fromJsonEncoding(String jsonEncoding) {
    return fromMap(jsonDecode(jsonEncoding));
  }

}