import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tested_and_optimized_production_ready_app/src/features/items/data/repositories/item_repository.dart';
import 'package:tested_and_optimized_production_ready_app/src/features/items/domain/models/item.dart';
import 'package:tested_and_optimized_production_ready_app/src/features/items/presentation/controllers/item_controller.dart';
import 'package:tested_and_optimized_production_ready_app/src/features/items/presentation/screens/item_detail_screen.dart';

import '../test_helpers.dart';

void main() {
  group('ItemDetailScreen Widget Tests', () {
    late MemoryItemRepository repository;
    late ItemController itemController;

    setUp(() {
      repository = MemoryItemRepository(
        initialItems: [
          const Item(
            id: '1',
            name: 'Montre Connectée',
            description: 'Suivi de la fréquence cardiaque',
            price: 199.00,
            category: 'Électronique',
            imageUrl: 'https://example.com/watch.png',
            isFavorite: false,
          ),
        ],
      );
      itemController = ItemController(repository: repository);
    });

    testWidgets('ItemDetailScreen renders item information properly', (WidgetTester tester) async {
      await itemController.loadItems();

      await tester.pumpWidget(
        createWidgetForTesting(
          child: ItemDetailScreen(
            itemId: '1',
            itemController: itemController,
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Montre Connectée'), findsWidgets);
      expect(find.text('Électronique'), findsOneWidget);
      expect(find.text('199.00 \$'), findsOneWidget);
      expect(find.text('Suivi de la fréquence cardiaque'), findsOneWidget);
    });

    testWidgets('Tapping favorite icon in detail screen toggles favorite', (WidgetTester tester) async {
      await itemController.loadItems();

      await tester.pumpWidget(
        createWidgetForTesting(
          child: ItemDetailScreen(
            itemId: '1',
            itemController: itemController,
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(itemController.items.first.isFavorite, false);

      final favoriteButton = find.byIcon(Icons.favorite_border);
      expect(favoriteButton, findsOneWidget);

      await tester.tap(favoriteButton);
      await tester.pumpAndSettle();

      expect(itemController.items.first.isFavorite, true);
      expect(find.byIcon(Icons.favorite), findsOneWidget);
    });
  });
}
