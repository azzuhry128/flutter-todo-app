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

void main() async {
  final log = Logger('Todo Widget Test');
  var account_id = '';
  var todo_1 = [];
  var todo_2 = [];
  var todo_3 = [];
  setUpAll(() async {
    Logger.root.onRecord.listen((LogRecord record) {
      print(
          '${record.level.name}: ${record.time}: ${record.loggerName}: ${record.message}');
    });
    Logger.root.level = Level.ALL;

    await IntegrationService.deleteAccount();
    account_id = await IntegrationService.registerAccount(newTestAccount);
    todo_1 = await IntegrationService.createTodo(newTestTodo, account_id);
    todo_2 = await IntegrationService.createTodo(newTestTodo_2, account_id);
    todo_3 = await IntegrationService.createTodo(newTestTodo_3, account_id);

    log.info('test account id: $account_id');
    log.info('test todo_1: $todo_1');
    log.info('test todo_2: $todo_2');
    log.info('test todo_3: $todo_3');
  });

  await _executeGetTodo(log);
  await _executePostTodo(log);
  await _executePatchTodo(log);
  await _executeDeleteTodo(log);

  log.info('completed all tests');
}

Future<void> _executeGetTodo(log) async {
  group('GET TEST GROUP', () {
    testWidgets('GET TEST', (WidgetTester tester) async {
      log.info('starting get test');
      await tester.pumpWidget(MaterialApp(
        home: TodoPage(),
      ));
    });
  });
}

Future<void> _executePostTodo(log) async {
  group('POST TEST GROUP', () {
    testWidgets('POST TEST', (WidgetTester tester) async {
      log.info('starting post test');
      await tester.pumpWidget(MaterialApp(
        home: TodoPage(),
      ));
    });
  });
}

Future<void> _executePatchTodo(log) async {
  group('PATCH TEST GROUP', () {
    testWidgets('PATCH TEST', (WidgetTester tester) async {
      log.info('starting patch test');
      await tester.pumpWidget(MaterialApp(
        home: TodoPage(),
      ));
    });
  });
}

Future<void> _executeDeleteTodo(log) async {
  group('DELETE TEST GROUP', () {
    testWidgets('DELETE TEST', (WidgetTester tester) async {
      log.info('starting delete test');
      await tester.pumpWidget(MaterialApp(
        home: TodoPage(),
      ));
    });
  });
}
