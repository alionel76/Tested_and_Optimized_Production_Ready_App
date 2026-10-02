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

  group('End-to-End Application Integration Tests', () {
    testWidgets('Search and toggle favorite integration flow',
        (WidgetTester tester) async {
      final settingsRepo = MemorySettingsRepository();
      final settingsController = SettingsController(repository: settingsRepo);
      await settingsController.loadSettings();

      final itemRepo = MemoryItemRepository();
      final itemController = ItemController(repository: itemRepo);
      await itemController.loadItems();

      await tester.pumpWidget(MyApp(
        settingsController: settingsController,
        itemController: itemController,
      ));
      await tester.pumpAndSettle();

      // Tap search icon
      final searchIcon = find.byIcon(Icons.search);
      expect(searchIcon, findsOneWidget);
      await tester.tap(searchIcon);
      await tester.pumpAndSettle();

      // Enter search query
      final textField = find.byType(TextField);
      await tester.enterText(textField, 'Gourde');
      await tester.pumpAndSettle();

      // Verify filtered item is displayed
      expect(find.text('Gourde Isotherme 1L'), findsOneWidget);

      // Tap item to open detail
      await tester.tap(find.text('Gourde Isotherme 1L'));
      await tester.pumpAndSettle();

      // Verify detail page
      expect(find.text('Gourde Isotherme 1L'), findsWidgets);
      expect(find.text('Accessoires'), findsOneWidget);
    });

    testWidgets('Add new item flow', (WidgetTester tester) async {
      final settingsRepo = MemorySettingsRepository();
      final settingsController = SettingsController(repository: settingsRepo);
      await settingsController.loadSettings();

      final itemRepo = MemoryItemRepository();
      final itemController = ItemController(repository: itemRepo);
      await itemController.loadItems();

      await tester.pumpWidget(MyApp(
        settingsController: settingsController,
        itemController: itemController,
      ));
      await tester.pumpAndSettle();

      // Tap floating action button to open add item screen
      final fab = find.byType(FloatingActionButton);
      await tester.tap(fab);
      await tester.pumpAndSettle();

      // Fill in item details
      await tester.enterText(
          find.byKey(const Key('item_name_field')), 'Tasse Écologique');
      await tester.enterText(
          find.byKey(const Key('item_price_field')), '12.50');
      await tester.enterText(
          find.byKey(const Key('item_description_field')), 'Fabriquée en bambou');

      // Submit form
      final submitBtn = find.byKey(const Key('submit_item_button'));
      await tester.tap(submitBtn);
      await tester.pumpAndSettle();

      // Verify newly added item appears on home screen
      expect(find.text('Tasse Écologique'), findsOneWidget);
    });
  });
}
