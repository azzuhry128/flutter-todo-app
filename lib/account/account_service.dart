import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'dart:convert';

import 'package:todo_app_ui_flutter/account/account_model.dart';

final Logger serviceLogger = Logger("RegisterService");

class AccountService {
  static Future<bool> registerAccount(AccountRegistrationModel account) async {
    try {
      final response = await http.post(
          Uri.parse('$baseURL/api/account/register'),
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

  static final String? baseURL = dotenv.env['BASE_URL'];

  static Future<bool> loginAccount(AccountLoginModel account) async {
    try {
      final response = await http.post(Uri.parse('$baseURL/api/account/login'),
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
}
