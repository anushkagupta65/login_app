import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_app/src/application/login/login_cubit.dart';
import 'package:login_app/src/presentation/core/app_colors.dart';
import 'package:login_app/src/presentation/core/app_strings.dart';
import 'package:login_app/src/presentation/core/extentions.dart';
import 'package:login_app/src/presentation/login_screen/widgets/login_input_field.dart';
// import 'package:login_app/src/presentation/core/app_strings.dart';
import 'package:login_app/src/presentation/login_screen/widgets/logo_image.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  static const routeName = "/login";

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.isSuccess) {
          // context.router
          //     .pushAndPopUntil(DashboardRoute(), predicate: (_) => false);
        }
        if (state.isFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: AutoSizeText(
                  textScaleFactor: 1,
                  state.errorMessage,
                  style: Theme.of(context).textTheme.titleMedium),
              backgroundColor: Colors.black,
              showCloseIcon: true,
              closeIconColor: AppColors.whiteColor,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      builder: (context, state) {
        final loginCubit = context.read<LoginCubit>();
        return Scaffold(
          body: GestureDetector(
            onTap: FocusScope.of(context).unfocus,
            child: Container(
              height: double.infinity,
              width: double.infinity,
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
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 16.h,
                ),
                child: Column(
                  children: [
                    LogoImage(),
                    SizedBox(
                      height: 24.h,
                    ),
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                            SizedBox(height: 16.h),
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
                              SizedBox(height: 8.h),
                              SizedBox(
                                width: double.infinity,
                                child: AutoSizeText(
                                  textScaleFactor: 1,
                                  state.usernameError,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontSize: 12.h,
                                        color: AppColors.error,
                                      ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                            SizedBox(height: 32.h),
                            LoginInputField(
                              inputType: AppStrings.password,
                              controller: passwordController,
                              onChanged: (val) =>
                                  loginCubit.passwordChanged(val),
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
                              height: 32.h,
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
                                    borderRadius: BorderRadius.circular(8.r),
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                              color: AppColors.whiteColor,
                                            ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
