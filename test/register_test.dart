import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';
import 'package:todo_app_ui_flutter/account/register_page.dart';

final Logger RegisterWidgetTestLogger = Logger("REGISTER WIDGET TEST");
void main() {
  setUp(() {
    Logger.root.level = Level.ALL; // Set the desired log level
    Logger.root.onRecord.listen((LogRecord record) {
      print(
          '${record.level.name}: ${record.time}: ${record.message}'); //basic print
    });
  });
  testWidgets('empty input test', (WidgetTester tester) async {
    RegisterWidgetTestLogger.info('starting empty input test');
    await tester.pumpWidget(MaterialApp(home: RegisterPage()));

    RegisterWidgetTestLogger.info('finding the elements');
    final usernameField = find.byKey(const Key('Username'));
    final emailField = find.byKey(const Key('Email'));
    final phoneNumberField = find.byKey(const Key('Phone'));
    final passwordField = find.byKey(const Key('Password'));
    final registerButton = find.byKey(const Key('RegisterButton'));

    RegisterWidgetTestLogger.info('filling out the form with empty data');
    await tester.enterText(usernameField, '');
    await tester.enterText(emailField, '');
    await tester.enterText(phoneNumberField, '');
    await tester.enterText(passwordField, '');

    RegisterWidgetTestLogger.info('pressing register button with empty data');
    await tester.tap(registerButton);
    await tester.pumpAndSettle();

    // Verify that error text is displayed
    expect(find.text('username cannot be empty'), findsOneWidget);
    expect(find.text('email cannot be empty'), findsOneWidget);
    expect(find.text('phone cannot be empty'), findsOneWidget);
    expect(find.text('password cannot be empty'), findsOneWidget);
  });

  testWidgets('invalid input test', (WidgetTester tester) async {
    RegisterWidgetTestLogger.info('staring invalid input test');
    await tester.pumpWidget(MaterialApp(home: RegisterPage()));

    RegisterWidgetTestLogger.info('finding the elements');
    final emailField = find.byKey(const Key('Email'));
    final passwordField = find.byKey(const Key('Password'));
    final registerButton = find.byKey(const Key('RegisterButton'));

    RegisterWidgetTestLogger.info('filling out the form with invalid data');
    await tester.enterText(
        emailField, 'email.com'); // Enter text into email field
    await tester.enterText(passwordField, '123');

    RegisterWidgetTestLogger.info('pressing login button');
    await tester.tap(registerButton);
    await tester.pumpAndSettle();

    expect(find.text('email must be valid'), findsOneWidget);
    expect(find.text('password is too short'), findsOneWidget);
  });
}
