import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  late SharedPreferences _sharedPreferences;

  // Save token and user data
  Future<void> saveLoginData({
    required String token,
    required String userId,
    required String email,
    required String role,
  }) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    await _sharedPreferences.setString('token', token);
    await _sharedPreferences.setString('userId', userId);
    await _sharedPreferences.setString('email', email);
    await _sharedPreferences.setString('role', role);
  }

  // Get token
  Future<String?> getToken() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.getString('token');
  }

  // Get role
  Future<String?> getRole() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.getString('role');
  }

  // Clear login data
  Future<void> clear() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    await _sharedPreferences.remove('token');
    await _sharedPreferences.remove('userId');
    await _sharedPreferences.remove('email');
    await _sharedPreferences.remove('role');
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    final token = _sharedPreferences.getString('token');
    return token != null && token.isNotEmpty;
  }
}
