import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:logging/logging.dart';
import 'package:todo_app_ui_flutter/account/login_page.dart';
import 'package:todo_app_ui_flutter/account/register_page.dart';
import 'package:http/http.dart' as http;

final Logger accountIntegrationTestLogger = Logger("REGISTRATION WIDGET TEST");
final String baseURL = 'http://localhost:3000';

void main() {
  final log = Logger('account integration test');
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    Logger.root.onRecord.listen((LogRecord record) {
      print(
          '${record.level.name}: ${record.time}: ${record.loggerName}: ${record.message}');
    });
    Logger.root.level = Level.ALL;
  });

  group('Account Registration Integration', () {
    setUpAll(() async {
      log.info('deleting previous account');
      try {
        final response = await http.delete(
          Uri.parse('$baseURL/api/accounts/delete'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'username': 'test123'}),
        );

        log.info(response.body);
      } catch (e) {
        log.severe('Error: $e');
      }
    });
    testWidgets('Account Registration test', (WidgetTester tester) async {
      log.info('starting registration test');
      await tester.pumpWidget(MaterialApp(
        home: RegisterPage(),
      ));

      final usernameText = 'test123';
      final emailText = 'test@gmail.com';
      final phoneText = '529440177013';
      final passwordText = '529440177013';

      log.info('filling out the form');
      await tester.enterText(find.byKey(const Key('Username')), usernameText);
      await tester.enterText(find.byKey(const Key('Email')), emailText);
      await tester.enterText(find.byKey(const Key('Phone')), phoneText);
      await tester.enterText(find.byKey(const Key('Password')), passwordText);

      log.info(
          'information inserted into the form $usernameText, $emailText, $phoneText, $passwordText');

      log.info('pressing the button');
      final registerButton = find.widgetWithText(ElevatedButton, 'Register');

      await tester.tap(registerButton);
      await tester.pumpAndSettle();
    });
  });

  group('Account Login Integration', () {
    testWidgets('Account Login test', (WidgetTester tester) async {
      log.info('starting Login test');
      await tester.pumpWidget(MaterialApp(
        home: LoginPage(),
      ));

      final emailText = 'test@gmail.com';
      final passwordText = '529440177013';

      log.info('filling out the form');
      await tester.enterText(find.byKey(const Key('Email')), emailText);
      await tester.enterText(find.byKey(const Key('Password')), passwordText);

      log.info('information inserted into the form $emailText, $passwordText');

      log.info('pressing the button');
      final loginButton = find.widgetWithText(ElevatedButton, 'Login');

      await tester.tap(loginButton);
      await tester.pumpAndSettle();
    });
  });
}
