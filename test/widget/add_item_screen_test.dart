import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tested_and_optimized_production_ready_app/src/features/items/data/repositories/item_repository.dart';
import 'package:tested_and_optimized_production_ready_app/src/features/items/presentation/controllers/item_controller.dart';
import 'package:tested_and_optimized_production_ready_app/src/features/items/presentation/screens/add_item_screen.dart';

import '../test_helpers.dart';

void main() {
  group('AddItemScreen Widget Tests', () {
    late MemoryItemRepository repository;
    late ItemController itemController;

    setUp(() {
      repository = MemoryItemRepository(initialItems: []);
      itemController = ItemController(repository: repository);
    });

    testWidgets('Validation errors appear when submitting empty form', (WidgetTester tester) async {
      await tester.pumpWidget(
        createWidgetForTesting(
          child: AddItemScreen(
            itemController: itemController,
          ),
        ),
      );

      await tester.pumpAndSettle();

      final submitButton = find.byKey(const Key('submit_item_button'));
      expect(submitButton, findsOneWidget);

      await tester.tap(submitButton);
      await tester.pumpAndSettle();

      expect(find.text('Veuillez saisir un nom'), findsOneWidget);
      expect(find.text('Veuillez saisir un prix'), findsOneWidget);
      expect(itemController.items, isEmpty);
    });

    testWidgets('Submitting valid form adds item and closes screen', (WidgetTester tester) async {
      await tester.pumpWidget(
        createWidgetForTesting(
          child: AddItemScreen(
            itemController: itemController,
          ),
        ),
      );

      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(const Key('item_name_field')), 'Nouveau Produit');
      await tester.enterText(find.byKey(const Key('item_price_field')), '45.50');
      await tester.enterText(find.byKey(const Key('item_description_field')), 'Excellente qualité');

      await tester.tap(find.byKey(const Key('submit_item_button')));
      await tester.pumpAndSettle();

      expect(itemController.items.length, 1);
      expect(itemController.items.first.name, 'Nouveau Produit');
      expect(itemController.items.first.price, 45.50);
    });
  });
}
