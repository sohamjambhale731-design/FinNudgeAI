
import 'package:flutter/material.dart';

import '../widgets/auth_button.dart';
import '../widgets/auth_textfield.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 50),

              const Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Start your financial journey today.",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 40),

              const AuthTextField(
                hintText: "Full Name",
              ),

              const SizedBox(height: 20),

              const AuthTextField(
                hintText: "Email",
              ),

              const SizedBox(height: 20),

              const AuthTextField(
                hintText: "Age",
              ),

              const SizedBox(height: 20),

              const AuthTextField(
                hintText: "Password",
                obscureText: true,
              ),

              const SizedBox(height: 20),

              const AuthTextField(
                hintText: "Confirm Password",
                obscureText: true,
              ),

              const SizedBox(height: 30),

              AuthButton(
                text: "Create Account",
                onPressed: () {},
              ),

              const SizedBox(height: 30),

              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Already have an account? Login",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}