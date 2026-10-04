/// Critères de filtrage applicables à la liste d'articles.
class ItemFilter {
  /// Terme de recherche par mot-clé.
  final String searchQuery;

  /// Catégorie sélectionnée (null si toutes les catégories).
  final String? category;

  /// Prix maximum autorisé.
  final double? maxPrice;

  /// Indique s'il faut afficher uniquement les favoris.
  final bool onlyFavorites;

  /// Constructeur immuable pour [ItemFilter].
  const ItemFilter({
    this.searchQuery = '',
    this.category,
    this.maxPrice,
    this.onlyFavorites = false,
  });

  /// Copie le filtre en mettant à jour sélectivement ses paramètres.
  ItemFilter copyWith({
    String? searchQuery,
    String? category,
    double? maxPrice,
    bool? onlyFavorites,
    bool clearCategory = false,
  }) {
    return ItemFilter(
      searchQuery: searchQuery ?? this.searchQuery,
      category: clearCategory ? null : (category ?? this.category),
      maxPrice: maxPrice ?? this.maxPrice,
      onlyFavorites: onlyFavorites ?? this.onlyFavorites,
    );
  }

  /// Indique si aucun critère de filtre spécifique n'est appliqué.
  bool get isEmpty =>
      searchQuery.isEmpty &&
      category == null &&
      maxPrice == null &&
      !onlyFavorites;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemFilter &&
          runtimeType == other.runtimeType &&
          searchQuery == other.searchQuery &&
          category == other.category &&
          maxPrice == other.maxPrice &&
          onlyFavorites == other.onlyFavorites;

  @override
  int get hashCode =>
      searchQuery.hashCode ^
      category.hashCode ^
      maxPrice.hashCode ^
      onlyFavorites.hashCode;
}
