import 'package:flutter/cupertino.dart';
import 'package:get/get_navigation/src/routes/route_middleware.dart';

import '../Services/Session.dart';

class HomePageMiddleware extends GetMiddleware {

  Map<String, String>? session;
  void getSessionInfo() async {
    session = await getSession();
  }
  @override
  RouteSettings? redirect(String? route) {
    getSessionInfo();
    debugPrint('+--------------------------------------+ / RouteSettings');
    if (session == null) return null;
      debugPrint('+--------------------------------------+ / RouteSettings ---- \n  ${session?['token']}');
      if (session?['token'].toString() == 'null') {
        return const RouteSettings(name: '/');
      }
      return null;
  }
}