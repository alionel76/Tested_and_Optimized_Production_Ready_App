// ignore_for_file: prefer_initializing_formals

import 'package:flutter/foundation.dart';

import '../../data/repositories/item_repository.dart';
import '../../domain/models/item.dart';
import '../../domain/models/item_filter.dart';

class ItemController extends ChangeNotifier {
  final ItemRepository _repository;

  List<Item> _items = [];
  List<String> _categories = [];
  ItemFilter _filter = const ItemFilter();
  bool _isLoading = false;

  ItemController({required ItemRepository repository}) : _repository = repository;

  List<Item> get items => List.unmodifiable(_items);
  List<String> get categories => List.unmodifiable(_categories);
  ItemFilter get filter => _filter;
  bool get isLoading => _isLoading;

  Future<void> loadItems() async {
    _isLoading = true;
    notifyListeners();

    _categories = await _repository.getCategories();
    _items = await _repository.getItems(filter: _filter);

    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateFilter(ItemFilter newFilter) async {
    _filter = newFilter;
    await loadItems();
  }

  Future<void> updateSearchQuery(String query) async {
    _filter = _filter.copyWith(searchQuery: query);
    await loadItems();
  }

  Future<void> selectCategory(String? category) async {
    if (category == null) {
      _filter = _filter.copyWith(clearCategory: true);
    } else {
      _filter = _filter.copyWith(category: category);
    }
    await loadItems();
  }

  Future<void> toggleFavoritesOnly() async {
    _filter = _filter.copyWith(onlyFavorites: !_filter.onlyFavorites);
    await loadItems();
  }

  Future<void> toggleFavorite(String id) async {
    await _repository.toggleFavorite(id);
    await loadItems();
  }

  Future<void> addItem(Item item) async {
    await _repository.addItem(item);
    await loadItems();
  }
}
