import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constants/api_constants.dart';
import '../storage/token_storage.dart';

class DashboardApi {

  static Future<Map<String, dynamic>> getDashboard(
    String month,
  ) async {
    final token = await TokenStorage.getAccessToken();

    if (token == null) {
      throw Exception('Not logged in');
    }

    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/dashboard/$month'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }

    return Map<String, dynamic>.from(
      jsonDecode(response.body),
    );
  }
}