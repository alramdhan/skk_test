import 'package:flutter/material.dart';

class CustomRoute {
  Route createRoute(page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curves = Curves.easeIn;
        final tween = Tween(begin: begin, end: end); //.chain(CurveTween(curve: curves));
        var curvedAnimation = CurvedAnimation(parent: animation, curve: curves);

        return SlideTransition(
            position: tween.animate(curvedAnimation),
            child: child
        );
      },
      // transitionDuration: const Duration(milliseconds: 300)
    );
  }
}