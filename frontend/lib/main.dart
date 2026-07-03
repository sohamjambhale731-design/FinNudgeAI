import 'package:flutter/material.dart';
import 'routes/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/screens/login_screen.dart';


void main() {
  runApp(
    const FinNudgeAI(),
  );
}

class FinNudgeAI extends StatelessWidget {
  const FinNudgeAI({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}