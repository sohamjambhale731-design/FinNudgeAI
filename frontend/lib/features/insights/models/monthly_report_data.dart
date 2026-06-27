class MonthlyReportData {
  final String month;
  final double income;
  final double fixedExpenses;
  final double variableExpenses;
  final double totalExpenses;
  final double totalSaved;
  final double savingsRate;

  MonthlyReportData({
    required this.month,
    required this.income,
    required this.fixedExpenses,
    required this.variableExpenses,
    required this.totalExpenses,
    required this.totalSaved,
    required this.savingsRate,
  });

  factory MonthlyReportData.fromJson(
      Map<String, dynamic> json) {
    return MonthlyReportData(
      month: json["month"] ?? "",
      income: (json["income"] ?? 0).toDouble(),
      fixedExpenses: (json["fixed_expenses"] ?? 0).toDouble(),
      variableExpenses:
          (json["variable_expenses"] ?? 0).toDouble(),
      totalExpenses:
          (json["total_expense"] ?? 0).toDouble(),
      totalSaved: (json["total_saved"] ?? 0).toDouble(),
      savingsRate: (json["savings_rate"] ?? 0).toDouble(),
    );
  }

}

