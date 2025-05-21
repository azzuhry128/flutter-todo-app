import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_ui_flutter/account/account_model.dart';
import 'package:todo_app_ui_flutter/store/account_store.dart';
import 'package:todo_app_ui_flutter/store/todo_store.dart';
import 'package:todo_app_ui_flutter/todo/todo_model.dart';
import 'package:todo_app_ui_flutter/todo/todo_page.dart';

import 'integration_service.dart';

final Logger todoIntegrationTestLogger = Logger("TODO INTEGRATION TEST");

final AccountRegistrationModel newTestAccount = AccountRegistrationModel(
    username: 'username123',
    email_address: 'test123@gmail.com',
    phone_number: 'test123456789',
    password: 'testpassword123');

final AccountLoginModel newTestLogin = AccountLoginModel(
    email_address: 'test123@gmail.com', password: 'testpassword123');

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
  dotenv.load(fileName: ".env.test");
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    todoIntegrationTestLogger.info('setting up todo integration test');
    Logger.root.onRecord.listen((LogRecord record) {
      print(
          '${record.level.name}: ${record.time}: ${record.loggerName}: ${record.message}');
    });
    Logger.root.level = Level.ALL;

    await IntegrationService.deleteAlltodo();
    await IntegrationService.deleteAccount();
    await IntegrationService.registerAccount(newTestAccount);
    final response = await IntegrationService.loginAccount(newTestLogin);
    final decodedResponse = jsonDecode(response);
    todoIntegrationTestLogger
        .info('decodedResponse: ${decodedResponse['data']}');

    await IntegrationService.createTodo(
        newTestTodo, decodedResponse['data']['account_id']);
    await IntegrationService.createTodo(
        newTestTodo_2, decodedResponse['data']['account_id']);
    await IntegrationService.createTodo(
        newTestTodo_3, decodedResponse['data']['account_id']);

    AccountStore.instance.setAccountState(decodedResponse['data']);
    todoIntegrationTestLogger.info('todo integration test setup finished');
  });

  testWidgets('GET TEST', (WidgetTester tester) async {
    todoIntegrationTestLogger.info('starting get test');
    await tester.pumpWidget(MultiProvider(
      providers: [
        Provider<AccountStore>(
          create: (context) => AccountStore(),
        ),
        ChangeNotifierProvider<TodoStore>(
          //  <--  This is the key line
          create: (context) => TodoStore(),
        ),
      ],
      child: MaterialApp(
        home: TodoPage(),
      ),
    ));

    await tester.pumpAndSettle();

    todoIntegrationTestLogger.info('get test finished');
  });

  testWidgets('POST TEST', (WidgetTester tester) async {
    todoIntegrationTestLogger.info('starting post test');
    await tester.pumpWidget(MultiProvider(
      providers: [
        Provider<AccountStore>(
          create: (context) => AccountStore(),
        ),
        ChangeNotifierProvider<TodoStore>(
          //  <--  This is the key line
          create: (context) => TodoStore(),
        ),
      ],
      child: MaterialApp(
        home: TodoPage(),
      ),
    ));

    await tester.pumpAndSettle();

    final addbutton = find.widgetWithText(FloatingActionButton, 'add');
    expect(addbutton, findsOneWidget);
    await tester.tap(addbutton);

    await tester.pumpAndSettle();

    todoIntegrationTestLogger.info('post test finished');
  });

  // testWidgets('PATCH TEST', (WidgetTester tester) async {
  //   todoIntegrationTestLogger.info('starting patch test');
  //   await tester.pumpWidget(MaterialApp(
  //     home: TodoPage(),
  //   ));

  //   await tester.pumpAndSettle();
  //   todoIntegrationTestLogger.info('patch test is finished');
  // });

  todoIntegrationTestLogger.info('completed all tests');
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
