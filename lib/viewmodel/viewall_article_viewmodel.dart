import 'package:blog/data/repositories/local/blog_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewAllArticleViewModel {
  final BlogRespository _blogRepository = BlogRespository();

  Stream<QuerySnapshot> getArticles() {
    return _blogRepository.getArticles();
  }
}
