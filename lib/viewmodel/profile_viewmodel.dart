import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:blog/data/repositories/local/blog_repository.dart';

class ProfileViewModel extends ChangeNotifier {
  final BlogRespository blogRepository;
  ProfileViewModel({required this.blogRepository});

  Stream<QuerySnapshot> getUserPersonalArticles(String userId) {
    return blogRepository.getUserPersonalArticles(userId);
  }
}
