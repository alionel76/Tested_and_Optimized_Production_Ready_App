class ItemFilter {
  final String searchQuery;
  final String? category;
  final double? maxPrice;
  final bool onlyFavorites;

  const ItemFilter({
    this.searchQuery = '',
    this.category,
    this.maxPrice,
    this.onlyFavorites = false,
  });

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
