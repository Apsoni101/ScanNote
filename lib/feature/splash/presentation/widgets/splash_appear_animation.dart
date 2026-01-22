import 'package:flutter/material.dart';

class SplashAppearAnimation extends StatelessWidget {
  const SplashAppearAnimation({
    required this.animation,
    required this.child,
    super.key,
  });

  final Animation<double> animation;
  final Widget child;

  @override
  Widget build(final BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (final BuildContext context, final Widget? child) {
        return Opacity(
          opacity: animation.value,
          child: Transform.translate(
            offset: Offset(0, 30 * (1 - animation.value)),
            child: child,
          ),
        );
      },
    );
  }
}
