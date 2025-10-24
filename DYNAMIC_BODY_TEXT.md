# Texte Dynamique du Body - Documentation

## 🎯 Vue d'ensemble

Le texte affiché dans le body de HomePage3 change **automatiquement** selon le segment sélectionné dans le contrôle segmenté.

## 📐 Comportement dynamique

### Segment sélectionné → Texte affiché

| Segment | Index | Texte affiché |
|---------|-------|---------------|
| **Mes fichiers** | 0 | "Aucun document importé" |
| **Recent** | 1 | "Aucun document récent" |
| **Mes dossiers** | 2 | "Aucun dossier créé" |

## 🎨 Résultat visuel

### Quand "Mes fichiers" est sélectionné :
```
┌─────────────────────────────────┐
│  Mes fichiers  Recent  Dossiers │
│      ━━━━                       │
├─────────────────────────────────┤
│        [📄 Document]            │
│   Aucun document importé        │  ← Texte par défaut
└─────────────────────────────────┘
```

### Quand "Recent" est sélectionné :
```
┌─────────────────────────────────┐
│  Mes fichiers  Recent  Dossiers │
│                 ━━━━            │
├─────────────────────────────────┤
│        [📄 Document]            │
│   Aucun document récent         │  ← Texte changé
└─────────────────────────────────┘
```

### Quand "Mes dossiers" est sélectionné :
```
┌─────────────────────────────────┐
│  Mes fichiers  Recent  Dossiers │
│                        ━━━━     │
├─────────────────────────────────┤
│        [📄 Document]            │
│     Aucun dossier créé          │  ← Texte changé
└─────────────────────────────────┘
```

## 🔧 Implémentation technique

### 1. Variable d'état
```dart
int _selectedSegmentIndex = 0; // 0: Mes fichiers, 1: Recent, 2: Mes dossiers
```

### 2. Méthode pour obtenir le texte
```dart
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
```

### 3. Utilisation dans le body
```dart
Text(
  _getEmptyStateText(), // ← Appel de la méthode
  textAlign: TextAlign.center,
  style: GoogleFonts.chelseaMarket(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: Colors.black.withOpacity(0.5),
  ),
),
```

### 4. Gestion du changement de segment
```dart
void _onSegmentChanged(int index) {
  setState(() {
    _selectedSegmentIndex = index; // ← Met à jour l'index
  });
  // Le widget se reconstruit automatiquement
  // _getEmptyStateText() retourne le nouveau texte
}
```

## 🔄 Flux d'interaction

```
User clique sur "Recent"
         ↓
_onSegmentChanged(1) appelée
         ↓
setState(() { _selectedSegmentIndex = 1; })
         ↓
Widget rebuild (body se reconstruit)
         ↓
_getEmptyStateText() appelée
         ↓
switch (_selectedSegmentIndex) → case 1
         ↓
return 'Aucun document récent'
         ↓
Text widget affiche le nouveau texte
         ↓
Animation de la barre orange vers "Recent"
```

## 🎨 Caractéristiques du texte

Peu importe le segment, le texte conserve le même style :

| Propriété | Valeur |
|-----------|--------|
| Police | Chelsea Market (Google Fonts) |
| Taille | 20px |
| Poids | FontWeight.w400 (normal) |
| Couleur | Noir avec opacité 50% |
| Alignement | Centré |

## 💡 Personnalisation

### Changer les textes affichés :

```dart
String _getEmptyStateText() {
  switch (_selectedSegmentIndex) {
    case 0:
      return 'Aucun fichier disponible'; // ← Modifiez ici
    case 1:
      return 'Aucun fichier récent'; // ← Modifiez ici
    case 2:
      return 'Aucun dossier disponible'; // ← Modifiez ici
    default:
      return 'Aucun document importé';
  }
}
```

### Ajouter un 4ème segment :

**Étape 1 :** Ajouter le segment dans `_buildAppBar()` :
```dart
_buildSegmentItem(
  label: 'Favoris',
  index: 3,
  isSelected: _selectedSegmentIndex == 3,
),
```

**Étape 2 :** Ajouter le cas dans `_getEmptyStateText()` :
```dart
case 3:
  return 'Aucun favori ajouté';
```

### Changer la langue (multilingue) :

```dart
String _getEmptyStateText() {
  // Exemple avec une variable de langue
  if (_currentLanguage == 'en') {
    switch (_selectedSegmentIndex) {
      case 0: return 'No document imported';
      case 1: return 'No recent document';
      case 2: return 'No folder created';
    }
  } else {
    // Français par défaut
    switch (_selectedSegmentIndex) {
      case 0: return 'Aucun document importé';
      case 1: return 'Aucun document récent';
      case 2: return 'Aucun dossier créé';
    }
  }
}
```

## 🎯 Avantages de cette approche

✅ **Réactif** : Le texte change instantanément au clic
✅ **Maintenable** : Un seul endroit pour gérer les textes
✅ **Extensible** : Facile d'ajouter de nouveaux segments
✅ **Cohérent** : Même style pour tous les textes
✅ **Performant** : Pas de requête réseau, changement local

## 🚀 Extension future

### Afficher du contenu différent selon le segment :

```dart
Widget _buildBody() {
  // Si des documents existent
  if (_hasContent()) {
    return _buildContentForSegment();
  }
  
  // Sinon, afficher l'état vide
  return _buildEmptyState();
}

Widget _buildContentForSegment() {
  switch (_selectedSegmentIndex) {
    case 0:
      return _buildFilesList(); // Liste des fichiers
    case 1:
      return _buildRecentList(); // Liste des récents
    case 2:
      return _buildFoldersList(); // Liste des dossiers
    default:
      return _buildEmptyState();
  }
}
```

### Changer l'image selon le segment :

```dart
String _getEmptyStateImage() {
  switch (_selectedSegmentIndex) {
    case 0:
      return 'assets/document.png';
    case 1:
      return 'assets/recent.png';
    case 2:
      return 'assets/folder.png';
    default:
      return 'assets/document.png';
  }
}

// Dans le body :
Image.asset(
  _getEmptyStateImage(), // ← Image dynamique
  fit: BoxFit.contain,
),
```

## 📊 États possibles

| État | Segment | Texte | Image |
|------|---------|-------|-------|
| Initial | Mes fichiers | "Aucun document importé" | document.png |
| Après clic Recent | Recent | "Aucun document récent" | document.png |
| Après clic Dossiers | Mes dossiers | "Aucun dossier créé" | document.png |

## 🎬 Animation

Le changement de texte se fait avec une transition fluide grâce à :
- `setState()` qui déclenche un rebuild
- Flutter qui anime automatiquement le changement de texte
- Durée : ~300ms (animation par défaut de Flutter)

## 💻 Code complet

```dart
// Variable d'état
int _selectedSegmentIndex = 0;

// Méthode de changement
void _onSegmentChanged(int index) {
  setState(() {
    _selectedSegmentIndex = index;
  });
}

// Méthode pour obtenir le texte
String _getEmptyStateText() {
  switch (_selectedSegmentIndex) {
    case 0: return 'Aucun document importé';
    case 1: return 'Aucun document récent';
    case 2: return 'Aucun dossier créé';
    default: return 'Aucun document importé';
  }
}

// Utilisation dans le body
Widget _buildBody() {
  return Container(
    child: Center(
      child: Column(
        children: [
          Image.asset('assets/document.png'),
          SizedBox(height: 12),
          Text(
            _getEmptyStateText(), // ← Texte dynamique
            style: GoogleFonts.chelseaMarket(
              fontSize: 20,
              color: Colors.black.withOpacity(0.5),
            ),
          ),
        ],
      ),
    ),
  );
}
```

---

Le texte du body s'adapte maintenant intelligemment au segment sélectionné, offrant une expérience utilisateur cohérente et informative ! 🎉
