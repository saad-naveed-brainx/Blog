import 'package:flutter/material.dart';
import 'package:blog/config/theme/dark.dart';
import 'package:blog/core/constants/app_constants.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final bool obscureText;
  final bool hasToggleVisibility;
  final bool isTextVisible;
  final VoidCallback? onToggleVisibility;
  final EdgeInsetsGeometry contentPadding;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.obscureText = false,
    this.hasToggleVisibility = false,
    this.isTextVisible = false,
    this.onToggleVisibility,
    required this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      style: TextStyle(color: DarkTheme.textColor),
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(
        contentPadding: contentPadding,
        hintText: hintText,
        hintStyle: TextStyle(color: DarkTheme.textGreyColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.gap8Px),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: DarkTheme.textColor),
          borderRadius: BorderRadius.circular(AppConstants.gap8Px),
        ),
        suffixIcon:
            hasToggleVisibility
                ? IconButton(
                  onPressed: onToggleVisibility,
                  icon: Icon(
                    isTextVisible ? Icons.visibility : Icons.visibility_off,
                    color: DarkTheme.textColor,
                  ),
                )
                : null,
      ),
    );
  }
}
