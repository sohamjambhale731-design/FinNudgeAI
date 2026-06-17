import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/widgets/bottom_nav_bar.dart';

import '../models/mock_goal_data.dart';
import '../widgets/goal_card.dart';

class GoalScreen extends StatelessWidget {
  const GoalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Goals'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ...mockGoals.map(
              (goal) => Padding(
                padding: const EdgeInsets.only(
                  bottom: 16,
                ),
                child: GoalCard(
                  title: goal.title,
                  currentAmount: goal.currentAmount,
                  targetAmount: goal.targetAmount,
                  progress: goal.progress,
                  onTap: (){
                    context.push('/goal-details');
                  },
                ),
              ),
            ),

            const SizedBox(height: 8),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  context.push('/add-goal');
                },
                icon: const Icon(Icons.add),
                label: const Text('Add Goal'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const FinNudgeBottomNavBar(
        currentIndex: 3,
      ),
    );
  }
}