import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/insight_api.dart';
import '../../../shared/widgets/bottom_nav_bar.dart';


import '../models/monthly_report_data.dart';
import '../models/savings_insight_data.dart';
import '../models/goal_report_data.dart';
import '../models/health_score_data.dart';
import '../models/trend_data.dart';


import '../widgets/monthly_report_card.dart';
import '../widgets/savings_insight_card.dart';


class InsightScreen extends StatefulWidget {
  const InsightScreen({super.key});

  @override
  State<InsightScreen> createState() => _InsightScreenState();
}

class _InsightScreenState extends State<InsightScreen> {
  late String currentMonth;

  late Future<Map<String, dynamic>> monthlyFuture;
  late Future<Map<String, dynamic>> savingsFuture;


  late Future<Map<String, dynamic>> categoryFuture;
  late Future goalFuture;
  late Future healthFuture;
  late Future trendFuture;

  @override
  void initState() {
    super.initState();

    currentMonth =
        DateFormat('MMMM').format(DateTime.now());

    monthlyFuture = InsightApi.getMonthlyReport(currentMonth);
    savingsFuture = InsightApi.getSavingsInsights(currentMonth);

    categoryFuture = InsightApi.getCategoryComparison(currentMonth);

    goalFuture = InsightApi.getGoalReport();
    healthFuture = InsightApi.getHealthScoreHistory();
    trendFuture = InsightApi.getTrends();
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
            FutureBuilder<Map<String, dynamic>>(
              future: monthlyFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Failed to load monthly report: ${snapshot.error}',
                    ),
                  );
                }

                final report = MonthlyReportData.fromJson(
                  snapshot.data!,
                );

                return MonthlyReportCard(
                  report: report,
                );
              },
            ),
            const SizedBox(height: 20),
            FutureBuilder<Map<String, dynamic>>(
              future: savingsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Failed to load savings insights: ${snapshot.error}',
                    ),
                  );
                }

                final data = SavingsInsightData.fromJson(
                  snapshot.data!,
                );

                return SavingsInsightCard(
                  insight: data,
                );
              },
            ),

            const SizedBox(height: 20),

            FutureBuilder<Map<String, dynamic>>(
              future: categoryFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Failed to load category comparison: ${snapshot.error}',
                    ),
                  );
                }

                final categories = snapshot.data!;

                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Category Comparison",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        ...categories.entries.map(
                          (e) => ListTile(
                            title: Text(e.key),
                            trailing: Text("₹${e.value}"),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            FutureBuilder(
              future: goalFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Failed to load goal report: ${snapshot.error}',
                    ),
                  );
                }

                final raw = snapshot.data as List;

                final goals = raw
                    .map((e) => GoalReportData.fromJson(
                          e as Map<String, dynamic>,
                        ))
                    .toList();


                return Card(
                  child: Column(
                    children: goals
                        .map(
                          (goal) => ListTile(
                            title: Text(goal.goalName),
                            subtitle: Text(
                              "${goal.completionPercentage.toStringAsFixed(1)}%",
                            ),

                            trailing: Text(goal.status),
                          ),
                        )
                        .toList(),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            FutureBuilder(
              future: healthFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Failed to load health score history: ${snapshot.error}',
                    ),
                  );
                }

                final scores = (snapshot.data as List)
                    .map((e) => HealthScoreData.fromJson(e))
                    .toList();

                return Card(
                  child: Column(
                    children: [
                      const ListTile(
                        leading: Icon(Icons.favorite),
                        title: Text("Financial Health Score"),
                      ),
                      ...scores.map((score) {
                        return ListTile(
                          title: Text(score.month),
                          trailing: Text(
                            score.financialHealthScore
                                .toStringAsFixed(0),
                          ),
                        );
                      }),
                    ],
                  ),
                );
              },
            ),


            const SizedBox(height: 20),

            FutureBuilder(
              future: trendFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Failed to load trends: ${snapshot.error}',
                    ),
                  );
                }

                final trends = (snapshot.data as List)
                    .map((e) => TrendData.fromJson(e))
                    .toList();

                return Card(
                  child: Column(
                    children: [
                      const ListTile(
                        leading: Icon(Icons.trending_up),
                        title: Text("Monthly Trends"),
                      ),
                      ...trends.map((trend) {
                        return ListTile(
                          title: Text(trend.month),
                          subtitle: Text(
                            "Spent ₹${trend.totalSpent.toStringAsFixed(0)}",
                          ),
                          trailing: Text(
                            "Saved ₹${trend.totalSaved.toStringAsFixed(0)}",
                          ),
                        );
                      }),
                    ],
                  ),
                );
              },
            ),

          ],
        ),
      ),

      bottomNavigationBar: const FinNudgeBottomNavBar(
        currentIndex: 4,
      ),
    );
  }
}


