import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ExpensePieChart extends StatelessWidget {
  final Map<String, double> data;

  const ExpensePieChart({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final sections = data.entries.map((e) {
      return PieChartSectionData(
        value: e.value,
        radius: 70,
        title: '${e.key}\n₹${e.value.toInt()}',
      );
    }).toList();

    return PieChart(
      PieChartData(
        sections: sections,
        centerSpaceRadius: 45,
      ),
    );
  }
}

