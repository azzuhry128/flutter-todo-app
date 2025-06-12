import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'dart:convert';

import 'package:todo_app_ui_flutter/account/account_model.dart';

final Logger serviceLogger = Logger("AccountService");
final String baseURL = dotenv.env['EMULATOR'] ?? '';

class AccountService {
  static Future<bool> registerAccount(AccountRegistrationModel account) async {
    serviceLogger.info('baseURL: $baseURL');
    serviceLogger.info('body: ${jsonEncode(account.toJson())}');
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

  static Future editAccount(AccountEditModel account, accountID) async {
  serviceLogger.info('baseURL: $baseURL');
  try {
    final response = await http.put(
      Uri.parse('$baseURL/api/accounts/edit/$accountID'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(account.toJson()),
    );

    serviceLogger.info(
        "Status Code: ${response.statusCode} Response: ${response.body}");
    return response.body;
  } catch (e) {
    serviceLogger.severe("Error: $e");
    return false;
  }
}
}
