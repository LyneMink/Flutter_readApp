# Contrôle Segmenté - Documentation

## 🎯 Vue d'ensemble

Le contrôle segmenté est un composant UI placé juste sous l'AppBar qui permet de naviguer entre trois sections : **Mes fichiers**, **Recent**, et **Mes dossiers**.

## 📐 Position et intégration

```
┌─────────────────────────────────┐
│  [Logo]            [🔍]         │  ← AppBar (hauteur: 100px)
├─────────────────────────────────┤
│ Mes fichiers  Recent  Mes dossiers │  ← Contrôle segmenté
│     ━━━━                        │  ← Barre indicatrice orange
├─────────────────────────────────┤
│                                 │
│         Contenu                 │  ← Body
│                                 │
└─────────────────────────────────┘
```

## 🎨 Caractéristiques visuelles

### **Segment sélectionné** (par défaut : "Mes fichiers")
- ✅ **Texte** : Orange #E67E22
- ✅ **Police** : Bold (FontWeight.bold)
- ✅ **Taille** : 16px
- ✅ **Barre indicatrice** :
  - Couleur : Orange #E67E22
  - Largeur : 60px
  - Hauteur : 4px
  - Bords arrondis : BorderRadius.circular(16)
  - Position : 8px sous le texte

### **Segments non sélectionnés** ("Recent", "Mes dossiers")
- ✅ **Texte** : Noir avec opacité 45% (Colors.black.withOpacity(0.45))
- ✅ **Police** : SemiBold (FontWeight.w600)
- ✅ **Taille** : 16px
- ✅ **Barre indicatrice** : Invisible (largeur: 0)

## 🔧 Structure du code

### Variables d'état :
```dart
int _selectedSegmentIndex = 0;  // 0: Mes fichiers, 1: Recent, 2: Mes dossiers
```

### Méthodes principales :

#### 1. `_buildSegmentedControl()`
Construit le conteneur principal du contrôle segmenté.

```dart
Widget _buildSegmentedControl() {
  return Container(
    color: Colors.white,
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildSegmentItem(...),  // Mes fichiers
        _buildSegmentItem(...),  // Recent
        _buildSegmentItem(...),  // Mes dossiers
      ],
    ),
  );
}
```

#### 2. `_buildSegmentItem()`
Construit un item individuel du contrôle segmenté.

**Paramètres :**
- `label` : Texte affiché
- `index` : Index du segment (0, 1, ou 2)
- `isSelected` : Booléen indiquant si le segment est sélectionné

**Structure :**
```dart
GestureDetector(
  onTap: () => _onSegmentChanged(index),
  child: Column(
    children: [
      Text(...),              // Label
      SizedBox(height: 8),
      AnimatedContainer(...), // Barre indicatrice
    ],
  ),
)
```

#### 3. `_onSegmentChanged(int index)`
Gère le changement de segment sélectionné.

```dart
void _onSegmentChanged(int index) {
  setState(() {
    _selectedSegmentIndex = index;
  });
}
```

## 🎬 Animation de la barre indicatrice

La barre indicatrice utilise un **AnimatedContainer** pour une transition fluide :

```dart
AnimatedContainer(
  duration: Duration(milliseconds: 300),
  curve: Curves.easeInOut,
  width: isSelected ? 60 : 0,  // Apparaît/disparaît
  height: 4,
  decoration: BoxDecoration(
    color: Color(0xFFE67E22),
    borderRadius: BorderRadius.circular(16),
  ),
)
```

**Comportement :**
- Durée : 300ms
- Courbe : easeInOut (fluide)
- Largeur : 60px → 0px (ou inverse)
- Transition automatique lors du changement de segment

## 📊 États possibles

| Index | Segment        | État par défaut |
|-------|----------------|-----------------|
| 0     | Mes fichiers   | ✅ Sélectionné  |
| 1     | Recent         | ❌ Non sélectionné |
| 2     | Mes dossiers   | ❌ Non sélectionné |

## 🎯 Interaction utilisateur

1. **Clic sur un segment** → `GestureDetector.onTap`
2. **Appel de** `_onSegmentChanged(index)`
3. **Mise à jour de** `_selectedSegmentIndex`
4. **Rebuild du widget** → Changement visuel
5. **Animation de la barre** → Transition fluide

## 🎨 Palette de couleurs

| Élément | Couleur | Code |
|---------|---------|------|
| Texte sélectionné | Orange | #E67E22 |
| Texte non sélectionné | Noir 45% | Colors.black.withOpacity(0.45) |
| Barre indicatrice | Orange | #E67E22 |
| Fond | Blanc | #FFFFFF |

## 📏 Dimensions

| Élément | Valeur |
|---------|--------|
| Padding horizontal | 24px |
| Padding vertical | 16px |
| Taille texte | 16px |
| Hauteur barre | 4px |
| Largeur barre | 60px |
| Espacement texte-barre | 8px |
| Bords arrondis barre | 16px |

## 💡 Bonnes pratiques implémentées

✅ **Feedback visuel clair** : Couleur orange distinctive
✅ **Animation fluide** : AnimatedContainer avec courbe easeInOut
✅ **Accessibilité** : GestureDetector pour zone de clic large
✅ **Code modulaire** : Méthodes séparées pour chaque composant
✅ **État géré** : setState() pour mise à jour réactive
✅ **Commentaires** : Code bien documenté

## 🔄 Flux de données

```
User clique sur "Recent"
         ↓
GestureDetector.onTap(1)
         ↓
_onSegmentChanged(1)
         ↓
setState(() { _selectedSegmentIndex = 1; })
         ↓
Widget rebuild
         ↓
"Mes fichiers" : isSelected = false → Texte noir, barre invisible
"Recent" : isSelected = true → Texte orange, barre visible
"Mes dossiers" : isSelected = false → Texte noir, barre invisible
         ↓
AnimatedContainer anime la transition (300ms)
```

## 🚀 Extension future possible

Pour afficher du contenu différent selon le segment sélectionné, modifiez `_buildBody()` :

```dart
Widget _buildBody() {
  switch (_selectedSegmentIndex) {
    case 0:
      return _buildMesFichiersContent();
    case 1:
      return _buildRecentContent();
    case 2:
      return _buildMesDossiersContent();
    default:
      return Container();
  }
}
```

## 📱 Responsive

Le contrôle segmenté s'adapte automatiquement à la largeur de l'écran grâce à :
- `Row` avec `MainAxisAlignment.spaceAround`
- Padding proportionnel
- Pas de largeur fixe pour les segments

---

Le contrôle segmenté offre une navigation intuitive et visuellement agréable entre les différentes sections de l'application ! 🎉
