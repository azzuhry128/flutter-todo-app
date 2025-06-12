// dart format width=80
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:widgetbook/widgetbook.dart' as _i1;
import 'package:widgetbook_workspace/login_page.dart' as _i4;
import 'package:widgetbook_workspace/register_page.dart' as _i5;
import 'package:widgetbook_workspace/settings_page.dart' as _i2;
import 'package:widgetbook_workspace/todo_page.dart' as _i3;

final directories = <_i1.WidgetbookNode>[
  _i1.WidgetbookLeafComponent(
    name: 'SettingsPageMockup',
    useCase: _i1.WidgetbookUseCase(
      name: 'Default',
      builder: _i2.buildCoolButtonUseCase,
    ),
  ),
  _i1.WidgetbookLeafComponent(
    name: 'TodoPageMockup',
    useCase: _i1.WidgetbookUseCase(
      name: 'Default',
      builder: _i3.buildCoolButtonUseCase,
    ),
  ),
  _i1.WidgetbookFolder(
    name: 'account',
    children: [
      _i1.WidgetbookLeafComponent(
        name: 'LoginPage',
        useCase: _i1.WidgetbookUseCase(
          name: 'Default',
          builder: _i4.buildCoolButtonUseCase,
        ),
      ),
      _i1.WidgetbookLeafComponent(
        name: 'RegisterPage',
        useCase: _i1.WidgetbookUseCase(
          name: 'Default',
          builder: _i5.buildCoolButtonUseCase,
        ),
      ),
    ],
  ),
];
