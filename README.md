# Application Flutter Prête pour la Production

[![Pipeline CI/CD](https://github.com/username/Tested_and_Optimized_Production_Ready_App/actions/workflows/ci.yml/badge.svg)](https://github.com/username/Tested_and_Optimized_Production_Ready_App/actions)
[![Version Flutter](https://img.shields.io/badge/Flutter-3.x-blue.svg)](https://flutter.dev)
[![Licence](https://img.shields.io/badge/licence-MIT-green.svg)](LICENSE)

Une application Flutter haute performance, accessible et prête pour la production. Conçue selon une **Architecture Feature-First**, elle intègre une couverture de tests complète (tests unitaires, de widgets et d'intégration), le support de l'internationalisation FR/EN et une intégration continue avec GitHub Actions.

---

## 🚀 Fonctionnalités Principales

- **5 Écrans Fonctionnels & Interactifs** :
  1. **`HomeScreen`** : Catalogue principal et flux avec barres de filtres par catégorie, rafraîchissement tactile et bouton flottant d'action.
  2. **`ItemDetailScreen`** : Vue détaillée de l'élément sélectionné avec animation Hero, description, prix et gestion des favoris.
  3. **`SearchScreen`** : Recherche dynamique en temps réel avec réinitialisation et compteur d'éléments.
  4. **`AddItemScreen`** : Formulaire de création d'élément avec validation stricte des champs et retours visuels.
  5. **`SettingsScreen`** : Changement de langue dynamique (Français / Anglais) et sélecteur de thème (Clair / Sombre / Système).
- **Internationalisation (i10n)** : Support natif Français (FR) et Anglais (EN) via des fichiers ARB et génération automatique des délégués.
- **Accessibilité** : Balises `Semantics` sur tous les contrôles interactifs, champs de saisie, boutons et images pour la compatibilité avec les lecteurs d'écran.
- **Performances Optimisées** : Listes à défilement paresseux (`ListView.builder`), reconstructions UI ciblées via `ListenableBuilder` et gestion efficace de la mémoire pour le rendu des images.

---

## 🏗️ Architecture : Feature-First

Le projet est structuré par fonctionnalités (Feature-First) pour garantir une grande maintenabilité et une séparation claire des responsabilités :

```text
lib/
├── main.dart
└── src/
    ├── app.dart
    ├── core/
    │   ├── localization/      # Fichiers ARB de traduction & délégués générés
    │   ├── theme/             # Configuration des thèmes Material 3 (Clair / Sombre)
    │   └── widgets/           # Composants réutilisables et accessibles (OptimizedImage)
    └── features/
        ├── items/
        │   ├── domain/        # Modèles Item et ItemFilter
        │   ├── data/          # Interface ItemRepository & MemoryItemRepository
        │   └── presentation/  # ItemController, HomeScreen, ItemDetailScreen, SearchScreen, AddItemScreen
        └── settings/
            ├── domain/        # Modèle AppSettings
            ├── data/          # Interface SettingsRepository
            └── presentation/  # SettingsController, SettingsScreen
```

---

## 🧪 Suite de Tests

Le projet intègre une suite automatisée de **21 tests** :

- **13 Tests Unitaires** : Validation de la logique métier, des modèles (`copyWith`, sérialisation JSON), des repositories, des filtres et des contrôleurs d'état.
- **6 Tests de Widgets** : Vérification du rendu UI, de l'internationalisation, de la recherche dynamique, de la validation du formulaire et des paramètres.
- **2 Tests d'Intégration** : Validation des parcours utilisateur de bout en bout (recherche/détail/favoris & formulaire de création d'élément).

### Lancement des tests

```bash
# Analyse statique du code (0 warning, 0 erreur)
flutter analyze

# Exécution des tests unitaires et de widgets
flutter test test/

# Exécution des tests d'intégration
flutter test integration_test/app_test.dart
```

---

## ⚙️ Installation & Démarrage

1. **Cloner le dépôt** :
   ```bash
   git clone https://github.com/username/Tested_and_Optimized_Production_Ready_App.git
   cd Tested_and_Optimized_Production_Ready_App
   ```

2. **Installer les dépendances** :
   ```bash
   flutter pub get
   ```

3. **Générer les fichiers de traduction** :
   ```bash
   flutter gen-l10n
   ```

4. **Lancer l'application** :
   ```bash
   flutter run
   ```

---

## 📋 Intégration Continue (CI/CD)

Une pipeline GitHub Actions est configurée dans `.github/workflows/ci.yml`. À chaque `push` ou `pull_request`, elle réalise automatiquement :
1. L'installation des dépendances Flutter.
2. La génération automatique des fichiers de localisation.
3. L'analyse statique du code (`flutter analyze`).
4. L'exécution de la suite de tests (`flutter test test/`).
