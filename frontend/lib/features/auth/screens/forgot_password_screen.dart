import 'package:flutter/material.dart';

import '../services/forgot_password_service.dart';
import '../widgets/auth_textfield.dart';
import '../widgets/otp_boxes.dart';

enum ForgotPasswordStep {
  email,
  otp,
  password,
}

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState
    extends State<ForgotPasswordScreen> {

  final emailController =
      TextEditingController();

  final otpController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  final confirmPasswordController =
      TextEditingController();

  ForgotPasswordStep currentStep =
      ForgotPasswordStep.email;

  bool loading = false;

  String email = "";

  String otp = "";

  Future<void> sendOTP() async {

    if (emailController.text.trim().isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Enter email",
          ),
        ),
      );

      return;
    }

    setState(() {
      loading = true;
    });

    try {

      await ForgotPasswordService.sendOTP(
        email: emailController.text.trim(),
      );

      email = emailController.text.trim();

      setState(() {
        currentStep =
            ForgotPasswordStep.otp;
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "OTP Sent Successfully",
          ),
        ),
      );

    } catch (e) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );

    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
          const Color(0xffF8FAFC),

      appBar: AppBar(
        backgroundColor:
            const Color(0xffF8FAFC),
        elevation: 0,
        title: const Text(
          "Forgot Password",
        ),
      ),

      body: Center(

        child: SingleChildScrollView(

          padding:
              const EdgeInsets.all(24),

          child: Container(

            constraints:
                const BoxConstraints(
              maxWidth: 520,
            ),

            padding:
                const EdgeInsets.all(32),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  blurRadius: 25,
                  color: Colors.black
                      .withOpacity(.06),
                ),
              ],
            ),

            child: Column(

              children: [

                const Icon(
                  Icons.lock_reset,
                  size: 80,
                  color: Color(0xff14B8A6),
                ),

                const SizedBox(height: 20),

                StepperIndicator(
                  currentStep: currentStep,
                ),

                const SizedBox(height: 30),

                if (currentStep ==
                    ForgotPasswordStep.email)

                  buildEmailStep(),

                if (currentStep ==
                    ForgotPasswordStep.otp)

                  buildOtpStep(),

                if (currentStep ==
                    ForgotPasswordStep.password)

                  buildPasswordStep(),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildEmailStep() {

    return Column(

      children: [

        const Text(
          "Forgot Password?",
          style: TextStyle(
            fontSize: 28,
            fontWeight:
                FontWeight.bold,
          ),
        ),

        const SizedBox(height: 10),

        const Text(
          "Enter your email address to receive an OTP.",
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 30),

        AuthTextField(
          controller: emailController,
          hintText: "Email Address",
        ),

        const SizedBox(height: 30),

        SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton(

            onPressed:
                loading ? null : sendOTP,

            child: loading

                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )

                : const Text(
                    "Send OTP",
                  ),
          ),
        ),
      ],
    );
  }

  Widget buildOtpStep() {

    return Column(

      children: [

        const Text(
          "Verify OTP",
          style: TextStyle(
            fontSize: 28,
            fontWeight:
                FontWeight.bold,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          "OTP sent to\n$email",
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 30),

        OTPBoxes(
          controller: otpController,
        ),

        const SizedBox(height: 30),

        SizedBox(

          width: double.infinity,

          height: 55,

          child: ElevatedButton(

            onPressed: () {

              if (otpController.text.length != 6) {
              
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Enter a valid 6 digit OTP",
                    ),
                  ),
                );

                return;
              }

              otp = otpController.text;

              setState(() {
              
                currentStep =
                    ForgotPasswordStep.password;

              });

            },

            child:
                const Text("Continue"),
          ),
        ),
      ],
    );
  }
  Future<void> resetPassword() async {
    if (passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
        
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Fill all fields"),
        ),
      );
      return;
    }
    if (passwordController.text !=
        confirmPasswordController.text) {
        
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text("Passwords do not match"),
        ),
      );
      return;
    }
    setState(() {
      loading = true;
    });
    try {
    
      await ForgotPasswordService.resetPassword(
      
        email: email,
        otp: otp,
        newPassword:
            passwordController.text,
      );
      if (!mounted) return;
      await showDialog(
      
        context: context,
        builder: (_) {
        
          return AlertDialog(
          
            title: const Text(
              "Success",
            ),
            content: const Text(
              "Password changed successfully.",
            ),
            actions: [
            
              TextButton(
              
                onPressed: () {
                
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text(
                  "Login",
                ),
              ),
            ],
          );
        },
      );
    } catch (e) {
    
      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
    setState(() {
      loading = false;
    });
  }
  Widget buildPasswordStep() {
    return Column(
    
      children: [
      
        const Text(
        
          "Create New Password",
  
          style: TextStyle(
          
            fontSize: 28,
  
            fontWeight: FontWeight.bold,
  
          ),
        ),
  
        const SizedBox(height: 12),
  
        const Text(
        
          "Enter your new password.",
  
          textAlign: TextAlign.center,
  
        ),
  
        const SizedBox(height: 30),
  
        AuthTextField(
        
          controller:
              passwordController,
  
          hintText:
              "New Password",
  
          obscureText: true,
  
        ),
  
        const SizedBox(height: 20),
  
        AuthTextField(
        
          controller:
              confirmPasswordController,
  
          hintText:
              "Confirm Password",
  
          obscureText: true,
  
        ),
  
        const SizedBox(height: 30),
  
        SizedBox(
        
          width: double.infinity,
  
          height: 55,
  
          child: ElevatedButton(
          
            onPressed:
                loading
                    ? null
                    : resetPassword,
  
            child: loading
  
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
  
                : const Text(
                    "Reset Password",
                  ),
          ),
        ),
      ],
    );
  }
  
}

class StepperIndicator
    extends StatelessWidget {

  final ForgotPasswordStep currentStep;

  const StepperIndicator({
    super.key,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {

    int step = switch (currentStep) {
      ForgotPasswordStep.email => 1,
      ForgotPasswordStep.otp => 2,
      ForgotPasswordStep.password => 3,
    };

    return Row(

      children: List.generate(

        3,

        (index) {

          final active =
              index + 1 <= step;

          return Expanded(

            child: Container(

              margin:
                  const EdgeInsets.symmetric(
                horizontal: 4,
              ),

              height: 6,

              decoration: BoxDecoration(

                color: active
                    ? const Color(
                        0xff14B8A6,
                      )
                    : Colors.grey.shade300,

                borderRadius:
                    BorderRadius.circular(
                  20,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}