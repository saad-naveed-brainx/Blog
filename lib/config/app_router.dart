import 'package:flutter/material.dart';
import 'package:blog/views/home.dart';

class AppRouter {
  static void NavigatorToHomeScreen(
    TextEditingController emailController,
    TextEditingController passwordController,
    BuildContext context,
  ) {
    if (emailController.text != '' && passwordController.text != '') {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeView()),
        (route) => false,
      );
    }
  }
}
