import 'dart:math';
import 'package:flutter/material.dart';

//PageRout Animations
class CustomPageTransitionBuilder extends PageTransitionsBuilder {
  const CustomPageTransitionBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // Faqat birinchi sahifa emas, keyingi sahifalarda animatsiya
    if (route.settings.name == '/') return child;

    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.1, 0.0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      ),
    );
  }
}

//Book Flip PageRout Animations
class BookPageTransitionBuilder extends PageTransitionsBuilder {
  const BookPageTransitionBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (route.settings.name == '/') return child;
    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.easeInOutCubic,
    );

    return AnimatedBuilder(
      animation: curvedAnimation,
      builder: (context, _) {
        final angle = pi * (1 - curvedAnimation.value);
        final isUnder = angle > pi / 2;

        final transform = Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY(angle);

        return Transform(
          alignment: Alignment.centerRight,
          transform: transform,
          child: isUnder
              ? Opacity(
                  opacity: 1 - curvedAnimation.value,
                  child: Container(color: Colors.black12),
                )
              : child,
        );
      },
    );
  }
}

class SmoothSlideTransitionBuilder extends PageTransitionsBuilder {
  const SmoothSlideTransitionBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (route.settings.name == '/') return child;
    final curved = CurvedAnimation(
      parent: animation,
      curve: Curves.easeInOutCubic,
    );
    return ScaleTransition(
      scale: Tween<double>(begin: 0.9, end: 1.0).animate(curved),
      child: FadeTransition(opacity: curved, child: child),
    );
  }
}

class LiquidPageTransitionBuilder extends PageTransitionsBuilder {
  const LiquidPageTransitionBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (route.settings.name == '/') return child;

    final curved = CurvedAnimation(
      parent: animation,
      curve: Curves.easeInOutQuart,
      reverseCurve: Curves.easeInOutCubic,
    );

    return AnimatedBuilder(
      animation: curved,
      builder: (context, _) {
        final size = MediaQuery.of(context).size;
        final maxRadius = sqrt(
          size.width * size.width + size.height * size.height,
        );
        final radius = maxRadius * curved.value;

        return ClipPath(
          clipper: _CircleRevealClipper(radius),
          child: Opacity(opacity: curved.value.clamp(0.2, 1.0), child: child),
        );
      },
    );
  }
}

class _CircleRevealClipper extends CustomClipper<Path> {
  final double radius;
  _CircleRevealClipper(this.radius);

  @override
  Path getClip(Size size) {
    final path = Path();
    path.addOval(
      Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: radius,
      ),
    );
    return path;
  }

  @override
  bool shouldReclip(_CircleRevealClipper oldClipper) =>
      radius != oldClipper.radius;
}
