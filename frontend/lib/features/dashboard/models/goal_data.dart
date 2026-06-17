class GoalData {
  final String goalName;
  final double currentAmount;
  final double targetAmount;

  final double savedThisMonth;
  final List<String> upcomingGoals;

  const GoalData({
    required this.goalName,
    required this.currentAmount,
    required this.targetAmount,
    required this.savedThisMonth,
    required this.upcomingGoals,
  });
}