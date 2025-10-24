import 'package:flutter/material.dart';

class MesDossiersPage extends StatefulWidget {
  const MesDossiersPage({Key? key}) : super(key: key);

  @override
  State<MesDossiersPage> createState() => _MesDossiersPageState();
}

class _MesDossiersPageState extends State<MesDossiersPage> with SingleTickerProviderStateMixin {
  // Contrôleur pour le champ de texte
  final TextEditingController _nomDossierController = TextEditingController();
  
  // Contrôleur d'animation pour l'apparition du rectangle
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    
    // Initialisation de l'animation
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    // Démarrer l'animation
    Future.delayed(const Duration(milliseconds: 50), () {
      if (mounted) {
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _nomDossierController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF), // Fond blanc
      
      // AppBar simple et moderne
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF333333)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Mes Dossiers',
          style: TextStyle(
            color: Color(0xFF333333),
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'Roboto',
          ),
        ),
        centerTitle: true,
      ),
      
      // Corps de la page
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: _buildCreationCard(),
          ),
        ),
      ),
    );
  }

  // Rectangle blanc arrondi et ombré avec le formulaire
  Widget _buildCreationCard() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        //espace occupe par chaque colonne
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icône de dossier orange
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFFFFA726).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.folder,
              size: 48,
              color: Color(0xFFFFA726), // Orange
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Titre
          const Text(
            'Créer un nouveau dossier',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF333333),
              fontFamily: 'Roboto',
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Sous-titre
          const Text(
            'Organisez vos documents',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF999999),
              fontFamily: 'Roboto',
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Champ de texte pour le nom du dossier
          TextField(
            controller: _nomDossierController,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Roboto',
              color: Color(0xFF333333),
            ),
            decoration: InputDecoration(
              hintText: 'Nom du dossier',
              hintStyle: const TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Color(0xFFCCCCCC),
                fontFamily: 'Roboto',
              ),
              //ajouter une box grise au dessus de l'input
              filled: true,
              fillColor: const Color(0xFFF5F5F5),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFFE0E0E0),
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFFE0E0E0),
                  width: 1,
                ),
              ),
              //quand tu ecris le cadre orange apparait
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFFFFA726),
                  width: 2,
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Bouton de création
          //cadre de creation et d'erreur
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                // TODO: Logique de création du dossier
                final nomDossier = _nomDossierController.text.trim();
                if (nomDossier.isNotEmpty) {
                  print('Création du dossier : $nomDossier');
                  // Retour à la page précédente
                  Navigator.pop(context);
                } else {
                  // Afficher un message d'erreur
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Veuillez entrer un nom de dossier'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFA726),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Créer le dossier',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
