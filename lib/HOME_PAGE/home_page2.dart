import 'dart:async';
import 'package:flutter/material.dart';
import 'home_page3.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  @override
  void initState() {
    super.initState();
    // Transition automatique vers HomePage3 après 2 secondes
    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        _navigateToHomePage3();
      }
    });
  }

  void _navigateToHomePage3() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const HomePage3(),
        transitionDuration: const Duration(milliseconds: 1000),
        reverseTransitionDuration: const Duration(milliseconds: 800),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // Animation de fade pour la transition
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
    return Scaffold(
      //couleur de la page
      backgroundColor: const Color(0xFFC5C6CA), // Gris clair
      body: SafeArea(
        child: Padding(
          //padding horizontal
          padding: const EdgeInsets.only(top: 20.0, left: 24.0, right: 24.0),
          //creation d'une colonne empilée
          child: Column(
            //alignement horizontal
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo en haut à gauche avec Hero animation
              Hero(
                tag: 'logo_hero', // Même tag que HomePage1 pour l'animation
                child: Container(
                  //ajout d'un container pour le logo
                  constraints: const BoxConstraints(
                    //dimensions de l'image
                    maxWidth: 50,
                    maxHeight: 50,
                  ),
                  //ajout de l'image avec bords arrondis
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    //ajout de l'image
                    child: Image.asset(
                      'assets/logo_app_lecture.png',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        // Fallback si l'image n'existe pas
                        return const Icon(
                          Icons.picture_in_picture,
                          size: 60,
                          color: Color(0xFFE67E22),
                        );
                      },
                    ),
                  ),
                ),
              ),
              
              // Espace pour les futurs éléments
              const SizedBox(height: 40),
              
              // Zone vide pour le moment (à compléter plus tard)
            ],
          ),
        ),
      ),
    );
  }
}
