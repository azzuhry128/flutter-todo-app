import 'package:flutter/material.dart';
import 'package:todo_app_ui_flutter/account/account_model.dart';
import 'package:todo_app_ui_flutter/account/account_service.dart';
import 'package:todo_app_ui_flutter/account/account_validator.dart';
import 'package:todo_app_ui_flutter/utils/toast_utils.dart';

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

  Future<void> registerAccount() async {
    final AccountRegistrationModel newAccount = AccountRegistrationModel(
        username: usernameController.text,
        email_address: emailController.text,
        phone_number: phoneController.text,
        password: passwordController.text);

    final result = await AccountService.registerAccount(newAccount);

    if (result) {
      ToastUtils.showToast('registration is successful');
    } else {
      ToastUtils.showToast('registration failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
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
          TextFormField(
            controller: usernameController,
            decoration: InputDecoration(
              labelText: 'Username',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              final error = RegistrationValidator.validateUsername(value);
              if (error != null) {
                ToastUtils.showToast(error);
              }

              return error;
            },
          ),
          SizedBox(height: 15),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              final error = RegistrationValidator.validateEmail(value);
              if (error != null) {
                ToastUtils.showToast(error);
              }

              return error;
            },
          ),
          SizedBox(height: 15),
          TextFormField(
            controller: phoneController,
            decoration: InputDecoration(
              labelText: 'Phone',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              final error = RegistrationValidator.validatePhone(value);
              if (error != null) {
                ToastUtils.showToast(error);
              }

              return error;
            },
          ),
          SizedBox(height: 15),
          TextFormField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              final error = RegistrationValidator.validatePassword(value);
              if (error != null) {
                ToastUtils.showToast(error);
              }

              return error;
            },
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
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          ToastUtils.showToast("Form is valid");
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
