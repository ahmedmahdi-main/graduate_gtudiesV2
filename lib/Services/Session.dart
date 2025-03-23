import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Save data
Future<void> saveSession(String token, String userId,
    {String? studentName}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('token', token);
  prefs.setString('UUID', userId);
  prefs.setString('studentName', studentName ?? '');
}

// Retrieve data
Future<Map<String, String>> getSession() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token') ?? '';
  String userId = prefs.getString('UUID') ?? '';
  String studentName = prefs.getString('studentName') ?? '';
  return {'token': token, 'UUID': userId, 'studentName': studentName};
}

Future<void> clearSession() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
  prefs.setString('token', '');
  debugPrint('Clear Session ------ ${prefs.getString('token')}');
}
