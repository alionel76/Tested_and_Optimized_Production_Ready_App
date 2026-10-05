import 'package:flutter_test/flutter_test.dart';
import 'package:tested_and_optimized_production_ready_app/src/features/items/data/repositories/item_repository.dart';
import 'package:tested_and_optimized_production_ready_app/src/features/items/domain/models/item.dart';
import 'package:tested_and_optimized_production_ready_app/src/features/items/domain/models/item_filter.dart';

void main() {
  group('MemoryItemRepository Tests', () {
    late MemoryItemRepository repository;

    final testItems = [
      const Item(
        id: '1',
        name: 'Alpha Phone',
        description: 'Smart smartphone',
        price: 500.0,
        category: 'Tech',
        imageUrl: 'http://example.com/1.png',
        isFavorite: false,
      ),
      const Item(
        id: '2',
        name: 'Beta Book',
        description: 'Interesting novel',
        price: 15.0,
        category: 'Books',
        imageUrl: 'http://example.com/2.png',
        isFavorite: true,
      ),
      const Item(
        id: '3',
        name: 'Gamma Laptop',
        description: 'High performance computer',
        price: 1200.0,
        category: 'Tech',
        imageUrl: 'http://example.com/3.png',
        isFavorite: true,
      ),
    ];

    setUp(() {
      repository = MemoryItemRepository(initialItems: List<Item>.from(testItems));
    });

    test('getItems without filter returns all items', () async {
      final items = await repository.getItems();
      expect(items.length, 3);
    });

    test('getItems filters by search query', () async {
      final items = await repository.getItems(
        filter: const ItemFilter(searchQuery: 'phone'),
      );
      expect(items.length, 1);
      expect(items.first.id, '1');
    });

    test('getItems filters by category', () async {
      final items = await repository.getItems(
        filter: const ItemFilter(category: 'Books'),
      );
      expect(items.length, 1);
      expect(items.first.id, '2');
    });

    test('getItems filters by maxPrice', () async {
      final items = await repository.getItems(
        filter: const ItemFilter(maxPrice: 600.0),
      );
      expect(items.length, 2);
      expect(items.map((e) => e.id), containsAll(['1', '2']));
    });

    test('getItems filters by onlyFavorites', () async {
      final items = await repository.getItems(
        filter: const ItemFilter(onlyFavorites: true),
      );
      expect(items.length, 2);
      expect(items.map((e) => e.id), containsAll(['2', '3']));
    });

    test('getItemById returns item when found, null when not found', () async {
      final item = await repository.getItemById('2');
      expect(item, isNotNull);
      expect(item?.name, 'Beta Book');

      final missing = await repository.getItemById('999');
      expect(missing, isNull);
    });

    test('addItem inserts item into repository', () async {
      const newItem = Item(
        id: '4',
        name: 'Delta Headset',
        description: 'Audio gear',
        price: 80.0,
        category: 'Audio',
        imageUrl: 'http://example.com/4.png',
      );

      await repository.addItem(newItem);
      final items = await repository.getItems();
      expect(items.length, 4);
      expect(await repository.getItemById('4'), equals(newItem));
    });

    test('toggleFavorite toggles favorite status of item', () async {
      expect((await repository.getItemById('1'))?.isFavorite, false);

      await repository.toggleFavorite('1');
      expect((await repository.getItemById('1'))?.isFavorite, true);

      await repository.toggleFavorite('1');
      expect((await repository.getItemById('1'))?.isFavorite, false);
    });

    test('getCategories returns sorted unique list of categories', () async {
      final categories = await repository.getCategories();
      expect(categories, ['Books', 'Tech']);
    });
  });
}
