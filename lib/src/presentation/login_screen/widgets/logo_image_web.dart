import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogoImageWeb extends StatelessWidget {
  const LogoImageWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).size.width),
      width: (MediaQuery.of(context).size.width) * 0.65,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
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
