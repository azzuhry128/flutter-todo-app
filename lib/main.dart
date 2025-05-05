// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:todo_app_ui_flutter/account/login_page.dart';
import 'package:todo_app_ui_flutter/account/register_page.dart';

Future<void> configureEnvironment() async {
  String envFile = '.env.emulator';
  await dotenv.load(fileName: envFile);
  print("Loaded ENV file: $envFile");
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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage()
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}
