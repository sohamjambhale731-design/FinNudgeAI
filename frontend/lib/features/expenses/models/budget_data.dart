class BudgetData {
  final int budgetId;
  final String month;
  final double allocatedBudget;
  final double remainingBudget;

  BudgetData({
    required this.budgetId,
    required this.month,
    required this.allocatedBudget,
    required this.remainingBudget,
  });

  factory BudgetData.fromJson(Map<String, dynamic> json) {
    return BudgetData(
      budgetId: json["budget_id"],
      month: json["month"],
      allocatedBudget: (json["allocated_budget"]).toDouble(),
      remainingBudget: (json["remaining_budget"]).toDouble(),
    );
  }
}

