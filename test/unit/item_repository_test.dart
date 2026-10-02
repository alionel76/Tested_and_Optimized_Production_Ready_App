import 'package:flutter_test/flutter_test.dart';
import 'package:tested_and_optimized_production_ready_app/src/features/items/data/repositories/item_repository.dart';
import 'package:tested_and_optimized_production_ready_app/src/features/items/domain/models/item.dart';
import 'package:tested_and_optimized_production_ready_app/src/features/items/domain/models/item_filter.dart';

void main() {
  group('MemoryItemRepository Tests', () {
    late MemoryItemRepository repository;

    setUp(() {
      repository = MemoryItemRepository(initialItems: [
        const Item(
          id: '1',
          name: 'Dart Book',
          description: 'Learn Dart',
          price: 20.0,
          category: 'Books',
          imageUrl: 'url1',
        ),
        const Item(
          id: '2',
          name: 'Wireless Mouse',
          description: 'Ergonomic mouse',
          price: 35.0,
          category: 'Electronics',
          imageUrl: 'url2',
          isFavorite: true,
        ),
      ]);
    });

    test('getItems returns all initial items', () async {
      final items = await repository.getItems();
      expect(items.length, 2);
    });

    test('getItems filters by search query', () async {
      final items = await repository.getItems(
        filter: const ItemFilter(searchQuery: 'mouse'),
      );
      expect(items.length, 1);
      expect(items.first.name, 'Wireless Mouse');
    });

    test('getItems filters by category and favorites', () async {
      final items = await repository.getItems(
        filter: const ItemFilter(onlyFavorites: true),
      );
      expect(items.length, 1);
      expect(items.first.id, '2');
    });

    test('addItem appends new item to repository', () async {
      const newItem = Item(
        id: '3',
        name: 'Keyboard',
        description: 'Mechanical keyboard',
        price: 80.0,
        category: 'Electronics',
        imageUrl: 'url3',
      );

      await repository.addItem(newItem);
      final items = await repository.getItems();

      expect(items.length, 3);
      expect(items.last.id, '3');
    });

    test('toggleFavorite toggles isFavorite status', () async {
      await repository.toggleFavorite('1');
      final item = await repository.getItemById('1');

      expect(item?.isFavorite, isTrue);
    });
  });
}
