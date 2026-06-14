import 'package:flutter/material.dart';

import '../../../shared/widgets/bottom_nav_bar.dart';

class GoalScreen extends StatelessWidget {
  const GoalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Goals'),
      ),
      body: const Center(
        child: Text(
          'Goal Screen',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bottomNavigationBar: const FinNudgeBottomNavBar(
        currentIndex: 3,
      ),
    );
  }
}