import 'package:flutter/material.dart';
import 'package:frontend/core/colors/app_colors.dart';

import '../../../shared/widgets/dashboard_card.dart';
import '../models/streak_data.dart';

class StreakCard extends StatelessWidget {
  final StreakData data;
  final double? height;

  const StreakCard({
    super.key,
    required this.data,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return DashboardCard(
      height: height,
      color: AppColors.streak,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.local_fire_department_rounded,
                color: Colors.white,
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                "Streak",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          const Spacer(),

          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.15),
                ),
              ),
              child: Text(
                "🔥 ${data.days} Days",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(height: 14),

          const Text(
            "Within Budget",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 8),

          const Row(
            children: [
              Icon(
                Icons.emoji_events_rounded,
                color: Colors.white70,
                size: 20,
              ),
              SizedBox(width: 6),
              Text(
                "Best: 15 Days",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          const Spacer(),
        ],
      ),
    );
  }
}