import '../../domain/models/item.dart';
import '../../domain/models/item_filter.dart';

/// Interface abstraite pour la gestion de la source de données des articles.
abstract class ItemRepository {
  /// Récupère la liste des articles correspondant aux critères de [filter].
  Future<List<Item>> getItems({ItemFilter? filter});

  /// Récupère un article spécifique à partir de son [id].
  Future<Item?> getItemById(String id);

  /// Ajoute un nouvel [item] dans le repository.
  Future<void> addItem(Item item);

  /// Alterne l'état favori de l'article spécifié par [id].
  Future<void> toggleFavorite(String id);

  /// Récupère la liste distincte des catégories d'articles.
  Future<List<String>> getCategories();
}

/// Implémentation en mémoire de [ItemRepository] pour le stockage local et les tests.
class MemoryItemRepository implements ItemRepository {
  final List<Item> _items;

  /// Délai de simulation d'accès réseau / disque.
  final Duration delay;

  /// Initialise le repository avec des données initiales ou un jeu de seed par défaut.
  MemoryItemRepository({
    List<Item>? initialItems,
    this.delay = Duration.zero,
  }) : _items = initialItems ?? _defaultSeedData;

  static final List<Item> _defaultSeedData = [
    const Item(
      id: '1',
      name: 'Flutter Cookbook',
      description: 'Guide complet pour construire des applications Flutter optimisées.',
      price: 29.99,
      category: 'Livres',
      imageUrl: 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?w=400',
    ),
    const Item(
      id: '2',
      name: 'Casque Audio Sans Fil',
      description: 'Réduction de bruit active et autonomie de 30 heures.',
      price: 149.99,
      category: 'Électronique',
      imageUrl: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400',
      isFavorite: true,
    ),
    const Item(
      id: '3',
      name: 'Clavier Mécanique RGB',
      description: 'Switches tactiles et rétroéclairage personnalisable.',
      price: 89.99,
      category: 'Électronique',
      imageUrl: 'https://images.unsplash.com/photo-1587829741301-dc798b83add3?w=400',
    ),
    const Item(
      id: '4',
      name: 'Gourde Isotherme 1L',
      description: 'Garde les boissons froides 24h et chaudes 12h.',
      price: 24.50,
      category: 'Accessoires',
      imageUrl: 'https://images.unsplash.com/photo-1602143407151-7111542de6e8?w=400',
    ),
    const Item(
      id: '5',
      name: 'Sac à Dos Ergonomique',
      description: 'Conçu pour transporter un ordinateur portable avec style.',
      price: 59.90,
      category: 'Accessoires',
      imageUrl: 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=400',
      isFavorite: true,
    ),
    const Item(
      id: '6',
      name: 'Montre Connectée Sport',
      description: 'Suivi de la fréquence cardiaque et GPS intégré.',
      price: 199.00,
      category: 'Électronique',
      imageUrl: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=400',
    ),
  ];

  @override
  Future<List<Item>> getItems({ItemFilter? filter}) async {
    try {
      if (delay > Duration.zero) {
        await Future.delayed(delay);
      }
      var result = List<Item>.from(_items);

      if (filter != null) {
        if (filter.searchQuery.isNotEmpty) {
          final query = filter.searchQuery.toLowerCase();
          result = result
              .where((item) =>
                  item.name.toLowerCase().contains(query) ||
                  item.description.toLowerCase().contains(query))
              .toList();
        }

        if (filter.category != null && filter.category!.isNotEmpty) {
          result = result
              .where((item) => item.category == filter.category)
              .toList();
        }

        if (filter.maxPrice != null) {
          result = result
              .where((item) => item.price <= filter.maxPrice!)
              .toList();
        }

        if (filter.onlyFavorites) {
          result = result.where((item) => item.isFavorite).toList();
        }
      }

      return result;
    } catch (e) {
      throw Exception('Erreur lors de la récupération des articles: $e');
    }
  }

  @override
  Future<Item?> getItemById(String id) async {
    try {
      if (delay > Duration.zero) {
        await Future.delayed(delay);
      }
      return _items.firstWhere(
        (item) => item.id == id,
        orElse: () => throw Exception('Article non trouvé'),
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> addItem(Item item) async {
    try {
      if (delay > Duration.zero) {
        await Future.delayed(delay);
      }
      _items.add(item);
    } catch (e) {
      throw Exception('Erreur lors de l\'ajout de l\'article: $e');
    }
  }

  @override
  Future<void> toggleFavorite(String id) async {
    try {
      if (delay > Duration.zero) {
        await Future.delayed(delay);
      }
      final index = _items.indexWhere((item) => item.id == id);
      if (index != -1) {
        _items[index] = _items[index].copyWith(
          isFavorite: !_items[index].isFavorite,
        );
      }
    } catch (e) {
      throw Exception('Erreur lors de la modification des favoris: $e');
    }
  }

  @override
  Future<List<String>> getCategories() async {
    try {
      if (delay > Duration.zero) {
        await Future.delayed(delay);
      }
      final categories = _items.map((e) => e.category).toSet().toList();
      categories.sort();
      return categories;
    } catch (e) {
      return [];
    }
  }
}
