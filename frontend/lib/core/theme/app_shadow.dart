import 'package:flutter/material.dart';

/// Shadow presets.
class AppShadow {
  /// Very subtle, for cards on light backgrounds.
  static const BoxShadow soft = BoxShadow(
    color: Color(0x1A0B1220),
    blurRadius: 20,
    spreadRadius: 0,
    offset: Offset(0, 8),
  );

  /// Slight lift.
  static const BoxShadow cardElev = BoxShadow(
    color: Color(0x140B1220),
    blurRadius: 14,
    spreadRadius: 0,
    offset: Offset(0, 6),
  );
}

