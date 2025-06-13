import 'package:flutter/material.dart';
import 'package:blog/core/constants/app_constants.dart';
import 'package:blog/config/theme/dark.dart';

class ReusableArticleCard extends StatelessWidget {
  final String title;
  final String content;
  const ReusableArticleCard({
    super.key,
    required this.title,
    required this.content,
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
            Text(
              title,
              style: TextStyle(
                fontSize: AppConstants.font18Px,
                fontWeight: FontWeight.bold,
                color: DarkTheme.blackColor,
              ),
            ),
            const SizedBox(height: AppConstants.gap4Px),
            Text(
              content,
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
