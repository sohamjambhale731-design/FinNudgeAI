import 'package:flutter/material.dart';

import '../../../core/api/profile_api.dart';
import '../models/profile_data.dart';
import '../widgets/profile_achievement_card.dart';
import '../widgets/profile_health_card.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_settings.dart';
import '../widgets/profile_stats_grid.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<Map<String, dynamic>> profileFuture;

  @override
  void initState() {
    super.initState();
    profileFuture = ProfileApi.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f7fb),
      body: FutureBuilder<Map<String, dynamic>>(
        future: profileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Failed to load profile\n${snapshot.error}',
                textAlign: TextAlign.center,
              ),
            );
          }

          final data = ProfileData.fromJson(snapshot.data!);

          return SingleChildScrollView(
            child: Column(
              children: [
                ProfileHeader(data: data),
                const SizedBox(height: 25),
                ProfileStatsGrid(data: data),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: ProfileHealthCard(data: data),
                ),
                const SizedBox(height: 14),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: ProfileAchievementCard(),
                ),
                const SizedBox(height: 22),
                const ProfileSettings(),
                const SizedBox(height: 26),
              ],
            ),
          );
        },
      ),
    );
  }
}


