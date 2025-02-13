import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sign_sphere/src/core/service/auth_service.dart';
import 'package:sign_sphere/src/presentation/core/app_colors.dart';
import 'package:sign_sphere/src/presentation/core/app_strings.dart';
import 'package:sign_sphere/src/presentation/core/extentions.dart';
import 'package:sign_sphere/src/utils/router/app_router.gr.dart';

class LogoutDialog {
  static void show(BuildContext context) {
    final AuthService authService = AuthService();
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: Text(
            AppStrings.logout,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          message: Text(
            AppStrings.reallyLogout,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                FocusScope.of(context).unfocus;
                context.router.popForced(AppStrings.logout);
                context.router.pushAndPopUntil(
                  LoginRoute(),
                  predicate: (route) => false,
                );
              },
              child: Text(
                AppStrings.logout,
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(color: AppColors.error),
              ),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              FocusScope.of(context).unfocus;
              context.router.popForced();
            },
            isDefaultAction: true,
            child: Text(
              AppStrings.cancel,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
        );
      },
    ).then((value) async {
      if (value == AppStrings.logout) {
        await authService.signOut();
        debugPrint("User signed out.");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: AutoSizeText(
                textScaleFactor: 1,
                "User signed out",
                style: Theme.of(context).textTheme.titleMedium),
            backgroundColor: color(
              context,
              AppColors.lightTextPrimary,
              AppColors.darkTextPrimary,
            ),
          ),
        );
        context.router.pushAndPopUntil(
          LoginRoute(),
          predicate: (route) => false,
        );
      }
    });
  }
}
