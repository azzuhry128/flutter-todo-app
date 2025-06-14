// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_ui_flutter/account/settings_page.dart';
import 'package:todo_app_ui_flutter/store/account_store.dart';
import 'package:todo_app_ui_flutter/account/login_page.dart';
import 'package:todo_app_ui_flutter/account/register_page.dart';
import 'package:todo_app_ui_flutter/store/todo_store.dart';
import 'package:todo_app_ui_flutter/todo/todo_page.dart';

Future<void> configureEnvironment() async {
  String envFile = '.env';
  await dotenv.load(fileName: envFile);
  print("Loaded ENV file: $envFile");

  print("Loaded Environment Variables:");
  dotenv.env.forEach((key, value) {
    print("$key: $value");
  });

  String? baseURL;

  if (dotenv.env['TEST_ENV'] == 'ANDROID') {
    baseURL = dotenv.env['ANDROID'] ?? 'https://default.android.url';
  } else if (dotenv.env['TEST_ENV'] == 'EMULATOR') {
    baseURL = dotenv.env['EMULATOR'] ?? 'http://10.0.2.2:3000';
  } else if (dotenv.env['TEST_ENV'] == 'PRODUCTION') {
    baseURL = dotenv.env['PRODUCTION'] ?? 'https://default.production.url';
  }

  print("Base URL: $baseURL");
}

void loggingConfig() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print(
        '${record.level.name}: ${record.time}: ${record.loggerName}: ${record.message}');
  });
}

void main() async {
  await configureEnvironment();
  loggingConfig();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => AccountStore(),
      ),
      ChangeNotifierProvider(
        create: (context) => TodoStore(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/main': (context) => TodoPage(),
        '/settings': (context) => SettingsPage(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}
