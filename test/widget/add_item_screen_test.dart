import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tested_and_optimized_production_ready_app/src/core/localization/generated/app_localizations.dart';
import 'package:tested_and_optimized_production_ready_app/src/features/items/data/repositories/item_repository.dart';
import 'package:tested_and_optimized_production_ready_app/src/features/items/presentation/controllers/item_controller.dart';
import 'package:tested_and_optimized_production_ready_app/src/features/items/presentation/screens/add_item_screen.dart';

void main() {
  testWidgets('AddItemScreen displays validation errors on empty submission',
      (WidgetTester tester) async {
    final repository = MemoryItemRepository();
    final controller = ItemController(repository: repository);

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
        home: AddItemScreen(itemController: controller),
      ),
    );

    await tester.pump();

    final submitButton = find.byKey(const Key('submit_item_button'));
    await tester.tap(submitButton);
    await tester.pump();

    expect(find.text('Veuillez saisir un nom'), findsOneWidget);
    expect(find.text('Veuillez saisir un prix'), findsOneWidget);
  });
}
