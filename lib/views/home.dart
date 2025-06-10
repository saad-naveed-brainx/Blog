import 'package:blog/core/constants/app_constants.dart';
import 'package:blog/core/constants/view_constants.dart';
import 'package:blog/config/theme/dark.dart';
import 'package:flutter/material.dart';
import 'package:blog/models/user_model.dart';
import 'package:provider/provider.dart';
import 'package:blog/providers/users_provider.dart';

class HomeView extends StatefulWidget {
  final UserModel user;
  const HomeView({super.key, required this.user});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppConstants.font14Px * 2,
          vertical: AppConstants.font14Px * 1,
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
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
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notifications,
                      size: AppConstants.font16Px * 2,
                      color: DarkTheme.iconColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppConstants.font14Px * 2),
              SizedBox(
                height: 120,
                child: Consumer<UsersProvider>(
                  builder: (context, usersProvider, child) {
                    // Create a new list with current user first
                    final allUsers = [...usersProvider.users];
                    final currentUserIndex = allUsers.indexWhere(
                      (user) => user.id == widget.user.id,
                    );
                    if (currentUserIndex != -1) {
                      final currentUser = allUsers.removeAt(currentUserIndex);
                      allUsers.insert(0, currentUser);
                    }
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: allUsers.length,
                      itemBuilder: (context, index) {
                        final user = allUsers[index];
                        final isCurrentUser = user.id == widget.user.id;
                        return Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Column(
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      isCurrentUser
                                          ? DarkTheme.textColor
                                          : DarkTheme.signUpButtonColor,
                                  border: Border.all(
                                    color:
                                        isCurrentUser
                                            ? DarkTheme.signUpButtonColor
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
                                              ? DarkTheme.signUpButtonColor
                                              : DarkTheme.textColor,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                isCurrentUser ? 'You' : user.username,
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
            ],
          ),
        ),
      ),
    );
  }
}
