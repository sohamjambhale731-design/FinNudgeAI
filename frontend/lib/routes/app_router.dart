import 'package:go_router/go_router.dart';

import '../features/dashboard/screens/dashboard_screen.dart';
import '../features/income/screens/income_screen.dart';
import '../features/expenses/screens/expense_screen.dart';
import '../features/goals/screens/goal_screen.dart';
import '../features/insights/screens/insight_screen.dart';

final GoRouter appRouter = GoRouter(
  routes: [
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