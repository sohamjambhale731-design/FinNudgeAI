import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/goal_api.dart';
import '../models/goal_data.dart';

class GoalDetailsScreen extends StatefulWidget {
  final GoalData goal;

  const GoalDetailsScreen({
    super.key,
    required this.goal,
  });


  @override
  State<GoalDetailsScreen> createState() => _GoalDetailsScreenState();
}

class _GoalDetailsScreenState extends State<GoalDetailsScreen> {
  String priorityText(int priority) {
    switch (priority) {
      case 1:
        return "🔴 High";
      case 2:
        return "🟡 Medium";
      default:
        return "🟢 Low";
    }
  }

  @override
  Widget build(BuildContext context) {
    final progress = widget.goal.currentAmount / widget.goal.targetAmount;

    final percentage = ((widget.goal.currentAmount / widget.goal.targetAmount) * 100)
        .toStringAsFixed(1);


    return Scaffold(
      appBar: AppBar(
        title: const Text('Goal Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.goal.goalName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Chip(
              label: Text(
                priorityText(widget.goal.priority),
              ),
            ),

            const SizedBox(height: 16),

            Text(
              'Saved: ₹${widget.goal.currentAmount.toStringAsFixed(0)}',
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 8),

            Text(
              'Target: ₹${widget.goal.targetAmount.toStringAsFixed(0)}',
              style: const TextStyle(fontSize: 18),
            ),

            Text(
              '$percentage% Complete',
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 20),

            LinearProgressIndicator(
              value: progress,
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () async {
                  final amountController = TextEditingController();

                  final confirmed = await showDialog<bool>(

                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Add Contribution'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: amountController,
                              decoration: const InputDecoration(
                                labelText: 'Amount',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text('Save'),
                          ),
                        ],
                      );
                    },
                  );

                  if (confirmed != true) return;

                  final amount = double.parse(amountController.text);

                  await GoalApi.addContribution(
                    goalId: widget.goal.goalId,
                    amount: amount,
                  );



                  if (context.mounted) {
                    context.pop(true);
                  }
                },
                icon: const Icon(Icons.add),
                label: const Text('Add Contribution'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

