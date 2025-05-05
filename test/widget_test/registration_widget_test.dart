import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app_ui_flutter/account/register_page.dart';
import 'package:todo_app_ui_flutter/utils/toast_utils.dart';

Future<void> pumpRegistrationPage(WidgetTester tester) async {
  await tester.pumpWidget(MaterialApp(
    home: RegisterPage(),
  ));
}

void main() {
  setUp(() {
    ToastUtils.showToast("hello there");
  });
  testWidgets('registration widget test', (WidgetTester tester) async {
    await pumpRegistrationPage(tester);

    final usernameField = find.bySemanticsLabel('Username');
    final emailField = find.bySemanticsLabel('Email');
    final phoneField = find.bySemanticsLabel('Phone');
    final passwordField = find.bySemanticsLabel('Password');

    final registerButton = find.widgetWithText(ElevatedButton, 'Register');

    // EMPTY FIELD TEST
    await tester.tap(registerButton);
    await tester.pumpAndSettle();

    expect(find.text("Username cannot be empty"), findsOneWidget);
    expect(find.text("Email cannot be empty"), findsOneWidget);
    expect(find.text("Phone cannot be empty"), findsOneWidget);
    expect(find.text("Password cannot be empty"), findsOneWidget);

    // INVALID INPUT TEST
    await tester.enterText(usernameField, '');
    await tester.enterText(emailField, 'invalid-email');
    await tester.enterText(phoneField, '123');
    await tester.enterText(passwordField, '123');
    await tester.tap(registerButton);
    await tester.pumpAndSettle();

    expect(find.text('Username cannot be empty'), findsOneWidget);
    expect(find.text('Enter a valid email address'), findsOneWidget);
    expect(
        find.text('Phone must be at least 10 characters long'), findsOneWidget);
    expect(find.text('Password must be at least 6 characters long'),
        findsOneWidget);
  });
}
