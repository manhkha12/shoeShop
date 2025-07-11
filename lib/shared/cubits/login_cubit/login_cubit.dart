import 'package:shoe_store/data/repository/repositories.dart';
import 'package:shoe_store/shared/cubits/app_cubit/app_cubit.dart';
import 'package:shoe_store/shared/cubits/login_cubit/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  final UserRepository userRepository;
  final AppCubit appCubit;
  LoginCubit({required this.userRepository, required this.appCubit})
      : super(LoginState());

  void emailChanged(String email) {
    emit(state.copyWith(email: email));
  }

  void passwordChanged(String password) {
    emit(state.copyWith(password: password));
  }

  //  Đăng nhập
  Future<void> login() async {
    if (!state.valid) {
      return;
    }

    emit(state.copyWith(isLoading: true));

    try {
      final user = await userRepository.login(state.email, state.password);

      appCubit.authorized(user);
      emit(state.copyWith(
        loginSuccess: true,
        isLoading: false,
        user: user,
        userRole: user.role,
      ));
    } catch (e) {
      emit(state.copyWith(
        errorMessage: e.toString(),
        isLoading: false,
      ));
    }
  }
}
