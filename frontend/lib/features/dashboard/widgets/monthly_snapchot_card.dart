import 'package:flutter/material.dart';

import '../models/monthly_snapshot_data.dart';

class MonthlySnapshotCard extends StatelessWidget {
  final MonthlySnapshotData data;

  const MonthlySnapshotCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.purple,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Monthly Snapshot 📅",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            "Income: ₹${data.income.toStringAsFixed(0)}",
            style: const TextStyle(
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            "Expenses: ₹${data.expenses.toStringAsFixed(0)}",
            style: const TextStyle(
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            "Saved: ₹${data.savings.toStringAsFixed(0)}",
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}