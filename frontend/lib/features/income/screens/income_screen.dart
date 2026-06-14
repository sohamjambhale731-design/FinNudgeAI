import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/widgets/bottom_nav_bar.dart';

import '../models/mock_income_data.dart';
import '../widgets/income_summary_card.dart';

class IncomeScreen extends StatelessWidget {
  const IncomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Income'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IncomeSummaryCard(
              title: 'Monthly Income',
              amount: '₹${mockIncome.totalIncome.toStringAsFixed(0)}',
              icon: Icons.account_balance_wallet,
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: IncomeSummaryCard(
                    title: 'Primary Income',
                    amount:
                        '₹${mockIncome.primaryIncome.toStringAsFixed(0)}',
                    icon: Icons.work,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: IncomeSummaryCard(
                    title: 'Additional Income',
                    amount:
                        '₹${mockIncome.additionalIncome.toStringAsFixed(0)}',
                    icon: Icons.trending_up,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            IncomeSummaryCard(
              title: 'Income Growth',
              amount:
                  '${mockIncome.growthPercentage.toStringAsFixed(0)}%',
              icon: Icons.show_chart,
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  context.push('/add-income');
                },
                icon: const Icon(Icons.add),
                label: const Text('Add Income'),
              ),
            ),
            const SizedBox(height:12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: (){
                  context.push('/income-history');
                },
                icon: const Icon(Icons.history),
                label: const Text('View History'),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: const FinNudgeBottomNavBar(
        currentIndex: 1,
      ),
    );
  }
}