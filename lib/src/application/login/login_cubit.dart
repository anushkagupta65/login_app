import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:login_app/src/core/auth_service.dart';

part 'login_state.dart';
part 'login_cubit.freezed.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthService authService;

  LoginCubit({required this.authService}) : super(LoginState.initial()) {
    checkUserAuthentication();
  }

  /// Check authentication status when app starts
  void checkUserAuthentication() {
    final User? user = FirebaseAuth.instance.currentUser;
    emit(state.copyWith(
      isUserAuthenticated: user != null,
      googleUser: user,
    ));
  }

  /// Toggles password visibility
  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  /// Handles username input change
  void usernameChanged(String username) {
    emit(
        state.copyWith(username: username, isSuccess: false, isFailure: false));
  }

  /// Handles password input change
  void passwordChanged(String password) {
    emit(
        state.copyWith(password: password, isSuccess: false, isFailure: false));
  }

  /// Validates user credentials
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

  /// Handles login with username and password
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

  /// Handles Google Sign-In
  Future<void> signInWithGoogle() async {
    emit(state.copyWith(
      isLoading: true,
      errorMessage: "",
    ));

    try {
      final User? user = await authService.signInWithGoogle();
      print("User after sign-in: $user");

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

  /// Handles user logout
  Future<void> signOut() async {
    await authService.signOut();
    emit(state.copyWith(
      googleUser: null,
      isUserAuthenticated: false,
    ));
  }
}
