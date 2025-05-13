import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';
import 'package:todo_app_ui_flutter/account/account_model.dart';
import 'package:todo_app_ui_flutter/todo/todo_model.dart';
import 'package:todo_app_ui_flutter/todo/todo_page.dart';

import 'integration_service.dart';

final Logger todoWidgetTestLogger = Logger("TODO WIDGET TEST");

final AccountRegistrationModel newTestAccount = AccountRegistrationModel(
    username: 'testusername123',
    email_address: 'test123@gmail.com',
    phone_number: 'test123456789',
    password: 'testpassword123');

final CreateTodoModel newTestTodo = CreateTodoModel(
  title: 'Test Todo',
  description: 'This is a test todo',
);

final CreateTodoModel newTestTodo_2 = CreateTodoModel(
  title: 'Test Todo 2',
  description: 'This is a test todo 2',
);

final CreateTodoModel newTestTodo_3 = CreateTodoModel(
  title: 'Test Todo 3',
  description: 'This is a test todo 3',
);

void main() {
  final log = Logger('Todo Widget Test');
  setUpAll(() {
    Logger.root.onRecord.listen((LogRecord record) {
      print(
          '${record.level.name}: ${record.time}: ${record.loggerName}: ${record.message}');
    });
    Logger.root.level = Level.ALL;
  });

  group('GET TEST GROUP', () {
    setUpAll(() async {
      log.info('setting up GET TEST GROUP');
      log.info('deleting existing account');
      await IntegrationService.deleteAccount();
      log.info('creating new account');
      final account_id =
          await IntegrationService.registerAccount(newTestAccount);
      log.info('creating todos');
      await IntegrationService.createTodo(newTestTodo, account_id);
      await IntegrationService.createTodo(newTestTodo_2, account_id);
      await IntegrationService.createTodo(newTestTodo_3, account_id);
      log.info('GET TEST GROUP setup complete');
    });
    testWidgets('GET TEST', (WidgetTester tester) async {
      log.info('starting get test');
      await tester.pumpWidget(MaterialApp(
        home: TodoPage(),
      ));
    });
  });
}
