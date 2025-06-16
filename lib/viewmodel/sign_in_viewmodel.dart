import 'package:flutter/material.dart';
import 'package:blog/data/repositories/local/user_repository.dart';
import 'package:blog/models/user_model.dart';
import 'package:blog/data/repositories/local/blog_repository.dart';

class SignInViewModel {
  final BlogRespository _blogRepository = BlogRespository();
  Future<UserModel> signIn(String email, String password) async {
    try {
      final user = await UserRepository().signIn(email, password);
      if (user.id.isNotEmpty) {
        return user;
      } else {
        throw Exception('User not found view model');
      }
    } catch (e) {
      throw Exception('Error signing in view model');
    }
  }

  signInWithGoogle(BuildContext context) async {
    await UserRepository().signInWithGoogle();
  }

  
}
