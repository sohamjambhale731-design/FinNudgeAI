import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constants/api_constants.dart';
import '../storage/token_storage.dart';

class GoalApi {
  static Future<List<dynamic>> getGoals() async {

    final token = await TokenStorage.getAccessToken();

    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/goal'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }

    return jsonDecode(response.body) as List<dynamic>;
  }

  static Future<void> createGoal({
    required String goalName,
    required double targetAmount,
    required int priority,
    required String targetDate,
  }) async {
    final token = await TokenStorage.getAccessToken();

    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/goal'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'goal_name': goalName,
        'target_amount': targetAmount,
        'priority': priority,
        'target_date': targetDate,
      }),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(response.body);
    }
  }

  static Future<void> addContribution({
    required int goalId,
    required double amount,
    required String date,
  }) async {
    final token = await TokenStorage.getAccessToken();

    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/goal/$goalId/contribute'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'amount': amount,
        'date': date,
      }),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(response.body);
    }
  }
}

