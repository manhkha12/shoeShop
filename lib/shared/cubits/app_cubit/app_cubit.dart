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
  print('[AppCubit] 🔍 Bắt đầu kiểm tra trạng thái đăng nhập');
  try {
    if (!authRepository.hasAccessToken) {
      print('[AppCubit] ❌ Không có access token, chuyển về intro screen');
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
        print('[AppCubit] ✅ Token hợp lệ, chuyển vào màn chính');
        authorized(e);
        return;
      }
    }
    print('[AppCubit] ❌ Token không hợp lệ');
    unauthorized();
  } catch (e) {
    print('[AppCubit] ❌ Lỗi khi kiểm tra token: $e');
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
