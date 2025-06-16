import 'package:flutter/material.dart';
import 'package:blog/core/constants/app_constants.dart';
import 'package:blog/config/theme/dark.dart';
import 'package:blog/models/blog_model.dart';
import 'package:blog/viewmodel/profile_viewmodel.dart';
import 'package:blog/core/constants/view_constants.dart';

class ReusableArticleCard extends StatelessWidget {
  final BlogModel blogModel;
  final bool profile;
  const ReusableArticleCard({
    super.key,
    required this.blogModel,
    this.profile = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: AppConstants.gap8Px,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.gap12Px),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.gap16Px),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (profile)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: DarkTheme.iconColor,
                      borderRadius: BorderRadius.circular(AppConstants.gap14Px),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(AppConstants.gap8Px),
                      child: Icon(Icons.edit, color: DarkTheme.whiteColor),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder:
                            (context) => AlertDialog(
                              title: Center(
                                child: Text(
                                  ViewConstants.deleteArticle,
                                  style: TextStyle(
                                    fontSize: AppConstants.font14Px,
                                    fontWeight: FontWeight.w600,
                                    color: DarkTheme.blackColor,
                                  ),
                                ),
                              ),
                              content: Text(
                                ViewConstants
                                    .areYouSureYouWantToDeleteThisArticle,
                                style: TextStyle(
                                  fontSize: AppConstants.font14Px,
                                  fontWeight: FontWeight.w600,
                                  color: DarkTheme.blackColor,
                                ),
                              ),

                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    ViewConstants.cancel,
                                    style: TextStyle(
                                      fontSize: AppConstants.font14Px,
                                      fontWeight: FontWeight.w600,
                                      color: DarkTheme.blackColor,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: DarkTheme.errorColor,
                                  ),
                                  onPressed: () {
                                    ProfileViewModel().deleteArticle(
                                      blogModel.id!,
                                    );
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    ViewConstants.delete,
                                    style: TextStyle(
                                      fontSize: AppConstants.font14Px,
                                      fontWeight: FontWeight.w600,
                                      color: DarkTheme.whiteColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: DarkTheme.errorColor,
                        borderRadius: BorderRadius.circular(
                          AppConstants.gap14Px,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(AppConstants.gap8Px),
                        child: Icon(Icons.delete, color: DarkTheme.whiteColor),
                      ),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: AppConstants.gap4Px),
            Text(
              blogModel.title,
              style: TextStyle(
                fontSize: AppConstants.font18Px,
                fontWeight: FontWeight.bold,
                color: DarkTheme.blackColor,
              ),
            ),
            const SizedBox(height: AppConstants.gap4Px),
            Text(
              blogModel.content,
              style: TextStyle(
                fontSize: AppConstants.font14Px,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
