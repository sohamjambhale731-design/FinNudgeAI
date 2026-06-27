import 'package:flutter/material.dart';

import '../../../core/api/expense_api.dart';

class ExpenseHistoryScreen extends StatelessWidget {
  const ExpenseHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense History'),
      ),

      body: FutureBuilder<List<dynamic>>(
        future: ExpenseApi.getExpenses(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final history = snapshot.data!;

          if (history.isEmpty) {
            return const Center(
              child: Text(
                "No expense history found",
              ),
            );
          }

          return ListView.builder(
            itemCount: history.length,
            itemBuilder: (context, index) {
              final expense = history[index];

              return ListTile(
                leading: const Icon(Icons.receipt_long),
                title: Text(
                  expense["category"],
                ),
                subtitle: Text(
                  expense["date"],
                ),
                trailing: Text(
                  '₹${expense["amount"]}',
                ),
              );
            },
          );
        },
      ),
    );
  }
}
