import 'package:flutter/material.dart';

import '../../../core/colors/app_colors.dart';
import '../../../shared/widgets/dashboard_card.dart';
import '../models/wallet_data.dart';

class WalletSummaryCard extends StatelessWidget {
  final WalletData data;

  const WalletSummaryCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return DashboardCard(
      color: AppColors.wallet,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Wallet Summary",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 16),

          Text(
            "₹${data.balance.toStringAsFixed(0)}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 42,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            "Available Balance",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              const Icon(
                Icons.trending_up,
                color: Colors.white,
                size: 20,
              ),

              const SizedBox(width: 8),

              Text(
                "+ ₹${data.monthlyGrowth.toStringAsFixed(0)} this month",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          const Text(
            "Last updated: Today",
            style: TextStyle(
              color: Colors.white60,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}