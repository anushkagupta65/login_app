import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_app/src/presentation/core/app_colors.dart';
import 'package:login_app/src/presentation/core/extentions.dart';

class LoginInputField extends StatelessWidget {
  final String inputType;
  final TextEditingController controller;
  final bool isPassword;
  final void Function(String)? onChanged;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool? obscureText;

  const LoginInputField({
    super.key,
    required this.inputType,
    required this.controller,
    this.isPassword = false,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      controller: controller,
      onChanged: onChanged,
      obscureText: obscureText!,
      style: TextStyle(
          color: color(
        context,
        AppColors.whiteColor,
        AppColors.blackColor,
      ) // Text color
          ),
      cursorColor: color(
        context,
        AppColors.primaryLightTheme,
        AppColors.primaryDarkTheme,
      ), // Cursor color
      decoration: InputDecoration(
        hintText: inputType,
        hintStyle: TextStyle(
          color: color(
            context,
            AppColors.whiteColor.withValues(alpha: 0.6),
            AppColors.blackColor.withValues(alpha: 0.6),
          ), // Hint color
        ),
        labelText: inputType,
        labelStyle: TextStyle(
          color: color(
            context,
            AppColors.whiteColor,
            AppColors.blackColor,
          ), // Label color
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: color(
            context,
            AppColors.whiteColor,
            AppColors.blackColor,
          ), // Icon color
        ),
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: color(
              context,
              AppColors.whiteColor,
              AppColors.blackColor,
            ), // Border color when enabled
            width: 0.6.w,
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: color(
              context,
              AppColors.whiteColor,
              AppColors.blackColor,
            ), // Border color when focused
            width: 1.0.w,
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    );
  }
}
