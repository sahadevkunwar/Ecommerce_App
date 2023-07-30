import 'dart:convert';

import 'package:ecommerce_project/features/auth/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsUtils {
  static const String _tokenKey = "appToken";
  static const String _userKey = "user";

  static Future<void> saveToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_tokenKey, token);
  }

  static Future<String> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(_tokenKey) ?? "";
  }

  static Future<void> removeToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(_tokenKey);
  }

  static Future<void> saveUser(User user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final mapUser = user.toMap();
    final String encodedData = jsonEncode(mapUser);
    sharedPreferences.setString(_userKey, encodedData);
  }

  static Future<User?> getUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final encodedData = sharedPreferences.getString(_userKey);
    if (encodedData != null) {
      final decodedData = Map<String, dynamic>.from(jsonDecode(encodedData));
      final user = User.fromMap(decodedData);
      return user;
    } else {
      return null;
    }
  }

  static Future<void> removeUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(_userKey);
  }
}
