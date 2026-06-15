import 'package:flutter/material.dart';
import '../widgets/auth_textfield.dart';
class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF8FAFC),

      appBar: AppBar(
        backgroundColor:
            const Color(0xFFF8FAFC),

        elevation: 0,

        title: const Text(
          "Reset Password",
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Center(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.all(24),

          child: Container(
            constraints:
                const BoxConstraints(
              maxWidth: 500,
            ),

            padding:
                const EdgeInsets.all(32),

            decoration: BoxDecoration(
              color: Colors.white,

              borderRadius:
                  BorderRadius.circular(
                24,
              ),

              boxShadow: [
                BoxShadow(
                  color: Colors.black
                      .withOpacity(0.05),

                  blurRadius: 20,
                ),
              ],
            ),

            child: Column(
              children: [

                Container(
                  height: 90,
                  width: 90,

                  decoration:
                      BoxDecoration(
                    color: const Color(
                        0xFF14B8A6),

                    borderRadius:
                        BorderRadius
                            .circular(
                      20,
                    ),
                  ),

                  child: const Icon(
                    Icons.lock_reset,
                    color: Colors.white,
                    size: 40,
                  ),
                ),

                const SizedBox(
                  height: 24,
                ),

                const Text(
                  "Forgot Password?",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                const Text(
                  "Enter your email address and we'll send a reset link.",
                  textAlign:
                      TextAlign.center,
                ),

                const SizedBox(
                  height: 30,
                ),

                const AuthTextField(
                  hintText: "Email Address",
                ),

                const SizedBox(
                  height: 24,
                ),

                SizedBox(
                  width:
                      double.infinity,
                  height: 56,

                  child: ElevatedButton(
                    onPressed: () {},

                    style: ElevatedButton.styleFrom(
  backgroundColor: const Color(
    0xFF14B8A6,
  ),

  foregroundColor:
      Colors.white,

  shape:
      RoundedRectangleBorder(
    borderRadius:
        BorderRadius.circular(
      16,
    ),
  ),
),

                    child: const Row(
  mainAxisAlignment:
      MainAxisAlignment.center,

  children: [
    Text(
      "Send Reset Link",
    ),

    SizedBox(width: 8),

    Icon(
      Icons.arrow_forward_rounded,
      size: 18,
    ),
  ],
),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}