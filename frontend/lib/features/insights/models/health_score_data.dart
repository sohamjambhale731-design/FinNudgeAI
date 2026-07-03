class HealthScoreData {
  final String month;
  final double financialHealthScore;

  HealthScoreData({
    required this.month,
    required this.financialHealthScore,
  });

  factory HealthScoreData.fromJson(
      Map<String, dynamic> json) {
    return HealthScoreData(
      month: json["month"] ?? "",
      financialHealthScore:
          (json["financial_health_score"] ?? 0)
              .toDouble(),
    );
  }
}

