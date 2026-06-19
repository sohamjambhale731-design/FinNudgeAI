import 'package:flutter/material.dart';

class InsightDetailsScreen extends StatelessWidget {
  const InsightDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insight Details'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Spending Alert',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 16),

            Text(
              'Your food expenses increased by 15% this month. Consider setting a monthly food budget to control spending.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}