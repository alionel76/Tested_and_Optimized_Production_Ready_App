import 'package:flutter_test/flutter_test.dart';
import 'package:tested_and_optimized_production_ready_app/src/features/items/domain/models/item.dart';

void main() {
  group('Item Model Tests', () {
    test('Item constructor creates item with correct values and default favorite', () {
      const item = Item(
        id: '1',
        name: 'Test Item',
        description: 'Test Description',
        price: 19.99,
        category: 'Test Category',
        imageUrl: 'https://example.com/image.jpg',
      );

      expect(item.id, '1');
      expect(item.name, 'Test Item');
      expect(item.description, 'Test Description');
      expect(item.price, 19.99);
      expect(item.category, 'Test Category');
      expect(item.imageUrl, 'https://example.com/image.jpg');
      expect(item.isFavorite, false);
    });

    test('copyWith updates specified fields and keeps unchanged fields', () {
      const item = Item(
        id: '1',
        name: 'Original Name',
        description: 'Original Description',
        price: 10.0,
        category: 'Original Category',
        imageUrl: 'https://example.com/original.jpg',
        isFavorite: false,
      );

      final updatedItem = item.copyWith(
        name: 'New Name',
        isFavorite: true,
      );

      expect(updatedItem.id, '1');
      expect(updatedItem.name, 'New Name');
      expect(updatedItem.description, 'Original Description');
      expect(updatedItem.price, 10.0);
      expect(updatedItem.category, 'Original Category');
      expect(updatedItem.imageUrl, 'https://example.com/original.jpg');
      expect(updatedItem.isFavorite, true);
    });

    test('toJson and fromJson convert item correctly', () {
      const item = Item(
        id: '123',
        name: 'Gadget',
        description: 'Cool gadget',
        price: 49.95,
        category: 'Electronics',
        imageUrl: 'https://example.com/gadget.png',
        isFavorite: true,
      );

      final json = item.toJson();

      expect(json, {
        'id': '123',
        'name': 'Gadget',
        'description': 'Cool gadget',
        'price': 49.95,
        'category': 'Electronics',
        'imageUrl': 'https://example.com/gadget.png',
        'isFavorite': true,
      });

      final itemFromJson = Item.fromJson(json);
      expect(itemFromJson, equals(item));
    });

    test('equality and hashCode work as expected', () {
      const item1 = Item(
        id: '1',
        name: 'Item',
        description: 'Desc',
        price: 10.0,
        category: 'Cat',
        imageUrl: 'url',
      );

      const item2 = Item(
        id: '1',
        name: 'Item',
        description: 'Desc',
        price: 10.0,
        category: 'Cat',
        imageUrl: 'url',
      );

      const item3 = Item(
        id: '2',
        name: 'Item',
        description: 'Desc',
        price: 10.0,
        category: 'Cat',
        imageUrl: 'url',
      );

      expect(item1, equals(item2));
      expect(item1.hashCode, equals(item2.hashCode));
      expect(item1, isNot(equals(item3)));
    });
  });
}
