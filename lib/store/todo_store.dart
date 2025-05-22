import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:todo_app_ui_flutter/todo/todo_model.dart';

final Logger todoStoreLogger = Logger("TodoStore");

class TodoStore extends ChangeNotifier {
  // Singleton instance
  static final TodoStore _instance = TodoStore._internal();
  factory TodoStore() => _instance;
  TodoStore._internal(); // Private constructor

  List<TodoItemModel> _todos = [];

  List<TodoItemModel> get todos => _todos;

  void setTodos(List<TodoItemModel> newTodos) {
    todoStoreLogger.info('setting todos');
    _todos = newTodos;
    todoStoreLogger.info('current todos: $_todos');
    notifyListeners(); // Notify widgets that are listening for changes
  }

  void addTodo(TodoItemModel todo) {
    _todos.add(todo);
    notifyListeners();
  }

  void editTodo(String todoID, String newTitle, String newDescription) {
    for (var todo in _todos) {
      if (todo.todo_id == todoID) {
        todo.title = newTitle;
        todo.description = newDescription;
        break;
      }
    }
    notifyListeners();
  }

  void statusTodo(String todoID) {
    for (var todo in _todos) {
      if (todo.todo_id == todoID) {
        todo.status = !todo.status;
        break;
      }
    }
    notifyListeners();
  }

  void deleteTodo(int index) {
    todoStoreLogger.info('Current todos: $todos');
    todoStoreLogger.warning('Attempting to delete index: $index');

    if (index >= 0 && index < _todos.length) {
      _todos.removeAt(index);
    }
    notifyListeners();
  }
}
