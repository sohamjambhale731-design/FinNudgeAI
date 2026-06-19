import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/widgets/bottom_nav_bar.dart';

import '../models/mock_insight_data.dart';
import '../widgets/insight_card.dart';

class InsightScreen extends StatelessWidget {
  const InsightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insights'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: mockInsights.length,
        itemBuilder: (context, index) {
          final insight = mockInsights[index];

          return InsightCard(
            title: insight.title,
            description: insight.description,
            onTap: () {
              context.push('/insight-details');
            },
          );
        },
      ),
      bottomNavigationBar: const FinNudgeBottomNavBar(
        currentIndex: 4,
      ),
    );
  }
}