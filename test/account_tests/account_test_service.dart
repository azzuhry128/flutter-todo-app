import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'dart:convert';

import 'package:todo_app_ui_flutter/account/account_model.dart';

final Logger serviceLogger = Logger("RegisterServiceTest");
final String baseURL = 'http://localhost:3000';

class AccountTestService {
  static Future<bool> getAccount() async {
    serviceLogger.info('baseURL: $baseURL');
    try {
      final response = await http.get(Uri.parse('$baseURL/api/accounts'));

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

  static Future<bool> registerAccount(AccountRegistrationModel account) async {
    serviceLogger.info('baseURL: $baseURL');

    serviceLogger.info('package: ${jsonEncode(account.toJson())}');
    try {
      final response = await http.post(
          Uri.parse('$baseURL/api/accounts/register'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(account.toJson()));

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

  static Future<bool> loginAccount(AccountLoginModel account) async {
    serviceLogger.info('baseURL: $baseURL');
    final account = AccountLoginModel(
        email_address: 'test123@gmail.com', password: 'test123456789');
    try {
      final response = await http.post(Uri.parse('$baseURL/api/accounts/login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(account.toJson()));

      serviceLogger.info(
          "Status Code: ${response.statusCode} Response: ${response.body}");
      return response.statusCode == 200;
    } catch (e) {
      serviceLogger.severe("Error: $e");
      return false;
    }
  }

  static Future<bool> deleteAccount() async {
    serviceLogger.info('baseURL: $baseURL');
    final username = 'username123'; // Replace with the actual username
    try {
      final response = await http.delete(
        Uri.parse('$baseURL/api/accounts/delete/$username'), // Corrected URL
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
