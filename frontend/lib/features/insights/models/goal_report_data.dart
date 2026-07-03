class GoalReportData {
  final String goalName;

  final double targetAmount;

  final double currentAmount;

  final double remainingAmount;

  final double completionPercentage;

  final String status;

  GoalReportData({
    required this.goalName,
    required this.targetAmount,
    required this.currentAmount,
    required this.remainingAmount,
    required this.completionPercentage,
    required this.status,
  });

  factory GoalReportData.fromJson(Map<String, dynamic> json) {
    return GoalReportData(
      goalName: json["goal_name"] ?? "",
      targetAmount: (json["target_amount"] ?? 0).toDouble(),
      currentAmount: (json["current_amount"] ?? 0).toDouble(),
      remainingAmount: (json["remaining_amount"] ?? 0).toDouble(),
      completionPercentage:
          (json["completion_percentage"] ?? 0).toDouble(),
      status: json["status"] ?? "",
    );
  }
}

