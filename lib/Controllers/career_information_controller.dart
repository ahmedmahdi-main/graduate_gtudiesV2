import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dioo;
import 'package:graduate_gtudiesV2/Services/session_error_handler.dart';
import '../Models/career_Information.dart';
import '../Services/base_route.dart';
import '../Services/costom_dialog.dart';
import '../Services/Failure.dart';
import '../Services/session.dart';

class CareerInformationController extends GetxController
    with SessionErrorHandler {
  CareerInformation careerInformation = CareerInformation();
  Map<String, String>? session;

  Future<void> getSessionInfo() async {
    session = await getSession();
  }

  @override
  void onInit() {
    careerInformation = CareerInformation();
    getSessionInfo();
    super.onInit();
  }

  Future<bool> uploadData() async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${session!['token']}'
      };
      var data = '[${json.encode(careerInformation.toJson())}]';
      // print('[${json.encode(careerInformation.toJson())}]');
      var dio = Dio();
      var response = await dio.request(
        '$baseRoute/Careerinformation',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        DilogCostom.dilogSecss(
            isErorr: false,
            title: response.data["message"],
            icons: Icons.check,
            color: Colors.greenAccent);
        return true;
      } else {
        DilogCostom.dilogSecss(
            isErorr: true,
            title: response.data["message"],
            icons: Icons.close,
            color: Colors.redAccent);
      }
    } on dioo.DioException catch (e) {
      handleDioError(e);
    } catch (e) {
      DilogCostom.dilogSecss(
          isErorr: true,
          title: 'هناك خطأ',
          icons: Icons.close,
          color: Colors.redAccent);
    }
    return false;
  }
}
