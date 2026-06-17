import 'package:flutter/material.dart';

class GoalDetailsScreen extends StatelessWidget {
  const GoalDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Goal Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Emergency Fund',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              'Saved: ₹40,000',
              style: TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 8),

            const Text(
              'Target: ₹100,000',
              style: TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 20),

            const LinearProgressIndicator(
              value: 0.4,
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add),
                label: const Text(
                  'Add Contribution',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}