import 'package:shoe_store/data/local/app_provider.dart';
import 'package:shoe_store/data/remote/user_api.dart';
import 'package:shoe_store/data/repository/api_service.dart';

import 'package:shoe_store/shared/models/user.dart';

class UserRepository {
  final ApiService apiService;
  final AppProvider appProvider;

  UserRepository(this.apiService, this.appProvider);

  Future<User> login(String email, String password) async {
    print('[AuthService] 🔄 Đang thực hiện đăng nhập với email: $email');

    try {
      final resp = await apiService.postRequest("auth/login", {
        "email": email,
        "password": password,
      });

      if (resp != null && resp['data'] != null) {
        print(
            '[AuthService] ✅ Đăng nhập thành công. Nhận dữ liệu: ${resp['data']}');

        // Cập nhật token
        await updateToken(resp['data']);
        print('[AuthService] ✅ Token đã được cập nhật thành công.');

        // Trả về user, kiểm tra null trước khi truy cập
        final user = User.fromJson(resp['data']['user'] ?? {});
        print('[AuthService] ✅ Đối tượng user đã được tạo: ${user.email}');
        return user;
      } else {
        print(
            '[AuthService] ❌ Đăng nhập thất bại: Không có phản hồi từ server');
        throw Exception("Đăng nhập thất bại");
      }
    } catch (e) {
      print('[AuthService] ❌ Lỗi khi đăng nhập: $e');
      throw Exception("Đăng nhập thất bại: $e");
    }
  }

  Future<User> register(
      String? username, String? email, String? password, String? rePass) async {
    final resp = await apiService.postRequest("auth/register", {
      "userName": username,
      "email": email,
      "password": password,
      "rePass": rePass,
    });

    if (resp != null) {
      return User.fromJson(resp['data']);
    } else {
      throw Exception("Đăng ký thất bại");
    }
  }

  Future<User> authToken() async {
    final resp = await apiService.authToken(refreshToken!);
    await updateToken(resp!['data']);
    return User.fromJson(resp['data']['user']);
  }

  Future<void> logout() async {
    await appProvider.setAccessToken(null);
    await appProvider.setRefreshToken(null);
  }

  Future<void> updateToken(Map<String, dynamic> response) async {
    await appProvider.setAccessToken(response['token']);
    // Nếu có refresh_token thì lưu luôn, giả sử server có trả
    if (response.containsKey('refresh_token')) {
      await appProvider.setRefreshToken(response['refresh_token']);
    }
  }

  bool get hasAccessToken => appProvider.hasAccessToken;

  String? get refreshToken => appProvider.refreshToken;
}
