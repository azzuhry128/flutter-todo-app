import 'package:flutter/material.dart';
import 'package:todo_app_ui_flutter/account/register_page.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: RegisterPage)
Widget buildCoolButtonUseCase(BuildContext context) {
  return RegisterPage();
}
