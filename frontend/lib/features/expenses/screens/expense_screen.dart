import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


import '../../../core/api/expense_api.dart';
import '../../../shared/widgets/bottom_nav_bar.dart';

import '../models/budget_data.dart';
import '../models/expense_data.dart';
import '../widgets/expense_summary_card.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  late Future<List<dynamic>> expenseFuture;
  late Future<List<dynamic>> budgetFuture;
  late Future<List<dynamic>> fixedExpenseFuture;

  Future<void> refreshData() async {
    if (!mounted) return;
    setState(() {
      expenseFuture = ExpenseApi.getExpenses();
      budgetFuture = ExpenseApi.getBudgets();
      fixedExpenseFuture = ExpenseApi.getFixedExpenses();
    });
  }

  @override
  void initState() {
    super.initState();
    expenseFuture = ExpenseApi.getExpenses();
    budgetFuture = ExpenseApi.getBudgets();
    fixedExpenseFuture = ExpenseApi.getFixedExpenses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "FinNudge AI",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,

        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),

        actions: [
          IconButton(
            icon: const CircleAvatar(
              radius: 16,
              child: Icon(Icons.person, size: 18),
            ),
            onPressed: () {
              context.push('/profile');
            },
          ),
          const SizedBox(width: 10),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.teal,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 28,
                    child: Icon(Icons.person, size: 30),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "FinNudge AI",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Profile"),
              onTap: () {
                context.push('/profile');
              },
            ),

            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text("About"),
              onTap: () {
                context.push('/about');
              },
            ),

            const Divider(),

            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () {
                context.go('/');
              },
            ),
          ],
        ),
      ),

      body: FutureBuilder<List<dynamic>>(
        future: expenseFuture,
        builder: (context, expenseSnapshot) {
          if (!expenseSnapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final expenses = expenseSnapshot.data!;

          final totalExpense = expenses.fold<double>(
            0,
            (sum, expense) =>
                sum + (expense['amount'] as num).toDouble(),
          );

          return FutureBuilder<List<dynamic>>(
            future: budgetFuture,
            builder: (context, budgetSnapshot) {
              if (!budgetSnapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              // ==========================
              // NO BUDGET
              // ==========================
              if (budgetSnapshot.data!.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.account_balance_wallet_outlined,
                          size: 90,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 25),
                        const Text(
                          'No Budget Set',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Set your monthly budget before\ntracking expenses.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 40),
                        SizedBox(
                          width: 280,
                          height: 55,
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.add),
                            label: const Text('Set Budget'),
                            onPressed: () async {
                              final result = await context.push('/add-budget');
                              if (result == true) {
                                refreshData();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              // Budget exists
              final budget = BudgetData.fromJson(
                budgetSnapshot.data!.first
                    as Map<String, dynamic>,
              );

              // ==========================
              // NO EXPENSES
              // ==========================
              if (expenses.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.receipt_long_rounded,
                          size: 90,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 25),
                        const Text(
                          'No Expenses Yet',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Monthly Budget : ₹${budget.allocatedBudget.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Start tracking your spending.',
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 35),
                        SizedBox(
                          width: 280,
                          height: 55,
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.add),
                            label: const Text('Add Expense'),
                            onPressed: () async {
                              final result = await context.push('/add-expense');
                              if (result == true) {
                                refreshData();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              // ==========================
              // NORMAL DASHBOARD
              // ==========================
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.account_balance_wallet,
                              size: 40,
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Total Expenses',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  '₹${totalExpense.toStringAsFixed(0)}',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Column(
                      children: [
                        Card(
                          child: ListTile(
                            title: const Text('Variable Budget'),
                            subtitle: Text(
                              '₹${budget.allocatedBudget.toStringAsFixed(0)}',
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () async {
                                final result = await context.push(
                                  '/update-budget',
                                  extra: budget,
                                );

                                if (result == true) {
                                  refreshData();
                                }
                              },
                            ),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            title: const Text('Remaining Budget'),
                            subtitle: Text(
                              '₹${budget.remainingBudget.toStringAsFixed(0)}',
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "Fixed Expenses",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    FutureBuilder<List<dynamic>>(
                      future: fixedExpenseFuture,
                      builder: (context, fixedSnapshot) {
                        if (!fixedSnapshot.hasData) {
                          return const CircularProgressIndicator();
                        }

                        final fixedExpenses = fixedSnapshot.data!;

                        if (fixedExpenses.isEmpty) {
                          return const Text(
                            "No Fixed Expenses",
                          );
                        }

                        return Column(
                          children: fixedExpenses.map((expense) {
                            return Card(
                              child: ListTile(
                                leading: const Icon(
                                  Icons.home,
                                ),
                                title: Text(
                                  expense["category"],
                                ),
                                subtitle: Text(
                                  expense["subcategory"],
                                ),
                                trailing: Text(
                                  "₹${expense["amount"]}",
                                ),
                                onTap: () async {
                                  final result = await context.push(
                                    '/update-fixed-expense',
                                    extra: expense,
                                  );

                                  if (result == true) {
                                    refreshData();
                                  }
                                },
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(
                          Icons.add,
                        ),
                        label: const Text(
                          "Add Fixed Expense",
                        ),
                        onPressed: () async {
                          final result = await context.push(
                            '/add-fixed-expense',
                          );

                          if (result == true) {
                            refreshData();
                          }
                        },
                      ),
                    ),

                    const SizedBox(height: 30),

                    const Text(
                      "Variable Expenses",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    ...expenses.map(
                      (expense) => GestureDetector(
                        onTap: () async {
                          final result = await context.push(
                            '/update-expense',
                            extra: ExpenseData.fromJson(
                              expense as Map<String, dynamic>,
                            ),
                          );

                          if (result == true) {
                            refreshData();
                          }
                        },
                        child: ExpenseSummaryCard(
                          category: expense['category'],
                          amount:
                              '₹${(expense['amount'] as num).toStringAsFixed(0)}',
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          final result = await context.push('/add-expense');
                          if (result == true) {
                            refreshData();
                          }
                        },
                        icon: const Icon(Icons.add),
                        label: const Text('Add Expense'),
                      ),
                    ),

                    const SizedBox(height: 12),

                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          context.push('/expense-history');
                        },
                        icon: const Icon(Icons.history),
                        label: const Text('View History'),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: const FinNudgeBottomNavBar(
        currentIndex: 2,
      ),
    );
  }
}

