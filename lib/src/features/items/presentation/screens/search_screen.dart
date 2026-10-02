import 'package:flutter/material.dart';

import '../../../../core/localization/generated/app_localizations.dart';
import '../controllers/item_controller.dart';
import '../widgets/item_card.dart';
import 'item_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  final ItemController itemController;

  const SearchScreen({
    super.key,
    required this.itemController,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(
      text: widget.itemController.filter.searchQuery,
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ListenableBuilder(
      listenable: widget.itemController,
      builder: (context, _) {
        final items = widget.itemController.items;

        return Scaffold(
          appBar: AppBar(
            title: TextField(
              controller: _searchController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: l10n.searchHint,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          widget.itemController.updateSearchQuery('');
                        },
                      )
                    : null,
              ),
              onChanged: (value) {
                widget.itemController.updateSearchQuery(value);
              },
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  children: [
                    Text(
                      '${l10n.totalItems}: ${items.length}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: items.isEmpty
                    ? Center(
                        child: Text(
                          l10n.noResults,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      )
                    : ListView.builder(
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
                                    itemController: widget.itemController,
                                  ),
                                ),
                              );
                            },
                            onFavoriteToggle: () {
                              widget.itemController.toggleFavorite(item.id);
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
