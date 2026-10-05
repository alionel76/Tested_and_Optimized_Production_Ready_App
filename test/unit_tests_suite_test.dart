import 'unit/item_filter_test.dart' as item_filter_test;
import 'unit/item_repository_test.dart' as item_repository_test;
import 'unit/item_test.dart' as item_test;
import 'unit/item_controller_test.dart' as item_controller_test;
import 'unit/settings_controller_test.dart' as settings_controller_test;

void main() {
  item_test.main();
  item_filter_test.main();
  item_repository_test.main();
  item_controller_test.main();
  settings_controller_test.main();
}
