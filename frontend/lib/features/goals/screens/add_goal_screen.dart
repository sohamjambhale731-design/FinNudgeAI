import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../../core/api/goal_api.dart';

class AddGoalScreen extends StatefulWidget {
  const AddGoalScreen({super.key});

  @override
  State<AddGoalScreen> createState() => _AddGoalScreenState();
}

class _AddGoalScreenState extends State<AddGoalScreen> {
  final nameController = TextEditingController();
  final amountController = TextEditingController();
  final priorityController = TextEditingController();
  final dateController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    amountController.dispose();
    priorityController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Goal'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Goal Name',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: amountController,
              decoration: const InputDecoration(
                labelText: 'Target Amount',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 16),

            TextField(
              controller: priorityController,
              decoration: const InputDecoration(
                labelText: 'Priority',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 16),

            TextField(
              controller: dateController,
              decoration: const InputDecoration(
                labelText: 'Target Date',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await GoalApi.createGoal(
                    goalName: nameController.text,
                    targetAmount: double.parse(amountController.text),
                    priority: int.parse(priorityController.text),
                    targetDate: dateController.text,
                  );

                  context.pop(true);
                },
                child: const Text('Create Goal'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

