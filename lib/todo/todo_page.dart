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
  bool _isLoading = true;
  final List<TodoItemModel> _todoItems = [];

  @override
  void initState() {
    super.initState();
    _fetchTodos();
  }

  Future _fetchTodos() async {
    todoLogger.info('fetching todos');
    final account = await AccountStore().getAccount();
    todoLogger.info('account id: ${account['account_id']}');

    final GetTodoModel todo = GetTodoModel(account_id: account['account_id']);
    final response = await TodoService.getTodo(todo);
  }

  void _deleteTodoItem(int index) {
    setState(() {
      _todoItems.removeAt(index);
    });
  }

  void _toggleDone(int index) {
    setState(() {
      /// Removes a todo item from the list at the given index.
      ///
      /// This should only be called from within the TodoPage widget tree.
      ///
      /// [index] The index of the todo item to remove.
      _todoItems[index].status = !_todoItems[index].status;
    });
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
      floatingActionButton: addTodoButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Expanded todoList() {
    return Expanded(
      child: Consumer<TodoStore>(
        builder: (context, TodoStore, child) {
          if (TodoStore.todos.isEmpty) {
            return const Center(
              child: Text('no todos yet'),
            );
          }
          return ListView.builder(
            // REMOVE SingleChildScrollView
            itemCount: TodoStore.todos.length,
            itemBuilder: (context, index) {
              final todoItem = TodoStore.todos[index];
              return TodoCard(
                todoItem: todoItem,
                onDelete: () => _deleteTodoItem(index),
                onToggleDone: () => _toggleDone(index),
              );
            },
          );
        },
      ),
    );
  }
}

FloatingActionButton addTodoButton(BuildContext context) {
  final todo = TodoItemModel(
      title: 'test todo', description: 'test description', status: false);

  return FloatingActionButton.extended(
    onPressed: () {
      Provider.of<TodoStore>(context, listen: false).addTodo(todo);
    },
    label: const Text('add'),
    icon: const Icon(
      Icons.add,
      size: 24.0,
    ),
  );
}

Container accountBar() {
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
            backgroundImage: NetworkImage(
                'https://via.placeholder.com/100'), // Replace with your image URL
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
