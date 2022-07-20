import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorage {
  Future getStorageList(String key);
  Future setStorageList(String key, List dados);
}

class LocalStorageImp implements LocalStorage {
  @override
  Future getStorageList(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<dynamic> _dados = [];
    String? storage = prefs.getString(key);
    if (storage != null) {
      _dados = jsonDecode(storage);
    }
    return _dados;
  }

  @override
  Future setStorageList(String key, List dados) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, jsonEncode(dados));
  }
}
