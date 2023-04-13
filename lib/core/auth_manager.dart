import 'package:flutter/material.dart';

import 'cash/storage.helper.dart';

class AuthenticationManager extends StorageHelper {
  BuildContext context;
  AuthenticationManager({
    required this.context,
  }) {
    fetchUserLogin();
    fetchLang();
  }

  bool isLogin = false;
  bool isFirst = true;
  String lang = "en";

  Future<void> fetchUserLogin() async {
    final token = await getToken();

    if (token != null && token.length > 3) {
      isLogin = true;
    }
  }

  Future<void> fetchUserIsFirst() async {
    final first = await getFirst();

    if (first != null) {
      isFirst = first;
    }
  }

  Future<void> fetchLang() async {
    final first = await getLang();

    if (first != null) {
      lang = first;
    }
  }



  Future<void> saveChoosedLang() async {
    await saveLang(lang);
  }


}
