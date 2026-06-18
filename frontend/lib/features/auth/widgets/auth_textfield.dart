import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {

  final String hintText;
  final bool obscureText;
  final IconData? prefixIcon;
  final TextEditingController? controller;

  const AuthTextField({
    super.key,
    required this.hintText,
    this.obscureText = false,
    this.prefixIcon,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {

    return TextField(

      controller: controller,

      obscureText: obscureText,

      style: const TextStyle(
        color: Color(0xFF0F172A),
        fontSize: 16,
      ),

      decoration: InputDecoration(
        hintText: hintText,

        hintStyle: const TextStyle(
          color: Color(0xFF64748B),
          fontSize: 16,
        ),

        prefixIcon: Icon(
          prefixIcon ??
              (hintText == "Email"
                  ? Icons.mail_outline
                  : Icons.person_outline),
          color: const Color(0xFF64748B),
        ),

        filled: true,
        fillColor: Colors.white,

        contentPadding:
            const EdgeInsets.symmetric(
          vertical: 20,
        ),

        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(16),

          borderSide: const BorderSide(
            color: Color(0xFFE5E7EB),
          ),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(16),

          borderSide: const BorderSide(
            color: Color(0xFFE5E7EB),
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(16),

          borderSide: const BorderSide(
            color: Color(0xFF14B8A6),
            width: 2,
          ),
        ),
      ),
    );
  }
}