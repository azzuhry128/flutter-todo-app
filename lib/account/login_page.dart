import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:todo_app_ui_flutter/account/account_model.dart';
import 'package:todo_app_ui_flutter/account/account_service.dart';
import 'package:todo_app_ui_flutter/account/account_validator.dart';

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

  Future<bool> loginAccount() async {
    final AccountLoginModel account = AccountLoginModel(
        email_address: emailController.text, password: passwordController.text);

    final bool result = await AccountService.loginAccount(account);

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: formFields(context),
        ),
      ),
    );
  }

  Form formFields(BuildContext context) {
    return Form(
      key: _loginFormKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Login',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text('Please sign in to continue.', style: TextStyle(fontSize: 16)),
          SizedBox(height: 20),
          TextFormField(
            key: const Key('Email'),
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
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
              border: OutlineInputBorder(),
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
              style: TextStyle(color: Colors.orange),
            ),
          ),
          SizedBox(height: 20),
          loginButton(),
          SizedBox(height: 15),
          redirectButton(context),
        ],
      ),
    );
  }

  ElevatedButton loginButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        minimumSize: Size(double.infinity, 50),
      ),
      onPressed: () async {
        loginLogger.info('login button is pressed');
        if (_loginFormKey.currentState!.validate()) {
          loginLogger.info('form is valid');
        }
      },
      child: Text('Login', style: TextStyle(color: Colors.white)),
    );
  }

  TextButton redirectButton(context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pushNamed('/register');
      },
      child: Text("Don't have an account? Sign up",
          style: TextStyle(color: Colors.orange)),
    );
  }
}
