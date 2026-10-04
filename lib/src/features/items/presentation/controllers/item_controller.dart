// ignore_for_file: prefer_initializing_formals

import 'package:flutter/foundation.dart';

import '../../data/repositories/item_repository.dart';
import '../../domain/models/item.dart';
import '../../domain/models/item_filter.dart';

/// Contrôleur gérant l'état de la liste d'articles, le filtrage et les favoris.
class ItemController extends ChangeNotifier {
  final ItemRepository _repository;

  List<Item> _items = [];
  List<String> _categories = [];
  ItemFilter _filter = const ItemFilter();
  bool _isLoading = false;
  String? _errorMessage;

  /// Constructeur injectant l'interface [ItemRepository].
  ItemController({required ItemRepository repository}) : _repository = repository;

  /// Liste immuable des articles actuellement chargés.
  List<Item> get items => List.unmodifiable(_items);

  /// Liste des catégories uniques d'articles.
  List<String> get categories => List.unmodifiable(_categories);

  /// Filtre actuellement appliqué.
  ItemFilter get filter => _filter;

  /// Indique si une opération de chargement est en cours.
  bool get isLoading => _isLoading;

  /// Message d'erreur éventuel en cas de défaillance.
  String? get errorMessage => _errorMessage;

  /// Charge les articles en fonction du filtre actuel avec gestion d'erreurs.
  Future<void> loadItems() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _categories = await _repository.getCategories();
      _items = await _repository.getItems(filter: _filter);
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Met à jour le filtre complet et recharge les données.
  Future<void> updateFilter(ItemFilter newFilter) async {
    _filter = newFilter;
    await loadItems();
  }

  /// Met à jour le mot-clé de recherche.
  Future<void> updateSearchQuery(String query) async {
    _filter = _filter.copyWith(searchQuery: query);
    await loadItems();
  }

  /// Sélectionne une catégorie spécifique (ou reinitialise si null).
  Future<void> selectCategory(String? category) async {
    if (category == null) {
      _filter = _filter.copyWith(clearCategory: true);
    } else {
      _filter = _filter.copyWith(category: category);
    }
    await loadItems();
  }

  /// Bascule le filtre pour n'afficher que les articles favoris.
  Future<void> toggleFavoritesOnly() async {
    _filter = _filter.copyWith(onlyFavorites: !_filter.onlyFavorites);
    await loadItems();
  }

  /// Modifie l'état favori d'un article par son [id].
  Future<void> toggleFavorite(String id) async {
    try {
      await _repository.toggleFavorite(id);
      await loadItems();
    } catch (error) {
      _errorMessage = error.toString();
      notifyListeners();
    }
  }

  /// Ajoute un nouvel article au repository et rafraîchit la liste.
  Future<void> addItem(Item item) async {
    try {
      await _repository.addItem(item);
      await loadItems();
    } catch (error) {
      _errorMessage = error.toString();
      notifyListeners();
    }
  }
}
