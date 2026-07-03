import 'package:flutter/material.dart';

import '../models/savings_insight_data.dart';

class SavingsInsightCard extends StatelessWidget {
  final SavingsInsightData insight;

  const SavingsInsightCard({
    super.key,
    required this.insight,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Savings Insights",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              "Potential Savings",
              style: TextStyle(color: Colors.grey.shade600),
            ),
            Text(
              "₹${insight.savingsPotential.toStringAsFixed(0)}",
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(height: 28),
            const Text(
              "Goal Predictions",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...insight.goals.map(
              (goal) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.flag),
                title: Text(goal.goalName),
                subtitle: Text(
                  "${goal.months.toStringAsFixed(1)} months remaining",
                ),
                trailing: Text(
                  "₹${goal.remainingAmount.toStringAsFixed(0)}",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

