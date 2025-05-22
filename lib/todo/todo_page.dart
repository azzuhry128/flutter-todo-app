import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_ui_flutter/store/account_store.dart';
import 'package:todo_app_ui_flutter/store/todo_store.dart';
import 'package:todo_app_ui_flutter/todo/todo_model.dart';
import 'package:todo_app_ui_flutter/todo/todo_service.dart';
import 'package:todo_app_ui_flutter/todo/widgets/todo_card.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final Logger todoLogger = Logger('TODO_PAGE');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchTodos();
    });
  }

  Future _fetchTodos() async {
    todoLogger.info('fetching todos');
    final account = await AccountStore().getAccount();
    // request formatting
    final GetTodoModel todo = GetTodoModel(account_id: account['account_id']);
    final response = await TodoService.getTodo(todo);
    final decodedResponse = jsonDecode(response);
    final data = decodedResponse['data'];
    // converting data to suit TodoItemModel
    List<TodoItemModel> todoItems =
        (data as List).map((item) => TodoItemModel.fromJson(item)).toList();
    // inserting todos into todo store
    final todoStore = Provider.of<TodoStore>(context, listen: false);
    todoStore.setTodos(todoItems);
  }

  Future _addTodo() async {
    todoLogger.info('adding todo');
    final account = await AccountStore().getAccount();

    final todoStore = Provider.of<TodoStore>(context, listen: false);

    final CreateTodoModel todo =
        CreateTodoModel(title: 'test todo', description: 'test description');

    final response = await TodoService.createTodo(todo, account['account_id']);
    final decodedResponse = jsonDecode(response);

    final todoItem = TodoItemModel(
        todo_id: decodedResponse['data']['todo_id'],
        title: decodedResponse['data']['title'],
        description: decodedResponse['data']['description'],
        status: decodedResponse['data']['status']);

    todoStore.addTodo(todoItem);
    todoLogger.info('response: $response');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            accountBar(),
            const SizedBox(width: 16),
            todoList(),
          ],
        ),
      ),
      floatingActionButton: addTodoButton(onAdd: _addTodo),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Expanded todoList() {
    final Logger todoListLogger = Logger('TODO_LIST');
    return Expanded(
      child: Consumer<TodoStore>(
        builder: (context, TodoStore, child) {
          todoListLogger.info(
              'todo store content: ${TodoStore.todos.map((todo) => todo.toString()).toList()}');
          if (TodoStore.todos.isEmpty) {
            return const Center(
              child: Text('no todos yet'),
            );
          }
          return ListView.builder(
            itemCount: TodoStore.todos.length,
            itemBuilder: (context, index) {
              final todoItem = TodoStore.todos[index];
              return TodoCard(
                index: index,
                todoItem: todoItem,
              );
            },
          );
        },
      ),
    );
  }
}

FloatingActionButton addTodoButton({required onAdd}) {
  return FloatingActionButton.extended(
    onPressed: onAdd,
    label: const Text('add'),
    icon: const Icon(
      Icons.add,
      size: 24.0,
    ),
  );
}

Container accountBar() {
  final Logger accountBarLogger = Logger('ACCOUNT_BAR');
  accountBarLogger.info('rendering account bar');
  return Container(
    height: 96,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(28.0),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 1,
          child: const CircleAvatar(
            radius: 32, // Adjust as needed
            backgroundColor: Colors.amberAccent,
          ),
        ),
        Flexible(
          flex: 3,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Good morning!',
                  style: TextStyle(
                    color: Colors.indigo,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
                Text(
                  'Muhammad Azzuhry', //replace
                  style: TextStyle(
                    color: Colors.indigo,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: IconButton(
            onPressed: () {
              // Handle settings button press
              print('Settings button pressed');
            },
            icon: const Icon(
              Icons.settings,
              size: 28,
            ),
            color: Colors.indigo,
          ),
        ),
      ],
    ),
  );
}
