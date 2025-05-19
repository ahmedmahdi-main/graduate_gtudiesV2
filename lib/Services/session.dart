import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

// Save data
Future<void> saveSession(String token, String userId,
    {String? studentName, String? expiresIn}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('token', token);
  prefs.setString('UUID', userId);
  prefs.setString('studentName', studentName ?? '');
  prefs.setString('expiresIn', expiresIn ?? '0');
}

// Retrieve data
Future<Map<String, String>> getSession() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token') ?? '';
  String userId = prefs.getString('UUID') ?? '';
  String studentName = prefs.getString('studentName') ?? '';
  String expiresIn = prefs.getString('expiresIn') ?? '0';
  return {
    'token': token,
    'UUID': userId,
    'studentName': studentName,
    'expiresIn': expiresIn
  };
}

Future<void> clearSession() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
  prefs.setString('token', '');
  // debugPrint('Clear Session ------ ${prefs.getString('token')}');
}
