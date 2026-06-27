import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/expense_api.dart';
import '../models/expense_data.dart';

class UpdateExpenseScreen extends StatefulWidget {
  final ExpenseData expense;

  const UpdateExpenseScreen({
    super.key,
    required this.expense,
  });

  @override
  State<UpdateExpenseScreen> createState() => _UpdateExpenseScreenState();
}

class _UpdateExpenseScreenState extends State<UpdateExpenseScreen> {
  late final TextEditingController categoryController;
  late final TextEditingController amountController;
  late final TextEditingController noteController;

  @override
  void initState() {
    super.initState();
    categoryController =
        TextEditingController(text: widget.expense.category);
    amountController =
        TextEditingController(text: widget.expense.amount.toString());
    noteController = TextEditingController(text: widget.expense.note);
  }

  @override
  void dispose() {
    categoryController.dispose();
    amountController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Expense'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: amountController,
              decoration: const InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
              ),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: noteController,
              decoration: const InputDecoration(
                labelText: 'Note',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    await ExpenseApi.updateExpense(
                      expenseId: widget.expense.expenseId,
                      category: categoryController.text,
                      amount: double.parse(amountController.text),
                      note: noteController.text,
                    );

                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Expense Updated'),
                        ),
                      );
                      context.pop(true);
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(e.toString()),
                      ),
                    );
                  }
                },
                child: const Text('Update Expense'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

