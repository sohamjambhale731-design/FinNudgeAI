import 'package:flutter/material.dart';

import 'fade_slide_animation.dart';

class StaggeredAnimation extends StatelessWidget {
  final List<Widget> children;

  const StaggeredAnimation({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        children.length,
        (index) => FadeSlideAnimation(
          delay: index * 100,
          child: children[index],
        ),
      ),
    );
  }
}

