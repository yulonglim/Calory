final String tableGoals = 'goals';

class GoalFields {
  static final String id = '_id';
  static final String goal = 'goal';
  static final String difficultyLevel = 'difficultyLevel';
  static final String startDate = 'startDate';
  static final String endDate = 'endDate';
  static final String multiplier = 'multiplier';
  static final String progress = 'progress';
}

class Goal {

  final int? goalId;
  final String goal;
  final String difficultyLevel;
  final DateTime startDate;
  final DateTime endDate;
  final int multiplier;
  final double progress;

  const Goal({
    this.goalId,
    required this.goal,
    required this.difficultyLevel,
    required this.startDate,
    required this.endDate,
    required this.multiplier,
    required this.progress,
  });

}