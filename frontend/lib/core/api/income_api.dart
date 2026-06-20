import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants/api_constants.dart';
import '../storage/token_storage.dart';

class IncomeApi {

  static Future<List<dynamic>>
     getIncome() async {

    final token =
        await TokenStorage.getAccessToken();

    final response =
        await http.get(

      Uri.parse(
        '${ApiConstants.baseUrl}/income',
      ),

      headers: {
        'Authorization':
            'Bearer $token',
      },
    );

    return jsonDecode(
      response.body,
    );
  }
}