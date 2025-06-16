import 'package:flutter/material.dart';
import 'package:blog/core/constants/view_constants.dart';
import 'package:blog/core/constants/app_constants.dart';
import 'package:blog/config/theme/dark.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:blog/utility/validators.dart';
import 'package:blog/widgets/reusableFormField.dart';
import 'package:blog/core/constants/app_assets.dart';
import 'package:blog/viewmodel/sign_in_viewmodel.dart';
import 'package:blog/views/sign_up.dart';
import 'package:blog/config/app_router.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPasswordVisible = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void submitForm() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      setState(() {
        isLoading = true;
      });
      try {
        final user = await SignInViewModel().signIn(
          emailController.text,
          passwordController.text,
        );
        AppRouter.NavigatorToHomeScreen(context, user);
      } catch (e) {
        debugPrint('Error during sign in: $e');
      } finally {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      }
    } else {
      debugPrint('Form has invalid credentials');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E1E1E),
      body: Stack(
        children: [
          _body(),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: CircularProgressIndicator(
                  color: DarkTheme.signUpButtonColor,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _body() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppConstants.gap20Px),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: SizedBox(
              height:
                  MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: AppConstants.gap20Px),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: AppConstants.gap24Px * 2),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ViewConstants.signInWelcome,
                              style: TextStyle(
                                fontSize: AppConstants.font24Px,
                                color: DarkTheme.textColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: AppConstants.gap8Px),
                            Text(
                              ViewConstants.signInMessage,
                              style: TextStyle(
                                fontSize: AppConstants.font16Px,
                                color: DarkTheme.textColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: AppConstants.gap16Px * 2),
                        CustomTextFormField(
                          controller: emailController,
                          hintText: ViewConstants.signInEmail,
                          validator: Validators.validateEmail,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: AppConstants.gap14Px * 2,
                            vertical: AppConstants.gap14Px * 2,
                          ),
                        ),
                        SizedBox(height: AppConstants.gap12Px),
                        CustomTextFormField(
                          controller: passwordController,
                          hintText: ViewConstants.signInPassword,
                          validator: Validators.validatePassword,
                          obscureText: !isPasswordVisible,
                          hasToggleVisibility: true,
                          isTextVisible: isPasswordVisible,
                          onToggleVisibility: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: AppConstants.gap14Px * 2,
                            vertical: AppConstants.gap20Px,
                          ),
                        ),
                        SizedBox(height: AppConstants.gap16Px * 2),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: submitForm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: DarkTheme.signUpButtonColor,
                              foregroundColor: DarkTheme.textColor,
                              padding: EdgeInsets.symmetric(
                                vertical: AppConstants.font18Px,
                                horizontal: AppConstants.gap24Px,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  AppConstants.font8Px,
                                ),
                              ),
                            ),
                            child: const Text(
                              ViewConstants.signInButton,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: AppConstants.font16Px,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: AppConstants.gap12Px),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              SignInViewModel().signInWithGoogle(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: DarkTheme.signUpButtonColor2,
                              foregroundColor: DarkTheme.textColor,
                              padding: EdgeInsets.symmetric(
                                vertical: AppConstants.font18Px,
                                horizontal: AppConstants.gap24Px,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  AppConstants.font8Px,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  AppAssets.googleIcon,
                                  width: AppConstants.font20Px,
                                  height: AppConstants.font20Px,
                                ),
                                SizedBox(width: AppConstants.gap10Px),
                                const Text(
                                  ViewConstants.signInGoogle,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: AppConstants.font16Px,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: AppConstants.gap12Px),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUpScreen(),
                                ),
                              );
                            },
                            child: Text(
                              ViewConstants.signInNoAccount,
                              style: TextStyle(
                                fontSize: AppConstants.font16Px,
                                color: DarkTheme.textColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
