import 'package:flutter/material.dart';

import '../models/profile_data.dart';

class ProfileHeader extends StatelessWidget {
  final ProfileData data;
  const ProfileHeader({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 70, bottom: 35),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff00c853),
            Color(0xff00acc1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(35),
          bottomRight: Radius.circular(35),
        ),
      ),
      child: Column(
        children: [
          const _Avatar(),
          const SizedBox(height: 15),

          const SizedBox(height: 5),

          Text(
            'Soham Jambhale',
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 5),

          const Text(
            'Financial Explorer',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 18),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Chip(
                label: Text(
                  '🏆 ${data.level} Saver',
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.black.withOpacity(0.18),
              ),
              const SizedBox(width: 10),
              IconButton(
                onPressed: () {
                  // TODO: wire edit profile flow
                },
                icon: const Icon(Icons.edit, color: Colors.white),
                tooltip: 'Edit profile',
              ),
            ],
          ),

          const SizedBox(height: 6),

          const Text(
            'soham@example.com',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar();

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 50,
      backgroundColor: Colors.white,
      child: Text(
        'S',
        style: TextStyle(
          fontSize: 38,
          fontWeight: FontWeight.bold,
          color: Colors.teal,
        ),
      ),
    );
  }
}

