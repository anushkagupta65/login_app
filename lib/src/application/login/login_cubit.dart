import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.dart';
part 'login_cubit.freezed.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState.initial());

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void usernameChanged(String username) {
    emit(state.copyWith(
      username: username,
      isSuccess: false,
      isFailure: false,
    ));
  }

  void passwordChanged(String password) {
    emit(state.copyWith(
      password: password,
      isSuccess: false,
      isFailure: false,
    ));
  }

  bool validateCredentials() {
    String? usernameErrorMessage;
    String? passwordErrorMessage;

    if (state.username.isEmpty) {
      usernameErrorMessage = "Username is required.";
    } else if (!state.password.contains(RegExp(r'[A-Z]'))) {
      usernameErrorMessage = "Please enter a valid username.";
    }
    // else if (!state.username.contains("@")) {
    //   usernameErrorMessage = "Please enter a valid username.";
    // }

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
        isLoading: true,
        isSuccess: false,
        isFailure: false,
        errorMessage: "",
        usernameError: "",
        passwordError: ""));

    if (!validateCredentials()) {
      emit(state.copyWith(isLoading: false));
      return;
    }

    //Valid credentials
    if (state.username == "Anushka" && state.password == "Anushka*123") {
      Future.delayed(const Duration(seconds: 1), () {
        emit(state.copyWith(
          isSuccess: true,
          isFailure: false,
          isLoading: false,
          errorMessage: "",
        ));
      });
    } else {
      Future.delayed(const Duration(seconds: 1), () {
        emit(state.copyWith(
          isSuccess: false,
          isFailure: true,
          isLoading: false,
          errorMessage: "Invalid Credentials. Please try again.",
        ));
      });
    }
  }
}
