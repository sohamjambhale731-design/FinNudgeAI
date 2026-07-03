class GoalData {
  final int goalId;
  final String goalName;
  final double currentAmount;
  final double targetAmount;
  final int priority;
  final String status;

  GoalData({
    required this.goalId,
    required this.goalName,
    required this.currentAmount,
    required this.targetAmount,
    required this.priority,
    required this.status,
  });

  double get progress => currentAmount / targetAmount;

  factory GoalData.fromJson(Map<String, dynamic> json) {
    return GoalData(
      goalId: json['goal_id'],
      goalName: json['goal_name'],
      currentAmount: (json['current_amount']).toDouble(),
      targetAmount: (json['target_amount']).toDouble(),
      priority: json['priority'],
      status: json['status'],
    );
  }
}

