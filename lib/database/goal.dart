import 'dart:convert';

// final String tableGoals = 'goals';

// class GoalFields {
//   static final List<String> values = [
//     goalId, goal, difficultyLevel, startDate, endDate, multiplier, progress
//   ];
//
//   static final String goalId = '_id';
//   static final String goal = 'goal';
//   static final String difficultyLevel = 'difficultyLevel';
//   static final String startDate = 'startDate';
//   static final String endDate = 'endDate';
//   static final String multiplier = 'multiplier';
//   static final String progress = 'progress';
// }

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

  // Goal copy({
  //   int? goalId,
  //   String? goal,
  //   String? difficultyLevel,
  //   DateTime? startDate,
  //   DateTime? endDate,
  //   int? multiplier,
  //   double? progress,
  // }) =>
  //     Goal(
  //       goalId: goalId ?? this.goalId,
  //       goal: goal ?? this.goal,
  //       difficultyLevel: difficultyLevel ?? this.difficultyLevel,
  //       startDate: startDate ?? this.startDate,
  //       endDate: endDate ?? this.endDate,
  //       multiplier: multiplier ?? this.multiplier,
  //       progress: progress ?? this.progress,
  //     );

  // static Goal fromJson(Map<String, Object?> json) => Goal(
  //   goalId: json[GoalFields.goalId] as int?,
  //   goal: json[GoalFields.goal] as String,
  //   difficultyLevel: json[GoalFields.difficultyLevel] as String,
  //   startDate: DateTime.parse(json[GoalFields.startDate] as String),
  //   endDate: DateTime.parse(json[GoalFields.endDate] as String),
  //   multiplier: json[GoalFields.multiplier] as int,
  //   progress: json[GoalFields.progress] as double,
  // );

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
  // Map<String, Object?> toJson() => {
  //   GoalFields.goalId: goalId,
  //   GoalFields.goal: goal,
  //   GoalFields.difficultyLevel: difficultyLevel,
  //   GoalFields.startDate: startDate.toIso8601String(),
  //   GoalFields.endDate: endDate.toIso8601String(),
  //   GoalFields.multiplier: multiplier,
  //   GoalFields.progress: progress,
  // };

}
