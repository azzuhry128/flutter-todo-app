import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'dart:convert';

import 'package:todo_app_ui_flutter/account/account_model.dart';
import 'package:todo_app_ui_flutter/todo/todo_model.dart';

final Logger serviceLogger = Logger("RegisterService");
final String baseURL = 'http://localhost:3000';

class TestTodoService {
  static Future<bool> getTodo(AccountLoginModel account, account_id) async {
    serviceLogger.info('baseURL: $baseURL');
    try {
      final response = await http.post(
        Uri.parse('$baseURL/api/todo/get/$account_id'),
        headers: {'Content-Type': 'application/json'},
      );

      serviceLogger.info(
          "Status Code: ${response.statusCode} Response: ${response.body}");
      return response.statusCode == 200;
    } catch (e) {
      serviceLogger.severe("Error: $e");
      return false;
    }
  }

  static Future<bool> createTodo(CreateTodoModel todo, account_id) async {
    serviceLogger.info('baseURL: $baseURL');
    try {
      final response = await http.patch(
          Uri.parse(
              '$baseURL/api/todos/create/$account_id'), //  Corrected URL for updating version
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(todo.toJson()) //  Send the new version in the body
          );

      serviceLogger.info(
          "Status Code: ${response.statusCode} Response: ${response.body}");
      //  Consider 200 OK or 204 No Content for a successful update
      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      serviceLogger.severe("Error: $e");
      return false;
    }
  }

  static Future<bool> updateTodo(CreateTodoModel todo, todo_id) async {
    serviceLogger.info('baseURL: $baseURL');
    try {
      final response = await http.delete(
          Uri.parse('$baseURL/api/todos/update/$todo_id'), // Corrected URL
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(todo.toJson()) // Added content type
          );

      serviceLogger.info(
          "Status Code: ${response.statusCode} Response: ${response.body}");
      return response.statusCode ==
          200; // Or 204 No Content, depending on your API
    } catch (e) {
      serviceLogger.severe("Error: $e");
      return false;
    }
  }

  static Future<bool> deleteTodo(todo_id) async {
    serviceLogger.info('baseURL: $baseURL');
    try {
      final response = await http.delete(
        Uri.parse('$baseURL/api/todos/delete/$todo_id'), // Corrected URL
        headers: {'Content-Type': 'application/json'}, // Added content type
      );

      serviceLogger.info(
          "Status Code: ${response.statusCode} Response: ${response.body}");
      return response.statusCode ==
          200; // Or 204 No Content, depending on your API
    } catch (e) {
      serviceLogger.severe("Error: $e");
      return false;
    }
  }
}
