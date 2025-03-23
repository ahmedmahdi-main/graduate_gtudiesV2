import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Services/Session.dart';

class AuthMiddleware extends GetMiddleware {
  Map<String, String>? session;

  Future<void> getSessionInfo() async {
    session = await getSession();
  }

  @override
  RouteSettings? redirect(String? route) {
    getSessionInfo();
    debugPrint(
        '+--------------------------------------+ DesktopHomePage RouteSettings');
    if (session == null) return null;
    if (session?['token'].toString() != 'null') {
      return const RouteSettings(name: '/DesktopHomePage');
    }
      return null;
  }
}
