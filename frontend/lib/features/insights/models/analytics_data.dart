class AnalyticsData {
  final int analyticsId;
  final String month;
  final double totalSpent;
  final double totalSaved;
  final double savingsRate;
  final double financialHealthScore;

  AnalyticsData({
    required this.analyticsId,
    required this.month,
    required this.totalSpent,
    required this.totalSaved,
    required this.savingsRate,
    required this.financialHealthScore,
  });

  factory AnalyticsData.fromJson(
      Map<String, dynamic> json) {
    return AnalyticsData(
      analyticsId: json["analytics_id"],
      month: json["month"],
      totalSpent: (json["total_spent"] as num).toDouble(),
      totalSaved: (json["total_saved"] as num).toDouble(),
      savingsRate:
          (json["savings_rate"] as num).toDouble(),
      financialHealthScore:
          (json["financial_health_score"] as num)
              .toDouble(),
    );
  }
}