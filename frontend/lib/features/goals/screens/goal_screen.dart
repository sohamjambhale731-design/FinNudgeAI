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
        title: const Text(
          "FinNudge AI",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,

        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),

        actions: [
          IconButton(
            icon: const CircleAvatar(
              radius: 16,
              child: Icon(Icons.person, size: 18),
            ),
            onPressed: () {
              context.push('/profile');
            },
          ),
          const SizedBox(width: 10),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.teal,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 28,
                    child: Icon(Icons.person, size: 30),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "FinNudge AI",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Profile"),
              onTap: () {
                context.push('/profile');
              },
            ),

            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text("About"),
              onTap: () {
                context.push('/about');
              },
            ),

            const Divider(),

            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () {
                context.go('/');
              },
            ),
          ],
        ),
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
