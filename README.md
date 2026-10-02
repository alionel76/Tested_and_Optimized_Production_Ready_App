# Tested & Optimized Production-Ready Flutter App

[![CI/CD Pipeline](https://github.com/username/Tested_and_Optimized_Production_Ready_App/actions/workflows/ci.yml/badge.svg)](https://github.com/username/Tested_and_Optimized_Production_Ready_App/actions)
[![Flutter Version](https://img.shields.io/badge/Flutter-3.x-blue.svg)](https://flutter.dev)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

A high-performance, accessible, production-ready Flutter application built with a **Feature-First Architecture**, complete test coverage (Unit, Widget, and Integration tests), FR/EN internationalization, and GitHub Actions CI/CD.

---

## 🚀 Features

- **5 Interactive Screens**:
  1. `HomeScreen`: Main catalog & feed with filtering, refresh, and floating action button.
  2. `ItemDetailScreen`: Full detail view with hero transition, pricing, and favorite toggling.
  3. `SearchScreen`: Live search filtering with item counter and clear action.
  4. `AddItemScreen`: Production-ready form with strict input validations and semantic labels.
  5. `SettingsScreen`: Theme switcher (Light/Dark/System) and language selector (FR/EN).
- **Internationalization (i10n)**: Native FR + EN support using ARB files and auto-generated localization delegates.
- **Accessibility**: Full `Semantics` coverage on interactive controls, inputs, and images.
- **Performance**: Optimized lazy-loaded lists (`ListView.builder`), minimal rebuilds via `ListenableBuilder`, and memory-conscious image rendering.

---

## 🏗️ Architecture: Feature-First

```text
lib/
├── main.dart
└── src/
    ├── app.dart
    ├── core/
    │   ├── localization/      # ARB translation files & generated delegates
    │   ├── theme/             # Material 3 light/dark theme configurations
    │   └── widgets/           # Reusable accessible components (OptimizedImage)
    └── features/
        ├── items/
        │   ├── domain/        # Item and ItemFilter models
        │   ├── data/          # ItemRepository & MemoryItemRepository
        │   └── presentation/  # ItemController, HomeScreen, ItemDetailScreen, SearchScreen, AddItemScreen
        └── settings/
            ├── domain/        # AppSettings model
            ├── data/          # SettingsRepository
            └── presentation/  # SettingsController, SettingsScreen
```

---

## 🧪 Test Suite

The project includes a comprehensive suite of **19+ tests**:

- **13 Unit Tests**: Testing business logic, models (`copyWith`, JSON serialization), repositories, filters, and state controllers.
- **6 Widget Tests**: Verifying UI rendering, localization, search interactions, form validation, and settings options.
- **2 Integration Tests**: Testing end-to-end user navigation flows and item creation workflows.

### Running Tests

```bash
# Run static analysis
flutter analyze

# Run unit and widget tests
flutter test test/

# Run integration tests
flutter test integration_test/app_test.dart
```

---

## ⚙️ Setup & Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/username/Tested_and_Optimized_Production_Ready_App.git
   cd Tested_and_Optimized_Production_Ready_App
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Generate localizations**:
   ```bash
   flutter gen-l10n
   ```

4. **Run the app**:
   ```bash
   flutter run
   ```

---

## 📋 CI/CD

GitHub Actions workflow is configured in `.github/workflows/ci.yml`. On every `push` and `pull_request`, it automatically:
1. Installs dependencies
2. Generates localizations
3. Runs `flutter analyze`
4. Runs `flutter test test/`
