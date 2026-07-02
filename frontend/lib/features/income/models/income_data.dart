class IncomeData {

  final int incomeId;
  final double primaryIncome;
  final double additionalIncome;
  final double totalIncome;
  final String month;
  final int year;

  IncomeData({
    required this.incomeId,
    required this.primaryIncome,
    required this.additionalIncome,
    required this.totalIncome,
    required this.month,
    required this.year,
  });

  factory IncomeData.fromJson(
    Map<String,dynamic> json,
  ) {
  
    return IncomeData(
      incomeId: json["income_id"],

      primaryIncome:
          (json["primary_income"])
              .toDouble(),

      additionalIncome:
          (json["total_additional_income"])
              .toDouble(),

      totalIncome:
          (json["total_income"])
              .toDouble(),

      month: json["month"],
      year: json["year"],
    );
  }
}