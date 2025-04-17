import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dioo;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../Models/UserInfo.dart';
import '../Services/base_route.dart';
import '../Services/DilogCostom.dart';
import '../Services/Failure.dart';

class UserRegisterController extends GetxController {
  String? fullName;
  String? uUID;
  String? email;
  String? password;

  UserRegisterController({this.uUID, this.email, this.password, this.fullName});

  Future<String?> uploadData() async {
    try {
      var dio = Dio();
      var data = dioo.FormData.fromMap({
        'email': '$email',
        'password': '$password',
        'FullName': '$fullName',
        'UUID': '$uUID'
      });
      var response = await dio.request(
        '$baseRoute/register',
        options: Options(
          method: 'POST',
        ),
        data: data,
      );
// debugPrint('${response.statusCode}');
      if (response.statusCode == 200) {
        debugPrint(json.encode(response.data));
        UserInfo user = UserInfo();
        user.fromJson(response.data);
        // debugPrint(user.accessToken);
        debugPrint(user.otp.toString());
        await DilogCostom.dilogSecss(
            isErorr: false,
            title: "otp = ${user.otp.toString()}",
            icons: Icons.close,
            color: Colors.greenAccent);
        return user.accessToken;
      }
    } on DioException catch (e) {
      debugPrint("-------------------------");
      debugPrint('${e.response?.data}');
      debugPrint("-------------------------");
      DilogCostom.dilogSecss(
          isErorr: true,
          title: "${e.message}",
          icons: Icons.close,
          color: Colors.redAccent);
    } catch (e) {
      DilogCostom.dilogSecss(
          isErorr: true,
          title: ' ${e.toString()}',
          icons: Icons.close,
          color: Colors.redAccent);
    }
    return null;
  }

  static Future<int?> resendVerifyEmail(String token) async {
    try {
      var headers = {'Authorization': 'Bearer $token'};
      var dio = Dio();
      var response = await dio.request(
        '$baseRoute/verify-resend',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );
      return response.statusCode;
    } on DioException catch (e) {
      debugPrint("-------------------------");
      debugPrint(e.response?.data.toString());
      debugPrint("-------------------------");
      DilogCostom.dilogSecss(
          isErorr: true,
          title: Failure.dioexeptiontype(e)!,
          icons: Icons.close,
          color: Colors.redAccent);
    } catch (e) {
      DilogCostom.dilogSecss(
          isErorr: true,
          title: "هناك خطأ",
          icons: Icons.close,
          color: Colors.redAccent);
    }
    return null;
  }

  Future<int?> verifyEmail(String otp, String token) async {
    var dio = Dio();
    try {
      var response = await dio.post(
        "$baseRoute/verify?otp=$otp",
        options: Options(headers: {
          'account-type': 'master',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        }),
      );
      debugPrint(response.data.toString());
      return response.data['code'];
    } on http.ClientException catch (e) {
      debugPrint(e.message);
      return 0;
    }
  }
}
