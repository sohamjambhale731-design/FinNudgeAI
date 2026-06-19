import 'package:flutter/material.dart';

import '../models/mock_income_history.dart';

class IncomeHistoryScreen extends StatelessWidget {
  const IncomeHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Income History'),
      ),

      body: ListView.builder(
        itemCount: mockIncomeHistory.length,

        itemBuilder: (context, index) {
          final income = mockIncomeHistory[index];

          return ListTile(
            leading: const Icon(Icons.payments),

            title: Text(income.source),

            subtitle: Text(income.date),

            trailing: Text(
              '₹${income.amount.toStringAsFixed(0)}',
            ),
          );
        },
      ),
    );
  }
}