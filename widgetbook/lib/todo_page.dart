import 'package:flutter/material.dart';
import 'package:todo_app_ui_flutter/todo/todo_page.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: TodoPage)
Widget buildCoolButtonUseCase(BuildContext context) {
  return TodoPage();
}
