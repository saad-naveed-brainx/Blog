import 'package:blog/views/layout.dart';
import 'package:flutter/material.dart';
import 'package:blog/models/user_model.dart';
import 'package:blog/views/create_update_article.dart';
import 'package:blog/views/detail_view_article.dart';
import 'package:blog/models/blog_model.dart';

class AppRouter {
  static void NavigatorToHomeScreen(BuildContext context, UserModel user) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LayoutView(user: user)),
      (route) => false,
    );
  }

  static void NavigatorToNewArticleScreen(
    BuildContext context,
    UserModel user,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewArticle(user: user)),
    );
  }

  static void NavigatorToDetailViewArticleScreen(
    BuildContext context,
    BlogModel article,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailViewArticle(article: article),
      ),
    );
  }

  static void NavigatorToUpdateArticleScreen(
    BuildContext context,
    UserModel user,
    BlogModel data,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewArticle(user: user, blogModel: data),
      ),
    );
  }
}
