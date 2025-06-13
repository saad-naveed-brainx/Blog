import 'package:blog/data/repositories/local/blog_repository.dart';
import 'package:blog/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:blog/config/theme/dark.dart';
import 'package:blog/core/constants/app_constants.dart';
import 'package:blog/viewmodel/profile_viewmodel.dart';
import 'package:blog/widgets/reusable_article_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:blog/core/constants/view_constants.dart';

class ProfileView extends StatefulWidget {
  final UserModel user;
  const ProfileView({super.key, required this.user});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppConstants.gap16Px * 2),
          children: [
            // Profile Card
            Container(
              decoration: BoxDecoration(
                color: DarkTheme.blueColor,
                borderRadius: BorderRadius.circular(AppConstants.gap16Px * 2),
              ),
              padding: const EdgeInsets.all(AppConstants.gap20Px),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(radius: AppConstants.gap18Px * 2),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.user.username,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: AppConstants.gap18Px,
                            ),
                          ),
                          Text(
                            widget.user.email,
                            style: TextStyle(color: DarkTheme.RealblueColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: AppConstants.gap16Px),
                  Text(
                    ViewConstants.aboutMe,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: AppConstants.gap16Px,
                    ),
                  ),
                  SizedBox(height: AppConstants.gap4Px),
                  Text(
                    ViewConstants.whatHaveYouDoneForTheNationToday,
                    style: TextStyle(color: DarkTheme.greyColor),
                  ),
                  SizedBox(height: AppConstants.gap16Px),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStat('52', ViewConstants.post, Colors.deepPurple),
                      _buildStat(
                        '120',
                        ViewConstants.following,
                        Colors.blueGrey,
                      ),
                      _buildStat(
                        '2.2k',
                        ViewConstants.followers,
                        Colors.blueGrey,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: AppConstants.gap24Px),
            // My Posts Section
            Text(
              ViewConstants.myPosts,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: AppConstants.gap18Px,
              ),
            ),
            SizedBox(height: AppConstants.gap12Px),
            StreamBuilder<QuerySnapshot>(
              stream: ProfileViewModel(
                blogRepository: BlogRespository(),
              ).getUserPersonalArticles(widget.user.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final doc = snapshot.data!.docs[index];
                      return ReusableArticleCard(
                        title: doc['title'],
                        content: doc['content'],
                      );
                    },
                  );
                }
                return const Center(child: Text(ViewConstants.noPostsFound));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String value, String label, Color color) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppConstants.gap20Px,
            vertical: AppConstants.gap8Px,
          ),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(AppConstants.gap12Px),
          ),
          child: Text(
            value,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: AppConstants.gap4Px),
        Text(label, style: TextStyle(color: DarkTheme.greyColor)),
      ],
    );
  }
}
