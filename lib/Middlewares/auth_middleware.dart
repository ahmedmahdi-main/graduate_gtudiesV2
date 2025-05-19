import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Services/session.dart';

class AuthMiddleware extends GetMiddleware {
  static bool _isRedirecting = false;

  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    if (!_isRedirecting) {
      _performAsyncSessionCheck();
    }
    return null;
  }

  Future<void> _performAsyncSessionCheck() async {
    if (_isRedirecting) return;
    _isRedirecting = true;

    try {
      final session = await getSession();
      final String? token = session['token'];
      final String? timestampStr = session['expiresIn'];

      debugPrint('AuthMiddleware: Token: $token, Timestamp: $timestampStr');

      // Check for missing token or timestamp
      if (token == null || token.isEmpty || timestampStr == null) {
        await _forceLogout();
        return;
      }

      // Parse epoch timestamp
      final int? timestamp = int.tryParse(timestampStr);
      if (timestamp == null) {
        debugPrint('Invalid timestamp format');
        await _forceLogout();
        return;
      }

      // Convert to DateTime (UTC)
      final DateTime storedTime =
          DateTime.fromMillisecondsSinceEpoch(timestamp, isUtc: true);
      final DateTime currentTime = DateTime.now().toUtc();
      final Duration difference = currentTime.difference(storedTime);

      debugPrint('Token age: ${difference.inSeconds} seconds');

      // Check expiration (2 hours = 7200 seconds)
      if (difference.inSeconds > 7200) {
        await _forceLogout();
      } else {
        await _redirectToHome();
      }
    } catch (e) {
      debugPrint('AuthMiddleware error: $e');
      await _forceLogout();
    } finally {
      _isRedirecting = false;
    }
  }

  Future<void> _forceLogout() async {
    await clearSession();
    if (Get.currentRoute != '/login') {
      await Get.offAllNamed('/login');
    }
  }

  Future<void> _redirectToHome() async {
    if (Get.currentRoute != '/DesktopHomePage') {
      await Get.offAllNamed('/DesktopHomePage');
    }
  }
}
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../Services/session.dart';

// class AuthMiddleware extends GetMiddleware {
//   static bool _isRedirecting = false;

//   @override
//   int? get priority => 1;

//   @override
//   RouteSettings? redirect(String? route) {
//     _performAsyncSessionCheck();
//     return null;
//   }

//   Future<void> _performAsyncSessionCheck() async {
//     if (_isRedirecting) return; // Prevent multiple redirections

//     try {
//       final session = await getSession();
//       debugPrint('AuthMiddleware: Checking session token: ${session['token']}');

//       if (session['token'] != null && session['token']!.isNotEmpty) {
//         debugPrint('AuthMiddleware: Valid token found, user is authenticated');
//         if (Get.currentRoute != '/DesktopHomePage') {
//           _isRedirecting = true;
//           await Get.offAllNamed('/DesktopHomePage');
//           _isRedirecting = false;
//         }
//       } else {
//         debugPrint('AuthMiddleware: No valid token found, user needs to login');
//         if (Get.currentRoute != '/login') {
//           _isRedirecting = true;
//           await Get.offAllNamed('/login');
//           _isRedirecting = false;
//         }
//       }
//     } catch (error) {
//       debugPrint('AuthMiddleware: Error checking session: $error');
//       if (!_isRedirecting && Get.currentRoute != '/login') {
//         _isRedirecting = true;
//         await Get.offAllNamed('/login');
//         _isRedirecting = false;
//       }
//     }
//   }
// }
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import '../Services/session.dart';

// // class AuthMiddleware extends GetMiddleware {
// //   @override
// //   int? get priority => 1;

// //   @override
// //   RouteSettings? redirect(String? route) {
// //     _performAsyncSessionCheck();
// //     return null;
// //   }

// //   Future<void> _performAsyncSessionCheck() async {
// //     try {
// //       final session = await getSession();
// //       final String? token = session['token'];
// //       final String? timestampStr = session['expiresIn'];

// //       debugPrint('AuthMiddleware: Token: $token, Timestamp: $timestampStr');

// //       if (token == null || token.isEmpty || timestampStr == null) {
// //         debugPrint('AuthMiddleware: Token or timestamp missing');
// //         _redirectToLogin();
// //         return;
// //       }

// //       try {
// //         final DateTime storedTime = DateTime.parse(timestampStr);
// //         final DateTime currentTime = DateTime.now().toUtc();
// //         final Duration difference = currentTime.difference(storedTime);

// //         debugPrint(
// //             'AuthMiddleware: Token age: ${difference.inSeconds} seconds');

// //         if (difference.inSeconds > 7200) {
// //           // 2 hours = 7200 seconds
// //           debugPrint('AuthMiddleware: Token expired');
// //           _redirectToLogin();
// //         } else {
// //           debugPrint('AuthMiddleware: Valid token');
// //           _redirectToHome();
// //         }
// //       } catch (e) {
// //         debugPrint('AuthMiddleware: Error parsing timestamp: $e');
// //         _redirectToLogin();
// //       }
// //     } catch (error) {
// //       debugPrint('AuthMiddleware: Error checking session: $error');
// //       _redirectToLogin();
// //     }
// //   }

// //   void _redirectToLogin() {
// //     if (Get.currentRoute != '/login') {
// //       Get.offAllNamed('/login');
// //     }
// //   }

// //   void _redirectToHome() {
// //     if (Get.currentRoute != '/DesktopHomePage') {
// //       Get.offAllNamed('/DesktopHomePage');
// //     }
// //   }
// // }
