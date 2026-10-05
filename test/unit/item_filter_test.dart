import 'package:flutter_test/flutter_test.dart';
import 'package:tested_and_optimized_production_ready_app/src/features/items/domain/models/item_filter.dart';

void main() {
  group('ItemFilter Model Tests', () {
    test('default ItemFilter has empty fields and isEmpty is true', () {
      const filter = ItemFilter();

      expect(filter.searchQuery, '');
      expect(filter.category, isNull);
      expect(filter.maxPrice, isNull);
      expect(filter.onlyFavorites, false);
      expect(filter.isEmpty, true);
    });

    test('isEmpty returns false if any criterion is set', () {
      expect(const ItemFilter(searchQuery: 'phone').isEmpty, false);
      expect(const ItemFilter(category: 'Livres').isEmpty, false);
      expect(const ItemFilter(maxPrice: 50.0).isEmpty, false);
      expect(const ItemFilter(onlyFavorites: true).isEmpty, false);
    });

    test('copyWith updates specified fields and clearCategory resets category', () {
      const filter = ItemFilter(category: 'Électronique', searchQuery: 'code');

      final updatedFilter = filter.copyWith(maxPrice: 100.0, onlyFavorites: true);
      expect(updatedFilter.category, 'Électronique');
      expect(updatedFilter.searchQuery, 'code');
      expect(updatedFilter.maxPrice, 100.0);
      expect(updatedFilter.onlyFavorites, true);

      final clearedCategoryFilter = updatedFilter.copyWith(clearCategory: true);
      expect(clearedCategoryFilter.category, isNull);
      expect(clearedCategoryFilter.searchQuery, 'code');
      expect(clearedCategoryFilter.maxPrice, 100.0);
    });

    test('equality and hashCode work properly', () {
      const filter1 = ItemFilter(searchQuery: 'test', category: 'Cat');
      const filter2 = ItemFilter(searchQuery: 'test', category: 'Cat');
      const filter3 = ItemFilter(searchQuery: 'other', category: 'Cat');

      expect(filter1, equals(filter2));
      expect(filter1.hashCode, equals(filter2.hashCode));
      expect(filter1, isNot(equals(filter3)));
    });
  });
}
