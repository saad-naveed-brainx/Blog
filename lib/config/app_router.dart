import 'package:flutter/material.dart';
import 'package:blog/views/home.dart';
import 'package:blog/models/user_model.dart';

class AppRouter {
  static void NavigatorToHomeScreen(BuildContext context, UserModel user) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomeView(user: user)),
      (route) => false,
    );
  }
}
