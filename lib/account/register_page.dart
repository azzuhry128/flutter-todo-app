// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:todo_app_ui_flutter/account/account_model.dart';
import 'package:todo_app_ui_flutter/account/account_service.dart';
import 'package:todo_app_ui_flutter/account/account_validator.dart';
import 'package:todo_app_ui_flutter/utils/gradient_backgroud.dart';

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
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  formFields(),
                  SizedBox(height: 24),
                  registerButton(),
                  SizedBox(height: 12),
                  redirectButton(context),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Form formFields() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Text(
              'create your account'.toUpperCase(),
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
              'fill the forms below to create your account',
              style: TextStyle(fontSize: 12),
            ),
          ),
          SizedBox(height: 20),
          Semantics(
            label: "Username",
            child: TextFormField(
              key: const Key('Username'),
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigo),
                    borderRadius: BorderRadius.circular(16)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigo),
                    borderRadius: BorderRadius.circular(16)),
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
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigo),
                    borderRadius: BorderRadius.circular(16)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigo),
                    borderRadius: BorderRadius.circular(16)),
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
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigo),
                    borderRadius: BorderRadius.circular(16)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigo),
                    borderRadius: BorderRadius.circular(16)),
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
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigo),
                    borderRadius: BorderRadius.circular(16)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigo),
                    borderRadius: BorderRadius.circular(16)),
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
      key: const Key('RegisterButton'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.indigo,
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
      style: ButtonStyle(
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        backgroundColor: WidgetStatePropertyAll(Colors.transparent),
      ),
      child: Text("already have an account? Sign in",
          style: TextStyle(
              color: Colors.indigo.shade900,
              fontSize: 14,
              fontWeight: FontWeight.bold)),
    );
  }
}
