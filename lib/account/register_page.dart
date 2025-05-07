// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:todo_app_ui_flutter/account/account_model.dart';
import 'package:todo_app_ui_flutter/account/account_service.dart';
import 'package:todo_app_ui_flutter/account/account_validator.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final Logger registerLogger = Logger('REGISTER_PAGE');

  Future<bool> registerAccount() async {
    final AccountRegistrationModel newAccount = AccountRegistrationModel(
        username: usernameController.text,
        email_address: emailController.text,
        phone_number: phoneController.text,
        password: passwordController.text);

    final bool result = await AccountService.registerAccount(newAccount);

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                formFields(),
                SizedBox(height: 20),
                registerButton(),
                SizedBox(height: 15),
                redirectButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Form formFields() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text(
            'Registration',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text('Create account to continue.', style: TextStyle(fontSize: 16)),
          SizedBox(height: 20),
          Semantics(
            label: "Username",
            child: TextFormField(
              key: const Key('Username'),
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                return RegistrationValidator.validateUsername(value);
              },
            ),
          ),
          SizedBox(height: 15),
          Semantics(
            label: "Email",
            child: TextFormField(
              key: const Key('Email'),
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                return RegistrationValidator.validateEmail(value);
              },
            ),
          ),
          SizedBox(height: 15),
          Semantics(
            label: "Phone",
            child: TextFormField(
              key: const Key('Phone'),
              controller: phoneController,
              decoration: InputDecoration(
                labelText: 'Phone',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                return RegistrationValidator.validatePhone(value);
              },
            ),
          ),
          SizedBox(height: 15),
          Semantics(
            label: "Password",
            child: TextFormField(
              key: const Key('Password'),
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                return RegistrationValidator.validatePassword(value);
              },
            ),
          ),
        ],
      ),
    );
  }

  ElevatedButton registerButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        minimumSize: Size(double.infinity, 50),
      ),
      onPressed: () async {
        registerLogger.info('register button is pressed');
        if (_formKey.currentState!.validate()) {
          registerLogger.info('form is valid');

          final bool result = await registerAccount();

          if (result) {
            registerLogger.info('registration successful');
          } else {
            registerLogger.info('registration failed');
          }
        }
      },
      child: Text('Register', style: TextStyle(color: Colors.white)),
    );
  }

  TextButton redirectButton(context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pushReplacementNamed('/login');
      },
      child: Text("already have an account? Sign in",
          style: TextStyle(color: Colors.orange)),
    );
  }
}
