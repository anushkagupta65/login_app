import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sign_sphere/src/presentation/core/app_colors.dart';

import 'extentions.dart';

class SigninTile extends StatelessWidget {
  final String icon;
  final String title;
  final dynamic onTap;

  const SigninTile({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: color(
            context,
            AppColors.darkBackground.withValues(alpha: 0.3),
            AppColors.lightBackground.withValues(alpha: 0.3),
          ),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: color(
              context,
              AppColors.whiteColor.withValues(alpha: 0.4),
              AppColors.blackColor,
            ),
            width: 0.6.w,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 4.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (!kIsWeb)
                if (icon == "assets/images/github.png")
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 11.r,
                        backgroundColor: AppColors.whiteColor,
                      ),
                      Image.asset(
                        icon,
                        height: 22.h,
                      ),
                    ],
                  )
                else
                  Image.asset(
                    icon,
                    height: 22.h,
                  )
              else if (icon == "assets/images/github.png")
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: 12.r,
                      backgroundColor: AppColors.whiteColor,
                    ),
                    Image.asset(
                      icon,
                      height: 24.h,
                    ),
                  ],
                )
              else
                Image.asset(
                  icon,
                  height: 24.h,
                ),
              SizedBox(
                width: 5.w,
              ),
              AutoSizeText(
                textAlign: TextAlign.center,
                title,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
