import 'dart:async';
import 'package:flutter/material.dart';
import 'Home_page.dart';
import 'home_page2.dart';

class SplashWrapper extends StatefulWidget {
  const SplashWrapper({super.key});

  @override
  State<SplashWrapper> createState() => _SplashWrapperState();
}

class _SplashWrapperState extends State<SplashWrapper> {
  @override
  void initState() {
    super.initState();
    // Transition automatique après 3 secondes
    Timer(const Duration(seconds: 1), () {
      if (mounted) {
        _navigateToHomePage2();
      }
    });
  }

  void _navigateToHomePage2() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const HomePage2(),
        transitionDuration: const Duration(milliseconds: 1200), // Durée plus longue pour Hero
        reverseTransitionDuration: const Duration(milliseconds: 800),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // Animation de fade pour rendre la transition plus douce
          return FadeTransition(
            opacity: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            )),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Home_page();
  }
}
