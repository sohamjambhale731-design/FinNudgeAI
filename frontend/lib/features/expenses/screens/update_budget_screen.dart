import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/expense_api.dart';
import '../models/budget_data.dart';

class UpdateBudgetScreen extends StatefulWidget {
  final BudgetData budget;

  const UpdateBudgetScreen({
    super.key,
    required this.budget,
  });

  @override
  State<UpdateBudgetScreen> createState() => _UpdateBudgetScreenState();
}

class _UpdateBudgetScreenState extends State<UpdateBudgetScreen> {
  late final TextEditingController amountController;

  @override
  void initState() {
    super.initState();
    amountController =
        TextEditingController(text: widget.budget.allocatedBudget.toString());
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Budget'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: amountController,
              decoration: const InputDecoration(
                labelText: 'Allocated Budget',
                border: OutlineInputBorder(),
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    final amount = double.parse(amountController.text);

                    await ExpenseApi.updateBudget(
                      budgetId: widget.budget.budgetId,
                      allocatedBudget: amount,
                    );

                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Budget Updated'),
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
                child: const Text('Update Budget'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

