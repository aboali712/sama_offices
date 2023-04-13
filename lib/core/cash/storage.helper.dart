import 'dart:async';
import 'dart:convert';


import 'package:shared_preferences/shared_preferences.dart';

import '../../src/auth/auth_model/user_model.dart';




class StorageHelper {
  Future<bool> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(CacheManagerKey.token.toString(), token);
    return true;
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? ln = prefs.getString(CacheManagerKey.token.toString());
    ln ??= "";
    return ln;
  }

  Future<bool> setFirst(bool first) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(CacheManagerKey.isFirst.toString(), first);
    return true;
  }

  Future<bool?> getFirst() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(CacheManagerKey.isFirst.toString());
  }

  Future<bool> saveLang(String lang) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(CacheManagerKey.lang.toString(), lang);
    return true;
  }

  Future<String?> getLang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? ln = prefs.getString(CacheManagerKey.lang.toString());
    ln ??= "ar";
    return ln;
  }
  Future<bool> saveUser(UserModel? customer) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String user = jsonEncode(customer);
    pref.setString(CacheManagerKey.user.toString(), user);
    return true;
  }

  Future<UserModel?> getUser() async
  {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString(CacheManagerKey.user.toString()) != null &&
        pref.getString(CacheManagerKey.user.toString()) != "null") {
      print(pref.getString(CacheManagerKey.user.toString()));
      Map<String, dynamic> jsonDatais = jsonDecode(
          pref.getString(CacheManagerKey.user.toString())!);
      var user = UserModel.fromJson(jsonDatais);
      return user;
    }
    return null;
  }


}

enum CacheManagerKey { token, isFirst, lang, currency, user, fave,cart,userApple }
