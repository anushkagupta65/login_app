import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login_app/src/core/auth_service.dart';
import 'package:login_app/src/presentation/core/app_colors.dart';
import 'package:login_app/src/presentation/core/extentions.dart';
import 'package:login_app/src/presentation/login_screen/widgets/logout_dialog.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  final User user;
  final AuthService authService;

  const HomeScreen({
    super.key,
    required this.user,
    required this.authService,
  });

  static const routeName = "/home-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomeScreen"),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: GestureDetector(
              onTap: () {
                LogoutDialog.show(context);
              },
              child: SvgPicture.asset(
                "assets/images/logout_icon.svg",
                height: 24.h,
                color: color(
                  context,
                  AppColors.whiteColor,
                  AppColors.blackColor,
                ),
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(user.photoURL ?? ''),
              radius: 50,
            ),
            SizedBox(height: 20),
            Text('Welcome, ${user.displayName}'),
            SizedBox(height: 10),
            Text('Email: ${user.email}'),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
