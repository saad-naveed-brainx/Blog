import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:blog/data/repositories/local/blog_repository.dart';
import 'package:blog/models/blog_model.dart';


class ProfileViewModel extends ChangeNotifier {
  final BlogRespository blogRepository = BlogRespository();

  Stream<QuerySnapshot> getUserPersonalArticles(String userId) {
    return blogRepository.getUserPersonalArticles(userId);
  }

  Future<void> deleteArticle(String articleID) async {
    await blogRepository.deleteArticle(articleID);
  }

  
}
