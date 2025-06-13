import 'package:flutter/material.dart';
import 'package:blog/data/repositories/local/user_repository.dart';
import 'package:blog/models/user_model.dart';

class SignUpViewModel {
  Future<UserModel> createUser(
    String username,
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      final user = await UserRepository().createUser(username, email, password);
      return user;
    } catch (e) {
      throw Exception('Error creating user');
    }
  }

  signUpWithGoogle(BuildContext context) async {
    await UserRepository().signUpWithGoogle();
    
  }
}