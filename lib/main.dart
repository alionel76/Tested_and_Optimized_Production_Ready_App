import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/features/items/data/repositories/item_repository.dart';
import 'src/features/items/presentation/controllers/item_controller.dart';
import 'src/features/settings/data/repositories/settings_repository.dart';
import 'src/features/settings/presentation/controllers/settings_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final settingsRepository = MemorySettingsRepository();
  final settingsController = SettingsController(repository: settingsRepository);
  await settingsController.loadSettings();

  final itemRepository = MemoryItemRepository();
  final itemController = ItemController(repository: itemRepository);
  await itemController.loadItems();

  runApp(MyApp(
    settingsController: settingsController,
    itemController: itemController,
  ));
}
