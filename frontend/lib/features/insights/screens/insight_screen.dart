import 'package:flutter/material.dart';

import '../../../shared/widgets/bottom_nav_bar.dart';

class InsightScreen extends StatelessWidget {
  const InsightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insights'),
      ),
      body: const Center(
        child: Text(
          'Insight Screen',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bottomNavigationBar: const FinNudgeBottomNavBar(
        currentIndex: 4,
      ),
    );
  }
}