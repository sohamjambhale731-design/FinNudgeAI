import 'package:flutter/material.dart';

class AnimatedCounter extends StatelessWidget {
  final double value;

  final String prefix;

  final int duration;

  final TextStyle? style;

  const AnimatedCounter({
    super.key,
    required this.value,
    this.prefix = "",
    this.duration = 1000,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(
        begin: 0,
        end: value,
      ),
      duration: Duration(
        milliseconds: duration,
      ),
      builder: (context, value, child) {
        return Text(
          "$prefix${value.toStringAsFixed(0)}",
          style: style,
        );
      },
    );
  }
}

