import 'package:flutter/material.dart';

import '../widgets/auth_button.dart';
import '../widgets/auth_textfield.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),

            child: Container(
              constraints: const BoxConstraints(
                maxWidth: 500,
              ),

              padding: const EdgeInsets.all(32),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  Center(
                    child: Container(
                      height: 90,
                      width: 90,

                      decoration: BoxDecoration(
                        color: const Color(0xFF14B8A6),
                        borderRadius: BorderRadius.circular(24),
                      ),

                      child: const Icon(
                        Icons.person_add_alt_1_rounded,
                        color: Colors.white,
                        size: 42,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    "Join FinNudge",
                    textAlign: TextAlign.center,

                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Create your account and start building better money habits.",
                    textAlign: TextAlign.center,

                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 40),

                  const AuthTextField(
                    hintText: "Full Name",
                    prefixIcon: Icons.person_outline,
                  ),

                  const SizedBox(height: 20),

                  const AuthTextField(
                    hintText: "Email",
                    prefixIcon: Icons.mail_outline,
                  ),

                  const SizedBox(height: 20),

                  const AuthTextField(
                    hintText: "Age",
                    prefixIcon: Icons.cake_outlined,
                  ),

                  const SizedBox(height: 20),

                  const AuthTextField(
                    hintText: "Password",
                    obscureText: true,
                    prefixIcon: Icons.lock_outline,
                  ),

                  const SizedBox(height: 20),

                  const AuthTextField(
                    hintText: "Confirm Password",
                    obscureText: true,
                    prefixIcon: Icons.lock_outline,
                  ),

                  const SizedBox(height: 30),

                  AuthButton(
                    text: "Create Account",
                    onPressed: () {},
                  ),

                  const SizedBox(height: 25),

                  Row(
                    children: const [
                      Expanded(child: Divider()),

                      Padding(
                        padding:
                            EdgeInsets.symmetric(
                          horizontal: 12,
                        ),

                        child: Text(
                          "OR",
                        ),
                      ),

                      Expanded(child: Divider()),
                    ],
                  ),

                  const SizedBox(height: 20),

                  OutlinedButton.icon(
                    onPressed: () {},

                    icon: const Icon(
                      Icons.g_mobiledata,
                      size: 30,
                    ),

                    label: const Text(
                      "Sign up with Google",
                    ),
                  ),

                  const SizedBox(height: 25),

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center,

                    children: [

                      const Text(
                        "Already have an account?",
                      ),

                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },

                        child: const Text(
                          "Login",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}