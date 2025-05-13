import 'package:flutter/material.dart';

class AccountStore with ChangeNotifier {
  String? _account_id;
  String? get account_id => _account_id;
  void setAccountId(String account_id) {
    _account_id = account_id;
    notifyListeners();
  }

  void clearAccount() {
    _account_id = null;
    notifyListeners();
  }
}
