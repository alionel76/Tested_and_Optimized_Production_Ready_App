import 'package:flutter_test/flutter_test.dart';
import 'package:tested_and_optimized_production_ready_app/src/features/items/data/repositories/item_repository.dart';
import 'package:tested_and_optimized_production_ready_app/src/features/items/domain/models/item.dart';
import 'package:tested_and_optimized_production_ready_app/src/features/items/presentation/controllers/item_controller.dart';

void main() {
  group('ItemController Tests', () {
    late MemoryItemRepository repository;
    late ItemController controller;

    final initialItems = [
      const Item(
        id: '1',
        name: 'Item One',
        description: 'First item description',
        price: 20.0,
        category: 'Cat A',
        imageUrl: 'http://example.com/1.png',
      ),
      const Item(
        id: '2',
        name: 'Item Two',
        description: 'Second item description',
        price: 50.0,
        category: 'Cat B',
        imageUrl: 'http://example.com/2.png',
        isFavorite: true,
      ),
    ];

    setUp(() {
      repository = MemoryItemRepository(initialItems: initialItems);
      controller = ItemController(repository: repository);
    });

    test('loadItems loads items and categories and updates state', () async {
      expect(controller.items, isEmpty);
      expect(controller.categories, isEmpty);

      await controller.loadItems();

      expect(controller.items.length, 2);
      expect(controller.categories, ['Cat A', 'Cat B']);
      expect(controller.isLoading, false);
      expect(controller.errorMessage, isNull);
    });

    test('updateSearchQuery updates filter and filters items', () async {
      await controller.loadItems();
      await controller.updateSearchQuery('Two');

      expect(controller.filter.searchQuery, 'Two');
      expect(controller.items.length, 1);
      expect(controller.items.first.id, '2');
    });

    test('selectCategory updates category filter', () async {
      await controller.loadItems();
      await controller.selectCategory('Cat A');

      expect(controller.filter.category, 'Cat A');
      expect(controller.items.length, 1);
      expect(controller.items.first.id, '1');

      await controller.selectCategory(null);
      expect(controller.filter.category, isNull);
      expect(controller.items.length, 2);
    });

    test('toggleFavoritesOnly filters items by favorites', () async {
      await controller.loadItems();
      await controller.toggleFavoritesOnly();

      expect(controller.filter.onlyFavorites, true);
      expect(controller.items.length, 1);
      expect(controller.items.first.id, '2');
    });

    test('toggleFavorite toggles item favorite state and reloads items', () async {
      await controller.loadItems();
      expect(controller.items.firstWhere((i) => i.id == '1').isFavorite, false);

      await controller.toggleFavorite('1');
      expect(controller.items.firstWhere((i) => i.id == '1').isFavorite, true);
    });

    test('addItem inserts item and refreshes items list', () async {
      await controller.loadItems();

      const newItem = Item(
        id: '3',
        name: 'Item Three',
        description: 'Third item',
        price: 30.0,
        category: 'Cat A',
        imageUrl: 'http://example.com/3.png',
      );

      await controller.addItem(newItem);
      expect(controller.items.length, 3);
      expect(controller.items.any((i) => i.id == '3'), true);
    });
  });
}
