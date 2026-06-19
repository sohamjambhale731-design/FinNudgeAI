import 'package:flutter/material.dart';

class ExpenseSummaryCard extends StatelessWidget {
  final String category;
  final String amount;

  const ExpenseSummaryCard({
    super.key,
    required this.category,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.receipt_long),
        title: Text(category),
        trailing: Text(amount),
      ),
    );
  }
}