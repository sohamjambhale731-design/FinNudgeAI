import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constants/api_constants.dart';
import '../storage/token_storage.dart';

class InsightApi {
  static Future<List<dynamic>> getAnalytics() async {
    final token = await TokenStorage.getAccessToken();

    final response = await http.get(
      Uri.parse(
        '${ApiConstants.baseUrl}/analytics',
      ),
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }

    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> getMonthlyReport(
    String month,
  ) async {
    final token = await TokenStorage.getAccessToken();

    final response = await http.get(
      Uri.parse(
        '${ApiConstants.baseUrl}/analytics/monthly-report/$month',
      ),
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }

    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> getSavingsInsights(
    String month,
  ) async {
    final token = await TokenStorage.getAccessToken();

    final response = await http.get(
      Uri.parse(
        '${ApiConstants.baseUrl}/analytics/insights/$month',
      ),
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }

    return jsonDecode(response.body);
  }

  static Future<List<dynamic>> getGoalReport() async {
    final token = await TokenStorage.getAccessToken();

    final response = await http.get(
      Uri.parse(
        '${ApiConstants.baseUrl}/analytics/goal-report',
      ),
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }

    final data = jsonDecode(response.body);
    return data;

  }


  static Future<Map<String, dynamic>> getCategoryComparison(
    String month,
  ) async {
    final token = await TokenStorage.getAccessToken();

    final response = await http.get(
      Uri.parse(
        '${ApiConstants.baseUrl}/analytics/category-comparison/$month',
      ),
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }

    return Map<String, dynamic>.from(
      jsonDecode(response.body),
    );
  }

  static Future<List<dynamic>> getHealthScoreHistory() async {
    final token = await TokenStorage.getAccessToken();

    final response = await http.get(
      Uri.parse(
        '${ApiConstants.baseUrl}/analytics/health-score-history',
      ),
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }

    return jsonDecode(response.body);
  }

  static Future<List<dynamic>> getTrends() async {
    final token = await TokenStorage.getAccessToken();

    final response = await http.get(
      Uri.parse(
        '${ApiConstants.baseUrl}/analytics/trends',
      ),
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }

    return jsonDecode(response.body);
  }

  static Future<List<dynamic>> getNudges() async {
    final token = await TokenStorage.getAccessToken();


    final response = await http.get(
      Uri.parse(
        '${ApiConstants.baseUrl}/analytics/nudges',
      ),
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }

    return jsonDecode(response.body);
  }
}

