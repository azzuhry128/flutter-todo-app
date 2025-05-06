import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';
import 'package:todo_app_ui_flutter/account/register_page.dart';

final Logger accountIntegrationTestLogger = Logger("REGISTRATION WIDGET TEST");

void main() {
  final log = Logger('account integration test');

  setUpAll(() {
    Logger.root.onRecord.listen((LogRecord record) {
      print(
          '${record.level.name}: ${record.time}: ${record.loggerName}: ${record.message}');
    });
    Logger.root.level = Level.ALL;
  });

  group('create user', () {
    testWidgets('registration test', (WidgetTester tester) async {
      log.info('starting registration test');
      await tester.pumpWidget(MaterialApp(
        home: RegisterPage(),
      ));

      final usernameText = 'test_account';
      final emailText = 'test@gmail.com';
      final phoneText = 'test_phone_123';
      final passwordText = 'test_password';

      log.info('filling out the form');
      await tester.enterText(
          find.byKey(const Key('username_field')), usernameText);
      await tester.enterText(find.byKey(const Key('email_field')), emailText);
      await tester.enterText(find.byKey(const Key('phone_field')), phoneText);
      await tester.enterText(
          find.byKey(const Key('password_field')), passwordText);

      log.info('information inserted into the form', {
        'username': usernameText,
        'email': emailText,
        'phone': phoneText,
        'password': passwordText,
      });

      log.info('pressing the button');
      final registerButton = find.widgetWithText(ElevatedButton, 'Register');

      await tester.tap(registerButton);
      await tester.pumpAndSettle();
    });
  });
}
