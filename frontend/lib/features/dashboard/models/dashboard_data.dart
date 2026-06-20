import 'wallet_data.dart';
import 'goal_data.dart';
import 'insight_data.dart';
import 'streak_data.dart';
import 'monthly_snapshot_data.dart';

class DashboardData {
  final WalletData wallet;
  final GoalData goal;
  final InsightData insight;
  final StreakData streak;
  final MonthlySnapshotData snapshot;

  DashboardData({
    required this.wallet,
    required this.goal,
    required this.insight,
    required this.streak,
    required this.snapshot,
  });

  factory DashboardData.fromJson(
    Map<String, dynamic> json,
  ) {
    return DashboardData(
      wallet: WalletData(
        balance: (json["wallet_summary"]["total_income"])
            .toDouble(),
        savings: (json["wallet_summary"]["total_saved"])
            .toDouble(),
        monthlyGrowth:
            (json["wallet_summary"]["total_saved"])
                .toDouble(),
        weeklyGrowth: 0,
      ),

      goal: GoalData(
        goalName:
            json["goals_overview"]["goal_name"],
        currentAmount:
            (json["goals_overview"]
                    ["current_amount"])
                .toDouble(),
        targetAmount:
            (json["goals_overview"]
                    ["target_amount"])
                .toDouble(),
        savedThisMonth:
            (json["wallet_summary"]
                    ["total_saved"])
                .toDouble(),
        upcomingGoals: const [],
      ),

      insight: InsightData(
        title: "Financial Insight",
        message:
            json["ai_insight"]["message"],
      ),

      streak: StreakData(
        days:
            json["money_streak"]
                ["current_streak"],
        description:
            "${json["money_streak"]["level"]} Level",
      ),

      snapshot: MonthlySnapshotData(
        income:
            (json["monthly_snapshot"]
                    ["income"])
                .toDouble(),
        expenses:
            (json["monthly_snapshot"]
                    ["expenses"])
                .toDouble(),
        savings:
            (json["monthly_snapshot"]
                    ["savings"])
                .toDouble(),
        goalContribution:
            (json["wallet_summary"]
                    ["total_saved"])
                .toDouble(),
      ),
    );
  }
}