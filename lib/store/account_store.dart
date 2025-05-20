import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Logger accountStoreLogger = Logger("AccountStore");

class AccountStore with ChangeNotifier {
  static final AccountStore _instance = AccountStore._internal();
  factory AccountStore() => _instance;
  static AccountStore get instance => _instance;
  AccountStore._internal();

  Map<String, dynamic>? _account;
  static const _accountJsonKey = 'account_json';

  void setAccountState(account) async {
    accountStoreLogger.info('setting account state');
    _account = account;
    accountStoreLogger.info('current account state: $_account');
    notifyListeners();
  }

  getAccount() async {
    accountStoreLogger.info('available account state: $_account');
    return _account;
  }

  Future<void> saveAccountToSharedPreference() async {
    if (_account != null) {
      try {
        final prefs = await SharedPreferences.getInstance();
        final accountJson = json.encode(_account);
        await prefs.setString(_accountJsonKey, accountJson);
      } catch (e) {
        accountStoreLogger.info('Error saving account data: $e');
      }
    } else {
      accountStoreLogger
          .info("Warning: Account data is null. Nothing to save.");
    }
  }
}
