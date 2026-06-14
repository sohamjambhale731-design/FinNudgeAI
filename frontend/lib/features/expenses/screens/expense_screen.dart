import 'package:flutter/material.dart';

import '../../../shared/widgets/bottom_nav_bar.dart';

class ExpenseScreen extends StatelessWidget {
  const ExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses'),
      ),
      body: const Center(
        child: Text(
          'Expense Screen',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bottomNavigationBar: const FinNudgeBottomNavBar(
        currentIndex: 2,
      ),
    );
  }
}