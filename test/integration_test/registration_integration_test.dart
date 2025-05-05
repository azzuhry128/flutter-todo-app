import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app_ui_flutter/account/account_service.dart';

void main() {
  group("Registration Service Integration test", () {
    late AccountService accountService;

    setUp(() {
      accountService = AccountService();
    });

    group('Username validation', () {
      test('valid username returns null', () {});
    });
  });
}
