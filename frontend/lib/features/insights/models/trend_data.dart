class TrendData {
  final String month;

  final double totalSpent;

  final double totalSaved;

  final double savingsRate;

  final double financialHealthScore;

  TrendData({
    required this.month,
    required this.totalSpent,
    required this.totalSaved,
    required this.savingsRate,
    required this.financialHealthScore,
  });

  factory TrendData.fromJson(Map<String, dynamic> json) {
    return TrendData(
      month: json["month"] ?? "",
      totalSpent:
          (json["total_spent"] ?? 0).toDouble(),
      totalSaved:
          (json["total_saved"] ?? 0).toDouble(),
      savingsRate:
          (json["savings_rate"] ?? 0).toDouble(),
      financialHealthScore:
          (json["financial_health_score"] ?? 0)
              .toDouble(),
    );
  }
}



