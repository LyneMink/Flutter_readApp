# Structure des Pages

## Architecture de l'application

### 📄 Fichiers créés :

1. **`lib/HOME_PAGE/Home_page.dart`** - Page d'accueil initiale (splash screen)
   - Logo centré verticalement avec Hero animation
   - Texte "POUR UNE MEILLEURE LECTURE DE VOS PDF"
   - Fond gris clair (#C5C6CA)
   - Affichée pendant 3 secondes

2. **`lib/HOME_PAGE/home_page2.dart`** - Page de transition
   - Logo en haut à gauche (50x50px) avec Hero animation
   - Padding top de 20px
   - Fond gris clair (#C5C6CA)
   - Affichée pendant 2 secondes

3. **`lib/HOME_PAGE/home_page3.dart`** - Page principale avec AppBar
   - Fond blanc pur (#FFFFFF)
   - AppBar animée (slide gauche → droite)
   - Logo réduit (40x40px) dans l'AppBar avec Hero animation
   - Icône de recherche à droite
   - Ombre portée douce sur l'AppBar

4. **`lib/HOME_PAGE/splash_wrapper.dart`** - Gestionnaire de transition
   - Timer de 3 secondes
   - Navigation avec PageRouteBuilder
   - Animation Hero + FadeTransition
   - Durée d'animation : 1200ms

5. **`lib/main.dart`** - Point d'entrée
   - Utilise `SplashWrapper` comme page d'accueil
   - Configure le thème global

### 🎬 Flux de l'application :

```
Lancement → HomePage1 (3s) → [Hero Animation] → HomePage2 (2s) → [Hero + Slide] → HomePage3
```

### 🎨 Animations :

#### HomePage1 → HomePage2 :
- **Type** : Hero + FadeTransition
- **Logo** : Se réduit et monte vers le haut à gauche
- **Durée** : 1200ms
- **Courbe** : easeInOut

#### HomePage2 → HomePage3 :
- **Type** : Hero + SlideTransition + FadeTransition
- **Logo** : Se réduit légèrement (50px → 40px)
- **AppBar** : Slide horizontal (gauche → droite)
- **Durée** : 1000ms (page) + 800ms (AppBar)
- **Courbe** : easeOutCubic

### 🚀 Pour tester :
```bash
flutter run
```

L'application affichera HomePage1 pendant 3 secondes, puis transitionnera automatiquement vers HomePage2 avec une animation fluide.
