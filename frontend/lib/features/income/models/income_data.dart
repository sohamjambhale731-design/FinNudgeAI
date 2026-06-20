class IncomeData {
  final double primaryIncome;
  final double additionalIncome;
  final double totalIncome;
  final String month;

  IncomeData({
    required this.primaryIncome,
    required this.additionalIncome,
    required this.totalIncome,
    required this.month,
  });

  factory IncomeData.fromJson(
    Map<String, dynamic> json,
  ) {
    return IncomeData(
      primaryIncome:
          (json["primary_income"]).toDouble(),

      additionalIncome:
          (json["total_additional_income"])
              .toDouble(),

      totalIncome:
          (json["total_income"]).toDouble(),

      month: json["month"],
    );
  }
}