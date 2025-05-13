import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';
import 'package:todo_app_ui_flutter/account/login_page.dart';

final Logger LoginWidgetTestLogger = Logger("LOGIN WIDGET TEST");
void main() {
  setUp(() {
    Logger.root.level = Level.ALL; // Set the desired log level
    Logger.root.onRecord.listen((LogRecord record) {
      print(
          '${record.level.name}: ${record.time}: ${record.message}'); //basic print
    });
  });
  testWidgets('empty input test', (WidgetTester tester) async {
    LoginWidgetTestLogger.info('starting empty input test');
    await tester.pumpWidget(MaterialApp(home: LoginPage()));

    LoginWidgetTestLogger.info('finding the elements');
    final emailField = find.byKey(const Key('Email'));
    final passwordField = find.byKey(const Key('Password'));
    final loginButton = find.byKey(const Key('LoginButton'));

    LoginWidgetTestLogger.info('filling out the form with empty data');
    await tester.enterText(emailField, ''); // Enter text into email field
    await tester.enterText(passwordField, '');

    LoginWidgetTestLogger.info('pressing login button');
    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    expect(find.text('email cannot be empty'), findsOneWidget);
    expect(find.text('password cannot be empty'), findsOneWidget);
  });

  testWidgets('invalid input test', (WidgetTester tester) async {
    LoginWidgetTestLogger.info('staring invalid input test');
    await tester.pumpWidget(MaterialApp(home: LoginPage()));

    LoginWidgetTestLogger.info('finding the elements');
    final emailField = find.byKey(const Key('Email'));
    final passwordField = find.byKey(const Key('Password'));
    final loginButton = find.byKey(const Key('LoginButton'));

    LoginWidgetTestLogger.info('filling out the form with invalid data');
    await tester.enterText(
        emailField, 'email.com'); // Enter text into email field
    await tester.enterText(passwordField, '123');

    LoginWidgetTestLogger.info('pressing login button');
    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    expect(find.text('email must be valid'), findsOneWidget);
    expect(find.text('password is too short'), findsOneWidget);
  });
}
