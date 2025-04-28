 import 'package:freezed_annotation/freezed_annotation.dart';
 part 'signup_state.freezed.dart';
 @freezed
 class SignupState with _$SignupState {
  const factory SignupState({
    @Default('') String? email,
    @Default('') String? password,
    @Default('') String? userName,
    @Default('') String? rePass,
    @Default(false) bool isLoading,
    @Default(false) bool signupSuccess,
    @Default('') String errorMessage,
  }) = _SignupState;

  const SignupState._();

  /// Custom getter to validate form
    bool get isValid =>
      (email?.isNotEmpty ?? false) &&
      (password?.isNotEmpty ?? false) &&
      (userName?.isNotEmpty ?? false)&&
      (rePass?.isNotEmpty ?? false) ;
 }