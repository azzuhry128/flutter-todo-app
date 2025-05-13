import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:todo_app_ui_flutter/todo/todo_model.dart';

final Logger todoServiceLogger = Logger("TodoServiceLogger");
final String baseURL = 'http://localhost:3000';

class TodoService {
  static Future<bool> getTodo(GetTodoModel todo) async {
    todoServiceLogger.info('baseURL: $baseURL');
    todoServiceLogger.info('body: ${jsonEncode(todo.toJson())}');

    try {
      final response = await http.get(
          Uri.parse('$baseURL/api/todos/get/${jsonEncode(todo.toJson())}'));

      if (response.statusCode == 200) {
        return true;
      }

      todoServiceLogger.info(
          "Status Code: ${response.statusCode} Response: ${response.body}");
      return false;
    } catch (e) {
      todoServiceLogger.severe("Error: $e");
      return false;
    }
  }

  static Future<bool> createTodo(CreateTodoModel todo, account_id) async {
    todoServiceLogger.info('destination: $baseURL');
    todoServiceLogger.info('account_id: $account_id');
    todoServiceLogger.info('body: ${jsonEncode(todo.toJson())}');

    try {
      final response = await http.post(
          Uri.parse('$baseURL/api/todos/create/$account_id'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(todo.toJson()));

      if (response.statusCode == 200) {
        return true;
      }

      todoServiceLogger.info(
          "Status Code: ${response.statusCode} Response: ${response.body}");
      return false;
    } catch (e) {
      todoServiceLogger.severe("Error: $e");
      return false;
    }
  }

  static Future<bool> updateTodo(UpdateTodoModel todo, todo_id) async {
    todoServiceLogger.info('destination: $baseURL');
    todoServiceLogger.info('todo_id: $todo_id');
    todoServiceLogger.info('body: ${jsonEncode(todo.toJson())}');

    try {
      final response = await http.patch(
          Uri.parse('$baseURL/api/todos/update/$todo_id'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(todo.toJson()));

      if (response.statusCode == 200) {
        return true;
      }

      todoServiceLogger.info(
          "Status Code: ${response.statusCode} Response: ${response.body}");
      return false;
    } catch (e) {
      todoServiceLogger.severe("Error: $e");
      return false;
    }
  }

  static Future<bool> deletetodo(todo_id) async {
    todoServiceLogger.info('destination: $baseURL');
    todoServiceLogger.info('todo_id: $todo_id');

    try {
      final response =
          await http.delete(Uri.parse('$baseURL/api/todos/delete/$todo_id'));

      if (response.statusCode == 200) {
        return true;
      }

      todoServiceLogger.info(
          "Status Code: ${response.statusCode} Response: ${response.body}");
      return false;
    } catch (e) {
      todoServiceLogger.severe("Error: $e");
      return false;
    }
  }
}
