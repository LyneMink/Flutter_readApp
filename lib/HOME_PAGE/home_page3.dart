import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';
import 'mes_dossiers_page.dart';
//import 'home_page2.dart';

class HomePage3 extends StatefulWidget {
  const HomePage3({super.key});

  @override
  State<HomePage3> createState() => _HomePage3State();
}

class _HomePage3State extends State<HomePage3> with SingleTickerProviderStateMixin {
  // Contrôleur d'animation pour l'AppBar
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  
  // Index du segment sélectionné (0: Mes fichiers, 1: Recent, 2: Mes dossiers)
  int _selectedSegmentIndex = 0;
  
  // Index de l'icône sélectionnée dans la bottom nav bar (0: Document, 1: Folder, 2: Settings)
  int _selectedBottomNavIndex = 0;

  @override
  void initState() {
    super.initState();
    
    // Initialisation du contrôleur d'animation
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // Animation de slide pour l'AppBar (gauche vers droite)
    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0), // Commence hors écran à gauche
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    // Animation de fade pour rendre la transition plus douce
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    ));

    // Démarrer l'animation après un court délai
    Future.delayed(const Duration(milliseconds: 50), () {
      if (mounted) {
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Gestion du changement de segment
  void _onSegmentChanged(int index) {
    setState(() {
      _selectedSegmentIndex = index;
    });
  }

  // Ouvre le sélecteur de fichiers pour PDF et images
  Future<void> _onAddPressed() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg'],
        allowMultiple: false,
        withData: false,
      );

      if (!mounted) return;

      // Si l'utilisateur annule, rien ne se passe
      if (result == null) {
        return;
      }

      final file = result.files.single;
      final fileName = file.name;

      // Affiche une confirmation
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Fichier sélectionné: $fileName')),
      );
      // Log console
      // ignore: avoid_print
      print('Fichier sélectionné: $fileName - chemin: ${file.path}');
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de la sélection du fichier')),
      );
      // ignore: avoid_print
      print('Erreur FilePicker: $e');
    }
  }

  // Obtenir le texte à afficher selon le segment sélectionné
  String _getEmptyStateText() {
    switch (_selectedSegmentIndex) {
      case 0:
        return 'Aucun document importé';
      case 1:
        return 'Aucun document récent';
      case 2:
        return 'Aucun dossier créé';
      default:
        return 'Aucun document importé';
    }
  }

  // ==================== CONSTRUCTION DE L'APPBAR ====================
  Widget _buildAppBar() {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFAFAFA), // Gris clair pour l'AppBar
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.26),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Première ligne : Logo et icône de recherche
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Logo à gauche avec Hero animation
                    Hero(
                      tag: 'logo_hero',
                      child: Container(
                        constraints: const BoxConstraints(
                          maxWidth: 50,
                          maxHeight: 50,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/logo 2.png',
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              // Fallback si l'image n'existe pas
                              return const Icon(
                                Icons.picture_in_picture,
                                size: 40,
                                color: Color(0xFFE67E22),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    
                    // Icône de recherche à droite
                    IconButton(
                      icon: const Icon(
                        Icons.search,
                        color: Color(0xFF333333),
                        size: 28,
                      ),
                      onPressed: () {
                        // Action de recherche à implémenter
                        print('Recherche cliquée');
                      },
                    ),
                  ],
                ),
              ),
              
              // Deuxième ligne : Contrôle segmenté intégré dans l'AppBar
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Segment 1 : Mes fichiers
                    _buildSegmentItem(
                      label: 'Mes fichiers',
                      index: 0,
                      isSelected: _selectedSegmentIndex == 0,
                    ),
                    
                    // Segment 2 : Recent
                    _buildSegmentItem(
                      label: 'Recent',
                      index: 1,
                      isSelected: _selectedSegmentIndex == 1,
                    ),
                    
                    // Segment 3 : Mes dossiers
                    _buildSegmentItem(
                      label: 'Mes dossiers',
                      index: 2,
                      isSelected: _selectedSegmentIndex == 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==================== CONSTRUCTION D'UN ITEM DU CONTRÔLE SEGMENTÉ ====================
  // Construction d'un item du contrôle segmenté
  Widget _buildSegmentItem({
    required String label,
    required int index,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () => _onSegmentChanged(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Label du segment
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
              color: isSelected
                  ? const Color(0xFFE67E22) // Orange si sélectionné
                  : Colors.black.withOpacity(0.45), // Noir avec opacité 45%
            ),
          ),
          
          const SizedBox(height: 0), // Espace réduit entre le texte et la barre
          
          // Barre indicatrice sous le label
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: isSelected ? 60 : 0, // Largeur de la barre
            height: 4, // Hauteur de la barre
            decoration: BoxDecoration(
              color: const Color(0xFFE67E22), // Orange
              borderRadius: BorderRadius.circular(16), // Bords arrondis
            ),
          ),
        ],
      ),
    );
  }

  // ==================== CONSTRUCTION DU BODY ====================
  Widget _buildBody() {
    return Container(
      // Fond blanc pour le corps de la page
      color: const Color(0xFFFFFFFF),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image illustrative - État vide (aucun document)
              // Pour changer l'image : remplacez 'assets/document.png' par le chemin de votre image
              Flexible(
                child: Container(
                  constraints: BoxConstraints(
                    // L'image s'adapte à la taille de l'écran
                    maxHeight: MediaQuery.of(context).size.height * 0.85, // Max 25% de la hauteur
                    maxWidth: MediaQuery.of(context).size.width * 0.95, // Max 50% de la largeur
                  ),
                  child: Image.asset(
                    'assets/document.png',
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      // Fallback si l'image n'existe pas
                      return const Icon(
                        Icons.description_outlined,
                        size: 120,
                        color: Color(0xFFCCCCCC),
                      );
                    },
                  ),
                ),
              ),
              
              // Espacement entre l'image et le texte
              const SizedBox(height: 12),
              
              // Texte dynamique selon le segment sélectionné
              // Le texte change automatiquement quand on clique sur un segment
              Text(
                _getEmptyStateText(), // Texte dynamique selon le segment
                textAlign: TextAlign.center,
                style: GoogleFonts.chelseaMarket(
                  fontSize: 20,
                  fontWeight: FontWeight.w400, // Normal
                  color: Colors.black.withOpacity(0.5), // Noir avec opacité 50%
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Construction d'un item de la bottom nav bar (style contrôle segmenté)
  Widget _buildBottomNavItem({
    required IconData icon,
    required int index,
    required VoidCallback onPressed,
    String? badge,
  }) {
    final bool isSelected = _selectedBottomNavIndex == index;
    final Color iconColor = isSelected ? const Color(0xFFE67E22) : const Color(0xFF999999);
    final Color badgeColor = isSelected ? const Color(0xFFE67E22) : const Color(0xFF666666);
    
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      //taille des box pour les boutons
      child: SizedBox(
        width: 52, // Largeur fixe pour uniformiser
        height: 52, // Hauteur fixe pour uniformiser
        //  child: Stack(
        //   clipBehavior: Clip.none,
        //   alignment: Alignment.center,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            // Icône
            Icon(
              icon,
              color: iconColor,
              size: 28, // Taille uniforme pour toutes les icônes
            ),
            
            // Badge "NEW" en haut à droite
            if (badge != null)
              Positioned(
                right: -4,
                top: -4,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                  decoration: BoxDecoration(
                    color: badgeColor,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Text(
                    badge,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 7,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // ==================== CONSTRUCTION DE LA BOTTOMNAVIGATIONBAR ====================
  Widget _buildBottomNavigationBar() {
    return Container(
      // padding: EdgeInsets.only(
      //   bottom: MediaQuery.of(context).padding.bottom, // Ajoute un padding pour éviter le chevauchement
      // ),
      decoration: BoxDecoration(
        //color: const Color(0xFFFFFFFF),
        //height = 300,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        child: BottomAppBar(
          color: const Color.fromARGB(255, 255, 255, 255),
          elevation: 0,
          shape: const CircularNotchedRectangle(),
          notchMargin: 5.0, 
          child: Container(
            height: 65, 
            //crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             //mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center, // Centre verticalement
              children: [
                // Icône 1 - Document → Mes fichiers
                _buildBottomNavItem(
                  icon: Icons.description,
                  index: 0,
                  onPressed: () {
                    setState(() {
                      _selectedBottomNavIndex = 0;
                      _selectedSegmentIndex = 0; // Renvoi vers "Mes fichiers"
                    });
                    print('Documents cliqué - Renvoi vers Mes fichiers');
                  },
                ),
                
                // Icône 2 - Nouveau dossier avec badge "NEW"
                _buildBottomNavItem(
                  icon: Icons.folder,
                  index: 1,
                  //badge: 'NEW',
                  onPressed: () {
                    setState(() {
                      _selectedBottomNavIndex = 1;
                      _selectedSegmentIndex = 2;
                    });
                    // Navigation vers la page "Mes Dossiers" avec animation slide
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => const MesDossiersPage(),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          const begin = Offset(1.0, 0.0); // Slide depuis la droite
                          const end = Offset.zero;
                          const curve = Curves.easeInOut;
                          
                          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                          var offsetAnimation = animation.drive(tween);
                          
                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                        transitionDuration: const Duration(milliseconds: 400),
                      ),
                    );
                  },
                ),
                
                // Espace vide au centre pour le FAB
                const SizedBox(width: 60),
                
                // Icône 3 - Espace vide (pour symétrie)
                const SizedBox(width: 36),
                
                // Icône 4 - Paramètres
                _buildBottomNavItem(
                  icon: Icons.settings,
                  index: 2,
                  onPressed: () {
                    setState(() {
                      _selectedBottomNavIndex = 2;
                    });
                    print('Paramètres cliqué');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ==================== BUILD PRINCIPAL ====================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fond blanc pur pour toute la page
      backgroundColor: const Color(0xFFFFFFFF),
      
      // Évite que le clavier ne redimensionne la page
      resizeToAvoidBottomInset: false,
      
      // Corps de la page avec SafeArea (seulement en haut, pas en bas)
      body: SafeArea(
        bottom: false, // Ne pas appliquer SafeArea en bas
        child: Column(
          children: [
            // ========== HEADER : AppBar personnalisée avec contrôle segmenté intégré ==========
            _buildAppBar(),
            
            // ========== BODY : Contenu principal de la page ==========
            Expanded(
              child: _buildBody(),
            ),
          ],
        ),
      ),
      
      // ========== FOOTER : BottomNavigationBar ==========
      bottomNavigationBar: _buildBottomNavigationBar(),
      
      // ========== FLOATING ACTION BUTTON : Bouton central orange ==========
      floatingActionButton: Container(
        //creation du bouton orange
        width: 65,
        height: 65,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFFE67E22), // Orange uni
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.16), // Noir avec opacité 16%
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: _onAddPressed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: const Icon(
            Icons.add,
            size: 30,
            color: Colors.white, // Icône blanche
          ),
        ),
      ),
      
      // Position du FAB au centre de la BottomNavigationBar
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
