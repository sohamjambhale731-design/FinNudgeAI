import 'package:flutter/material.dart';

class ProfileAchievementCard extends StatelessWidget {
  const ProfileAchievementCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: const Icon(
          Icons.local_fire_department,
          color: Colors.orange,
        ),
        title: const Text('Money Streak'),
        subtitle: const Text('12 Days'),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}

