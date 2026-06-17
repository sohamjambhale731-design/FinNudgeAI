import 'package:go_router/go_router.dart';
import '../features/income/screens/add_income_screen.dart';
import '../features/dashboard/screens/dashboard_screen.dart';
import '../features/income/screens/income_screen.dart';
import '../features/income/screens/history_screen.dart';
import '../features/expenses/screens/expense_screen.dart';
import '../features/expenses/screens/add_expense_screen.dart';
import '../features/expenses/screens/expense_history_screen.dart';
import '../features/goals/screens/goal_screen.dart';
import '../features/goals/screens/add_goal_screen.dart';
import '../features/goals/screens/goal_detail_screen.dart';
import '../features/insights/screens/insight_screen.dart';
import '../features/insights/screens/insight_details_screen.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(path: '/insight-details',
    builder: (context, state) => 
    const InsightDetailsScreen(),
    ),

    GoRoute(path: '/goal-details',
    builder: (context, state) => 
    const GoalDetailsScreen(),
    ),

    GoRoute(path: '/add-goal',
    builder: (context, state) =>
    const AddGoalScreen(),
    ),

    GoRoute(
      path: '/expense-history',
      builder: (context, state) =>
      const ExpenseHistoryScreen(),
      ),

    GoRoute(
      path: '/add-expense',
      builder: (context, state) =>
      const AddExpenseScreen(),
      ),

    GoRoute(
      path: '/income-history',
      builder: (context, state) =>
          const IncomeHistoryScreen(),
      ),

    GoRoute(
      path: '/add-income',
      builder: (context, state) =>
          const AddIncomeScreen(),
      ),

    GoRoute(
      path: '/',
      builder: (context, state) => const DashboardScreen(),
    ),

    GoRoute(
      path: '/income',
      builder: (context, state) => const IncomeScreen(),
    ),

    GoRoute(
      path: '/expenses',
      builder: (context, state) => const ExpenseScreen(),
    ),

    GoRoute(
      path: '/goals',
      builder: (context, state) => const GoalScreen(),
    ),

    GoRoute(
      path: '/insights',
      builder: (context, state) => const InsightScreen(),
    ),
  ],
);