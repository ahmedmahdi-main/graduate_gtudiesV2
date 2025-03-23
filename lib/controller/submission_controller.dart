import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dioo;
import '../Models/Submission.dart';
import '../Services/base_route.dart';
import '../Services/DilogCostom.dart';
import '../Services/Failure.dart';
import '../Services/Session.dart';

class SubmissionController extends GetxController {
  Submission submission = Submission();
  Map<String, String>? session;

  Future<void> getSessionInfo() async {
    submission = Submission();
    session = await getSession();
  }

  @override
  void onInit() async {
    //getSessionInfo();
   await getSessionInfo();
    super.onInit();
  }

  Future<bool> uploadData() async {
    try {
      debugPrint("session!['token'] ==============   ${session!['token']}");
      var headers = {
        'Authorization': 'Bearer ${session!['token']}'
      };
      var data = json.encode([submission.toJson()]);
      var dio = Dio();
      var response = await dio.request(
        '$baseRoute/Submission',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        DilogCostom.dilogSecss(
            isErorr: false,
            title: 'response.data["message"]',
            icons: Icons.check,
            color: Colors.greenAccent);
        return true;
      } else {
        DilogCostom.dilogSecss(
            isErorr: true,
            title: 'response.data["message"]',
            icons: Icons.close,
            color: Colors.redAccent);
      }
    } on dioo.DioException catch (e) {
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
          title: " ${e.toString()} هناك خطأ",
          icons: Icons.close,
          color: Colors.redAccent);
    }
    return false;
  }
}
