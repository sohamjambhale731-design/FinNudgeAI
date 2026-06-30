import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HealthScoreChart extends StatelessWidget {
  final List<double> scores;

  const HealthScoreChart({
    super.key,
    required this.scores,
  });

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        borderData: FlBorderData(show: false),
        gridData: const FlGridData(show: false),
        titlesData: const FlTitlesData(),
        lineBarsData: [
          LineChartBarData(
            isCurved: true,
            barWidth: 4,
            spots: List.generate(
              scores.length,
              (index) => FlSpot(index.toDouble(), scores[index]),
            ),
          ),
        ],
      ),
      duration: const Duration(milliseconds: 900),
    );
  }
}

