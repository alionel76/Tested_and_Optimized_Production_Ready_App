import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tested_and_optimized_production_ready_app/src/core/localization/generated/app_localizations.dart';
import 'package:tested_and_optimized_production_ready_app/src/features/items/data/repositories/item_repository.dart';
import 'package:tested_and_optimized_production_ready_app/src/features/items/presentation/controllers/item_controller.dart';
import 'package:tested_and_optimized_production_ready_app/src/features/items/presentation/screens/home_screen.dart';

void main() {
  testWidgets('HomeScreen renders catalog items and floating action button',
      (WidgetTester tester) async {
    final repository = MemoryItemRepository();
    final controller = ItemController(repository: repository);
    await controller.loadItems();

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: HomeScreen(
          itemController: controller,
          settingsWidget: const SizedBox(),
        ),
      ),
    );

    await tester.pump();

    expect(find.text('Catalogue & Flux'), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(find.text('Flutter Cookbook'), findsOneWidget);
  });
}
