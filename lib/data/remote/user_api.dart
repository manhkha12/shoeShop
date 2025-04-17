import 'handler/api_handler.dart';

class UserApi {
  final ApiHandler _api;

  UserApi(this._api);

  Future<Map<String, dynamic>?> login(String email, String password) async {
    return await _api.post(
      "/auth/login",
      body: {"email": email, "password": password},
    );
  }
  Future<Map<String, dynamic>?> register(String username, String email, String password, String rePass) async {
    return await _api.post(
      "/auth/register",
      body: {"userName": username, "email": email, "password": password, "rePass": rePass},
    );
  }

}
