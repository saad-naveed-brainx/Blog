import 'package:blog/views/layout.dart';
import 'package:flutter/material.dart';
import 'package:blog/models/user_model.dart';
import 'package:blog/views/create_article.dart';

class AppRouter {
  static void NavigatorToHomeScreen(BuildContext context, UserModel user) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LayoutView(user: user)),
      (route) => false,
    );
  }

  static void NavigatorToNewArticleScreen(BuildContext context, UserModel user) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewArticle(user: user)),
    );
  }
}
