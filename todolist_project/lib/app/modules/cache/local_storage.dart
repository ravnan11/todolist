import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorage {
  Future getStorageMap(String key);
  Future getStorageList(String key);
  Future getItem(String key, String chave);
  Future setStorageMap(String key, Map<String, dynamic> dados);
  Future setStorageList(String key, List dados);
  Future setItem(String key, String chave, dynamic valor);
}

class LocalStorageImp implements LocalStorage {
  @override
  Future getStorageMap(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> _dados = {};
    String? storage = prefs.getString(key);
    if (storage != null) {
      _dados = jsonDecode(storage);
    }
    return _dados;
  }

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
  Future getItem(String key, String chave) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> _dados = {};
    String? storage = prefs.getString(key);
    if (storage != null) {
      _dados = jsonDecode(storage);
    }
    return _dados[chave];
  }

  @override
  Future setStorageMap(String key, Map<String, dynamic> dados) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, jsonEncode(dados));
  }

  @override
  Future setStorageList(String key, List dados) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, jsonEncode(dados));
  }

  @override
  Future setItem(String key, String chave, dynamic valor) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> _dados = {};
    String? storage = prefs.getString(key);
    if (storage != null) {
      _dados = jsonDecode(storage);
    }
    _dados[chave] = valor;
    await prefs.setString(key, jsonEncode(_dados));
  }
}
