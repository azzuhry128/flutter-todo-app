import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';
import 'package:todo_app_ui_flutter/account/register_page.dart';

final Logger registerWidgetTestLogger = Logger("REGISTRATION WIDGET TEST");

void main() {
  final log = Logger('registration widget test');
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
      home: RegisterPage(),
    ));
    // EMPTY FIELD TEST
    log.info('pressing the button');
    final registerButton = find.widgetWithText(ElevatedButton, 'Register');

    await tester.tap(registerButton);
    await tester.pumpAndSettle();

    log.info('checking all the list');
    expect(find.text("Username cannot be empty"), findsOneWidget);
    expect(find.text("Email cannot be empty"), findsOneWidget);
    expect(find.text("Phone cannot be empty"), findsOneWidget);
    expect(find.text("Password cannot be empty"), findsOneWidget);
    log.info('empty inputs test finished');
  });

  testWidgets('invalid input test', (WidgetTester tester) async {
    log.info('starting invalid input test');
    await tester.pumpWidget(MaterialApp(
      home: RegisterPage(),
    ));

    final usernameText = 'ab';
    final emailText = 'invalid_email';
    final phoneText = '123';
    final passwordText = 'short';

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

    log.info('checking all the list');
    expect(find.text("Username is too short"), findsOneWidget);
    expect(find.text("Enter a valid email address"), findsOneWidget);
    expect(find.text("Phone number must be at least 10 characters long"),
        findsOneWidget);
    expect(find.text("Password must be at least 6 characters long"),
        findsOneWidget);
    log.info('invalid input test finished');
  });

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

  
}
