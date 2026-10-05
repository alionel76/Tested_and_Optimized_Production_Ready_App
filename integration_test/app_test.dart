import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:tested_and_optimized_production_ready_app/src/app.dart';
import 'package:tested_and_optimized_production_ready_app/src/features/items/data/repositories/item_repository.dart';
import 'package:tested_and_optimized_production_ready_app/src/features/items/presentation/controllers/item_controller.dart';
import 'package:tested_and_optimized_production_ready_app/src/features/settings/data/repositories/settings_repository.dart';
import 'package:tested_and_optimized_production_ready_app/src/features/settings/presentation/controllers/settings_controller.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('End-To-End Application Integration Tests', () {
    late MemorySettingsRepository settingsRepository;
    late SettingsController settingsController;
    late MemoryItemRepository itemRepository;
    late ItemController itemController;

    setUp(() async {
      settingsRepository = MemorySettingsRepository();
      settingsController = SettingsController(repository: settingsRepository);
      await settingsController.loadSettings();

      itemRepository = MemoryItemRepository();
      itemController = ItemController(repository: itemRepository);
      await itemController.loadItems();
    });

    testWidgets('E2E Flow 1: Navigate to details, toggle favorite and return', (WidgetTester tester) async {
      await tester.pumpWidget(
        MyApp(
          settingsController: settingsController,
          itemController: itemController,
        ),
      );

      await tester.pumpAndSettle();

      // Verify HomeScreen is displayed with items
      expect(find.text('Catalogue & Flux'), findsOneWidget);
      expect(find.text('Flutter Cookbook'), findsOneWidget);

      // Tap on Flutter Cookbook item card
      await tester.tap(find.text('Flutter Cookbook'));
      await tester.pumpAndSettle();

      // Verify ItemDetailScreen is open
      expect(find.text('Flutter Cookbook'), findsWidgets);
      expect(find.text('Guide complet pour construire des applications Flutter optimisées.'), findsOneWidget);

      // Toggle favorite
      await tester.tap(find.byIcon(Icons.favorite_border));
      await tester.pumpAndSettle();

      // Go back
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      // Verify we are back on HomeScreen
      expect(find.text('Catalogue & Flux'), findsOneWidget);
    });

    testWidgets('E2E Flow 2: Add a new item via AddItemScreen and verify insertion', (WidgetTester tester) async {
      await tester.pumpWidget(
        MyApp(
          settingsController: settingsController,
          itemController: itemController,
        ),
      );

      await tester.pumpAndSettle();

      // Tap Floating Action Button
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      // Fill out AddItem form
      await tester.enterText(find.byKey(const Key('item_name_field')), 'Casque Bluetooth Pro');
      await tester.enterText(find.byKey(const Key('item_price_field')), '129.99');
      await tester.enterText(find.byKey(const Key('item_description_field')), 'Casque haute fidélité avec réducteur de bruit');

      // Submit form
      await tester.tap(find.byKey(const Key('submit_item_button')));
      await tester.pumpAndSettle();

      // Verify back on HomeScreen and scroll down to find new item
      expect(find.text('Catalogue & Flux'), findsOneWidget);

      final newItemFinder = find.text('Casque Bluetooth Pro');
      await tester.scrollUntilVisible(
        newItemFinder,
        200.0,
        scrollable: find.byType(Scrollable).last,
      );
      await tester.pumpAndSettle();

      expect(newItemFinder, findsOneWidget);
    });
  });
}
