import 'package:flutter/material.dart';

import '../../../../core/localization/generated/app_localizations.dart';

class FilterBar extends StatelessWidget {
  final List<String> categories;
  final String? selectedCategory;
  final bool onlyFavorites;
  final ValueChanged<String?> onCategorySelected;
  final VoidCallback onToggleFavorites;

  const FilterBar({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onlyFavorites,
    required this.onCategorySelected,
    required this.onToggleFavorites,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          FilterChip(
            label: Text(l10n.favorite),
            selected: onlyFavorites,
            avatar: Icon(
              onlyFavorites ? Icons.favorite : Icons.favorite_border,
              size: 18,
            ),
            onSelected: (_) => onToggleFavorites(),
          ),
          const SizedBox(width: 8),
          FilterChip(
            label: Text(l10n.filterAll),
            selected: selectedCategory == null,
            onSelected: (_) => onCategorySelected(null),
          ),
          const SizedBox(width: 8),
          ...categories.map((category) {
            final isSelected = selectedCategory == category;
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: FilterChip(
                label: Text(category),
                selected: isSelected,
                onSelected: (_) => onCategorySelected(category),
              ),
            );
          }),
        ],
      ),
    );
  }
}
