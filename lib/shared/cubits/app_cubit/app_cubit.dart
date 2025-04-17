import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoe_store/data/repository/repositories.dart';
import 'package:shoe_store/shared/models/user.dart';

import 'app_state.dart';
export 'app_state.dart';

const int splashDuration = 3;

class AppCubit extends Cubit<AppState> {
  final UserRepository authRepository;

  AppCubit({
    required this.authRepository,
  }) : super(AppState.checking());

  Future<void> checkAuthState() async {
    try {
      if (!authRepository.hasAccessToken) {
        await Future.delayed(const Duration(seconds: splashDuration));
        unauthorized();
        return;
      }
      final res = await Future.wait([
        authRepository.authToken(),
        Future.delayed(const Duration(seconds: splashDuration))
      ]);
      for (var e in res) {
        if (e is User) {
          authorized(e);
          return;
        }
      }
      unauthorized();
    } catch (e) {
      await Future.delayed(const Duration(seconds: splashDuration));
      unauthorized();
    }
  }

  void authorized(User user) {
    emit(AppState.authorized(user: user));
  }

  void unauthorized() {
    emit(AppState.unAuthorized());
  }

  void logout() {
    authRepository.logout();
    unauthorized();
  }
}
