import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

setUserPrefs(String email, String password) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('email', email);
  prefs.setString('password', password);

  debugPrint(prefs.getString('email'));
  debugPrint(prefs.getString('password'));
}

Future<Map<String, String>> getUserPrefs() async {
  Map<String, String> user;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('email') && prefs.containsKey('password')) {
    user['email'] = prefs.getString('email');
    user['password'] = prefs.getString('password');
  }
}
