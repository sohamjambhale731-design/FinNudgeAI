import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constants/api_constants.dart';

class AuthApi {

  static Future<Map<String, dynamic>>
  register({

    required String fullName,
    required String email,
    required String password,
    required int age,
    required String userType,

  }) async {

    final response = await http.post(

      Uri.parse(
        "${ApiConstants.baseUrl}/auth/register",
      ),

      headers: {
        "Content-Type":
            "application/json",
      },

      body: jsonEncode({

        "full_name": fullName,
        "email": email,
        "password": password,
        "age": age,
        "user_type": userType,

      }),
    );

    return jsonDecode(
      response.body,
    );
  }
  static Future<Map<String, dynamic>>
  login({
  
    required String email,
    required String password,
  
  }) async {
  
    final response = await http.post(
    
      Uri.parse(
        "${ApiConstants.baseUrl}/auth/login",
      ),
  
      headers: {
        "Content-Type":
            "application/json",
      },
  
      body: jsonEncode({
      
        "email": email,
        "password": password,
  
      }),
    );
  
    return jsonDecode(
      response.body,
    );
  }
}