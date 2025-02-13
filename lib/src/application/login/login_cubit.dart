import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sign_sphere/src/core/service/auth_service.dart';

part 'login_state.dart';
part 'login_cubit.freezed.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthService authService;

  LoginCubit({required this.authService}) : super(LoginState.initial()) {
    checkUserAuthentication();
  }

  void checkUserAuthentication() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      debugPrint("Auth state changed: $user");

      emit(state.copyWith(
        isUserAuthenticated: user != null,
        googleUser: user,
        githubUser: user,
        isLoading: false,
      ));
    });
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void usernameChanged(String username) {
    emit(
        state.copyWith(username: username, isSuccess: false, isFailure: false));
  }

  void passwordChanged(String password) {
    emit(
        state.copyWith(password: password, isSuccess: false, isFailure: false));
  }

  bool validateCredentials() {
    String? usernameErrorMessage;
    String? passwordErrorMessage;

    if (state.username.isEmpty) {
      usernameErrorMessage = "Username is required.";
    } else if (!state.username.contains(RegExp(r'[A-Z]'))) {
      usernameErrorMessage = "Please enter a valid username.";
    }

    if (state.password.isEmpty) {
      passwordErrorMessage = "Password is required.";
    } else if (state.password.length < 8 ||
        !state.password.contains(RegExp(r'[A-Z]')) ||
        !state.password.contains(RegExp(r'[0-9]')) ||
        !state.password.contains(RegExp(r'[!@#\$&*~]'))) {
      passwordErrorMessage = "Please enter a valid password.";
    }

    emit(state.copyWith(
      usernameError: usernameErrorMessage ?? "",
      passwordError: passwordErrorMessage ?? "",
    ));

    return usernameErrorMessage == null && passwordErrorMessage == null;
  }

  Future<void> onDoneButtonClick() async {
    emit(state.copyWith(
        isLoading: true, isSuccess: false, isFailure: false, errorMessage: ""));

    if (!validateCredentials()) {
      emit(state.copyWith(isLoading: false));
      return;
    }

    if (state.username == "Anushka" && state.password == "Anushka*123") {
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(
        isSuccess: true,
        isFailure: false,
        isLoading: false,
        isUserAuthenticated: true,
      ));
    } else {
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(
        isSuccess: false,
        isFailure: true,
        isLoading: false,
        errorMessage: "Invalid Credentials. Please try again.",
      ));
    }
  }

  Future<void> signInWithGoogle() async {
    emit(state.copyWith(
      isLoading: true,
      errorMessage: "",
    ));

    try {
      final User? user = await authService.signInWithGoogle();
      debugPrint("User after sign-in: $user");

      if (user != null) {
        emit(state.copyWith(
          isSuccess: true,
          googleUser: user,
          isUserAuthenticated: true,
          isLoading: false,
        ));
      } else {
        emit(state.copyWith(
          isFailure: true,
          errorMessage: "Google Sign-in failed",
          isLoading: false,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isFailure: true,
        errorMessage: e.toString(),
        isLoading: false,
      ));
    }
  }

  Future<void> signInWithGitHub() async {
    emit(state.copyWith(isLoading: true, errorMessage: ""));

    try {
      final User? user = await authService.signInWithGitHub();
      debugPrint("User after GitHub sign-in: $user");

      if (user != null) {
        emit(state.copyWith(
          isSuccess: true,
          githubUser: user,
          isUserAuthenticated: true,
          isLoading: false,
        ));
      } else {
        emit(state.copyWith(
          isFailure: true,
          errorMessage: "GitHub Sign-in failed or user is null",
          isLoading: false,
        ));
      }
    } catch (e) {
      debugPrint("GitHub Sign-In Error: $e");
      emit(state.copyWith(
        isFailure: true,
        errorMessage: e.toString(),
        isLoading: false,
      ));
    }
  }

  Future<void> signOut() async {
    await authService.signOut();
    emit(state.copyWith(
      googleUser: null,
      githubUser: null,
      isUserAuthenticated: false,
    ));
  }
}
