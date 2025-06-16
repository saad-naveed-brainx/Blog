import 'package:flutter/material.dart';
import 'package:blog/models/blog_model.dart';
import 'package:blog/config/theme/dark.dart';
import 'package:blog/core/constants/app_constants.dart';
import 'package:intl/intl.dart';

class DetailViewArticle extends StatelessWidget {
  const DetailViewArticle({super.key, required this.article});
  final BlogModel article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DarkTheme.whiteColor,
      appBar: AppBar(backgroundColor: DarkTheme.whiteColor),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.gap16Px,
              vertical: AppConstants.gap18Px,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.title,
                  style: TextStyle(
                    fontSize: AppConstants.font18Px * 2,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: AppConstants.gap24Px),
                Text(
                  DateFormat(
                    'MMMM dd, yyyy',
                  ).format(article.timestamp.toDate()),
                  style: TextStyle(
                    fontSize: AppConstants.font18Px,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: AppConstants.gap24Px),
                Text(
                  article.content,
                  style: TextStyle(
                    fontSize: AppConstants.font14Px * 2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
