import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'dart:convert';

import 'package:todo_app_ui_flutter/account/account_model.dart';
import 'package:todo_app_ui_flutter/todo/todo_model.dart';

final Logger serviceLogger = Logger("IntegrationService");
final String baseURL = 'http://10.0.2.2:3000';

class IntegrationService {
  static Future registerAccount(AccountRegistrationModel account) async {
    serviceLogger.info('baseURL: $baseURL');
    serviceLogger.info('body: ${jsonEncode(account.toJson())}');
    try {
      final response = await http.post(
          Uri.parse('$baseURL/api/accounts/register'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(account.toJson()));

      if (response.statusCode == 200) {
        return response;
      }

      serviceLogger.info(
          "Status Code: ${response.statusCode} Response: ${response.body}");
      return false;
    } catch (e) {
      serviceLogger.severe("Error: $e");
      return false;
    }
  }

  static Future loginAccount(AccountLoginModel account) async {
    serviceLogger.info('baseURL: $baseURL');
    try {
      final response = await http.post(Uri.parse('$baseURL/api/accounts/login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(account.toJson()));

      serviceLogger.info(
          "Status Code: ${response.statusCode} Response: ${response.body}");
      return response.body;
    } catch (e) {
      serviceLogger.severe("Error: $e");
      return false;
    }
  }

  static Future deleteAccount() async {
    serviceLogger.info('baseURL: $baseURL');
    final username = 'username123'; // Replace with the actual username
    try {
      final response = await http.delete(
        Uri.parse('$baseURL/api/accounts/delete/$username'), // Corrected URL
        headers: {'Content-Type': 'application/json'}, // Added content type
      );

      serviceLogger.info(
          "Status Code: ${response.statusCode} Response: ${response.body}");
      return response.statusCode == 200;
    } catch (e) {
      serviceLogger.severe("Error: $e");
      return false;
    }
  }

  static Future getTodo(AccountLoginModel account, account_id) async {
    serviceLogger.info('baseURL: $baseURL');
    try {
      final response = await http.post(
        Uri.parse('$baseURL/api/todo/get/$account_id'),
        headers: {'Content-Type': 'application/json'},
      );

      serviceLogger.info(
          "Status Code: ${response.statusCode} Response: ${response.body}");
      return response;
    } catch (e) {
      serviceLogger.severe("Error: $e");
      return false;
    }
  }

  static Future createTodo(CreateTodoModel todo, account_id) async {
    serviceLogger.info('todo body: $todo');
    serviceLogger.info('account_id: $account_id');
    try {
      final response = await http.post(
          Uri.parse('$baseURL/api/todos/create/$account_id'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(todo.toJson()));

      serviceLogger.info(
          "Status Code: ${response.statusCode} Response: ${response.body}");
      return response;
    } catch (e) {
      serviceLogger.severe("Error: $e");
      return false;
    }
  }

  static Future updateTodo(UpdateTodoModel todo, todo_id) async {
    serviceLogger.info('baseURL: $baseURL');
    try {
      final response = await http.delete(
          Uri.parse('$baseURL/api/todos/update/$todo_id'), // Corrected URL
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(todo.toJson()) // Added content type
          );

      serviceLogger.info(
          "Status Code: ${response.statusCode} Response: ${response.body}");
      return response;
    } catch (e) {
      serviceLogger.severe("Error: $e");
      return false;
    }
  }

  static Future deleteTodo(todo_id) async {
    serviceLogger.info('baseURL: $baseURL');
    try {
      final response = await http.delete(
        Uri.parse('$baseURL/api/todos/delete/$todo_id'), // Corrected URL
        headers: {'Content-Type': 'application/json'}, // Added content type
      );

      serviceLogger.info(
          "Status Code: ${response.statusCode} Response: ${response.body}");
      return response;
    } catch (e) {
      serviceLogger.severe("Error: $e");
      return false;
    }
  }

  static Future deleteAlltodo() async {
    serviceLogger.warning('deleting all todos');

    try {
      final response =
          await http.delete(Uri.parse('$baseURL/api/todos/delete'));

      if (response.statusCode == 200) {
        return true;
      }

      serviceLogger.info(
          "Status Code: ${response.statusCode} Response: ${response.body}");
      return false;
    } catch (e) {
      serviceLogger.severe("Error: $e");
      return false;
    }
  }
}
