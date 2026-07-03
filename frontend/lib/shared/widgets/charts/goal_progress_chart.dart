import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GoalProgressChart extends StatelessWidget {
  final double progress;

  const GoalProgressChart({
    super.key,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        startDegreeOffset: 270,
        centerSpaceRadius: 65,
        sections: [
          PieChartSectionData(
            value: progress,
            radius: 18,
            title: '${progress.toInt()}%',
          ),
          PieChartSectionData(
            value: 100 - progress,
            radius: 18,
            title: '',
          ),
        ],
      ),
    );
  }
}

