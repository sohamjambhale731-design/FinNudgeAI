import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/expense_api.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() =>
      _AddExpenseScreenState();
}

class _AddExpenseScreenState
    extends State<AddExpenseScreen> {

  final categoryController =
      TextEditingController();

  final amountController =
      TextEditingController();

  final noteController =
      TextEditingController();

  final dateController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Expense',
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            TextField(
              controller:
                  categoryController,

              decoration:
                  const InputDecoration(
                labelText: 'Category',
                border:
                    OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller:
                  amountController,

              keyboardType:
                  TextInputType.number,

              decoration:
                  const InputDecoration(
                labelText: 'Amount',
                border:
                    OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller:
                  noteController,

              decoration:
                  const InputDecoration(
                labelText: 'Note',
                border:
                    OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller:
                  dateController,

              decoration:
                  const InputDecoration(
                labelText:
                    'Date (YYYY-MM-DD)',
                border:
                    OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: () async {

                  try {

                    await ExpenseApi.addExpense(
                      category:
                          categoryController.text,

                      amount:
                          double.parse(
                        amountController.text,
                      ),

                      note:
                          noteController.text,

                      date:
                          dateController.text,
                    );

                    if (context.mounted) {

                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Expense Added",
                          ),
                        ),
                      );

                      context.pop(true);
                    }

                  } catch (e) {

                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(
                      SnackBar(
                        content: Text(
                          e.toString(),
                        ),
                      ),
                    );
                  }
                },

                child: const Text(
                  'Save Expense',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

