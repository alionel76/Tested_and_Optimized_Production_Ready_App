import 'package:flutter_test/flutter_test.dart';
import 'package:tested_and_optimized_production_ready_app/src/app.dart';
import 'package:tested_and_optimized_production_ready_app/src/features/items/data/repositories/item_repository.dart';
import 'package:tested_and_optimized_production_ready_app/src/features/items/presentation/controllers/item_controller.dart';
import 'package:tested_and_optimized_production_ready_app/src/features/settings/data/repositories/settings_repository.dart';
import 'package:tested_and_optimized_production_ready_app/src/features/settings/presentation/controllers/settings_controller.dart';

void main() {
  testWidgets('App renders correctly and displays catalog title', (WidgetTester tester) async {
    final settingsRepo = MemorySettingsRepository();
    final settingsController = SettingsController(repository: settingsRepo);
    await settingsController.loadSettings();

    final itemRepo = MemoryItemRepository();
    final itemController = ItemController(repository: itemRepo);
    await itemController.loadItems();

    await tester.pumpWidget(MyApp(
      settingsController: settingsController,
      itemController: itemController,
    ));

    await tester.pumpAndSettle();

    expect(find.text('Catalogue & Flux'), findsOneWidget);
  });
}
