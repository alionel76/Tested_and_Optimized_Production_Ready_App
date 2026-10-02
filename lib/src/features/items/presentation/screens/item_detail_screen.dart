import 'package:flutter/material.dart';

import '../../../../core/localization/generated/app_localizations.dart';
import '../../../../core/widgets/optimized_image.dart';
import '../../domain/models/item.dart';
import '../controllers/item_controller.dart';

class ItemDetailScreen extends StatelessWidget {
  final String itemId;
  final ItemController itemController;

  const ItemDetailScreen({
    super.key,
    required this.itemId,
    required this.itemController,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return ListenableBuilder(
      listenable: itemController,
      builder: (context, _) {
        final Item? item = itemController.items.cast<Item?>().firstWhere(
              (e) => e?.id == itemId,
              orElse: () => null,
            );

        if (item == null) {
          return Scaffold(
            appBar: AppBar(title: Text(l10n.itemDetailTitle)),
            body: Center(child: Text(l10n.noResults)),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(item.name),
            actions: [
              Semantics(
                label: item.isFavorite
                    ? l10n.removeFromFavorites
                    : l10n.addToFavorites,
                button: true,
                child: IconButton(
                  icon: Icon(
                    item.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: item.isFavorite ? Colors.red : null,
                  ),
                  onPressed: () => itemController.toggleFavorite(item.id),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: 'item_image_${item.id}',
                  child: OptimizedImage(
                    imageUrl: item.imageUrl,
                    height: 280,
                    semanticLabel: 'Photo de ${item.name}',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Chip(
                            label: Text(item.category),
                            backgroundColor:
                                theme.colorScheme.primaryContainer,
                          ),
                          Text(
                            '${item.price.toStringAsFixed(2)} \$',
                            style: theme.textTheme.headlineMedium?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        l10n.description,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item.description,
                        style: theme.textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
