import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:blog/data/repositories/local/blog_repository.dart';

class NewArticleViewModel {
  final BlogRespository _blogRepository = BlogRespository();

  Future<void> createArticle(
    String title,
    String content,
    String user_id,
  ) async {
    try {
      await _blogRepository.saveArticleToFirebase(
        title: title,
        content: content,
        user_id: user_id,
        timestamp: Timestamp.now(),
      );
    } catch (e) {
      throw Exception('Error creating article: $e');
    }
  }
}
