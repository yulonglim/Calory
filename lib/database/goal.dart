import 'dart:convert';

class Goal {
  final int? goalId;
  final int goal;
  final int difficultyLevel;
  final String startDate;
  final String endDate;
  final int multiplier;
  final int progress;

  const Goal({
    this.goalId,
    required this.goal,
    required this.difficultyLevel,
    required this.startDate,
    required this.endDate,
    required this.multiplier,
    required this.progress,
  });

  static Goal fromMap(Map<String, dynamic> map) {
    int goalId = map['goalId'];
    int goal = map['goal'];
    int difficultyLevel = map['difficultyLevel'];
    String startDate = map['startDate'];
    String endDate = map['endDate'];
    int multiplier = map['multiplier'];
    int progress = map['progress'];

    return Goal(
        goalId: goalId,
        goal: goal,
        difficultyLevel: difficultyLevel,
        startDate: startDate,
        endDate: endDate,
        multiplier: multiplier,
        progress: progress);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'goalId': goalId,
      'goal': goal,
      'difficultyLevel': difficultyLevel,
      'startDate': startDate,
      'endDate': endDate,
      'multiplier': multiplier,
      'progress': progress,
    };

    if (this.goalId != null) {
      map['goalId'] = this.goalId;
    }

    return map;
  }

  String toJsonEncoding() {
    return jsonEncode(this.toMap());
  }

  static Goal fromJsonEncoding(String jsonEncoding) {
    return fromMap(jsonDecode(jsonEncoding));
  }

  @override
  String toString() {
    return "goalId: $goalId, goal: $goal, difficulty: $difficultyLevel, startdate: $startDate, endDate: $endDate, multiplier $multiplier, progress $progress";
  }


}
