import 'package:flutter/material.dart';

import '../models/profile_data.dart';

class ProfileHealthCard extends StatelessWidget {
  final ProfileData data;
  const ProfileHealthCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: const Icon(
          Icons.favorite,
          color: Colors.red,
        ),
        title: const Text('Financial Health'),
        subtitle: Text('${data.healthScore.toStringAsFixed(0)} / 100'),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}

