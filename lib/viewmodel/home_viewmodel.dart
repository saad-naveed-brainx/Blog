import 'package:flutter/material.dart';
import 'package:blog/models/user_model.dart';
import 'package:blog/data/repositories/local/blog_repository.dart';
import 'package:blog/data/repositories/local/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeViewModel extends ChangeNotifier {
  List<UserModel> users = [];
  final BlogRespository blogRespository = BlogRespository();

  HomeViewModel() {
    getUsers();
  }

  Future<void> getUsers() async {
    users = await UserRepository().getUsers();
    notifyListeners();
  }

  Stream<QuerySnapshot> getArticles() {
    debugPrint('getArticles');
    return blogRespository.getRecentArticles();
  }
}
