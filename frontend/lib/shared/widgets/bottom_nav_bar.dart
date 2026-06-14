import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FinNudgeBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const FinNudgeBottomNavBar({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,

      onTap: (index) {
        switch (index) {
          case 0:
            context.go('/');
            break;

          case 1:
            context.go('/income');
            break;

          case 2:
            context.go('/expenses');
            break;

          case 3:
            context.go('/goals');
            break;

          case 4:
            context.go('/insights');
            break;
        }
      },

      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.account_balance_wallet),
          label: 'Income',
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.receipt_long),
          label: 'Expenses',
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.flag),
          label: 'Goals',
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.insights),
          label: 'Insights',
        ),
      ],
    );
  }
}