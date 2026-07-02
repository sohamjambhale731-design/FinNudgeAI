import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/expense_api.dart';


class ExpenseHistoryScreen extends StatelessWidget {
  const ExpenseHistoryScreen({super.key});

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


      body: FutureBuilder<List<dynamic>>(
        future: ExpenseApi.getExpenses(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final history = snapshot.data!;

          if (history.isEmpty) {
            return const Center(
              child: Text(
                "No expense history found",
              ),
            );
          }

          return ListView.builder(
            itemCount: history.length,
            itemBuilder: (context, index) {
              final expense = history[index];

              return ListTile(
                leading: const Icon(Icons.receipt_long),
                title: Text(
                  expense["category"],
                ),
                subtitle: Text(
                  expense["date"],
                ),
                trailing: Text(
                  '₹${expense["amount"]}',
                ),
              );
            },
          );
        },
      ),
    );
  }
}
