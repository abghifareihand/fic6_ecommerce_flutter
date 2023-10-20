import 'dart:convert';
import 'package:fic6_ecommerce_flutter/data/models/auth_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDatasource {
  static const String _authKey = 'token';
  Future<bool> saveAuthData(AuthResponseModel model) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.setString(_authKey, jsonEncode(model.toJson()));
  }

  Future<bool> removeAuthData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.remove(_authKey);
  }

  Future<String> getToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final authJson = pref.getString(_authKey) ?? '';
    return AuthResponseModel.fromJson(jsonDecode(authJson)).jwt;
  }

  Future<AuthResponseModel> getAuthData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final authJson = pref.getString(_authKey) ?? '';
    return AuthResponseModel.fromJson(jsonDecode(authJson));
  }

  Future<bool> isLogin() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final authJson = pref.getString(_authKey);
    return authJson != null;
  }

  Future<User> getUser() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final authJson = pref.getString(_authKey) ?? '';
    return AuthResponseModel.fromJson(jsonDecode(authJson)).user;
  }
  Future<int> getUserId() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final authJson = pref.getString(_authKey) ?? '';
    return AuthResponseModel.fromJson(jsonDecode(authJson)).user.id;
  }
}
