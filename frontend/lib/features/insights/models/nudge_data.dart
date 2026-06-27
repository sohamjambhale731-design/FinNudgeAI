class NudgeData {
  final String message;
  final String priority;
  final String category;

  NudgeData({
    required this.message,
    required this.priority,
    required this.category,
  });

  factory NudgeData.fromJson(
      Map<String, dynamic> json) {
    return NudgeData(
      message: json["message"],
      priority: json["priority"],
      category: json["category"],
    );
  }
}