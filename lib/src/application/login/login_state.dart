part of 'login_cubit.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    @Default("") String username,
    @Default("") String password,
    @Default(false) bool isPasswordVisible,
    @Default(false) bool isLoading,
    @Default(false) bool isSuccess,
    @Default(false) bool isFailure,
    @Default("") String errorMessage,
    @Default("") String usernameError,
    @Default("") String passwordError,
    User? googleUser,
    @Default(false) bool isUserAuthenticated,
  }) = _LoginState;

  factory LoginState.initial() => const LoginState(
        username: "",
        password: "",
        isPasswordVisible: true,
        isLoading: false,
        isSuccess: false,
        isFailure: false,
        errorMessage: "",
        usernameError: "",
        passwordError: "",
        googleUser: null,
        isUserAuthenticated: false,
      );
}
