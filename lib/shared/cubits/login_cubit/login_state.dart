import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shoe_store/shared/models/user.dart';


part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    @Default('') String email,
    @Default('') String password,
    @Default(false) bool loginSuccess,
    @Default(false) bool isLoading,
    @Default('') String errorMessage,
    @Default('') String userRole,
    User? user,
    @Default('') String emailError,
    @Default('') String userNameError,
  }) = _LoginState;

  const LoginState._();

  /// Custom getter to validate form
  bool get valid {
    // if (isSignUp) {
    //   return email.isNotEmpty &&
    //       password.isNotEmpty &&
    //       rePass.isNotEmpty &&
    //       userName.isNotEmpty;
    // }
    return email.isNotEmpty && password.isNotEmpty;
  }
}
