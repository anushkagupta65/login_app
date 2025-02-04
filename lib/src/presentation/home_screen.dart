import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login_app/src/presentation/login_screen/widgets/logout_dialog.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                context.router.popForced();
                LogoutDialog.show(context);
              },
              child: SvgPicture.asset(
                "assets/images/logout_icon.svg",
                height: 24.h,
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: Text("Home Screen"),
      ),
    );
  }
}
