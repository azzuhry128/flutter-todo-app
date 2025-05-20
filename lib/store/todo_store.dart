import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:todo_app_ui_flutter/todo/todo_model.dart';

final Logger todoStoreLogger = Logger("TodoStore");

class TodoStore extends ChangeNotifier {
  final List<TodoItemModel> _todos = [];

  List<TodoItemModel> get todos => _todos;

  void addTodo(TodoItemModel todo) {
    _todos.add(todo);
    notifyListeners();
  }

  void deleteTodo(int index) {
    _todos.removeAt(index);
    notifyListeners();
  }
}
