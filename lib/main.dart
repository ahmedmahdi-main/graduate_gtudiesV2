import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduate_gtudiesV2/Middlewares/auth_middleware.dart';
import 'package:graduate_gtudiesV2/view/pages/loading_page.dart';
import 'package:graduate_gtudiesV2/view/system_config_page_v2.dart';

import 'view/pages/Desktop/desktop_home_page.dart';
import 'view/pages/authentication/signup.dart';
import 'view/pages/authentication/login.dart';
import 'view/pages/authentication/otp.dart';
import 'view/pages/splash_page.dart';

void main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Run the app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.light,
      darkTheme: ThemeData.dark(useMaterial3: true),

      // Change initial route to splash screen which will handle authentication check
      initialRoute: SplashScreen.SplashPage,

      getPages: [
        // Login page with middleware to check if user is already logged in
        GetPage(
          name: '/login',
          page: () => Login(),
          middlewares: [AuthMiddleware()],
        ),

        // Home page with middleware to ensure user is authenticated
        GetPage(
          name: '/DesktopHomePage',
          page: () => DesktopHomePage(),
          middlewares: [AuthMiddleware()],
        ),

        // Other pages
        GetPage(name: '/SignUp', page: () => SignUp()),
        GetPage(name: '/LoadingPage', page: () => const LoadingPage()),
        GetPage(name: '/OTP', page: () => OTP()),

        // Splash screen that will check authentication status
        GetPage(name: SplashScreen.SplashPage, page: () => SplashScreen()),
        GetPage(
            name: '/SystemConfigPageRout', page: () => SystemConfigPageV2()),
        // GetPage(
        //     name: ResetPasswordMain.resetPassword,
        //     page: () =>  ResetPasswordMain(),
        //   binding: ResetPasswordBinding(),
        // )
      ],
      theme: ThemeData(
          useMaterial3: true,
          fontFamily: "Cairo",
          scrollbarTheme: const ScrollbarThemeData(
            trackBorderColor: WidgetStatePropertyAll(Colors.transparent),
            trackColor: WidgetStatePropertyAll(Colors.transparent),
            thumbColor: WidgetStatePropertyAll(Colors.transparent),
          )),
      debugShowCheckedModeBanner: false,

      // home: Login()

      // : Resbonsive(
      //   Desktop: DesktopHomePage(),
      //   Mobile: const MobileHomePage(),
      //   Tablet: TabletHomePage(),
      // ),
    );
  }
}

//mohammed
