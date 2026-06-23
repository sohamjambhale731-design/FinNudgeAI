import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants/api_constants.dart';
import '../storage/token_storage.dart';

class IncomeApi {
  static Future<List<dynamic>> getIncome() async {
    final token = await TokenStorage.getAccessToken();

    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/income'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    return jsonDecode(response.body);
  }

  static Future<void> updateIncome({
    required int incomeId,
    required double primaryIncome,
  }) async {
    print("UPDATE INCOME");
    print("ID: $incomeId");
    print("AMOUNT: $primaryIncome");

    final token = await TokenStorage.getAccessToken();

    final response = await http.put(
      Uri.parse('${ApiConstants.baseUrl}/income/$incomeId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "primary_income": primaryIncome,
      }),
    );

    print("STATUS: ${response.statusCode}");
    print("BODY: ${response.body}");

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }
  }

  static Future<void> addAdditionalIncome({
    required String sourceName,
    required double amount,
    required String date,
  }) async {
    final token = await TokenStorage.getAccessToken();

    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/income/additional'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "source_name": sourceName,
        "amount": amount,
        "date": date,
      }),
    );

    print("SOURCE: $sourceName");
    print("AMOUNT: $amount");
    print("DATE: $date");

    print(response.statusCode);
    print(response.body);

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }
  }
}

