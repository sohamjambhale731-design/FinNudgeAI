import 'package:flutter/material.dart';
import 'package:frontend/core/colors/app_colors.dart';

import '../../../shared/widgets/dashboard_card.dart';
import '../models/monthly_snapshot_data.dart';

class MonthlySnapshotCard extends StatelessWidget {
  final MonthlySnapshotData data;
  final double? height;

  const MonthlySnapshotCard({
    super.key,
    required this.data,
    this.height,
  });

  String _formatK(double value) {
    return "${(value / 1000).toStringAsFixed(0)}K";
  }

  Widget _buildMetricChip({
    required Widget metric,
    required String label,
  }) {
    return Expanded(
      child: Column(
        children: [
          Container(
            height: 72,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.15),
              ),
            ),
            child: Center(
              child: metric,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            label,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DashboardCard(
      height: height,
      color: AppColors.snapshot,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.calendar_month,
                color: Colors.white,
                size: 22,
              ),
              SizedBox(width: 10),
              Text(
                "Snapshot",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          const Spacer(),

          Row(
            children: [
              _buildMetricChip(
                label: "Saved",
                metric: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.north_east_rounded,
                      color: Colors.white,
                      size: 20,
                    ),

                    const SizedBox(width: 4),

                    Text(
                      "₹${_formatK(data.savings)}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),

              _buildMetricChip(
                label: "Income",
                metric: Text(
                  "+${_formatK(data.income)}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(width: 10),

              _buildMetricChip(
                label: "Expense",
                metric: Text(
                  "-${_formatK(data.expenses)}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
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