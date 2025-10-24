# Animation Hero - Documentation

## 🎬 Fonctionnement de la transition

### Architecture de l'animation

L'application utilise une **Hero animation** combinée avec une **FadeTransition** pour créer une transition fluide et professionnelle entre les deux pages.

### Composants de l'animation :

#### 1. **Hero Widget**
- **Tag commun** : `'logo_hero'` sur les deux pages
- **Page 1** : Logo grand et centré (60% largeur, 40% hauteur)
- **Page 2** : Logo petit en haut à gauche (50x50px)

#### 2. **FadeTransition**
- **Durée** : 1200ms (1.2 secondes)
- **Courbe** : `Curves.easeInOut` (démarrage et fin en douceur)
- **Opacité** : 0.0 → 1.0

#### 3. **Navigation**
- Utilise `PageRouteBuilder` avec `Navigator.pushReplacement`
- Permet à Hero de gérer automatiquement l'animation du logo

### 🎯 Comportement de l'animation :

1. **Démarrage** : HomePage1 affiche le logo centré
2. **Après 3 secondes** : Transition automatique déclenchée
3. **Animation Hero** :
   - Le logo se **réduit** progressivement (de grand à 50x50px)
   - Le logo **monte** vers le haut à gauche
   - Les **bords arrondis** s'adaptent (25px → 10px)
4. **FadeTransition** : Le reste de la page 2 apparaît en fondu
5. **Arrivée** : HomePage2 avec logo en position finale

### ⚙️ Paramètres techniques :

```dart
Hero(
  tag: 'logo_hero',
  child: // Widget du logo
)

PageRouteBuilder(
  transitionDuration: Duration(milliseconds: 1200),
  transitionsBuilder: FadeTransition avec Curves.easeInOut
)
```

### 🎨 Avantages de cette approche :

- ✅ **Transition fluide** : Hero gère automatiquement la position et la taille
- ✅ **Performance optimale** : Animation native de Flutter
- ✅ **Cohérence visuelle** : Le logo reste le même élément visuellement
- ✅ **Effet professionnel** : Combinaison Hero + Fade
- ✅ **Responsive** : S'adapte à toutes les tailles d'écran

### 🔧 Personnalisation possible :

Pour modifier la durée de l'animation, changez dans `splash_wrapper.dart` :
```dart
transitionDuration: const Duration(milliseconds: 1200), // Ajustez ici
```

Pour modifier la courbe d'animation :
```dart
curve: Curves.easeInOut, // Essayez: easeOutCubic, fastOutSlowIn, etc.
```
