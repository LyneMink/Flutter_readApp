# Page "Mes Dossiers"

## 📋 Description

Page permettant à l'utilisateur de créer un nouveau dossier pour organiser ses documents.

## 🎨 Design

### Structure visuelle
```
┌─────────────────────────────────────────┐
│  ← Mes Dossiers                         │ AppBar
├─────────────────────────────────────────┤
│                                         │
│   ┌───────────────────────────────┐    │
│   │                               │    │
│   │         🗂️ (orange)           │    │
│   │                               │    │
│   │   Créer un nouveau dossier    │    │
│   │   Organisez vos documents     │    │
│   │                               │    │
│   │   ┌───────────────────────┐  │    │
│   │   │ Nom du dossier...     │  │    │ Card centré
│   │   └───────────────────────┘  │    │
│   │                               │    │
│   │   [ Créer le dossier ]        │    │
│   │                               │    │
│   └───────────────────────────────┘    │
│                                         │
└─────────────────────────────────────────┘
```

### Couleurs
- **Fond page** : Blanc (#FFFFFF)
- **Icône dossier** : Orange (#FFA726)
- **Bordure TextField** : Gris clair (#E0E0E0)
- **Focus TextField** : Orange (#FFA726)
- **Bouton** : Orange (#FFA726)
- **Texte** : Gris foncé (#333333)

### Composants

#### 1. AppBar
- Fond blanc
- Bouton retour à gauche
- Titre "Mes Dossiers" centré
- Elevation 0 (flat design)

#### 2. Card de création
- Rectangle blanc arrondi (border-radius: 20px)
- Ombre douce (blur: 20, opacity: 0.08)
- Largeur: 85% de l'écran
- Padding: 32px

#### 3. Icône dossier
- Taille: 48px
- Couleur: Orange (#FFA726)
- Fond circulaire orange avec opacité 10%
- Diamètre: 80px

#### 4. TextField
- Police: Roboto, 16px
- Placeholder: "Nom du dossier" (italique)
- Fond: Gris très clair (#F5F5F5)
- Bordure: Gris clair (#E0E0E0)
- Focus: Orange (#FFA726), 2px
- Border-radius: 12px
- Padding: 20px horizontal, 16px vertical

#### 5. Bouton "Créer le dossier"
- Largeur: 100%
- Hauteur: 50px
- Fond: Orange (#FFA726)
- Texte: Blanc, 16px, Roboto SemiBold
- Border-radius: 12px
- Elevation: 0

## 🔄 Navigation

### Depuis HomePage3
- Clic sur l'icône **folder** dans la BottomNavigationBar
- Animation: **Slide depuis la droite** (400ms)
- Curve: `Curves.easeInOut`

### Retour
- Bouton retour AppBar
- Navigation.pop()

## 🎭 Animations

### Apparition de la card
1. **Fade-in** : Opacité 0 → 1 (600ms)
2. **Slide-up** : Offset (0, 0.1) → (0, 0) (600ms)
3. Curve: `Curves.easeOutCubic`
4. Délai: 50ms après l'initialisation

## 💻 Code

### Fichier
`lib/HOME_PAGE/mes_dossiers_page.dart`

### Import
```dart
import 'mes_dossiers_page.dart';
```

### Navigation (dans home_page3.dart)
```dart
Navigator.push(
  context,
  PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const MesDossiersPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
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
```

### État
- `TextEditingController _nomDossierController` : Gère le texte du champ
- `AnimationController _animationController` : Contrôle l'animation d'apparition
- `Animation<double> _fadeAnimation` : Animation de fondu
- `Animation<Offset> _slideAnimation` : Animation de glissement

## ✅ Validation

### Création du dossier
```dart
onPressed: () {
  final nomDossier = _nomDossierController.text.trim();
  if (nomDossier.isNotEmpty) {
    // TODO: Logique de création
    print('Création du dossier : $nomDossier');
    Navigator.pop(context);
  } else {
    // Message d'erreur
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Veuillez entrer un nom de dossier'),
        backgroundColor: Colors.red,
      ),
    );
  }
}
```

## 📝 TODO Backend

- [ ] Implémenter la logique de création du dossier
- [ ] Ajouter la persistance (base de données locale / Firebase)
- [ ] Gérer les dossiers existants
- [ ] Ajouter la validation du nom (caractères interdits, longueur max)
- [ ] Afficher la liste des dossiers créés
- [ ] Ajouter la possibilité de supprimer/renommer un dossier

## 🎯 Fonctionnalités futures

- Liste des dossiers existants sous la card de création
- Drag & drop de documents dans les dossiers
- Couleurs personnalisables pour chaque dossier
- Statistiques (nombre de documents par dossier)
- Recherche dans les dossiers
- Export de dossiers
