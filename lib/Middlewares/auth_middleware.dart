import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Services/Session.dart';

class AuthMiddleware extends GetMiddleware {
  // Higher priority number means this middleware will be executed first
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    // This is the key method that determines if we should redirect
    return _checkSession();
  }

  // Helper method to check session synchronously
  RouteSettings? _checkSession() {
    // Start the async check but return immediately
    _performAsyncSessionCheck();
    
    // Always return null initially to allow navigation to continue
    // The actual redirection will happen in the async check if needed
    return null;
  }

  // This method handles the actual session check asynchronously
  Future<void> _performAsyncSessionCheck() async {
    try {
      final session = await getSession();
      
      debugPrint('AuthMiddleware: Checking session token: ${session['token']}');
      
      // Check if token exists and is not empty
      if (session['token'] != null && session['token']!.isNotEmpty) {
        debugPrint('AuthMiddleware: Valid token found, user is authenticated');
        // If we're already on the home page, don't redirect
        if (Get.currentRoute != '/DesktopHomePage') {
          Get.offAllNamed('/DesktopHomePage');
        }
      } else {
        debugPrint('AuthMiddleware: No valid token found, user needs to login');
        // If we're already on the login page, don't redirect
        if (Get.currentRoute != '/login') {
          Get.offAllNamed('/login');
        }
      }
    } catch (error) {
      debugPrint('AuthMiddleware: Error checking session: $error');
      // On error, redirect to login page
      if (Get.currentRoute != '/login') {
        Get.offAllNamed('/login');
      }
    }
  }
}
