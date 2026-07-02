import 'package:flutter/material.dart';

import '../models/profile_data.dart';

class ProfileStatsGrid extends StatelessWidget {
  final ProfileData data;
  const ProfileStatsGrid({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _AnimatedStatCard(
            title: 'Income',
            value: '₹${data.income.toStringAsFixed(0)}',
            icon: Icons.account_balance_wallet,
            color: Colors.blue,
          ),
          _AnimatedStatCard(
            title: 'Saved',
            value: '₹${data.saved.toStringAsFixed(0)}',
            icon: Icons.savings,
            color: Colors.green,
          ),
          _AnimatedStatCard(
            title: 'Expense',
            value: '₹${data.expense.toStringAsFixed(0)}',
            icon: Icons.money_off,
            color: Colors.red,
          ),
          _AnimatedStatCard(
            title: 'Goals',
            value: '${data.goals}',
            icon: Icons.flag,
            color: Colors.orange,
          ),
        ],
      ),
    );
  }
}

class _AnimatedStatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _AnimatedStatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 650),
      curve: Curves.easeOutCubic,
      builder: (context, t, _) {
        return Transform.scale(
          scale: 0.96 + (t * 0.04),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: color, size: 36),
                  const SizedBox(height: 15),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(title),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

