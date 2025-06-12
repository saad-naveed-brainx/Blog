import 'package:blog/config/theme/dark.dart';
import 'package:blog/core/constants/app_constants.dart';
import 'package:flutter/material.dart';

class ReusableCategoryCard extends StatelessWidget {
  final String image;
  final String title;
  const ReusableCategoryCard({
    super.key,
    required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 300,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: DarkTheme.backgroundColor,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(image, fit: BoxFit.fill),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                width: double.infinity,
                height: 300,
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            Positioned(
              bottom: 0,
              left: AppConstants.font20Px,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: AppConstants.font14Px * 2,
                  fontWeight: FontWeight.w600,
                  color: DarkTheme.textColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
