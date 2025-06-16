import 'package:blog/models/blog_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BlogRespository {
  Future<BlogModel> saveArticleToFirebase({
    required String title,
    required String content,
    required String user_id,
    required Timestamp timestamp,
  }) async {
    try {
      // Create a new document reference with auto-generated ID
      DocumentReference docRef =
          FirebaseFirestore.instance.collection('blogs').doc();

      // Create a new blog model with the auto-generated ID
      BlogModel blog = BlogModel(
        id: docRef.id,
        title: title,
        content: content,
        user_id: user_id,
        timestamp: timestamp,
      );

      // Save to Firestore
      await docRef.set(blog.toJson());
      debugPrint('Blog saved successfully with ID: ${docRef.id}');

      return blog;
    } catch (e) {
      debugPrint('Error saving blog: ${e.toString()}');
      throw Exception('Error saving blog');
    }
  }

  Stream<QuerySnapshot> getArticles() {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      Stream<QuerySnapshot> stream =
          firestore
              .collection('blogs')
              .orderBy('timestamp', descending: true)
              .snapshots();
      return stream;
    } catch (e) {
      debugPrint('Error getting articles: ${e.toString()}');
      throw Exception('Error getting articles');
    }
  }

  Stream<QuerySnapshot> getRecentArticles() {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final twelveHoursAgo = DateTime.now().subtract(const Duration(hours: 12));
    Stream<QuerySnapshot> stream =
        firestore
            .collection('blogs')
            .where(
              'timestamp',
              isGreaterThan: Timestamp.fromDate(twelveHoursAgo),
            )
            .orderBy('timestamp', descending: true)
            .snapshots();
    return stream;
  }

  Stream<QuerySnapshot> getUserPersonalArticles(String userId) {
    final firebasefirestore = FirebaseFirestore.instance;
    final stream =
        firebasefirestore
            .collection('blogs')
            .where('user_id', isEqualTo: userId)
            .orderBy('timestamp', descending: true)
            .snapshots();
    return stream;
  }

  Future<void> deleteArticle(String articleID) async {
    try {
      await FirebaseFirestore.instance
          .collection('blogs')
          .doc(articleID)
          .delete();
    } catch (e) {
      debugPrint('Error deleting article: ${e.toString()}');
      throw Exception('Error deleting article');
    }
  }

  Future<void> updateArticle(BlogModel updatedArticle) async {
    try {
      await FirebaseFirestore.instance
          .collection('blogs')
          .doc(updatedArticle.id)
          .update(updatedArticle as Map<String, dynamic>);
    } catch (e) {
      throw Exception('error updating the document');
    }
  }
}
