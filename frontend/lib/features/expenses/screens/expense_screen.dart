import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/expense_api.dart';
import '../../../shared/widgets/bottom_nav_bar.dart';

import '../models/expense_data.dart';


import '../widgets/expense_summary_card.dart';
import '../models/budget_data.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() =>
      _ExpenseScreenState();
}

class _ExpenseScreenState
    extends State<ExpenseScreen> {
  late Future<List<dynamic>> expenseFuture;
  late Future<List<dynamic>> budgetFuture;

  Future<void> refreshData() async {
    if (!mounted) return;
    setState(() {
      expenseFuture = ExpenseApi.getExpenses();
      budgetFuture = ExpenseApi.getBudgets();
    });
  }

  @override
  void initState() {
    super.initState();

    expenseFuture = ExpenseApi.getExpenses();
    budgetFuture = ExpenseApi.getBudgets();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Expenses'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: expenseFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final expenses = snapshot.data!;

          final totalExpense = expenses.fold<double>(
            0,
            (sum, expense) =>
                sum + (expense["amount"] as num).toDouble(),
          );

          if (expenses.isEmpty) {

            return const Center(
              child: Text(
                "No Expenses Found",
              ),
            );
          }



          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 3,
                  child: Padding(
                    padding:
                        const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.account_balance_wallet,
                          size: 40,
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
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

                FutureBuilder<List<dynamic>>(
                  future: budgetFuture,
                  builder: (context, budgetSnapshot) {
                    if (!budgetSnapshot.hasData ||
                        budgetSnapshot.data!.isEmpty) {
                      return const SizedBox();
                    }

                    final budget = BudgetData.fromJson(
                      budgetSnapshot.data!.first
                          as Map<String, dynamic>,
                    );

                    return Column(
                      children: [
                        Card(
                          child: ListTile(
                            title:
                                const Text('Variable Budget'),
                            subtitle:
                                Text('₹${budget.allocatedBudget.toStringAsFixed(0)}'),
                            trailing: IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () async {
                                final result =
                                    await context.push(
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
                            subtitle:
                                Text('₹${budget.remainingBudget.toStringAsFixed(0)}'),
                          ),
                        ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 20),

                const Text(
                  'Expense Categories',
                  style: TextStyle(
                    fontSize: 18,
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
                      category: expense["category"],
                      amount:
                          '₹${(expense["amount"] as num).toStringAsFixed(0)}',
                    ),
                  ),
                ),


                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      final result =
                          await context.push('/add-expense');

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
      ),

      bottomNavigationBar: const FinNudgeBottomNavBar(
        currentIndex: 2,
      ),
    );
  }
}