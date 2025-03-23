import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduate_gtudiesV2/module/user_profile.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../Models/UserInfo.dart';
import '../Services/base_route.dart';
import '../Services/DilogCostom.dart';

class UserLogin {
  String? email;
  String? password;

  UserLogin({this.email, this.password});

  String? token;


  Future<UserProfile> getUserProfile(UserInfo userInfo) async {
    try {
      var headers = {
        'Authorization': 'Bearer ${userInfo.accessToken!}',
      };
      var dio = Dio();

      var response = await dio.request(
        '$baseRoute/profile',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
      );

      // If the request is successful (status code 200), return the user profile data
      if (response.statusCode == 200) {
        var data = UserProfile.fromJson(response.data['message']);

        return data;
      }
    } on DioException catch (e) {
      // Handle DioException and manually check the status code
      if (e.response?.statusCode == 406) {
        // Handle 406 status code, show a dialog, and potentially redirect the user
        DilogCostom.dilogSecss(
          isErorr: true,
          title: 'يرجى تفعيل الايميل أولا',
          icons: Icons.close,
          color: Colors.redAccent,
        );

        // You may also want to navigate or show a more specific action here, similar to previous example
        Get.toNamed('/OTP', arguments: {'token': userInfo.accessToken});
      } else {
        // Handle other errors (e.g., network issues, 500 errors, etc.)
        debugPrint("------------DioException getUserProfile-------------");
        debugPrint(e.message);
        DilogCostom.dilogSecss(
          isErorr: true,
          title: 'حدث خطأ أثناء تحميل الملف الشخصي',
          icons: Icons.close,
          color: Colors.redAccent,
        );
      }
    } catch (e) {
      // Handle other general exceptions
      debugPrint("-----------Exception getUserProfile--------------");
      debugPrint(e.toString());
      DilogCostom.dilogSecss(
        isErorr: true,
        title: 'هناك خطأ غير متوقع',
        icons: Icons.close,
        color: Colors.redAccent,
      );
    }

    // Return an empty UserProfile or handle it in case of an error (fallback)
    return UserProfile();
  }

  Future<UserInfo?> login() async {
    try {
      var dio = Dio();
      var response = await dio.request(
        "$baseRoute/login?email=$email&password=$password",
        options: Options(
          method: 'POST',
        ),
      );

      UserInfo user = UserInfo();
      debugPrint('${response.data}');
      if (response.statusCode == 200) {
         user.fromJson(response.data);
         debugPrint('${user.toJson()}');
        return user;
      } else {
        debugPrint(response.statusMessage);
      }
    } on DioException catch (e) {
      debugPrint("-------------------------");
      debugPrint('${e.response?.data}');
      debugPrint("-------------------------");
      DilogCostom.dilogSecss(
          isErorr: true,
          title: "${e.response?.data['message'][0].toString()}",
          icons: Icons.close,
          color: Colors.redAccent);
    } catch (e) {
      DilogCostom.dilogSecss(
          isErorr: true,
          title: e.toString(),
          icons: Icons.close,
          color: Colors.redAccent);
    }

    return null;
  }
}
