import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogoImage extends StatelessWidget {
  const LogoImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190.h,
      width: 440.w,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: Theme.of(context).brightness == Brightness.dark
              ? AssetImage(
                  "assets/images/login_background_dark.png",
                )
              : AssetImage(
                  "assets/images/login_background_light.png",
                ),
        ),
      ),
    );
  }
}
