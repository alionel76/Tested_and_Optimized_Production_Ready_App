import 'package:flutter_test/flutter_test.dart';
import 'package:tested_and_optimized_production_ready_app/src/features/items/domain/models/item_filter.dart';

void main() {
  group('ItemFilter Tests', () {
    test('default ItemFilter is empty', () {
      const filter = ItemFilter();
      expect(filter.isEmpty, isTrue);
      expect(filter.searchQuery, isEmpty);
      expect(filter.category, isNull);
      expect(filter.onlyFavorites, isFalse);
    });

    test('copyWith clears category when clearCategory is true', () {
      const filter = ItemFilter(category: 'Books', searchQuery: 'Flutter');
      final updated = filter.copyWith(clearCategory: true);

      expect(updated.category, isNull);
      expect(updated.searchQuery, 'Flutter');
    });
  });
}
