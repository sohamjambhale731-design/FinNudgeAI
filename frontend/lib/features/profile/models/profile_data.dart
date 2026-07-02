class ProfileData {
  final double income;
  final double expense;
  final double saved;
  final int goals;
  final double healthScore;
  final String level;

  ProfileData({
    required this.income,
    required this.expense,
    required this.saved,
    required this.goals,
    required this.healthScore,
    required this.level,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      income: (json['wallet_summary']['total_income'] as num).toDouble(),
      expense: (json['wallet_summary']['total_expense'] as num).toDouble(),
      saved: (json['wallet_summary']['total_saved'] as num).toDouble(),
      goals: json['goals_overview']['active_goals'] as int,
      healthScore: (json['monthly_snapshot']['financial_health_score']
          as num)
          .toDouble(),
      level: json['money_streak']['level'] as String,
    );
  }
}

