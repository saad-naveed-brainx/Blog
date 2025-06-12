import 'package:cloud_firestore/cloud_firestore.dart';

class BlogModel {
  final String? id;
  final String title;
  final String content;
  final String user_id;
  final Timestamp timestamp;

  BlogModel({
    this.id,
    required this.title,
    required this.content,
    required this.user_id,
    required this.timestamp,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'] as String?,
      title: json['title'] as String,
      content: json['content'] as String,
      user_id: json['user_id'] as String,
      timestamp: json['timestamp'] as Timestamp,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'content': content,
      'user_id': user_id,
      'timestamp': timestamp,
    };
  }
}
