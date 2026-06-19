import 'package:flutter/material.dart';

import '../../../shared/widgets/bottom_nav_bar.dart';

import '../data/mock_dashboard_data.dart';

import '../widgets/ai_insight_card.dart';
import '../widgets/goal_progress_card.dart';
import '../widgets/monthly_snapshot_card.dart';
import '../widgets/streak_card.dart';
import '../widgets/wallet_summary_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      bottomNavigationBar: const FinNudgeBottomNavBar(
        currentIndex: 0,
      ),
      appBar: AppBar(
        title: const Text('FinNudge AI'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: LayoutBuilder(
          builder: (context, constraints) {
            // MOBILE
            if (constraints.maxWidth < 900) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    WalletSummaryCard(
                      data: MockDashboardData.wallet,
                    ),

                    const SizedBox(height: 16),

                    GoalProgressCard(
                      data: MockDashboardData.goal,
                    ),

                    const SizedBox(height: 16),

                    AIInsightCard(
                      data: MockDashboardData.insight,
                    ),

                    const SizedBox(height: 16),

                    MonthlySnapshotCard(
                      data: MockDashboardData.snapshot,
                    ),

                    const SizedBox(height: 16),

                    StreakCard(
                      data: MockDashboardData.streak,
                    ),
                  ],
                ),
              );
            }

            // DESKTOP / WEB
            final availableHeight = (constraints.maxHeight -20).clamp(700.00, 950.00);

            return SizedBox(
              height: availableHeight,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// LEFT COLUMN
                  Expanded(
                    child: WalletSummaryCard(
                      data: MockDashboardData.wallet,
                      height: availableHeight,
                    ),
                  ),

                  const SizedBox(width: 20),

                  /// CENTER COLUMN
                  Expanded(
                    child: SizedBox(
                      height: availableHeight,
                      child: Column(
                        children: [
                          Expanded(
                            child: AIInsightCard(
                              data: MockDashboardData.insight,
                            ),
                          ),

                          const SizedBox(height: 20),

                          Expanded(
                            child: MonthlySnapshotCard(
                              data: MockDashboardData.snapshot,
                            ),
                          ),

                          const SizedBox(height: 20),

                          Expanded(
                            child: StreakCard(
                              data: MockDashboardData.streak,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 20),

                  /// RIGHT COLUMN
                  Expanded(
                    child: GoalProgressCard(
                      data: MockDashboardData.goal,
                      height: availableHeight,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}