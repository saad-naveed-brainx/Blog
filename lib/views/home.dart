import 'package:blog/core/constants/app_constants.dart';
import 'package:blog/core/constants/view_constants.dart';
import 'package:blog/config/theme/dark.dart';
import 'package:blog/widgets/reusable_article_card.dart';
import 'package:flutter/material.dart';
import 'package:blog/models/user_model.dart';
import 'package:provider/provider.dart';
import 'package:blog/viewmodel/home_viewmodel.dart';
import 'package:blog/widgets/reusable_category_card.dart';

class HomeView extends StatefulWidget {
  final UserModel user;
  const HomeView({super.key, required this.user});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<dynamic> categories = [
    {"category": "Robotics", "image": "assets/categories/robot.webp"},
    {"category": "Mountains", "image": "assets/categories/mountains.png"},
    {"category": "AI", "image": "assets/categories/AI.jpg"},
    {"category": "Programming", "image": "assets/categories/programming.jpg"},
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.only(
            top: AppConstants.font14Px * 1,
            bottom: AppConstants.font14Px * 1,
          ),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: AppConstants.font14Px * 2,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${ViewConstants.homeHi}, ${widget.user.username}!',
                        style: TextStyle(
                          fontSize: AppConstants.font14Px * 1.5,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        ViewConstants.homeExploreNow,
                        style: TextStyle(
                          fontSize: AppConstants.font14Px * 2,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notifications,
                    size: AppConstants.font16Px * 2,
                    color: DarkTheme.backgroundColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.font14Px * 2),
            SizedBox(
              height: 120,
              child: Consumer<HomeViewModel>(
                builder: (context, usersProvider, child) {
                  final allUsers = [...usersProvider.users];
                  final currentUserIndex = allUsers.indexWhere(
                    (user) => user.id == widget.user.id,
                  );
                  if (currentUserIndex != -1) {
                    final currentUser = allUsers.removeAt(currentUserIndex);
                    allUsers.insert(0, currentUser);
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.only(
                      left: AppConstants.font14Px * 2,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemCount: allUsers.length,
                    itemBuilder: (context, index) {
                      final user = allUsers[index];
                      final isCurrentUser = user.id == widget.user.id;
                      return Padding(
                        padding: const EdgeInsets.only(
                          right: AppConstants.gap16Px,
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: AppConstants.gap24Px * 3,
                              height: AppConstants.gap24Px * 3,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    isCurrentUser
                                        ? DarkTheme.textColor
                                        : DarkTheme.backgroundColor,
                                border: Border.all(
                                  color:
                                      isCurrentUser
                                          ? DarkTheme.backgroundColor
                                          : DarkTheme.textColor,
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  user.username.isNotEmpty
                                      ? user.username[0].toUpperCase()
                                      : '?',
                                  style: TextStyle(
                                    fontSize: AppConstants.font16Px * 1.5,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        isCurrentUser
                                            ? DarkTheme.backgroundColor
                                            : DarkTheme.textColor,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: AppConstants.gap8Px),
                            Text(
                              isCurrentUser
                                  ? ViewConstants.homeYou
                                  : user.username,
                              style: TextStyle(
                                fontSize: AppConstants.font14Px,
                                color: DarkTheme.backgroundColor,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: AppConstants.font14Px * 2),
            SizedBox(
              width: AppConstants.gap24Px * 18,
              height: AppConstants.gap24Px * 12,
              child: ListView.builder(
                padding: const EdgeInsets.only(left: AppConstants.font14Px * 2),
                itemCount: categories.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: ReusableCategoryCard(
                      image: categories[index]['image'],
                      title: categories[index]['category'],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: AppConstants.font14Px * 2),
            Padding(
              padding: const EdgeInsets.only(left: AppConstants.font14Px * 2),
              child: const Text(
                'Recent Posts',
                style: TextStyle(
                  fontSize: AppConstants.font24Px,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: AppConstants.font14Px),
            StreamBuilder(
              stream: HomeViewModel().getArticles(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children:
                        snapshot.data!.docs.map((doc) {
                          return Padding(
                            padding: const EdgeInsets.all(AppConstants.gap16Px),
                            child: ReusableArticleCard(
                              title: doc['title'],
                              content: doc['content'],
                            ),
                          );
                        }).toList(),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(color: DarkTheme.whiteColor),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
