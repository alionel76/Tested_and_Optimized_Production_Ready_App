import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tested_and_optimized_production_ready_app/src/features/items/data/repositories/item_repository.dart';
import 'package:tested_and_optimized_production_ready_app/src/features/items/domain/models/item.dart';
import 'package:tested_and_optimized_production_ready_app/src/features/items/presentation/controllers/item_controller.dart';
import 'package:tested_and_optimized_production_ready_app/src/features/items/presentation/screens/search_screen.dart';

import '../test_helpers.dart';

void main() {
  group('SearchScreen Widget Tests', () {
    late MemoryItemRepository repository;
    late ItemController itemController;

    setUp(() {
      repository = MemoryItemRepository(
        initialItems: [
          const Item(
            id: '1',
            name: 'Clavier RGB',
            description: 'Mécanique',
            price: 89.99,
            category: 'Électronique',
            imageUrl: 'https://example.com/keyboard.png',
          ),
          const Item(
            id: '2',
            name: 'Souris Gamer',
            description: 'Optique',
            price: 49.99,
            category: 'Électronique',
            imageUrl: 'https://example.com/mouse.png',
          ),
        ],
      );
      itemController = ItemController(repository: repository);
    });

    testWidgets('SearchScreen filters items in real time as text is entered', (WidgetTester tester) async {
      await itemController.loadItems();

      await tester.pumpWidget(
        createWidgetForTesting(
          child: SearchScreen(
            itemController: itemController,
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Clavier RGB'), findsOneWidget);
      expect(find.text('Souris Gamer'), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'Clavier');
      await tester.pumpAndSettle();

      expect(find.text('Clavier RGB'), findsOneWidget);
      expect(find.text('Souris Gamer'), findsNothing);
    });

    testWidgets('SearchScreen shows no results message when search query has no match', (WidgetTester tester) async {
      await itemController.loadItems();

      await tester.pumpWidget(
        createWidgetForTesting(
          child: SearchScreen(
            itemController: itemController,
          ),
        ),
      );

      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'NonExistentItemKey');
      await tester.pumpAndSettle();

      expect(find.text('Aucun élément trouvé'), findsOneWidget);
    });
  });
}
