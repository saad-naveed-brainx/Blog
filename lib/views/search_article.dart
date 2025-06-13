import 'package:flutter/material.dart';
import 'package:blog/core/constants/app_constants.dart';
import 'package:blog/config/theme/dark.dart';
import 'package:blog/viewmodel/viewall_article_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:blog/core/constants/view_constants.dart';

class SearchArticle extends StatefulWidget {
  const SearchArticle({super.key});

  @override
  State<SearchArticle> createState() => _SearchArticleState();
}

class _SearchArticleState extends State<SearchArticle> {
  final TextEditingController searchController = TextEditingController();
  String searchQuery = '';
  final ViewAllArticleViewModel viewAllArticleViewModel =
      ViewAllArticleViewModel();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(AppConstants.gap16Px),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: DarkTheme.blackColor,
                    spreadRadius: AppConstants.gap2Px,
                    blurRadius: AppConstants.gap4Px,
                  ),
                ],
              ),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    searchQuery = value.toLowerCase();
                  });
                },
                decoration: InputDecoration(
                  hintText: ViewConstants.searchArticles,
                  prefixIcon: const Icon(
                    Icons.search,
                    color: DarkTheme.blackColor,
                  ),
                  suffixIcon:
                      searchQuery.isNotEmpty
                          ? IconButton(
                            icon: const Icon(
                              Icons.clear,
                              color: DarkTheme.blackColor,
                            ),
                            onPressed: () {
                              searchController.clear();
                              setState(() {
                                searchQuery = '';
                              });
                            },
                          )
                          : null,
                  filled: true,
                  fillColor: DarkTheme.whiteColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppConstants.gap12Px),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.gap16Px,
                    vertical: AppConstants.gap12Px,
                  ),
                ),
              ),
            ),
            // Search Results
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
                    return const Center(
                      child: Text(
                        ViewConstants.noArticlesFound,
                        style: TextStyle(
                          color: DarkTheme.whiteColor,
                          fontSize: AppConstants.font16Px,
                        ),
                      ),
                    );
                  }

                  // Filter articles based on search query
                  final filteredDocs =
                      snapshot.data!.docs.where((doc) {
                        final title = doc['title'].toString().toLowerCase();
                        final content = doc['content'].toString().toLowerCase();
                        return title.contains(searchQuery) ||
                            content.contains(searchQuery);
                      }).toList();

                  if (filteredDocs.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: AppConstants.font24Px * 2,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: AppConstants.gap16Px),
                          Text(
                            ViewConstants.noResultsFoundFor + ' "$searchQuery"',
                            style: TextStyle(
                              color: DarkTheme.greyColor,
                              fontSize: AppConstants.font16Px,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(AppConstants.gap16Px),
                    itemCount: filteredDocs.length,
                    itemBuilder: (context, index) {
                      final doc = filteredDocs[index];
                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: AppConstants.gap16Px,
                        ),
                        child: Card(
                          elevation: AppConstants.gap8Px,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppConstants.gap12Px,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(AppConstants.gap16Px),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  doc['title'] ?? ViewConstants.noTitle,
                                  style: const TextStyle(
                                    fontSize: AppConstants.font18Px,
                                    fontWeight: FontWeight.bold,
                                    color: DarkTheme.blackColor,
                                  ),
                                ),
                                const SizedBox(height: AppConstants.gap8Px),
                                Text(
                                  doc['content'].toString().length > 100
                                      ? '${doc['content'].toString().substring(0, 100)}...'
                                      : doc['content'].toString(),
                                  style: const TextStyle(
                                    fontSize: AppConstants.font14Px,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}