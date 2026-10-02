import 'package:flutter/material.dart';

import '../../../../core/localization/generated/app_localizations.dart';
import '../controllers/item_controller.dart';
import '../widgets/filter_bar.dart';
import '../widgets/item_card.dart';
import 'add_item_screen.dart';
import 'item_detail_screen.dart';
import 'search_screen.dart';

class HomeScreen extends StatelessWidget {
  final ItemController itemController;
  final Widget settingsWidget;

  const HomeScreen({
    super.key,
    required this.itemController,
    required this.settingsWidget,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ListenableBuilder(
      listenable: itemController,
      builder: (context, _) {
        final items = itemController.items;
        final isLoading = itemController.isLoading;

        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.homeTitle),
            actions: [
              Semantics(
                label: l10n.searchTitle,
                button: true,
                child: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SearchScreen(itemController: itemController),
                      ),
                    );
                  },
                ),
              ),
              Semantics(
                label: l10n.settingsTitle,
                button: true,
                child: IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => settingsWidget,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              FilterBar(
                categories: itemController.categories,
                selectedCategory: itemController.filter.category,
                onlyFavorites: itemController.filter.onlyFavorites,
                onCategorySelected: (cat) => itemController.selectCategory(cat),
                onToggleFavorites: () => itemController.toggleFavoritesOnly(),
              ),
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : items.isEmpty
                        ? Center(
                            child: Text(
                              l10n.noResults,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          )
                        : RefreshIndicator(
                            onRefresh: () => itemController.loadItems(),
                            child: ListView.builder(
                              itemCount: items.length,
                              itemBuilder: (context, index) {
                                final item = items[index];
                                return ItemCard(
                                  item: item,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ItemDetailScreen(
                                          itemId: item.id,
                                          itemController: itemController,
                                        ),
                                      ),
                                    );
                                  },
                                  onFavoriteToggle: () {
                                    itemController.toggleFavorite(item.id);
                                  },
                                );
                              },
                            ),
                          ),
              ),
            ],
          ),
          floatingActionButton: Semantics(
            label: l10n.addItemTitle,
            button: true,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AddItemScreen(itemController: itemController),
                  ),
                );
              },
              tooltip: l10n.addItemTitle,
              child: const Icon(Icons.add),
            ),
          ),
        );
      },
    );
  }
}
