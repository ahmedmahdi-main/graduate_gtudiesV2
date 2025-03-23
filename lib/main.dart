import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduate_gtudiesV2/view/pages/loading_page.dart';
import 'package:graduate_gtudiesV2/view/system_config_page_v2.dart';

import 'view/pages/Desktop/desktop_home_page.dart';
import 'view/pages/authentication/signup.dart';
import 'view/pages/authentication/login.dart';
import 'view/pages/authentication/otp.dart';
import 'view/pages/splashpage.dart';

void main() async {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.light,

      darkTheme: ThemeData.dark(useMaterial3: true),
      initialRoute: "/",
      getPages: [
        GetPage(name: '/', page: () => Login()),
        GetPage(
          name: '/DesktopHomePage',
          page: () => DesktopHomePage()
        ),
        GetPage(name: '/SignUp', page: () => SignUp()),
        GetPage(name: '/LoadingPage', page: () => const LoadingPage()),
        GetPage(
            name:  '/OTP',
            page: () => OTP(
                )),
        GetPage(name: SplashScreen.SplashPage, page: () => SplashScreen()),
         GetPage(name: '/SystemConfigPageRout', page: () => SystemConfigPageV2()),
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
            trackBorderColor: MaterialStatePropertyAll(Colors.transparent),
            trackColor: MaterialStatePropertyAll(Colors.transparent),
            thumbColor: MaterialStatePropertyAll(Colors.transparent),
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
