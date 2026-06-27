class CategoryData {
  final String category;
  final double amount;

  CategoryData({
    required this.category,
    required this.amount,
  });

  factory CategoryData.fromJson(
      Map<String, dynamic> json) {
    return CategoryData(
      category: json["category"],
      amount: (json["amount"] as num).toDouble(),
    );
  }
}