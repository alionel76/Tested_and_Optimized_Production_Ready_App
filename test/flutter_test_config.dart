import 'dart:async';
import 'dart:io';

import 'test_helpers.dart';

Future<void> testExecutable(FutureOr<void> Function() main) async {
  HttpOverrides.global = TestHttpOverrides();
  await main();
}
