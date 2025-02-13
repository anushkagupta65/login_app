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
import 'package:sign_sphere/src/presentation/login_screen/login_web.dart';
import 'package:sign_sphere/src/presentation/core/login_input_field.dart';
import 'package:sign_sphere/src/presentation/core/logo_image.dart';
import 'package:sign_sphere/src/presentation/core/signin_tile.dart';
import 'package:sign_sphere/src/utils/router/app_router.gr.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const routeName = "/login";

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isWeb = MediaQuery.of(context).size.width > 500;
    final AuthService authService = AuthService();

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
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      builder: (context, state) {
        final loginCubit = context.read<LoginCubit>();

        if (isWeb) {
          return LoginWeb();
        }

        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: GestureDetector(
            onTap: FocusScope.of(context).unfocus,
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
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
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: 20.w,
                      left: 20.w,
                      top: 52.h,
                      bottom: 16.h,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        LogoImage(),
                        SizedBox(
                          height: 24.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AutoSizeText(
                                AppStrings.welcomeBack,
                                textScaleFactor: 0.8,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineLarge!
                                    .copyWith(
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
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: color(
                                        context,
                                        AppColors.whiteColor,
                                        AppColors.blackColor,
                                      ),
                                    ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 24.h),
                              LoginInputField(
                                inputType: AppStrings.username,
                                controller: usernameController,
                                onChanged: (val) =>
                                    loginCubit.usernameChanged(val),
                                isPassword: false,
                                prefixIcon: Icons.person_outlined,
                                obscureText: false,
                              ),
                              if (state.usernameError.isNotEmpty) ...[
                                SizedBox(
                                  height: 6.h,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: AutoSizeText(
                                    state.usernameError,
                                    textScaleFactor: 1,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          color: AppColors.error,
                                        ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                              SizedBox(
                                height: 6.h,
                              ),
                              LoginInputField(
                                inputType: AppStrings.password,
                                controller: passwordController,
                                onChanged: (val) =>
                                    loginCubit.passwordChanged(val),
                                isPassword: true,
                                prefixIcon: Icons.lock_outline,
                                suffixIcon: GestureDetector(
                                  child: Icon(
                                    state.isPasswordVisible
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: color(
                                      context,
                                      AppColors.whiteColor,
                                      AppColors.blackColor,
                                    ), // Eye icon color
                                  ),
                                  onTap: () {
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
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          color: AppColors.error,
                                        ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                              SizedBox(
                                height: 8.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
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
                                height: 8.h,
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: 54.h,
                                child: ElevatedButton(
                                  onPressed: () {
                                    FocusScope.of(context).unfocus;
                                    loginCubit
                                        .onDoneButtonClick(); // Trigger the login action
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
                                          child:
                                              const CircularProgressIndicator(
                                            color: AppColors.whiteColor,
                                          ),
                                        )
                                      : AutoSizeText(
                                          textScaleFactor: 1,
                                          AppStrings.login,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                color: AppColors.whiteColor,
                                              ),
                                        ),
                                ),
                              ),
                              SizedBox(
                                height: 24.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
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
                                      width: 10.w,
                                    ),
                                    Text(
                                      "or",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: color(
                                          context,
                                          AppColors.whiteColor,
                                          AppColors.blackColor,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.w,
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
                                height: 24.h,
                              ),
                              SigninTile(
                                icon: "assets/images/phone_number.png",
                                title: AppStrings.phone,
                              ),
                              SizedBox(
                                height: 8.h,
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
                                height: 8.h,
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
                                height: 12.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: AutoSizeText(
                                  AppStrings.signUp,
                                  minFontSize: 14,
                                  maxFontSize: 14,
                                  maxLines: 1,
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
