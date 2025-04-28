import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoe_store/shared/models/user.dart';

const String _tokenKey = 'family_4_0_app.access_token';
const String _refreshTokenKey = 'family_4_0_app.refresh_token';
const String _releaseLocationPermissionKey =
    'family_4_0_app.release_location_permission';

    const String _userIdKey = 'family_4_0_app.user_id';

class AppProvider {
  final SharedPreferences _preferences;

  AppProvider(this._preferences);

  String? _accessToken;
   User? _user;

int? get userId {
  return _preferences.getInt(_userIdKey);
}

Future<void> setUser(User? value) async {
  _user = value;
  if (value != null) {
    await _preferences.setInt(_userIdKey, value.id);
  } else {
    await _preferences.remove(_userIdKey);
  }
}


  String? get accessToken {
    // print('Access Token Retrieved: ${_accessToken ?? _preferences.getString(_tokenKey)}');
    return _accessToken ?? _preferences.getString(_tokenKey);
  }

  String? _refreshToken;
  String? get refreshToken {
    // print('Refresh Token Retrieved: ${_refreshToken ?? _preferences.getString(_refreshTokenKey)}');
    return _refreshToken ?? _preferences.getString(_refreshTokenKey);
  }
  
  bool get hasAccessToken {
    // print('Has Access Token: ${accessToken?.isNotEmpty ?? false}');
    return accessToken?.isNotEmpty ?? false;
  }

  Future<void> setAccessToken(String? value) async {
    _accessToken = value;
    await _preferences.setString(_tokenKey, value ?? '');
    // print('Access Token Set: $value');
  }

  Future<void> setRefreshToken(String? value) async {
    _refreshToken = value;
    await _preferences.setString(_refreshTokenKey, value ?? '');
    // print('Refresh Token Set: $value');
  }

  bool get isReleaseLocationPermission {
    bool permission = _preferences.getBool(_releaseLocationPermissionKey) ?? false;
    // print('Location Permission Status: $permission');
    return permission;
  }

  Future<void> releaseLocationPermission() async {
    await _preferences.setBool(_releaseLocationPermissionKey, true);
    // print('Location Permission Released');
  }
}