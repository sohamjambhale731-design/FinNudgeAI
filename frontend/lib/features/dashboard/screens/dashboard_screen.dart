import 'package:flutter/material.dart';
import '../../../shared/widgets/bottom_nav_bar.dart';
import '../widgets/ai_insight_card.dart';
import '../../../core/api/dashboard_api.dart';
import '../models/wallet_data.dart';
import '../widgets/goal_progress_card.dart';
import '../widgets/monthly_snapshot_card.dart';
import '../widgets/streak_card.dart';
import '../widgets/wallet_summary_card.dart';
import '../models/dashboard_data.dart';
import '../models/dashboard_response.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({
    super.key,
  });

  @override
  State<DashboardScreen> createState() =>
      _DashboardScreenState();
}

class _DashboardScreenState
    extends State<DashboardScreen> {

  late Future<Map<String, dynamic>>
      dashboardFuture;

  @override
  void initState() {
    super.initState();

    dashboardFuture =
        DashboardApi.getDashboard(
      "June",
    );
  }

  @override
  Widget build(
      BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      bottomNavigationBar: const FinNudgeBottomNavBar(
        currentIndex: 0,
      ),
      appBar: AppBar(
        title: const Text('FinNudge AI'),
        centerTitle: true,
      ),
      body: FutureBuilder<
          Map<String, dynamic>>(
        future: dashboardFuture,
      
        builder:
            (context, snapshot) {
            
          if (!snapshot.hasData) {
            return const Center(
              child:
                  CircularProgressIndicator(),
            );
          }
      
          final dashboardData =
              snapshot.data!;

          final dashboard =
              DashboardData.fromJson(
                dashboardData,
              );
              return Padding(
                padding: const EdgeInsets.all(20),
                child: LayoutBuilder(

          builder: (context, constraints) {
            // MOBILE
            if (constraints.maxWidth < 900) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    WalletSummaryCard(
                      data: dashboard.wallet,
                    ),

                    const SizedBox(height: 16),

                    GoalProgressCard(
                      data: dashboard.goal,
                    ),

                    const SizedBox(height: 16),

                    AIInsightCard(
                      data: dashboard.insight,
                    ),

                    const SizedBox(height: 16),

                    MonthlySnapshotCard(
                      data: dashboard.snapshot,
                    ),

                    const SizedBox(height: 16),

                    StreakCard(
                      data: dashboard.streak,
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
                      data: dashboard.wallet,
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
                              data: dashboard.insight,
                            ),
                          ),

                          const SizedBox(height: 20),

                          Expanded(
                            child: MonthlySnapshotCard(
                              data: dashboard.snapshot,
                            ),
                          ),

                          const SizedBox(height: 20),

                          Expanded(
                            child: StreakCard(
                              data: dashboard.streak,
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
                      data: dashboard.goal,
                      height: availableHeight,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  ),
);
  }
}