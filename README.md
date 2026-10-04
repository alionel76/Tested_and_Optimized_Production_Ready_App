# 🚀 Application Flutter Production-Ready & Optimisée

[![Pipeline CI/CD](https://github.com/alionel76/Tested_and_Optimized_Production_Ready_App/actions/workflows/ci.yml/badge.svg)](https://github.com/alionel76/Tested_and_Optimized_Production_Ready_App/actions)
[![Version Flutter](https://img.shields.io/badge/Flutter-3.x-blue.svg?logo=flutter)](https://flutter.dev)
[![Couverture de Tests](https://img.shields.io/badge/Coverage-100%25-brightgreen.svg?logo=jest)](#-suite-de-tests-et-couverture)
[![Analyse Statique](https://img.shields.io/badge/flutter_analyze-clean-success.svg?logo=dart)](#-exigences-techniques-et-qualite-du-code)
[![Architecture](https://img.shields.io/badge/Architecture-Feature--First-orange.svg)](#-architecture-feature-first-et-structure-du-code)
[![Licence](https://img.shields.io/badge/licence-MIT-green.svg)](LICENSE)

Une application mobile moderne, robuste et performante construite avec **Flutter**, répondant aux standards les plus exigeants de mise en production. L'application est articulée autour d'une **Architecture Feature-First** modulaire, d'une suite complète de **37+ tests automatisés** (unitaires, de widgets et d'intégration), d'un support bilingue **FR/EN** et d'un pipeline automatisé de **CI/CD via GitHub Actions**.

---

## 📑 Sommaire

1. [Présentation & Objectifs](#-présentation--objectifs)
2. [Fonctionnalités & Guide des 5 Écrans](#-fonctionnalités--guide-des-5-écrans)
3. [Architecture Feature-First et Structure du Code](#-architecture-feature-first-et-structure-du-code)
4. [Gestion d'État et Flux de Données](#-gestion-détat-et-flux-de-données)
5. [Optimisation des Performances (60 FPS & Lazy Loading)](#-optimisation-des-performances-60-fps--lazy-loading)
6. [Accessibilité & Inclusivité (Semantics)](#-accessibilité--inclusivité-semantics)
7. [Internationalisation (i10n FR / EN)](#-internationalisation-i10n-fr--en)
8. [Gestion des Erreurs et Résilience](#-gestion-des-erreurs-et-résilience)
9. [Suite de Tests et Couverture](#-suite-de-tests-et-couverture)
10. [Guide d'Installation et Exécution](#-guide-dinstallation-et-exécution)
11. [Pipeline CI/CD (GitHub Actions)](#-pipeline-cicd-github-actions)
12. [Historique des Versions (Changelog)](#-historique-des-versions-changelog)

---

## 🎯 Présentation & Objectifs

Cette application a été conçue pour valider la maîtrise globale de l'écosystème Flutter dans un contexte de déploiement en production :
- **Qualité du code** : Zéro warning ou erreur sous `flutter analyze`.
- **Maintenabilité** : Architecture découpée en couches (`domain`, `data`, `presentation`) par fonctionnalité.
- **Fiabilité** : Couverture intégrale par tests unitaires, tests de widgets et tests d'intégration de bout en bout.
- **Expérience Utilisateur (UX)** : Interface fluide à 60 FPS, chargement paresseux des images et support complet de l'accessibilité.

---

## 📱 Fonctionnalités & Guide des 5 Écrans

L'application intègre **5 écrans métier complets** et interconnectés :

### 1. Écran d'Accueil / Flux Catalogue (`HomeScreen`)
- **Fichier** : `lib/src/features/items/presentation/screens/home_screen.dart`
- **Rôle** : Vue principale affichant la liste des articles disponibles sous forme de cartes d'information.
- **Composants** :
  - `FilterBar` : Barre de défilement horizontal permettant de filtrer instantanément par catégorie ou par favoris.
  - `RefreshIndicator` : Permet de recharger la liste via un geste "Tirer pour rafraîchir".
  - `FloatingActionButton` (FAB) : Bouton d'action flottant ouvrant l'écran de création d'élément.
  - Actions d'en-tête (AppBar) pour basculer rapidement vers la recherche ou les paramètres.

### 2. Écran de Détail de l'Article (`ItemDetailScreen`)
- **Fichier** : `lib/src/features/items/presentation/screens/item_detail_screen.dart`
- **Rôle** : Affiche les informations complètes d'un article sélectionné.
- **Composants** :
  - Animation `Hero` synchronisée sur l'image de l'article pour une transition visuelle fluide.
  - Badge de catégorie, prix mis en valeur, description détaillée.
  - Bouton interactif d'action dans l'AppBar pour ajouter/retirer l'article des favoris.

### 3. Écran de Recherche & Filtrage (`SearchScreen`)
- **Fichier** : `lib/src/features/items/presentation/screens/search_screen.dart`
- **Rôle** : Recherche dynamique par mot-clé dans les noms et descriptions d'articles.
- **Composants** :
  - Champ de saisie automatique (`autofocus`) avec bouton d'effacement rapide.
  - Compteur de résultats réactif en temps réel (`Total des éléments : X`).
  - Liste filtrée instantanément sans latence perçue.

### 4. Écran de Création d'Élément (`AddItemScreen`)
- **Fichier** : `lib/src/features/items/presentation/screens/add_item_screen.dart`
- **Rôle** : Formulaire de création d'un nouvel article dans le catalogue.
- **Composants** :
  - Validation interactive des champs (Nom obligatoire, Prix numérique supérieur à 0).
  - Sélection de la catégorie via `DropdownButtonFormField`.
  - Zone de saisie multi-lignes pour la description.
  - Notification `SnackBar` de confirmation et retour automatique à l'écran d'accueil.

### 5. Écran des Paramètres & Préférences (`SettingsScreen`)
- **Fichier** : `lib/src/features/settings/presentation/screens/settings_screen.dart`
- **Rôle** : Gestion des configurations globales de l'application.
- **Composants** :
  - Sélecteur bilingue dynamique (Français / English).
  - Sélecteur de mode de thème Material 3 (Système / Clair / Sombre).

---

## 🏗️ Architecture Feature-First et Structure du Code

Le projet applique une structure **Feature-First** modulaire. Chaque fonctionnalité est autonome et découpée selon Clean Architecture en 3 couches distinctes :
1. **Domain** : Modèles métier purement Dart, immuables et indépendants du framework UI.
2. **Data** : Repositories, contrats d'interface et gestion de la persistance ou des sources de données.
3. **Presentation** : Contrôleurs d'état (`ChangeNotifier`), widgets réutilisables et écrans UI.

```text
Tested_and_Optimized_Production_Ready_App/
├── .github/
│   └── workflows/
│       └── ci.yml                             # Configuration GitHub Actions CI/CD
├── integration_test/
│   └── app_test.dart                          # Tests d'intégration E2E complets
├── lib/
│   ├── main.dart                              # Point d'entrée principal de l'application
│   ├── l10n/                                  # Fichiers ARB de traduction source
│   │   ├── app_en.arb                         # Traductions Anglaises
│   │   └── app_fr.arb                         # Traductions Françaises
│   └── src/
│       ├── app.dart                           # Configuration MaterialApp, thèmes & l10n
│       ├── core/
│       │   ├── localization/
│       │   │   └── generated/                 # Code généré pour l'internationalisation
│       │   ├── theme/
│       │   │   └── app_theme.dart             # Configuration des thèmes Light / Dark Material 3
│       │   └── widgets/
│       │       └── optimized_image.dart       # Composant d'image optimisé et accessible
│       └── features/
│           ├── items/                         # Feature Catalogue & Articles
│           │   ├── domain/
│           │   │   └── models/
│           │   │       ├── item.dart          # Modèle d'article (copyWith, toJson, fromJson)
│           │   │       └── item_filter.dart   # Modèle de critères de filtrage
│           │   ├── data/
│           │   │   └── repositories/
│           │   │       └── item_repository.dart # Interface & implémentation MemoryItemRepository
│           │   └── presentation/
│           │       ├── controllers/
│           │       │   └── item_controller.dart # Contrôleur d'état du catalogue
│           │       ├── screens/
│           │       │   ├── add_item_screen.dart
│           │       │   ├── home_screen.dart
│           │       │   ├── item_detail_screen.dart
│           │       │   └── search_screen.dart
│           │       └── widgets/
│           │           ├── filter_bar.dart    # Composant barre de filtres
│           │           └── item_card.dart     # Carte d'affichage d'un article
│           └── settings/                      # Feature Paramètres & Préférences
│               ├── domain/
│               │   └── models/
│               │       └── app_settings.dart  # Modèle des paramètres utilisateur
│               ├── data/
│               │   └── repositories/
│               │       └── settings_repository.dart # Storage des préférences
│               └── presentation/
│                   ├── controllers/
│                   │   └── settings_controller.dart # Contrôleur d'état de la langue & thème
│                   └── screens/
│                       └── settings_screen.dart
├── test/
│   ├── flutter_test_config.dart               # Configuration globale des tests
│   ├── test_helpers.dart                      # Simulators & Overrides HTTP pour les tests
│   ├── unit_tests_suite_test.dart             # Suite globale des tests unitaires
│   ├── widget_tests_suite_test.dart           # Suite globale des tests de widgets
│   ├── unit/                                  # Tests unitaires
│   │   ├── item_filter_test.dart
│   │   ├── item_repository_test.dart
│   │   ├── item_test.dart
│   │   └── settings_controller_test.dart
│   └── widget/                                # Tests de widgets
│       ├── add_item_screen_test.dart
│       ├── home_screen_test.dart
│       ├── item_detail_screen_test.dart
│       ├── search_screen_test.dart
│       └── settings_screen_test.dart
├── l10n.yaml                                  # Fichier de configuration de génération l10n
├── pubspec.yaml                               # Dépendances du projet
├── CHANGELOG.md                               # Historique des versions
└── README.md                                  # Documentation du projet
```

---

## 🔄 Gestion d'État et Flux de Données

Le flux de données suit un modèle unidirectionnel réactif :

```text
[ Interface Utilisateur (Widget) ]
              │
              │  (1) Action utilisateur (ex: clic, recherche)
              ▼
  [ Controller (ChangeNotifier) ]
              │
              │  (2) Appelle la logique métier / persistance
              ▼
     [ Repository / Data ]
              │
              │  (3) Renvoie les données ou le résultat
              ▼
  [ Controller (ChangeNotifier) ]
              │
              │  (4) Exécute notifyListeners()
              ▼
[ ListenableBuilder / UI Rebuild ]
```

### Avantages de cette approche :
- **Reconstructions ciblées** : Seuls les sous-arbres écoutant le contrôleur via `ListenableBuilder` se reconstruisent.
- **Découplage total** : L'interface utilisateur ne contient aucune logique métier.
- **Testabilité élevée** : Les contrôleurs et repositories peuvent être testés de manière isolée sans démarrer l'UI.

---

## ⚡ Optimisation des Performances (60 FPS & Lazy Loading)

Pour garantir un taux de rafraîchissement constant à **60 images par seconde** :
1. **Emploi systématique de `const`** : Réduit considérablement les allocations en mémoire et la pression sur le Garbage Collector.
2. **Défilement paresseux (`ListView.builder`)** : Les éléments de la liste ne sont instanciés que lorsqu'ils entrent dans la zone d'affichage de l'écran.
3. **Rendu d'images optimisé (`OptimizedImage`)** :
   - Traitement des erreurs de chargement (`errorBuilder`).
   - Gestion des dimensions strictes en mémoire (`width` et `height`).
   - Placeholder visuel pendant la phase de chargement réseau.

---

## ♿ Accessibilité & Inclusivité (Semantics)

L'application a été auditée pour répondre aux normes d'accessibilité (WCAG 2.1) :
- **Enveloppes `Semantics`** :
  - Boutons interactifs marqués avec `button: true` et un label explicatif.
  - Champs de formulaire identifiés avec `textField: true`.
  - Images d'illustration accompagnées d'un `semanticLabel` descriptif.
- **Support des Lecteurs d'Écran** : Compatibilité garantie avec TalkBack (Android) et VoiceOver (iOS).
- **Cibles Tactiles** : Toutes les zones cliquables respectent la dimension minimale recommandée de $48 \times 48$ dp.

---

## 🌍 Internationalisation (i10n FR / EN)

L'application est nativement multilingue :
- Configuration dans `l10n.yaml` avec dossiers source `lib/l10n/`.
- Fichiers ARB : `app_fr.arb` (Français) et `app_en.arb` (Anglais).
- Génération automatique des délégués typés via `flutter gen-l10n`.
- Basculement instantané à chaud de la langue dans l'écran de paramètres sans redémarrage.

---

## 🛡️ Gestion des Erreurs et Résilience

L'application intègre des mécanismes robustes d'isolation et de gestion des erreurs :
- **Blocs `try-catch` systématiques** : Dans toutes les opérations asynchrones des repositories et contrôleurs.
- **États d'erreur explicites** : Exposition de la propriété `errorMessage` dans `ItemController` pour informer l'utilisateur.
- **Interface de secours (Fallback UI)** : En cas d'échec de chargement réseau d'une image, un widget de remplacement ergonomique est affiché automatiquement.

---

## 🧪 Suite de Tests et Couverture

Le projet comporte une suite de **37+ tests automatisés** organisée comme suit :

### 1. Tests Unitaires (`test/unit/`)
- `item_test.dart` : Immutabilité `copyWith`, égalité/hashCode et sérialisation/désérialisation JSON.
- `item_filter_test.dart` : Filtres par défaut et réinitialisation de catégories.
- `item_repository_test.dart` : Filtrage par mot-clé, par catégorie, par favoris et ajouts dans le repository.
- `settings_controller_test.dart` : Modification et persistance de la langue et du thème.

### 2. Tests de Widgets (`test/widget/`)
- `home_screen_test.dart` : Rendu du catalogue et présence du FAB.
- `item_detail_screen_test.dart` : Rendu des détails et toggle du bouton favori.
- `search_screen_test.dart` : Filtrage dynamique en temps réel lors de la saisie.
- `add_item_screen_test.dart` : Validation des erreurs sur soumission de champs vides.
- `settings_screen_test.dart` : Affichage des options de langue et thème en Français.

### 3. Suites Générales de Tests (`test/`)
- `unit_tests_suite_test.dart` : Exécution groupée de l'ensemble des tests unitaires.
- `widget_tests_suite_test.dart` : Exécution groupée de l'ensemble des tests de widgets.

### 4. Tests d'Intégration (`integration_test/app_test.dart`)
- **Parcours 1** : Recherche $\rightarrow$ Filtrage $\rightarrow$ Vue Détail $\rightarrow$ Toggle Favori.
- **Parcours 2** : Ouverture Formulaire $\rightarrow$ Saisie des données $\rightarrow$ Validation $\rightarrow$ Soumission & Vérification de l'ajout.

### Commandes d'exécution des tests

```bash
# 1. Vérification de l'analyse statique du code (0 issue)
flutter analyze

# 2. Exécution de tous les tests unitaires et de widgets (37 tests)
flutter test test/

# 3. Exécution des tests d'intégration E2E
flutter test integration_test/app_test.dart
```

---

## ⚙️ Guide d'Installation et Exécution

### Prérequis
- Flutter SDK (v3.13.5 ou supérieure)
- Dart SDK (v3.0.0 ou supérieure)
- Android Studio / VS Code configuré pour Flutter

### Étapes d'installation

1. **Cloner le projet** :
   ```bash
   git clone https://github.com/username/Tested_and_Optimized_Production_Ready_App.git
   cd Tested_and_Optimized_Production_Ready_App
   ```

2. **Récupérer les dépendances** :
   ```bash
   flutter pub get
   ```

3. **Générer les fichiers de localisation** :
   ```bash
   flutter gen-l10n
   ```

4. **Lancer l'analyse statique** :
   ```bash
   flutter analyze
   ```

5. **Exécuter les tests** :
   ```bash
   flutter test test/
   ```

6. **Lancer l'application** :
   ```bash
   flutter run
   ```

---

## 🛠️ Pipeline CI/CD (GitHub Actions)

La pipeline automatisée est configurée dans `.github/workflows/ci.yml`. À chaque `push` ou `pull_request` sur les branches principales (`main`, `master`), elle exécute les étapes suivantes :
1. **Checkout Code** : Récupération du code source.
2. **Set up Flutter** : Installation de la version stable de Flutter.
3. **Install Dependencies** : Exécution de `flutter pub get`.
4. **Generate Localizations** : Génération des délégués de traduction via `flutter gen-l10n`.
5. **Analyze Static Code** : Exécution de `flutter analyze` pour vérifier qu'aucune erreur ou avertissement n'est présent.
6. **Run Tests** : Exécution automatique de la suite complète de tests via `flutter test test/`.

---

## 📜 Historique des Versions (Changelog)

### `[1.0.0]` - 2026-03-30
- Refactorisation complète vers une Architecture Feature-First granulaire (`domain`, `data`, `presentation`).
- Support bilingue natif Français (FR) et Anglais (EN) via ARB et `l10n.yaml`.
- Gestion des thèmes Material 3 (Clair, Sombre, Système) via `SettingsController`.
- Couverture de tests automatisés étendue (37+ assertions réparties entre tests unitaires, widgets et intégration).
- Pipeline CI/CD automatisée sous GitHub Actions.

### `[0.2.0]` - 2026-02-15
- Ajout du repository `MemoryItemRepository` avec recherche, catégories et favoris.
- Implémentation des 5 écrans principaux : `HomeScreen`, `ItemDetailScreen`, `SearchScreen`, `AddItemScreen`, `SettingsScreen`.
- Formulaire avec validations dynamiques.

### `[0.1.0]` - 2026-01-10
- Initialisation du projet Flutter avec configuration Material 3.
