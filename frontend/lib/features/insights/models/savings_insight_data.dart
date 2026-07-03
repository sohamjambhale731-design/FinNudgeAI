class GoalPrediction {
  final String goalName;
  final double remainingAmount;
  final double months;

  GoalPrediction({
    required this.goalName,
    required this.remainingAmount,
    required this.months,
  });

  factory GoalPrediction.fromJson(Map<String, dynamic> json) {
    return GoalPrediction(
      goalName: json["goal_name"],
      remainingAmount: (json["remaining_amount"] as num).toDouble(),
      months: (json["months_to_complete"] as num).toDouble(),
    );
  }
}

class SavingsInsightData {
  final String month;
  final double savingsPotential;
  final List<GoalPrediction> goals;

  SavingsInsightData({
    required this.month,
    required this.savingsPotential,
    required this.goals,
  });

  factory SavingsInsightData.fromJson(Map<String, dynamic> json) {
    return SavingsInsightData(
      month: json["month"],
      savingsPotential: (json["savings_potential"] as num).toDouble(),
      goals: (json["goal_predictions"] as List)
          .map(
            (e) => GoalPrediction.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}

