import 'package:flutter/material.dart';

import '../models/monthly_report_data.dart';

class MonthlyReportCard extends StatelessWidget {
  final MonthlyReportData report;

  const MonthlyReportCard({
    super.key,
    required this.report,
  });

  Widget _tile(String title, String value, IconData icon) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon),
          const SizedBox(height: 6),
          Text(title),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

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
              "Monthly Report",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                _tile(
                  "Income",
                  "₹${report.income.toStringAsFixed(0)}",
                  Icons.account_balance_wallet,
                ),
                _tile(
                  "Spent",
                  "₹${report.totalExpenses.toStringAsFixed(0)}",
                  Icons.money_off,
                ),
                _tile(
                  "Saved",
                  "₹${report.totalSaved.toStringAsFixed(0)}",
                  Icons.savings,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              "Savings Rate : ${report.savingsRate.toStringAsFixed(2)}%",
            ),
          ],
        ),
      ),
    );
  }
}

