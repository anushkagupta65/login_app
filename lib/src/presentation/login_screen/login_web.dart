import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sign_sphere/src/application/login/login_cubit.dart';
import 'package:sign_sphere/src/core/service/auth_service.dart';
import 'package:sign_sphere/src/presentation/core/app_colors.dart';
import 'package:sign_sphere/src/presentation/core/app_strings.dart';
import 'package:sign_sphere/src/presentation/core/extentions.dart';
import 'package:sign_sphere/src/presentation/core/input_field.dart';
import 'package:sign_sphere/src/presentation/core/logo_image_web.dart';
import 'package:sign_sphere/src/presentation/core/signin_tile.dart';
import 'package:sign_sphere/src/utils/router/app_router.gr.dart';

class LoginWeb extends StatefulWidget {
  const LoginWeb({super.key});

  @override
  State<LoginWeb> createState() => _LoginWebState();
}

class _LoginWebState extends State<LoginWeb> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.isSuccess &&
            (state.googleUser != null || state.githubUser != null)) {
          context.router.pushAndPopUntil(
            HomeRoute(user: state.googleUser!, authService: authService),
            predicate: (route) => false,
          );
        }
        if (state.isFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: AutoSizeText(
                  textScaleFactor: 1,
                  state.errorMessage,
                  style: Theme.of(context).textTheme.titleMedium),
              backgroundColor: color(
                context,
                AppColors.lightTextPrimary,
                AppColors.darkTextPrimary,
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        if (MediaQuery.of(context).size.width > 750) {
          return Scaffold(
            body: Row(
              children: [
                Expanded(
                  flex: 6,
                  child: LogoImageWeb(),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: (MediaQuery.of(context).size.width) * 0.4,
                    decoration: Theme.of(context).brightness == Brightness.dark
                        ? BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                AppColors.primaryDarkTheme,
                                AppColors.secondaryDarkTheme,
                              ],
                            ),
                          )
                        : BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                AppColors.primaryLightTheme,
                                AppColors.secondaryLightTheme,
                              ],
                            ),
                          ),
                    child: loginFormWebWidget(state),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Scaffold(
            body: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: LogoImageWeb(),
                ),
                Expanded(
                  flex: 5,
                  child: GestureDetector(
                    child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: (MediaQuery.of(context).size.width) * 0.5,
                        decoration:
                            Theme.of(context).brightness == Brightness.dark
                                ? BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        AppColors.primaryDarkTheme,
                                        AppColors.secondaryDarkTheme,
                                      ],
                                    ),
                                  )
                                : BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        AppColors.primaryLightTheme,
                                        AppColors.secondaryLightTheme,
                                      ],
                                    ),
                                  ),
                        child: loginFormWebWidget(state)),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget loginFormWebWidget(LoginState state) {
    final loginCubit = context.read<LoginCubit>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AutoSizeText(
              AppStrings.welcomeBack,
              textScaleFactor: 0.8,
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  fontSize: 32,
                  color: color(
                    context,
                    AppColors.whiteColor,
                    AppColors.blackColor,
                  )),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 16.h,
            ),
            AutoSizeText(
              AppStrings.enterCredentials,
              maxFontSize: 14,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: color(
                      context,
                      AppColors.whiteColor,
                      AppColors.blackColor,
                    ),
                  ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            InputField(
              inputType: AppStrings.username,
              controller: usernameController,
              onChanged: (val) => loginCubit.usernameChanged(val),
              isPassword: false,
              prefixIcon: Icons.person_outlined,
              obscureText: false,
            ),
            if (state.usernameError.isNotEmpty) ...[
              SizedBox(
                height: 8.h,
              ),
              SizedBox(
                width: double.infinity,
                child: AutoSizeText(
                  state.usernameError,
                  textScaleFactor: 1,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.error,
                      ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
            SizedBox(
              height: 16.h,
            ),
            InputField(
              inputType: AppStrings.password,
              controller: passwordController,
              onChanged: (val) => loginCubit.passwordChanged(val),
              isPassword: true,
              prefixIcon: Icons.lock_outline,
              suffixIcon: IconButton(
                icon: Icon(
                  state.isPasswordVisible
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: color(
                    context,
                    AppColors.whiteColor,
                    AppColors.blackColor,
                  ), // Eye icon color
                ),
                onPressed: () {
                  FocusScope.of(context).unfocus;
                  loginCubit.togglePasswordVisibility();
                },
              ),
              obscureText: state.isPasswordVisible,
            ),
            if (state.passwordError.isNotEmpty) ...[
              SizedBox(
                height: 8.h,
              ),
              SizedBox(
                width: double.infinity,
                child: AutoSizeText(
                  state.passwordError,
                  textScaleFactor: 1,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.error,
                      ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
            SizedBox(
              height: 16.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: SizedBox(
                width: double.infinity,
                child: AutoSizeText.rich(
                  TextSpan(
                    text: AppStrings.forgetPassword,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.underline,
                      decorationColor: color(
                        context,
                        AppColors.whiteColor,
                        AppColors.blackColor,
                      ),
                      decorationThickness: 8,
                    ),
                  ),
                  minFontSize: 14,
                  maxFontSize: 14,
                  maxLines: 1,
                  textAlign: TextAlign.right,
                ),
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            SizedBox(
              width: double.infinity,
              height: 54.h,
              child: ElevatedButton(
                onPressed: () {
                  FocusScope.of(context).unfocus;
                  loginCubit.onDoneButtonClick();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: EdgeInsets.symmetric(
                    horizontal: 32.w,
                    vertical: 8.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: state.isLoading
                    ? SizedBox(
                        height: 32.h,
                        child: const CircularProgressIndicator(
                          color: AppColors.whiteColor,
                        ),
                      )
                    : AutoSizeText(
                        textScaleFactor: 1,
                        AppStrings.login,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: AppColors.whiteColor,
                            ),
                      ),
              ),
            ),
            SizedBox(
              height: 32.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: color(
                        context,
                        AppColors.whiteColor,
                        AppColors.blackColor,
                      ),
                      height: 1.2.h,
                    ),
                  ),
                  SizedBox(
                    width: 6.w,
                  ),
                  Text(
                    "or",
                    style: TextStyle(
                      fontSize: 16,
                      color: color(
                        context,
                        AppColors.whiteColor,
                        AppColors.blackColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 6.w,
                  ),
                  Expanded(
                    child: Divider(
                      color: color(
                        context,
                        AppColors.whiteColor,
                        AppColors.blackColor,
                      ),
                      height: 1.2.h,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 32.h,
            ),
            SigninTile(
              icon: "assets/images/phone_number.png",
              title: AppStrings.phone,
            ),
            SizedBox(
              height: 16.h,
            ),
            GestureDetector(
              onTap: () {
                loginCubit.signInWithGoogle();
              },
              child: SigninTile(
                icon: "assets/images/search.png",
                title: AppStrings.google,
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            GestureDetector(
              onTap: () {
                loginCubit.signInWithGitHub();
              },
              child: SigninTile(
                icon: "assets/images/github.png",
                title: AppStrings.github,
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 1.w),
              child: AutoSizeText(
                AppStrings.signUp,
                minFontSize: 14,
                maxFontSize: 16,
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
