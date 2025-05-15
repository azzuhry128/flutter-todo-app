import 'package:flutter/material.dart';
import 'package:todo_app_ui_flutter/account/login_page.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: LoginPage)
Widget buildCoolButtonUseCase(BuildContext context) {
  return LoginPage();
}
