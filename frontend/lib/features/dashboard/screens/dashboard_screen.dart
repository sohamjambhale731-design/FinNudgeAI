import 'package:flutter/material.dart';
import '../../../shared/widgets/bottom_nav_bar.dart';

import '../data/mock_dashboard_data.dart';

import '../widgets/ai_insight_card.dart';
import '../widgets/goal_progress_card.dart';
import '../widgets/monthly_snapchot_card.dart';
import '../widgets/streak_card.dart';
import '../widgets/wallet_summary_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const FinNudgeBottomNavBar(
        currentIndex: 0
        ),
      appBar: AppBar(
        title: const Text('FinNudge AI'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            WalletSummaryCard(
              data: MockDashboardData.wallet,
            ),

            const SizedBox(height: 16),

            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth < 700) {
                  return Column(
                    children: [
                      GoalProgressCard(
                        data: MockDashboardData.goal,
                      ),

                      const SizedBox(height: 16),

                      AIInsightCard(
                        data: MockDashboardData.insight,
                      ),

                      const SizedBox(height: 16),

                      StreakCard(
                        data: MockDashboardData.streak,
                      ),

                      const SizedBox(height: 16),

                      MonthlySnapshotCard(
                        data: MockDashboardData.snapshot,
                      ),
                    ],
                  );
                }

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: GoalProgressCard(
                        data: MockDashboardData.goal,
                      ),
                    ),

                    const SizedBox(width: 16),

                    Expanded(
                      child: Column(
                        children: [
                          AIInsightCard(
                            data: MockDashboardData.insight,
                          ),

                          const SizedBox(height: 16),

                          StreakCard(
                            data: MockDashboardData.streak,
                          ),

                          const SizedBox(height: 16),

                          MonthlySnapshotCard(
                            data: MockDashboardData.snapshot,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}