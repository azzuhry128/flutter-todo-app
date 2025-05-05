import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtils extends StatelessWidget {
  const ToastUtils({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }

  static void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.BOTTOM, // Toast position
      backgroundColor: Colors.grey, // Background color
      textColor: Colors.white, // Text color
      fontSize: 16.0,
    );
  }
}
