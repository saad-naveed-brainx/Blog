import 'package:blog/config/theme/dark.dart';
import 'package:blog/core/constants/app_constants.dart';
import 'package:blog/models/user_model.dart';
import 'package:blog/views/home.dart';
import 'package:flutter/material.dart';
import 'package:blog/config/app_router.dart';
import 'package:blog/views/viewall_article.dart';
import 'package:blog/views/search_article.dart';

class LayoutView extends StatefulWidget {
  final UserModel user;
  const LayoutView({super.key, required this.user});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  int _currentIndex = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomeView(user: widget.user),
      ViewAllArticle(),
      const SearchArticle(),
      const Center(child: Text('Profile')),
    ];
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AppRouter.NavigatorToNewArticleScreen(context, widget.user);
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: DarkTheme.backgroundColor,
        shape: CircularNotchedRectangle(),
        notchMargin: AppConstants.gap2Px,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.home),
                  onPressed: () => _onTabTapped(0),
                  color:
                      _currentIndex == 0
                          ? DarkTheme.whiteColor
                          : DarkTheme.greyColor,
                ),
                SizedBox(width: AppConstants.font18Px * 2),
                IconButton(
                  icon: Icon(Icons.article),
                  onPressed: () => _onTabTapped(1),
                  color:
                      _currentIndex == 1
                          ? DarkTheme.whiteColor
                          : DarkTheme.greyColor,
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () => _onTabTapped(2),
                  color:
                      _currentIndex == 2
                          ? DarkTheme.whiteColor
                          : DarkTheme.greyColor,
                ),
                SizedBox(width: AppConstants.font18Px * 2),
                IconButton(
                  icon: Icon(Icons.person),
                  onPressed: () => _onTabTapped(3),
                  color:
                      _currentIndex == 3
                          ? DarkTheme.whiteColor
                          : DarkTheme.greyColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
