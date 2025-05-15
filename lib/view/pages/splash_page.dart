import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Services/Session.dart';

class SplashScreen extends StatefulWidget {
  static String SplashPage = "/SplashScreen";

  const SplashScreen({super.key});
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Check for existing session after a short delay to show splash screen
    Timer(const Duration(seconds: 2), () => _checkAuthAndRedirect());
  }

  // Check if user is already authenticated and redirect accordingly
  Future<void> _checkAuthAndRedirect() async {
    try {
      final session = await getSession();

      // Check if token exists and is not empty
      if (session['token'] != null && session['token']!.isNotEmpty) {
        debugPrint('SplashScreen: Valid token found, redirecting to home');
        Get.offAllNamed('/DesktopHomePage');
      } else {
        debugPrint('SplashScreen: No valid token found, redirecting to login');
        Get.offAllNamed('/login');
      }
    } catch (error) {
      debugPrint('SplashScreen: Error checking session: $error');
      // On error, redirect to login page
      Get.offAllNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App logo
            Image.asset(
              'assets/icons/Logo.png',
              width: 150,
              height: 150,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 24),
            // Loading indicator
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            // Loading text
            Text(
              '...جاري التحميل ',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}
