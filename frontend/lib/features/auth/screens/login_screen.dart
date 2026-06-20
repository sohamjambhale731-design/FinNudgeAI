  import 'package:flutter/material.dart';

  import '../../../core/api/auth_api.dart';
  import '../../../core/colors/app_colors.dart';

  import '../widgets/auth_button.dart';
  import '../widgets/auth_textfield.dart';
  import '../../../core/storage/token_storage.dart';
  import '../../dashboard/screens/dashboard_screen.dart';
  import '../../../core/api/dashboard_api.dart';
  import '../../../core/api/income_api.dart';
  import 'package:go_router/go_router.dart';


  import 'forgot_password_screen.dart';
  import 'register_screen.dart';

  class LoginScreen extends StatefulWidget {
    const LoginScreen({
      super.key,
    });

    @override
    State<LoginScreen> createState() =>
        _LoginScreenState();
  }

  class _LoginScreenState
      extends State<LoginScreen> {

    final emailController =
        TextEditingController();

    final passwordController =
        TextEditingController();

    @override
    Widget build(BuildContext context) {
      print("LOGIN SCREEN BUILD");

      return Scaffold(
        backgroundColor:
            AppColors.background,

        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.all(
                24,
              ),

              child: Container(
                constraints:
                    const BoxConstraints(
                  maxWidth: 500,
                ),

                padding:
                    const EdgeInsets.all(
                  32,
                ),

                decoration:
                    BoxDecoration(
                  color: Colors.white,

                  borderRadius:
                      BorderRadius.circular(
                    24,
                  ),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black
                          .withOpacity(
                        0.08,
                      ),

                      blurRadius: 20,

                      offset:
                          const Offset(
                        0,
                        8,
                      ),
                    ),
                  ],
                ),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .stretch,

                  children: [

                    const SizedBox(
                      height: 20,
                    ),

                    Center(
                      child: Container(
                        height: 90,
                        width: 90,

                        decoration:
                            BoxDecoration(
                          color:
                              AppColors
                                  .accent,

                          borderRadius:
                              BorderRadius
                                  .circular(
                            24,
                          ),
                        ),

                        child:
                            const Center(
                          child: Text(
                            "FN",

                            style:
                                TextStyle(
                              color:
                                  Colors
                                      .white,

                              fontSize:
                                  34,

                              fontWeight:
                                  FontWeight
                                      .bold,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 25,
                    ),

                    const Text(
                      "Welcome Back",

                      textAlign:
                          TextAlign.center,

                      style: TextStyle(
                        fontSize: 32,
                        fontWeight:
                            FontWeight
                                .bold,
                        color:
                            AppColors
                                .textPrimary,
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    const Text(
                      "Your AI-powered financial companion.",

                      textAlign:
                          TextAlign.center,

                      style: TextStyle(
                        color:
                            AppColors
                                .textSecondary,

                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(
                      height: 40,
                    ),

                    AuthTextField(
                      hintText: "Email",
                      controller:
                          emailController,
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    AuthTextField(
                      hintText:
                          "Password",

                      obscureText:
                          true,

                      controller:
                          passwordController,
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Align(
                      alignment:
                          Alignment
                              .centerRight,

                      child: TextButton(
                        onPressed: () {

                          Navigator.push(
                            context,

                            MaterialPageRoute(
                              builder: (_) =>
                                  const ForgotPasswordScreen(),
                            ),
                          );
                        },

                        child:
                            const Text(
                          "Forgot Password?",
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    AuthButton(
                      text: "Login",

                      onPressed: () async {
                        print("LOGIN BUTTON CLICKED");
                      
                        try {
                        
                          final result =
                              await AuthApi.login(
                             email: emailController.text,
                             password: passwordController.text,
                          );

                          await TokenStorage.saveTokens(
                            accessToken:
                                result["access_token"],
                            refreshToken:
                                result["refresh_token"],
                          );

                          print("STEP 1");
                          final dashboardData =
                              await DashboardApi.getDashboard(
                            "June",
                          );

                          final income =
                              await IncomeApi.getIncome();

                          print(
                            "INCOME DATA",
                          );

                          print(
                            income,
                          );

                          print("STEP 2");

                          print(dashboardData);

                          final token =
                              await TokenStorage
                                  .getAccessToken();

                          print(
                            token,
                          );

                          print(
                            result,
                          );

                          if (context.mounted) {

                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(
                            
                              const SnackBar(
                                content: Text(
                                  "Login Successful",
                                ),
                              ),
                            );

                            context.go('/dashboard');
                          }

                        } catch (e) {
                        
                          print(e);

                          if (context.mounted) {
                          
                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(
                            
                              SnackBar(
                                content: Text(
                                  e.toString(),
                                ),
                              ),
                            );
                          }
                        }
                      },
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    Row(
                      children: [

                        const Expanded(
                          child:
                              Divider(),
                        ),

                        Padding(
                          padding:
                              const EdgeInsets
                                  .symmetric(
                            horizontal:
                                12,
                          ),

                          child: Text(
                            "OR",

                            style:
                                TextStyle(
                              color:
                                  AppColors
                                      .textSecondary,
                            ),
                          ),
                        ),

                        const Expanded(
                          child:
                              Divider(),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    OutlinedButton.icon(
                      onPressed: () {},

                      icon:
                          const Icon(
                        Icons
                            .g_mobiledata,
                        size: 30,
                      ),

                      label:
                          const Text(
                        "Continue with Google",
                      ),
                    ),

                    const SizedBox(
                      height: 25,
                    ),

                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .center,

                      children: [

                        const Text(
                          "Don't have an account?",
                        ),

                        TextButton(
                          onPressed: () {

                            Navigator.push(
                              context,

                              MaterialPageRoute(
                                builder: (_) =>
                                    const RegisterScreen(),
                              ),
                            );
                          },

                          child:
                              const Text(
                            "Register",
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