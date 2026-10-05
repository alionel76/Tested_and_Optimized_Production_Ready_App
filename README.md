# 🚀 Application Flutter Production-Ready & Optimisée

[![Pipeline CI/CD](https://github.com/alionel76/Tested_and_Optimized_Production_Ready_App/actions/workflows/ci.yml/badge.svg)](https://github.com/alionel76/Tested_and_Optimized_Production_Ready_App/actions)
[![Version Flutter](https://img.shields.io/badge/Flutter-3.x-blue.svg?logo=flutter)](https://flutter.dev)
[![Couverture de Tests](https://img.shields.io/badge/Tests-38%20passing-brightgreen.svg?logo=jest)](#-suite-de-tests-et-couverture)
[![Analyse Statique](https://img.shields.io/badge/flutter_analyze-clean-success.svg?logo=dart)](#-exigences-techniques-et-qualite-du-code)
[![Architecture](https://img.shields.io/badge/Architecture-Feature--First-orange.svg)](#-architecture-feature-first-et-structure-du-code)
[![Licence](https://img.shields.io/badge/licence-MIT-green.svg)](LICENSE)

Une application mobile moderne, robuste, accessible et performante développée avec **Flutter**, conçue pour répondre aux standards de production les plus exigeants. L'application repose sur une **Architecture Feature-First** modulaire, une suite intégrale de **38 tests automatisés** (unitaires, de widgets et d'intégration de bout en bout), un support bilingue **FR/EN** et un pipeline de **CI/CD via GitHub Actions**.

---

## 📑 Sommaire

1. [Présentation & Objectifs](#-présentation--objectifs)
2. [Guide des 5 Écrans Fonctionnels](#-guide-des-5-écrans-fonctionnels)
3. [Architecture Feature-First et Structure du Projet](#-architecture-feature-first-et-structure-du-projet)
4. [Gestion d'État et Flux de Données](#-gestion-détat-et-flux-de-données)
5. [Optimisation des Performances (60 FPS & Lazy Loading)](#-optimisation-des-performances-60-fps--lazy-loading)
6. [Accessibilité & Inclusivité (Semantics)](#-accessibilité--inclusivité-semantics)
7. [Internationalisation (i10n FR / EN)](#-internationalisation-i10n-fr--en)
8. [Résilience et Gestion des Erreurs](#-résilience-et-gestion-des-erreurs)
9. [Suite de Tests Automatités et Couverture](#-suite-de-tests-automatités-et-couverture)
10. [Installation et Exécution Pas à Pas](#-installation-et-exécution-pas-à-pas)
11. [Pipeline CI/CD (GitHub Actions)](#-pipeline-cicd-github-actions)
12. [Historique des Versions (Changelog)](#-historique-des-versions-changelog)

---

## 🎯 Présentation & Objectifs

Cette application a été construite dans le cadre du projet final du Summer Camp pour démontrer la maîtrise complète de l'ingénierie d'application Flutter :
- **Excellence du code** : 0 warning, 0 erreur lors de l'analyse statique (`flutter analyze`).
- **Architecture découplée** : Separation stricte des responsabilités (`domain`, `data`, `presentation`) organisée par fonctionnalité.
- **Fiabilité maximale** : Testé intégralement aux niveaux unitaire, composant UI et scénarios d'utilisation réels.
- **Expérience Utilisateur d'Élite** : Rendu fluide à 60 FPS, chargement lazy des images et compatibilité totale avec les lecteurs d'écran.

---

## 📱 Guide des 5 Écrans Fonctionnels

L'application comporte **5 écrans métier complets** :

### 1. Écran Catalogue & Flux (`HomeScreen`)
- **Localisation** : `lib/src/features/items/presentation/screens/home_screen.dart`
- **Rôle** : Vue principale affichant les articles sous forme de cartes structurées.
- **Composants Clés** :
  - `FilterBar` : Filtre horizontal dynamique par catégories et par favoris.
  - `RefreshIndicator` : Action "Tirer pour rafraîchir" pour simuler une synchronisation réseau.
  - `FloatingActionButton` (FAB) : Accès direct à la création d'un article.
  - Boutons d'action dans l'AppBar vers la recherche et les paramètres.

### 2. Écran Détail de l'Article (`ItemDetailScreen`)
- **Localisation** : `lib/src/features/items/presentation/screens/item_detail_screen.dart`
- **Rôle** : Consultation approfondie des spécifications d'un article.
- **Composants Clés** :
  - Transition visuelle `Hero` sur l'image de l'article.
  - Badges de catégorie, prix mis en relief et description textuelle.
  - Bouton interactif d'ajout/retrait des favoris dans l'AppBar.

### 3. Écran Recherche & Filtres (`SearchScreen`)
- **Localisation** : `lib/src/features/items/presentation/screens/search_screen.dart`
- **Rôle** : Recherche en temps réel dans les titres et descriptions.
- **Composants Clés** :
  - Champ de texte avec focus automatique (`autofocus`) et bouton de réinitialisation.
  - Indicateur du nombre de résultats trouvés mis à jour instantanément.

### 4. Écran Ajout d'un Élément (`AddItemScreen`)
- **Localisation** : `lib/src/features/items/presentation/screens/add_item_screen.dart`
- **Rôle** : Formulaire de création et d'insertion d'un nouvel article.
- **Composants Clés** :
  - Validation dynamique des champs (Nom requis, Prix positif, Description).
  - Menu déroulant `DropdownButtonFormField` pour le choix de la catégorie.
  - Notification `SnackBar` de confirmation à la soumission.

### 5. Écran Paramètres & Préférences (`SettingsScreen`)
- **Localisation** : `lib/src/features/settings/presentation/screens/settings_screen.dart`
- **Rôle** : Configuration globale des préférences utilisateur.
- **Composants Clés** :
  - Sélecteur bilingue dynamique (Français / Anglais).
  - Sélecteur de mode de thème Material 3 (Système / Clair / Sombre).

---

## 🏗️ Architecture Feature-First et Structure du Projet

Le projet suit les principes de la **Clean Architecture** combinés à une organisation par **Feature** :

```text
Tested_and_Optimized_Production_Ready_App/
├── .github/
│   └── workflows/
│       └── ci.yml                             # Automation CI/CD GitHub Actions
├── integration_test/
│   └── app_test.dart                          # Tests d'intégration de bout en bout (E2E)
├── lib/
│   ├── main.dart                              # Point d'entrée de l'application
│   ├── l10n/                                  # Fichiers ARB sources de traduction
│   │   ├── app_en.arb                         # Anglais
│   │   └── app_fr.arb                         # Français
│   └── src/
│       ├── app.dart                           # Racines MaterialApp, thèmes & l10n
│       ├── core/
│       │   ├── localization/                  # Classes de localisation générées
│       │   ├── theme/
│       │   │   └── app_theme.dart             # Configuration Thèmes Light & Dark
│       │   └── widgets/
│       │       └── optimized_image.dart       # Composant d'image optimisé & accessible
│       └── features/
│           ├── items/                         # Module Catalogue & Articles
│           │   ├── domain/
│           │   │   └── models/
│           │   │       ├── item.dart          # Modèle Item (copyWith, JSON, equality)
│           │   │       └── item_filter.dart   # Modèle des critères de filtrage
│           │   ├── data/
│           │   │   └── repositories/
│           │   │       └── item_repository.dart # Storage et repository d'articles
│           │   └── presentation/
│           │       ├── controllers/
│           │       │   └── item_controller.dart # Contrôleur d'état du catalogue
│           │       ├── screens/
│           │       │   ├── add_item_screen.dart
│           │       │   ├── home_screen.dart
│           │       │   ├── item_detail_screen.dart
│           │       │   └── search_screen.dart
│           │       └── widgets/
│           │           ├── filter_bar.dart    # Composant filtre de catégorie
│           │           └── item_card.dart     # Carte d'affichage d'un article
│           └── settings/                      # Module Paramètres
│               ├── domain/
│               │   └── models/
│               │       └── app_settings.dart  # Modèle des réglages utilisateur
│               ├── data/
│               │   └── repositories/
│               │       └── settings_repository.dart # Persistance des réglages
│               └── presentation/
│                   ├── controllers/
│                   │   └── settings_controller.dart # Contrôleur de langue & thème
│                   └── screens/
│                       └── settings_screen.dart
├── test/
│   ├── flutter_test_config.dart               # Configuration environnement des tests
│   ├── test_helpers.dart                      # Fake HttpClient & Mock Overrides
│   ├── unit_tests_suite_test.dart             # Suite globale des tests unitaires
│   ├── widget_tests_suite_test.dart           # Suite globale des tests de widgets
│   ├── unit/                                  # Tests unitaires isolés
│   │   ├── item_controller_test.dart
│   │   ├── item_filter_test.dart
│   │   ├── item_repository_test.dart
│   │   ├── item_test.dart
│   │   └── settings_controller_test.dart
│   └── widget/                                # Tests de composants UI
│       ├── add_item_screen_test.dart
│       ├── home_screen_test.dart
│       ├── item_detail_screen_test.dart
│       ├── search_screen_test.dart
│       └── settings_screen_test.dart
├── l10n.yaml                                  # Configuration l10n
├── pubspec.yaml                               # Dépendances du projet
├── CHANGELOG.md                               # Historique des versions
└── README.md                                  # Documentation du projet
```

---

## 🔄 Gestion d'État et Flux de Données

Le flux d'informations est strictement unidirectionnel et réactif :

```text
[ VUE (Widget) ] ────(Action Utilisateur)────► [ CONTROLLER (ChangeNotifier) ]
       ▲                                                    │
       │                                           (Logique Métier / Async)
(Notification UI)                                           ▼
       │                                             [ REPOSITORY ]
       └────────────── ListenableBuilder ◄──────────────────┘
```

---

## ⚡ Optimisation des Performances (60 FPS & Lazy Loading)

- **Instanciation optimisée** : Utilisation généralisée du mot-clé `const` pour restreindre la réallocation d'objets en mémoire.
- **Rendu paresseux** : Emploi de `ListView.builder` pour ne construire que les éléments affichés à l'écran.
- **Gestion intelligente des images** : Le widget `OptimizedImage` intègre des dimensions explicites et une interface de secours en cas de perte de connexion réseau.

---

## ♿ Accessibilité & Inclusivité (Semantics)

L'application respecte les recommandations WCAG :
- **Balises `Semantics`** sur tous les éléments interactifs (`button: true`, `textField: true`, labels clairs).
- **Cibles tactiles ergonomiques** conformes aux dimensions minimales préconisées ($48 \times 48$ dp).
- **Support natif** des lecteurs d'écran TalkBack (Android) et VoiceOver (iOS).

---

## 🌍 Internationalisation (i10n FR / EN)

- Prise en charge native du **Français** et de l'**Anglais**.
- Génération automatique des délégués typés via `flutter gen-l10n`.
- Modification de la langue en temps réel sans nécessiter le redémarrage de l'application.

---

## 🧪 Suite de Tests Automatités et Couverture

L'application possède **38 tests automatisés** garantissant une stabilité sans faille :

| Type de Test | Fichiers de Test | Nombre de Tests | Description |
| :--- | :--- | :---: | :--- |
| **Unitaires** | `test/unit/*` | **26** | Validation des modèles (`Item`, `ItemFilter`), repositories et logique métier des contrôleurs. |
| **Widgets** | `test/widget/*` | **10** | Vérification du rendu UI, de la validation des formulaires et des événements utilisateur. |
| **Intégration** | `integration_test/app_test.dart` | **2** | Test E2E de navigation, ajout d'article et basculement des favoris. |
| **TOTAL** | | **38** | **74+ assertions exécutées et validées.** |

### Commandes pour exécuter la suite de tests

```bash
# 1. Analyse statique (0 avertissement, 0 erreur)
flutter analyze

# 2. Exécution de tous les tests unitaires et de widgets (36 tests)
flutter test test/

# 3. Exécution des tests d'intégration E2E
flutter test integration_test/app_test.dart -d windows
```

---

## ⚙️ Installation et Exécution Pas à Pas

### Prérequis
- **Flutter SDK** : v3.13.5 ou supérieure
- **Dart SDK** : v3.0.0 ou supérieure

### Procédure de lancement

```bash
# 1. Cloner le dépôt
git clone https://github.com/alionel76/Tested_and_Optimized_Production_Ready_App.git
cd Tested_and_Optimized_Production_Ready_App

# 2. Installer les dépendances
flutter pub get

# 3. Générer les traductions
flutter gen-l10n

# 4. Lancer l'analyse statique
flutter analyze

# 5. Exécuter la suite de tests
flutter test test/

# 6. Démarrer l'application
flutter run
```

---

## 🛠️ Pipeline CI/CD (GitHub Actions)

La pipeline automatisée se trouve dans `.github/workflows/ci.yml`. À chaque `push` ou `pull_request` sur les branches `main` et `master`, elle effectue les tâches suivantes :
1. **Récupération du code source** (`actions/checkout@v4`).
2. **Configuration de Java 17** (`actions/setup-java@v4`).
3. **Installation de Flutter** (`subosito/flutter-action@v2`).
4. **Récupération des paquets** (`flutter pub get`).
5. **Génération de la localisation** (`flutter gen-l10n`).
6. **Vérification du code** (`flutter analyze`).
7. **Exécution automatisée de tous les tests** (`flutter test test/`).

---

## 📜 Historique des Versions (Changelog)

### `[1.0.0]` - 2026-03-30
- Architecture Feature-First modulaire et Clean Architecture.
- Internationalisation complète en Français (FR) et Anglais (EN).
- Thèmes Material 3 dynamique (Clair, Sombre, Système).
- Intégration de la suite de 38 tests automatisés (26 unitaires, 10 widgets, 2 intégration E2E).
- Pipeline CI/CD GitHub Actions opérationnelle.

### `[0.2.0]` - 2026-02-15
- Implémentation du repository de données en mémoire avec filtres et recherche.
- Création des 5 écrans métier (`HomeScreen`, `ItemDetailScreen`, `SearchScreen`, `AddItemScreen`, `SettingsScreen`).

### `[0.1.0]` - 2026-01-10
- Initialisation de la structure du projet Flutter avec Material 3.
