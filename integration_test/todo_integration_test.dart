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

  var decodedAlterationTodo;
  var alterationTodoID = '';

  var decodedDeletionTodo;
  var deletionTodoID = '';

  setUp(() async {
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

    final alterationTodoResponse = await IntegrationService.createTodo(
        newTestTodo, decodedResponse['data']['account_id']);
    final deletionTodoResponse = await IntegrationService.createTodo(
        newTestTodo_2, decodedResponse['data']['account_id']);
    await IntegrationService.createTodo(
        newTestTodo_3, decodedResponse['data']['account_id']);

    todoIntegrationTestLogger.info('alteration todo : $alterationTodoResponse');

    decodedAlterationTodo = jsonDecode(alterationTodoResponse.body);
    alterationTodoID = decodedAlterationTodo['data']['todo_id'];

    decodedDeletionTodo = jsonDecode(deletionTodoResponse.body);
    deletionTodoID = decodedDeletionTodo['data']['todo_id'];

    AccountStore.instance.setAccountState(decodedResponse['data']);
    todoIntegrationTestLogger.info('todo integration test setup finished');
  });

  testWidgets('CRUD TEST', (WidgetTester tester) async {
    todoIntegrationTestLogger.info('starting CRUD test');
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

    // GET TEST
    todoIntegrationTestLogger.info('GET test started');
    await tester.pumpAndSettle();

    expect(find.byType(Card), findsNWidgets(3));
    todoIntegrationTestLogger.info('GET test finished');

    // POST TEST
    todoIntegrationTestLogger.info('POST test started');
    final addbutton = find.widgetWithText(FloatingActionButton, 'add');
    expect(addbutton, findsOneWidget);

    await tester.tap(addbutton);
    await tester.pumpAndSettle();
    todoIntegrationTestLogger.info('POST test finished');

    // PATCH TEST
    todoIntegrationTestLogger.info('PATCH test started');
    final text = 'test todo';
    final card = find.text(text);

    await tester.tap(card);
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);

    final firstTextField = find.byType(TextField).at(0);
    final secondTextField = find.byType(TextField).at(1);

    await tester.enterText(firstTextField, 'new test');
    await tester.enterText(secondTextField, 'new description');
    await tester.pumpAndSettle();

    final saveButton = find.widgetWithText(ElevatedButton, 'save');
    await tester.tap(saveButton);
    await tester.pumpAndSettle();

    final checkbox = find.byWidgetPredicate(
        (widget) => widget is Checkbox && widget.key == Key(alterationTodoID));
    todoIntegrationTestLogger.info('alterationTodoID: $alterationTodoID');

    await tester.tap(checkbox);
    await tester.pumpAndSettle();
    todoIntegrationTestLogger.info('PATCH test is finished');

    // DELETE TEST
    todoIntegrationTestLogger.info('DELETE test is started');
    final deleteButton = find.byWidgetPredicate(
        (widget) => widget is IconButton && widget.key == Key(deletionTodoID));
    todoIntegrationTestLogger.info('deletionTodoID: $deletionTodoID');

    expect(deleteButton, findsOneWidget);
    await tester.tap(deleteButton);
    await tester.pumpAndSettle();
    todoIntegrationTestLogger.info('DELETE test is finished');
  });
}
