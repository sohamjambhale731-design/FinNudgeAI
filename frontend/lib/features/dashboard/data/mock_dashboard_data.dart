import '../models/wallet_data.dart';
import '../models/goal_data.dart';
import '../models/insight_data.dart';
import '../models/streak_data.dart';
import '../models/monthly_snapshot_data.dart';

class MockDashboardData {
  static const wallet = WalletData(
    balance: 18000,
    monthlyGrowth: 2500,
  );

  static const goal = GoalData(
    goalName: 'MacBook Fund',
    currentAmount: 65000,
    targetAmount: 100000,
  );

  static const insight = InsightData(
    title: 'You spent 12% less on food this week.',
    message: 'Great job! Keep it up.',
  );

  static const streak = StreakData(
    days: 12,
    description:
        'You stayed within budget for 12 consecutive days.',
  );

  static const snapshot = MonthlySnapshotData(
    income: 18000,
    expenses: 12000,
    savings: 6000,
  );
}