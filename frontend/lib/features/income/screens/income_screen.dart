import 'package:flutter/material.dart';

import '../../../shared/widgets/bottom_nav_bar.dart';

class IncomeScreen extends StatelessWidget {
  const IncomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Income'),
      ),
      body: const Center(
        child: Text(
          'Income Screen',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bottomNavigationBar: const FinNudgeBottomNavBar(
        currentIndex: 1,
      ),
    );
  }
}