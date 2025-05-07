import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';
import 'package:todo_app_ui_flutter/account/login_page.dart';

final Logger loginWidgetTestLogger = Logger("LOGIN WIDGET TEST");

void main() {
  final log = Logger('Login Widget Test');
  setUpAll(() {
    Logger.root.onRecord.listen((LogRecord record) {
      print(
          '${record.level.name}: ${record.time}: ${record.loggerName}: ${record.message}');
    });
    Logger.root.level = Level.ALL;
  });
  testWidgets('empty input test', (WidgetTester tester) async {
    log.info('starting empty input test');
    await tester.pumpWidget(MaterialApp(
      home: LoginPage(),
    ));
    // EMPTY FIELD TEST
    log.info('pressing the button');
    final loginButton = find.widgetWithText(ElevatedButton, 'Login');

    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    log.info('checking all the list');
    expect(find.text("Email cannot be empty"), findsOneWidget);
    expect(find.text("Password cannot be empty"), findsOneWidget);
    log.info('empty inputs test finished');
  });

  testWidgets('invalid input test', (WidgetTester tester) async {
    log.info('starting invalid input test');
    await tester.pumpWidget(MaterialApp(
      home: LoginPage(),
    ));

    final emailText = 'invalid_email';
    final passwordText = 'short';

    log.info('filling out the form');
    await tester.enterText(find.byKey(const Key('Email')), emailText);
    await tester.enterText(find.byKey(const Key('Password')), passwordText);

    log.info('information inserted into the form', {
      'email': emailText,
      'password': passwordText,
    });

    log.info('pressing the button');
    final loginButton = find.widgetWithText(ElevatedButton, 'Login');

    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    log.info('checking all the list');
    expect(find.text("Enter a valid email address"), findsOneWidget);
    expect(find.text("Password must be at least 6 characters long"),
        findsOneWidget);
    log.info('invalid input test finished');
  });
}
