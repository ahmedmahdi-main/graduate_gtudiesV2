import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dioo;
import '../Models/CareerInformation.dart';
import '../Services/base_route.dart';
import '../Services/DilogCostom.dart';
import '../Services/Failure.dart';
import '../Services/Session.dart';

class CareerInformationController extends GetxController {
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
      print('[${json.encode(careerInformation.toJson())}]');
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
      print("-------------------------");
      print(e.response?.data.toString());
      print("-------------------------");
      DilogCostom.dilogSecss(
          isErorr: true,
          title: Failure.dioexeptiontype(e)!,
          icons: Icons.close,
          color: Colors.redAccent);
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
