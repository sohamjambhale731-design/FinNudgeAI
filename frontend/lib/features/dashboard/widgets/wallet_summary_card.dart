import 'package:flutter/material.dart';

import '../../../core/colors/app_colors.dart';
import '../../../shared/widgets/dashboard_card.dart';
import '../models/wallet_data.dart';

class WalletSummaryCard extends StatelessWidget {
  final WalletData data;
  final double? height;

  const WalletSummaryCard({
    super.key,
    required this.data,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final weeklyPositive = data.weeklyGrowth >= 0;

    return DashboardCard(
      height: height,
      color: AppColors.wallet,
      child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Wallet",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 28,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 36),

          Text(
            "₹${data.balance.toStringAsFixed(0)}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 58,
              fontWeight: FontWeight.w300,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            "Available Balance",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 22,
            ),
          ),

          const SizedBox(height: 24),

          Text(
            "₹${data.savings.toStringAsFixed(0)} in Savings",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 28),

          // Growth Panel
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
                        "Monthly Growth",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        "+ ₹${data.monthlyGrowth.toStringAsFixed(0)}",
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
                          "Weekly Growth",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          "${weeklyPositive ? '+' : '-'} ₹${data.weeklyGrowth.abs().toStringAsFixed(0)}",
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

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Recent Transactions",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),

              TextButton(
                onPressed: () {},
                child: const Text(
                  "View All",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: const Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.white24,
                  child: Icon(
                    Icons.account_balance_wallet,
                    color: Colors.white,
                    size: 16,
                  ),
                ),

                SizedBox(width: 12),

                Expanded(
                  child: Text(
                    "Salary",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),

                Text(
                  "+₹18,000",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          Divider(
            color: Colors.white.withValues(alpha: 0.15),
          ),

          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: const Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.white24,
                  child: Icon(
                    Icons.fastfood,
                    color: Colors.white,
                    size: 16,
                  ),
                ),

                SizedBox(width: 12),

                Expanded(
                  child: Text(
                    "Swiggy",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),

                Text(
                  "-₹250",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
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
                foregroundColor: AppColors.wallet,
                minimumSize: const Size.fromHeight(52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Add Transaction coming soon',
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text(
                "Add Transaction",
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