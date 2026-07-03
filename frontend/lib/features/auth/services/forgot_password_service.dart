import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../core/constants/api_constants.dart';

class ForgotPasswordService {
  /// STEP 1
  /// Send OTP to email
  static Future<void> sendOTP({
    required String email,
  }) async {
    final response = await http.post(
      Uri.parse(
        "${ApiConstants.baseUrl}/auth/send-reset-otp",
      ),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "email": email,
      }),
    );

    if (response.statusCode != 200) {
      final body = jsonDecode(response.body);

      throw Exception(
        body["detail"] ?? "Failed to send OTP",
      );
    }
  }

  /// STEP 2
  /// Reset password
  static Future<void> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    final response = await http.post(
      Uri.parse(
        "${ApiConstants.baseUrl}/auth/reset-password",
      ),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "email": email,
        "otp": otp,
        "new_password": newPassword,
      }),
    );

    if (response.statusCode != 200) {
      final body = jsonDecode(response.body);

      throw Exception(
        body["detail"] ??
            "Unable to reset password",
      );
    }
  }
}