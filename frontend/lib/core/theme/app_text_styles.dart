import 'package:flutter/material.dart';

import '../colors/app_colors.dart';

/// Typography tokens.
/// Font sizes: Heading 32, Section Title 22, Card Title 18, Body 15, Caption 13
class AppTextStyles {
  static const TextStyle heading = TextStyle(
    fontSize: 32,
    height: 1.15,
    fontWeight: FontWeight.w800,
    color: AppColors.text,
  );

  static const TextStyle sectionTitle = TextStyle(
    fontSize: 22,
    height: 1.2,
    fontWeight: FontWeight.w800,
    color: AppColors.text,
  );

  static const TextStyle cardTitle = TextStyle(
    fontSize: 18,
    height: 1.25,
    fontWeight: FontWeight.w700,
    color: AppColors.text,
  );

  static const TextStyle body = TextStyle(
    fontSize: 15,
    height: 1.35,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 13,
    height: 1.3,
    fontWeight: FontWeight.w600,
    color: AppColors.grey,
  );

  static TextStyle bodyMuted({Color? color}) => TextStyle(
        fontSize: 15,
        height: 1.35,
        fontWeight: FontWeight.w600,
        color: color ?? AppColors.textSecondary,
      );
}

