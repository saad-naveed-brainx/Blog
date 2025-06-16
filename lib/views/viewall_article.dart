import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:blog/viewmodel/viewall_article_viewmodel.dart';
import 'package:blog/core/constants/app_constants.dart';
import 'package:blog/config/theme/dark.dart';
import 'package:blog/config/app_router.dart';
import 'package:blog/models/blog_model.dart';

class ViewAllArticle extends StatefulWidget {
  const ViewAllArticle({super.key});
  @override
  State<ViewAllArticle> createState() => _ViewAllArticleState();
}

class _ViewAllArticleState extends State<ViewAllArticle> {
  final ViewAllArticleViewModel viewAllArticleViewModel =
      ViewAllArticleViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: viewAllArticleViewModel.getArticles(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: DarkTheme.whiteColor,
                    ),
                  );
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No articles found'));
                }
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final doc = snapshot.data!.docs[index];
                      return GestureDetector(
                        onTap: () {
                          AppRouter.NavigatorToDetailViewArticleScreen(
                            context,
                            BlogModel.fromJson(
                              doc.data() as Map<String, dynamic>,
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppConstants.gap18Px,
                            vertical: AppConstants.gap12Px,
                          ),
                          child: Card(
                            elevation: AppConstants.gap8Px,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                AppConstants.gap12Px,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(
                                AppConstants.gap16Px,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    doc['title'] ?? 'No Title',
                                    style: TextStyle(
                                      fontSize: AppConstants.font18Px,
                                      fontWeight: FontWeight.bold,
                                      color: DarkTheme.blackColor,
                                    ),
                                  ),
                                  const SizedBox(height: AppConstants.gap4Px),
                                  Text(
                                    doc['content'].toString().length > 100
                                        ? '${doc['content'].toString().substring(0, 100)}...'
                                        : doc['content'].toString(),
                                    style: TextStyle(
                                      fontSize: AppConstants.font14Px,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
