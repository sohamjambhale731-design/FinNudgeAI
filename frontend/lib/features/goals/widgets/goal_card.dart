import 'package:flutter/material.dart';

class GoalCard extends StatelessWidget {
  final String title;
  final double currentAmount;
  final double targetAmount;
  final double progress;
  final VoidCallback? onTap;

  const GoalCard({
    super.key,
    required this.title,
    required this.currentAmount,
    required this.targetAmount,
    required this.progress,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                '₹${currentAmount.toStringAsFixed(0)} / ₹${targetAmount.toStringAsFixed(0)}',
              ),

              const SizedBox(height: 12),

              LinearProgressIndicator(
                value: progress,
              ),
            ],
          ),
        ),
      ),
    );
  }
}