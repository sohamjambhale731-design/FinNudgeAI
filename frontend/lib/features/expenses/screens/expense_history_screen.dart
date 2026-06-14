import 'package:flutter/material.dart';

import '../models/mock_expense_history.dart';

class ExpenseHistoryScreen extends StatelessWidget {
  const ExpenseHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense History'),
      ),

      body: ListView.builder(
        itemCount: mockExpenseHistory.length,

        itemBuilder: (context, index) {
          final expense = mockExpenseHistory[index];

          return ListTile(
            leading: const Icon(Icons.receipt_long),

            title: Text(expense.category),

            subtitle: Text(expense.date),

            trailing: Text(
              '₹${expense.amount.toStringAsFixed(0)}',
            ),
          );
        },
      ),
    );
  }
}