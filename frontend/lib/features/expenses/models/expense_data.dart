class ExpenseData {
  final int expenseId;
  final String category;
  final double amount;
  final String note;
  final String date;

  ExpenseData({
    required this.expenseId,
    required this.category,
    required this.amount,
    required this.note,
    required this.date,
  });

  factory ExpenseData.fromJson(
    Map<String, dynamic> json,
  ) {
    return ExpenseData(
      expenseId: json["expense_id"],
      category: json["category"],
      amount: (json["amount"]).toDouble(),
      note: json["note"] ?? "",
      date: json["date"] ?? "",
    );
  }
}

