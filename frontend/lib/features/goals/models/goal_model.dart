class GoalModel {
  final String title;
  final double currentAmount;
  final double targetAmount;

  const GoalModel({
    required this.title,
    required this.currentAmount,
    required this.targetAmount,
  });

  double get progress =>
      currentAmount / targetAmount;
}