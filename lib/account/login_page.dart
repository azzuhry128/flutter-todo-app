import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
        ),
        body: Center(
            child: Container(
          width: MediaQuery.of(context).size.width * 0.85, // Half screen width
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
              ),
              SizedBox(height: 10),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: "Password"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  print("logging in...");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Blue background
                  foregroundColor: Colors.black, // Black text
                  textStyle: const TextStyle(fontSize: 18), // Medium text size
                ),
                child: const Text("Login"),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(
                      context, "/register"); // Navigate to registration page
                },
                child: const Text("Register an Account?",
                    style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        )));
  }
}
