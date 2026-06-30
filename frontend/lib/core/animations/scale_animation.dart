import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ScaleAnimation extends StatelessWidget {
  final Widget child;

  final int delay;

  const ScaleAnimation({
    super.key,
    required this.child,
    this.delay = 0,
  });

  @override
  Widget build(BuildContext context) {
    return child
        .animate(delay: Duration(milliseconds: delay))
        .scale(
          begin: const Offset(.8, .8),
          end: const Offset(1, 1),
          duration: 400.ms,
        )
        .fade();
  }
}

