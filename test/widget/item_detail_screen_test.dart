import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tested_and_optimized_production_ready_app/src/core/localization/generated/app_localizations.dart';
import 'package:tested_and_optimized_production_ready_app/src/features/items/data/repositories/item_repository.dart';
import 'package:tested_and_optimized_production_ready_app/src/features/items/presentation/controllers/item_controller.dart';
import 'package:tested_and_optimized_production_ready_app/src/features/items/presentation/screens/item_detail_screen.dart';

void main() {
  testWidgets('ItemDetailScreen renders item information and favorite button',
      (WidgetTester tester) async {
    final repository = MemoryItemRepository();
    final controller = ItemController(repository: repository);
    await controller.loadItems();

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: ItemDetailScreen(
          itemId: '1',
          itemController: controller,
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Flutter Cookbook'), findsWidgets);
    expect(find.text('Livres'), findsOneWidget);
    expect(find.byIcon(Icons.favorite_border), findsOneWidget);
  });
}
