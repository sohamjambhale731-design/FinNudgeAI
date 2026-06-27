import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants/api_constants.dart';
import '../storage/token_storage.dart';

class ExpenseApi {
  static Future<List<dynamic>> getExpenses() async {
    final token = await TokenStorage.getAccessToken();

    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/expense/variable'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    return jsonDecode(response.body);
  }

  static Future<List<dynamic>> getBudgets() async {
    final token = await TokenStorage.getAccessToken();

    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/expense/budget'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    return jsonDecode(response.body);
  }

  static Future<void> updateBudget({
    required int budgetId,
    required double allocatedBudget,
  }) async {
    final token = await TokenStorage.getAccessToken();

    final response = await http.put(
      Uri.parse('${ApiConstants.baseUrl}/expense/budget/$budgetId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "allocated_budget": allocatedBudget,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }
  }

  static Future<void> addExpense({
    required String category,
    required double amount,
    required String note,
    required String date,
  }) async {
    final token = await TokenStorage.getAccessToken();

    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/expense/variable'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "category": category,
        "amount": amount,
        "note": note,
        "date": date,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }
  }

  static Future<void> updateExpense({
    required int expenseId,
    required String category,
    required double amount,
    required String note,
  }) async {
    final token = await TokenStorage.getAccessToken();

    final response = await http.put(
      Uri.parse('${ApiConstants.baseUrl}/expense/variable/$expenseId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "category": category,
        "amount": amount,
        "note": note,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }
  }
}


