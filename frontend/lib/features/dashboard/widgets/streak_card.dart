import 'package:flutter/material.dart';

import '../models/streak_data.dart';

class StreakCard extends StatelessWidget {
  final StreakData data;

  const StreakCard({
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
        color: const Color.fromARGB(255, 240, 85, 85),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Money Streak 🔥",
            style: TextStyle(
              color: Color.fromARGB(255, 64, 171, 67),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            "${data.days} Days",
            style: const TextStyle(
              color: Color.fromARGB(255, 187, 237, 164),
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            data.description,
            style: const TextStyle(
              color: Color.fromARGB(255, 233, 218, 150),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}