import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_ui_flutter/account/account_store.dart';
import 'package:todo_app_ui_flutter/account/login_page.dart';
import 'package:todo_app_ui_flutter/account/register_page.dart';

import 'integration_service.dart';

final Logger accountIntegrationTestLogger = Logger("ACCOUNT INTEGRATION TEST");
final String baseURL = 'http://10.0.2.2:3000';

void main() async {
  dotenv.load(fileName: ".env.test");
  final log = Logger('account integration test');
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    Logger.root.onRecord.listen((LogRecord record) {
      print(
          '${record.level.name}: ${record.time}: ${record.loggerName}: ${record.message}');
    });
    Logger.root.level = Level.ALL;
  });

  await _executeRegistrationTest(log);
  await _executeLoginTest(log);

  log.info('completed all tests');
}

Future<void> _executeRegistrationTest(log) async {
  group('Account Registration Integration', () {
    setUpAll(() async {
      log.info('setting up registration test');
      await IntegrationService.deleteAccount();
    });
    testWidgets('Account Registration test', (WidgetTester tester) async {
      log.info('starting registration test');
      await tester.pumpWidget(MaterialApp(
        home: RegisterPage(),
      ));

      final usernameText = 'username123';
      final emailText = 'test123@gmail.com';
      final phoneText = 'test123456789';
      final passwordText = 'password123';

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
}

Future<void> _executeLoginTest(log) async {
  group('Account Login Integration', () {
    testWidgets('Account Login test', (WidgetTester tester) async {
      log.info('starting Login test');
      await tester.pumpWidget(ChangeNotifierProvider<AccountStore>(
        create: (context) => AccountStore(),
        child: MaterialApp(
          home: LoginPage(),
        ),
      ));

      final emailText = 'test123@gmail.com';
      final passwordText = 'password123';

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
