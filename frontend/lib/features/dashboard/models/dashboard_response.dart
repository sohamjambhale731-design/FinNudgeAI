class DashboardResponse {
  final Map<String, dynamic> data;

  DashboardResponse({
    required this.data,
  });

  factory DashboardResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return DashboardResponse(
      data: json,
    );
  }
}