import 'package:go_router/go_router.dart';

import '../features/auth/screens/login_screen.dart';

import '../features/dashboard/screens/dashboard_screen.dart';

import '../features/income/screens/income_screen.dart';

import '../features/profile/screens/profile_screen.dart';
import '../features/about/screens/about_screen.dart';

import '../features/income/screens/add_income_screen.dart';
import '../features/income/screens/history_screen.dart';
import '../features/income/models/income_data.dart';


import '../features/expenses/models/expense_data.dart';
import '../features/expenses/models/budget_data.dart';

import '../features/expenses/screens/expense_screen.dart';

import '../features/expenses/screens/add_expense_screen.dart';
import '../features/expenses/screens/expense_history_screen.dart';
import '../features/expenses/screens/update_expense_screen.dart';
import '../features/expenses/screens/update_budget_screen.dart';
import '../features/expenses/screens/add_budget_screen.dart';
import '../features/expenses/screens/add_fixed_expense_screen.dart';
import '../features/expenses/screens/update_fixed_expense_screen.dart';



import '../features/goals/screens/goal_screen.dart';
import '../features/goals/screens/add_goal_screen.dart';
import '../features/goals/screens/goal_detail_screen.dart';
import '../features/goals/models/goal_data.dart';


import '../features/insights/screens/insight_screen.dart';
import '../features/insights/screens/insight_details_screen.dart';
import '../features/income/screens/add_additional_income_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',

  routes: [
    /// LOGIN
    GoRoute(
      path: '/',
      builder: (context, state) =>
          const LoginScreen(),
    ),

    /// DASHBOARD
    GoRoute(
      path: '/dashboard',
      builder: (context, state) =>
          const DashboardScreen(),
    ),

    /// INCOME
    GoRoute(
      path: '/income',
      builder: (context, state) =>
          const IncomeScreen(),
    ),

    GoRoute(
      path: '/add-income',
      builder: (context, state) {
        final income = state.extra as IncomeData?;
        return AddIncomeScreen(
          income: income,
        );
      },
    ),

    GoRoute(
      path: '/add-additional-income',
      builder: (context, state) =>
          const AddAdditionalIncomeScreen(),
    ),

    GoRoute(
      path: '/income-history',
      builder: (context, state) =>
          const IncomeHistoryScreen(),
    ),

    /// EXPENSES
    GoRoute(
      path: '/expenses',
      builder: (context, state) =>
          const ExpenseScreen(),
    ),

    GoRoute(
      path: '/add-expense',
      builder: (context, state) =>
          const AddExpenseScreen(),
    ),

    GoRoute(
      path: '/expense-history',
      builder: (context, state) =>
          const ExpenseHistoryScreen(),
    ),

    GoRoute(
      path: '/update-expense',
      builder: (context, state) {
        final expense = state.extra as ExpenseData;
        return UpdateExpenseScreen(
          expense: expense,
        );

      },
    ),

    GoRoute(
      path: '/add-budget',
      builder: (context, state) =>
          const AddBudgetScreen(),
    ),

    GoRoute(
      path: '/add-fixed-expense',
      builder: (context, state) =>
          const AddFixedExpenseScreen(),
    ),

    GoRoute(
      path: '/update-fixed-expense',
      builder: (context, state) {
        final expense = state.extra as Map<String, dynamic>;

        return UpdateFixedExpenseScreen(
          expense: expense,
        );
      },
    ),

    GoRoute(
      path: '/update-budget',
      builder: (context, state) {
        final budget = state.extra as BudgetData;
        return UpdateBudgetScreen(
          budget: budget,
        );
      },
    ),


    /// GOALS

    GoRoute(
      path: '/goals',
      builder: (context, state) =>
          const GoalScreen(),
    ),

    GoRoute(
      path: '/add-goal',
      builder: (context, state) =>
          const AddGoalScreen(),
    ),

    GoRoute(
      path: '/goal-details',
      builder: (context, state) {
        final goal = state.extra as GoalData;

        return GoalDetailsScreen(
          goal: goal,
        );
      },
    ),



    /// INSIGHTS
    GoRoute(
      path: '/insights',
      builder: (context, state) =>
          const InsightScreen(),
    ),

    GoRoute(
      path: '/insight-details',
      builder: (context, state) =>
          const InsightDetailsScreen(),
    ),

    GoRoute(
      path: '/profile',
      builder: (context, state) =>
          const ProfileScreen(),
    ),

    GoRoute(
      path: '/about',
      builder: (context, state) =>
          const AboutScreen(),
    ),
  ],
);
