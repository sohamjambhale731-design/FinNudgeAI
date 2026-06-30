import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class FadeSlideAnimation extends StatelessWidget {
  final Widget child;

  final int delay;

  const FadeSlideAnimation({
    super.key,
    required this.child,
    this.delay = 0,
  });

  @override
  Widget build(BuildContext context) {
    return child
        .animate(delay: Duration(milliseconds: delay))
        .fade(
          duration: 500.ms,
        )
        .slideY(
          begin: .25,
          end: 0,
          duration: 500.ms,
        );
  }
}

