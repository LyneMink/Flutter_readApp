import 'package:flutter/material.dart';

class Home_page extends StatelessWidget {
  const Home_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //couleur de la page
      backgroundColor: const Color(0xFFC5C6CA), // Gris clair
      appBar: AppBar(
        backgroundColor: const Color(0xFFC5C6CA),
        elevation: 0,
      ),
      body: Center(
        //padding horizontal
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          //creation d'une colonne empilée
          child: Column(
            //centrer les elements verticals et horizontales dans la colonne
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo avec Hero animation
              Flexible(
                child: Hero(
                  tag: 'logo_hero', // Tag unique pour l'animation Hero
                  child: Container(
                    //ajout d'un container pour centrer l'image
                    constraints: BoxConstraints(
                      //dimensions de l'image
                      maxWidth: MediaQuery.of(context).size.width * 0.4,
                      maxHeight: MediaQuery.of(context).size.height * 0.2,
                    ),
                    //ajout de l'image avec bords arrondis
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      //ajout de l'image
                      child: Image.asset(
                        'assets/logo_app_lecture.png',
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          // Fallback si l'image n'existe pas
                          return const Icon(
                            Icons.picture_in_picture,
                            size: 120,
                            color: Color(0xFFE67E22),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Texte
              const Text(
                'POUR UNE MEILLEURE LECTURE DE VOS PDF',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFE67E22), // Orange
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Roboto',
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}