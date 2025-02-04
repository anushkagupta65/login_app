import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_app/src/presentation/core/app_colors.dart';
import 'package:login_app/src/presentation/core/app_strings.dart';
import 'package:login_app/src/utils/router/app_router.gr.dart';

class LogoutDialog {
  static void show(BuildContext context) {
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
      if (value == AppStrings.logout && context.mounted) {
        context.router.pushAndPopUntil(
          LoginRoute(),
          predicate: (route) => false,
        );
      }
    });
  }
}
