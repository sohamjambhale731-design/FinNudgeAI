import 'package:flutter/material.dart';

class InsightCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback? onTap;

  const InsightCard({
    super.key,
    required this.title,
    required this.description,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: ListTile(
          leading: const Icon(Icons.lightbulb),
          title: Text(title),
          subtitle: Text(description),
        ),
      ),
    );
  }
}