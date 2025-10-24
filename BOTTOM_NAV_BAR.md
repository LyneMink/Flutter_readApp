# Bottom Navigation Bar Personnalisée - Documentation

## 🎯 Vue d'ensemble

HomePage3 dispose d'une **BottomNavigationBar personnalisée** avec un design moderne incluant :
- Un creux central incurvé
- Un FloatingActionButton orange au centre
- 4 icônes de navigation réparties de chaque côté
- Une ombre douce pour un effet surélevé

## 📐 Structure visuelle

```
┌─────────────────────────────────────────┐
│                                         │
│            Contenu de la page           │
│                                         │
├─────────────────────────────────────────┤
│                                         │
│  [🏠]  [📁]      [+]      [❤️]  [👤]   │  ← Bottom Nav Bar
│                  ↑                      │
│            FAB Orange                   │
└─────────────────────────────────────────┘
```

### Vue détaillée de la barre :

```
┌─────────────────────────────────────────┐
│                                         │
│  [Home] [Folder]  ╭─────╮  [Fav] [User]│
│                   │  +  │               │  ← Creux circulaire
│                   ╰─────╯               │
└─────────────────────────────────────────┘
```

## 🎨 Caractéristiques du design

### **1. BottomAppBar**

**Fond :**
- Couleur : Blanc pur (#FFFFFF)
- Hauteur : 70px
- Bords arrondis en haut : 20px (topLeft, topRight)

**Ombre :**
```dart
BoxShadow(
  color: Colors.black.withOpacity(0.26), // Noir avec 26% d'opacité
  blurRadius: 8,
  offset: Offset(0, -2), // Ombre vers le haut
)
```

**Creux central :**
- Type : `CircularNotchedRectangle()`
- Marge autour du FAB : 8px (`notchMargin`)
- Permet au FAB de s'intégrer parfaitement

### **2. FloatingActionButton (FAB)**

**Apparence :**
- ✅ Forme : Ronde (par défaut)
- ✅ Couleur : Orange #E67E22
- ✅ Taille icône : 28px
- ✅ Icône : `Icons.add` (symbole +)
- ✅ Couleur icône : Blanc
- ✅ Élévation : 6.0 (ombre prononcée)

**Position :**
```dart
floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked
```
- Positionné au centre de la BottomAppBar
- "Docked" = ancré dans le creux

**Code :**
```dart
FloatingActionButton(
  onPressed: () {
    // Action à implémenter
    print('FAB cliqué - Ajouter un document');
  },
  backgroundColor: const Color(0xFFE67E22), // Orange
  elevation: 6.0,
  child: const Icon(
    Icons.add,
    size: 28,
    color: Colors.white,
  ),
)
```

### **3. Icônes de navigation**

**Disposition :**
- 2 icônes à gauche du FAB
- 2 icônes à droite du FAB
- Espacement uniforme (`MainAxisAlignment.spaceEvenly`)

**Icônes actuelles (placeholders) :**

| Position | Icône | Nom | Couleur |
|----------|-------|-----|---------|
| Gauche 1 | `Icons.home_outlined` | Home | #999999 |
| Gauche 2 | `Icons.folder_outlined` | Folder | #999999 |
| Droite 1 | `Icons.favorite_outline` | Favorite | #999999 |
| Droite 2 | `Icons.person_outline` | Profile | #999999 |

**Taille des icônes :** 28px

**Code d'une icône :**
```dart
IconButton(
  icon: const Icon(
    Icons.home_outlined,
    color: Color(0xFF999999),
    size: 28,
  ),
  onPressed: () {
    print('Home cliqué');
  },
),
```

## 🔧 Structure du code

### Méthode `_buildBottomNavigationBar()`

```dart
Widget _buildBottomNavigationBar() {
  return Container(
    height: 70,
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [/* Ombre */],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: BottomAppBar(
        color: Colors.white,
        elevation: 0,
        shape: CircularNotchedRectangle(), // ← Creux pour le FAB
        notchMargin: 8.0,
        child: SizedBox(
          height: 60,
          child: Row(
            children: [
              // 2 icônes à gauche
              Expanded(/* ... */),
              
              // Espace pour le FAB
              SizedBox(width: 80),
              
              // 2 icônes à droite
              Expanded(/* ... */),
            ],
          ),
        ),
      ),
    ),
  );
}
```

### Dans le build principal :

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: /* ... */,
    
    // Bottom Navigation Bar
    bottomNavigationBar: _buildBottomNavigationBar(),
    
    // Floating Action Button
    floatingActionButton: FloatingActionButton(/* ... */),
    
    // Position du FAB
    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
  );
}
```

## 💡 Personnalisation

### Changer la couleur du FAB :

```dart
FloatingActionButton(
  backgroundColor: const Color(0xFF3498DB), // ← Bleu au lieu d'orange
  // ...
)
```

### Changer l'icône du FAB :

```dart
child: const Icon(
  Icons.camera_alt, // ← Icône caméra au lieu de +
  size: 28,
  color: Colors.white,
)
```

### Ajouter une action au FAB :

```dart
floatingActionButton: FloatingActionButton(
  onPressed: () {
    // Naviguer vers une page d'ajout de document
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddDocumentPage()),
    );
  },
  // ...
)
```

### Changer les icônes de navigation :

```dart
IconButton(
  icon: const Icon(
    Icons.search, // ← Nouvelle icône
    color: Color(0xFF999999),
    size: 28,
  ),
  onPressed: () {
    // Nouvelle action
  },
)
```

### Ajouter un état sélectionné :

```dart
// Variable d'état
int _selectedNavIndex = 0;

// Dans l'IconButton
IconButton(
  icon: Icon(
    Icons.home_outlined,
    color: _selectedNavIndex == 0 
        ? const Color(0xFFE67E22) // Orange si sélectionné
        : const Color(0xFF999999), // Gris sinon
    size: 28,
  ),
  onPressed: () {
    setState(() {
      _selectedNavIndex = 0;
    });
  },
)
```

## 🎨 Palette de couleurs

| Élément | Couleur | Code |
|---------|---------|------|
| Fond BottomBar | Blanc | #FFFFFF |
| FAB | Orange | #E67E22 |
| Icône FAB | Blanc | #FFFFFF |
| Icônes nav | Gris | #999999 |
| Ombre | Noir 26% | Colors.black.withOpacity(0.26) |

## 📏 Dimensions

| Élément | Valeur |
|---------|--------|
| Hauteur BottomBar | 70px |
| Hauteur interne | 60px |
| Bords arrondis | 20px |
| Taille icônes | 28px |
| Élévation FAB | 6.0 |
| Marge creux | 8px |
| Espace central | 80px |

## 🎯 Avantages du design

✅ **Moderne** : Design avec creux central très tendance
✅ **Accessible** : Bouton principal (FAB) facilement atteignable
✅ **Visuel** : Ombre douce pour effet de profondeur
✅ **Flexible** : Facile d'ajouter/modifier les icônes
✅ **Responsive** : S'adapte à la largeur de l'écran
✅ **Cohérent** : Couleurs harmonisées avec le reste de l'app

## 🚀 Cas d'usage du FAB

Le FloatingActionButton orange peut être utilisé pour :

1. **Ajouter un document** (action principale)
2. **Ouvrir une caméra** pour scanner
3. **Créer un nouveau dossier**
4. **Importer un fichier**
5. **Ouvrir un menu d'actions rapides**

### Exemple : Menu d'actions rapides

```dart
floatingActionButton: FloatingActionButton(
  onPressed: () {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 200,
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.camera),
              title: Text('Scanner un document'),
              onTap: () { /* ... */ },
            ),
            ListTile(
              leading: Icon(Icons.upload_file),
              title: Text('Importer un fichier'),
              onTap: () { /* ... */ },
            ),
            ListTile(
              leading: Icon(Icons.create_new_folder),
              title: Text('Créer un dossier'),
              onTap: () { /* ... */ },
            ),
          ],
        ),
      ),
    );
  },
  backgroundColor: const Color(0xFFE67E22),
  child: const Icon(Icons.add, size: 28, color: Colors.white),
)
```

## 💻 Code complet

```dart
// Dans le Scaffold
return Scaffold(
  body: /* ... */,
  
  // Bottom Navigation Bar avec creux
  bottomNavigationBar: _buildBottomNavigationBar(),
  
  // FAB orange au centre
  floatingActionButton: FloatingActionButton(
    onPressed: () {
      print('FAB cliqué');
    },
    backgroundColor: const Color(0xFFE67E22),
    elevation: 6.0,
    child: const Icon(
      Icons.add,
      size: 28,
      color: Colors.white,
    ),
  ),
  
  // Position centrée et ancrée
  floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
);
```

## 🎬 Animation (optionnelle)

Pour animer le FAB lors du clic :

```dart
floatingActionButton: FloatingActionButton(
  onPressed: () {
    // Animation de rotation
    setState(() {
      _fabRotation += 0.25; // Rotation de 90°
    });
  },
  child: AnimatedRotation(
    turns: _fabRotation,
    duration: Duration(milliseconds: 300),
    child: Icon(Icons.add, size: 28, color: Colors.white),
  ),
)
```

---

La BottomNavigationBar personnalisée offre un design moderne et professionnel avec un FAB orange bien intégré ! 🎉
