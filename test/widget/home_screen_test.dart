import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tested_and_optimized_production_ready_app/src/features/items/data/repositories/item_repository.dart';
import 'package:tested_and_optimized_production_ready_app/src/features/items/domain/models/item.dart';
import 'package:tested_and_optimized_production_ready_app/src/features/items/presentation/controllers/item_controller.dart';
import 'package:tested_and_optimized_production_ready_app/src/features/items/presentation/screens/home_screen.dart';

import '../test_helpers.dart';

void main() {
  group('HomeScreen Widget Tests', () {
    late MemoryItemRepository repository;
    late ItemController itemController;

    setUp(() {
      repository = MemoryItemRepository(
        initialItems: [
          const Item(
            id: '1',
            name: 'Flutter Cookbook',
            description: 'Learn Flutter',
            price: 29.99,
            category: 'Livres',
            imageUrl: 'https://example.com/flutter.png',
          ),
          const Item(
            id: '2',
            name: 'Casque Sans Fil',
            description: 'Audio HD',
            price: 99.99,
            category: 'Électronique',
            imageUrl: 'https://example.com/casque.png',
          ),
        ],
      );
      itemController = ItemController(repository: repository);
    });

    testWidgets('HomeScreen displays app bar title and list items', (WidgetTester tester) async {
      await itemController.loadItems();

      await tester.pumpWidget(
        createWidgetForTesting(
          child: HomeScreen(
            itemController: itemController,
            settingsWidget: const Text('Settings View'),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Catalogue & Flux'), findsOneWidget);
      expect(find.text('Flutter Cookbook'), findsOneWidget);
      expect(find.text('Casque Sans Fil'), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets('Tapping floating action button opens AddItemScreen', (WidgetTester tester) async {
      await itemController.loadItems();

      await tester.pumpWidget(
        createWidgetForTesting(
          child: HomeScreen(
            itemController: itemController,
            settingsWidget: const Text('Settings View'),
          ),
        ),
      );

      await tester.pumpAndSettle();

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      expect(find.text('Ajouter un Élément'), findsOneWidget);
    });
  });
}
