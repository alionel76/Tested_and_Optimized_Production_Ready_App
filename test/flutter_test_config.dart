import 'dart:async';
import 'dart:io';
import 'test_helpers.dart';

Future<void> testExecutable(Future<void> Function() testMain) async {
  HttpOverrides.global = TestHttpOverrides();
  await testMain();
}
