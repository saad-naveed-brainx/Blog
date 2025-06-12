import 'package:blog/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:blog/core/constants/app_constants.dart';
import 'package:blog/config/theme/dark.dart';
import 'package:blog/core/constants/view_constants.dart';
import 'package:intl/intl.dart';
import 'package:blog/viewmodel/new_article_viewmodel.dart';

class NewArticle extends StatefulWidget {
  final UserModel user;
  const NewArticle({super.key, required this.user});
  @override
  State<NewArticle> createState() => _NewArticleState();
}

class _NewArticleState extends State<NewArticle> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  void _createArticle() {
    final newArticleViewModel = NewArticleViewModel();
    newArticleViewModel.createArticle(
      titleController.text,
      contentController.text,
      widget.user.id,
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DarkTheme.whiteColor,
      appBar: AppBar(
        backgroundColor: DarkTheme.whiteColor,
        actions: [
          IconButton(onPressed: _createArticle, icon: const Icon(Icons.save)),
        ],
      ),
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
                TextField(
                  controller: titleController,
                  style: TextStyle(
                    fontSize: AppConstants.font18Px,
                    fontWeight: FontWeight.w900,
                  ),
                  maxLines: null,
                  minLines: 1,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: ViewConstants.articleTitle,
                  ),
                ),
                const SizedBox(height: AppConstants.gap24Px),
                Text(
                  DateFormat('MMMM dd, yyyy').format(DateTime.now()),
                  style: TextStyle(
                    fontSize: AppConstants.font18Px,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: AppConstants.gap24Px),
                TextField(
                  controller: contentController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: ViewConstants.articleContent,
                  ),
                  style: TextStyle(
                    fontSize: AppConstants.font14Px,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: null,
                  minLines: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
