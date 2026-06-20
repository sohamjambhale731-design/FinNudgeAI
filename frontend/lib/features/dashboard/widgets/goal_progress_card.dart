import 'package:flutter/material.dart';
import 'package:frontend/core/colors/app_colors.dart';

import '../../../shared/widgets/dashboard_card.dart';
import '../models/goal_data.dart';

class GoalProgressCard extends StatelessWidget {
  final GoalData data;
  final double? height;

  const GoalProgressCard({
    super.key,
    required this.data,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final progress = data.currentAmount / data.targetAmount;
    final remaining = data.targetAmount - data.currentAmount;

    return DashboardCard(
      height: height,
      color: AppColors.goal,
      child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Goal",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 28,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 20),

          Text(
            data.goalName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            "₹${data.currentAmount.toStringAsFixed(0)}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 58,
              fontWeight: FontWeight.w300,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            "Current Progress",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 22,
            ),
          ),

          const SizedBox(height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${(progress * 100).toInt()}% Complete",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              Text(
                "${(progress * 100).toInt()}%",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 14,
              backgroundColor: Colors.white24,
              valueColor: const AlwaysStoppedAnimation<Color>(
                Colors.white,
              ),
            ),
          ),

          const SizedBox(height: 20),

          Text(
            "₹${remaining.toStringAsFixed(0)} Remaining",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 24),

          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.15),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Target Goal",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        "₹${data.targetAmount.toStringAsFixed(0)}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  width: 1,
                  height: 40,
                  color: Colors.white24,
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Saved This Month",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          "₹${data.savedThisMonth.toStringAsFixed(0)}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.15),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Next Goal",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  data.upcomingGoals.isNotEmpty
                      ? data.upcomingGoals.first
                      : "No Upcoming Goal",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF14B8A6),
                minimumSize: const Size.fromHeight(52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Add Contribution coming soon',
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text(
                'Add Contribution',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }
}