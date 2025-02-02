part of 'login_cubit.dart';

@freezed
class LoginState with _$LoginState {
  factory LoginState({
    @Default("") String username,
    @Default("") String password,
    @Default(false) bool isLoading,
    @Default("") String errorMessage,
    @Default(false) bool isSuccess,
    @Default(false) bool isFailure,
    @Default("") String usernameError,
    @Default("") String passwordError,
    @Default(true) bool isPasswordVisible,
  }) = _LoginState;

  factory LoginState.initial() => LoginState(
        username: "",
        password: "",
        isLoading: false,
        isSuccess: false,
        isFailure: false,
        usernameError: "",
        passwordError: "",
        isPasswordVisible: true,
        errorMessage: "",
      );
}
