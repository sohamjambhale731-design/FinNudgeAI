import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/widgets/bottom_nav_bar.dart';

import '../../../core/api/goal_api.dart';

import '../models/goal_data.dart';

import '../widgets/goal_card.dart';


class GoalScreen extends StatefulWidget {
  const GoalScreen({super.key});

  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  late Future<List<dynamic>> goalsFuture;

  @override
  void initState() {
    super.initState();
    goalsFuture = GoalApi.getGoals();
  }

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
            FutureBuilder<List<dynamic>>(
              future: goalsFuture,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final goals = snapshot.data!;

                return Column(
                  children: goals.map((goal) {
                    final goalData = GoalData.fromJson(goal);

                    return Padding(
                      padding: const EdgeInsets.only(
                        bottom: 16,
                      ),
                      child: GoalCard(
                        title: goalData.goalName,
                        currentAmount: goalData.currentAmount,
                        targetAmount: goalData.targetAmount,
                        progress: goalData.progress,
                        priority: goalData.priority,
                        onTap: () async {
                          final result = await context.push(
                            '/goal-details',
                            extra: goalData,
                          );

                          if (result == true && mounted) {
                            setState(() {
                              goalsFuture = GoalApi.getGoals();
                            });
                          }
                        },
                      ),
                    );
                  }).toList(),
                );
              },
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
