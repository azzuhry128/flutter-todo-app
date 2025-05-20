// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:todo_app_ui_flutter/account/account_model.dart';
import 'package:todo_app_ui_flutter/account/account_service.dart';
import 'package:todo_app_ui_flutter/account/account_validator.dart';
import 'package:todo_app_ui_flutter/store/account_store.dart';
import 'package:todo_app_ui_flutter/utils/gradient_backgroud.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginFormKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final Logger loginLogger = Logger('LOGIN_PAGE');

  Future loginAccount() async {
    final AccountLoginModel account = AccountLoginModel(
        email_address: emailController.text, password: passwordController.text);

    final response = await AccountService.loginAccount(account);
    final decodedResponse = jsonDecode(response);
    loginLogger.info('account_id: ${decodedResponse['data']['account_id']}');
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Stack(children: [
        GradientBackground(),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.75,
            decoration: BoxDecoration(
              // Added BoxDecoration
              color: Colors.white,
              borderRadius: BorderRadius.only(
                // Apply borderRadius here
                topLeft: Radius.circular(36.0), // Top-left radius
                topRight: Radius.circular(36.0), // Top-right radius
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  formFields(context),
                  SizedBox(height: 24),
                  loginButton(),
                  SizedBox(height: 12),
                  redirectButton(context)
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Form formFields(BuildContext context) {
    return Form(
      key: _loginFormKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              'login using account'.toUpperCase(),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.indigo, // Apply the indigo shade
              ),
            ),
          ),
          SizedBox(height: 4),
          Align(
            alignment: Alignment.center,
            child: Text(
              'please fill form below with correct data',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            key: const Key('Email'),
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.indigo),
                  borderRadius: BorderRadius.circular(16)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.indigo),
                  borderRadius: BorderRadius.circular(16)),
            ),
            validator: (value) {
              return LoginValidator.validateEmail(value);
            },
          ),
          SizedBox(height: 15),
          TextFormField(
            key: const Key('Password'),
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.indigo),
                  borderRadius: BorderRadius.circular(16)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.indigo),
                  borderRadius: BorderRadius.circular(16)),
            ),
            validator: (value) {
              return LoginValidator.validatePassword(value);
            },
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Forgot password?',
              style: TextStyle(
                  color: Colors.indigo,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  ElevatedButton loginButton() {
    return ElevatedButton(
      key: const Key('LoginButton'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.indigo,
        minimumSize: Size(double.infinity, 50),
      ),
      onPressed: () async {
        loginLogger.info('login button is pressed');
        if (_loginFormKey.currentState!.validate()) {
          loginLogger.info('form is valid');

          final response = await loginAccount();
          final decodedResponse = jsonDecode(response);
          loginLogger.info('decodedResponse: ${decodedResponse['data']}');
          AccountStore().setAccountState(decodedResponse['data']);
        }
      },
      child: Text('Login',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
    );
  }

  TextButton redirectButton(context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pushNamed('/register');
      },
      child: Text("Don't have an account? Sign up",
          style: TextStyle(
              color: Colors.indigo.shade900,
              fontSize: 14,
              fontWeight: FontWeight.bold)),
    );
  }
}
