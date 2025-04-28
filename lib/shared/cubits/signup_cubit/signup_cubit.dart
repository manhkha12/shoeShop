import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoe_store/data/repository/user_repository.dart';
import 'package:shoe_store/shared/cubits/app_cubit/app_cubit.dart';
import 'package:shoe_store/shared/cubits/signup_cubit/signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final UserRepository userRepository;


  SignupCubit({
    required this.userRepository,

  }) : super(SignupState());

  void emailChanged(String email) {
    emit(state.copyWith(email: email));
  }

  void passwordChanged(String password) {
    emit(state.copyWith(password: password));
  }

  void userNameChanged(String userName) {
    emit(state.copyWith(userName: userName));
  }

  void rePassChanged(String rePass) {
    emit(state.copyWith(rePass: rePass));
  }
Future<void> register() async {
    if (!state.isValid) return;
    emit(state.copyWith(isLoading: true, errorMessage: ""));

    try {
      final user = await userRepository.register(
        state.email,
        state.password,
        state.userName,
        state.rePass,
      );

      emit(state.copyWith(
       
        isLoading: false,
        signupSuccess: true,
      ));
    } catch (e) {
      final err = e.toString();

      if (err.contains("Email đã tồn tại")) {
        emit(state.copyWith(
            errorMessage: "Email này đã tồn tại", isLoading: false));
      } else if (err.contains("Tên người dùng đã tồn tại")) {
        emit(state.copyWith(
            errorMessage: "Tên người dùng đã tồn tại", isLoading: false));
      } else {
        emit(state.copyWith(
            errorMessage: err, isLoading: false));
      }
    }
  }

}