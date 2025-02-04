import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_app/src/application/login/login_cubit.dart';
import 'package:login_app/src/presentation/core/app_colors.dart';
import 'package:login_app/src/presentation/core/app_strings.dart';
import 'package:login_app/src/presentation/core/extentions.dart';
import 'package:login_app/src/presentation/login_screen/widgets/login_input_field.dart';
import 'package:login_app/src/presentation/login_screen/widgets/logo_image_web.dart';
import 'package:login_app/src/presentation/login_screen/widgets/signin_tile.dart';

class LoginWeb extends StatelessWidget {
  LoginWeb({super.key});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.isSuccess) {}
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
          body: Row(
            children: [
              Expanded(
                flex: 60,
                child: LogoImageWeb(),
              ),
              Expanded(
                flex: 40,
                child: GestureDetector(
                  onTap: FocusScope.of(context).unfocus,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: (MediaQuery.of(context).size.width) / 3,
                    decoration: Theme.of(context).brightness == Brightness.dark
                        ? BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                const Color.fromARGB(212, 109, 67, 3),
                                AppColors.secondaryDarkTheme,
                              ],
                            ),
                          )
                        : BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                const Color.fromARGB(210, 252, 240, 224),
                                const Color.fromARGB(255, 241, 195, 135),
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
                                      height: 8.h,
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
                                    height: 8.h,
                                  ),
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
                                    height: 16.h,
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
                                          borderRadius:
                                              BorderRadius.circular(12.r),
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
                                  SigninTile(
                                    icon: "assets/images/search.png",
                                    title: "Sign in with Google",
                                  ),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  SigninTile(
                                    icon: "assets/images/linkedin.png",
                                    title: "Sign in with LinkedIn",
                                  ),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  SigninTile(
                                    icon: "assets/images/github.png",
                                    title: "Sign in with GitHub",
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
            ],
          ),
        );
      },
    );
  }
}
