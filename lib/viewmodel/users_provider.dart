import 'package:flutter/material.dart';
import 'package:blog/models/user_model.dart';
import 'package:blog/data/repositories/local/user_repository.dart';

class UsersProvider extends ChangeNotifier {
  List<UserModel> users = [];

  UsersProvider() {
    getUsers();
  }

  Future<void> getUsers() async {
    users = await UserRepository().getUsers();
    notifyListeners();
  }
}
