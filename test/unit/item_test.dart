import 'package:flutter_test/flutter_test.dart';
import 'package:tested_and_optimized_production_ready_app/src/features/items/domain/models/item.dart';

void main() {
  group('Item Model Tests', () {
    const sampleItem = Item(
      id: '1',
      name: 'Test Product',
      description: 'A test description',
      price: 49.99,
      category: 'Electronics',
      imageUrl: 'https://example.com/image.png',
      isFavorite: false,
    );

    test('copyWith updates specified fields correctly', () {
      final updated = sampleItem.copyWith(
        name: 'Updated Name',
        isFavorite: true,
      );

      expect(updated.id, '1');
      expect(updated.name, 'Updated Name');
      expect(updated.isFavorite, isTrue);
      expect(updated.price, 49.99);
    });

    test('toJson and fromJson serialize and deserialize correctly', () {
      final json = sampleItem.toJson();
      final deserialized = Item.fromJson(json);

      expect(deserialized, equals(sampleItem));
    });

    test('equality and hashCode work properly', () {
      const item1 = Item(
        id: '1',
        name: 'Test',
        description: 'Desc',
        price: 10,
        category: 'Cat',
        imageUrl: 'url',
      );
      const item2 = Item(
        id: '1',
        name: 'Test',
        description: 'Desc',
        price: 10,
        category: 'Cat',
        imageUrl: 'url',
      );

      expect(item1, equals(item2));
      expect(item1.hashCode, equals(item2.hashCode));
    });
  });
}
