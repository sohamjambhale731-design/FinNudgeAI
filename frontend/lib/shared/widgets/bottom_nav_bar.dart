import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/colors/app_colors.dart';

class FinNudgeBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const FinNudgeBottomNavBar({
    super.key,
    required this.currentIndex,
  });

  static const _items = [
    (
      icon: Icons.dashboard_rounded,
      label: 'Dashboard',
      route: '/',
    ),
    (
      icon: Icons.account_balance_wallet_rounded,
      label: 'Income',
      route: '/income',
    ),
    (
      icon: Icons.receipt_long_rounded,
      label: 'Expenses',
      route: '/expenses',
    ),
    (
      icon: Icons.flag_rounded,
      label: 'Goals',
      route: '/goals',
    ),
    (
      icon: Icons.auto_graph_rounded,
      label: 'Insights',
      route: '/insights',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 72,
        margin: const EdgeInsets.fromLTRB(
          16,
          0,
          16,
          12,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFF0ECE7),
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(
                alpha: 0.05,
              ),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: List.generate(
            _items.length,
            (index) {
              final item = _items[index];
              final isSelected =
                  currentIndex == index;

              return Expanded(
                child: InkWell(
                  borderRadius:
                      BorderRadius.circular(16),
                  onTap: () =>
                      context.go(item.route),
                  child: AnimatedContainer(
                    duration:
                        const Duration(milliseconds: 200),
                    padding:
                        const EdgeInsets.symmetric(
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.white
                          : Colors.transparent,
                      borderRadius:
                          BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        Icon(
                          item.icon,
                          size: 20,
                          color: isSelected
                              ? AppColors.goal
                              : Colors.black54,
                        ),

                        const SizedBox(height: 2),

                        Text(
                          item.label,
                          maxLines: 1,
                          overflow:
                              TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: isSelected
                                ? FontWeight.w700
                                : FontWeight.w500,
                            color: isSelected
                                ? AppColors.goal
                                : Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}