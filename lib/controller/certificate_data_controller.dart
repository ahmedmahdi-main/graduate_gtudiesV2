import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../Models/certificate_data.dart';
import '../Services/base_route.dart';
import '../Services/DilogCostom.dart';
import '../Services/Failure.dart';
import '../Services/Session.dart';

class CertificateDataController extends GetxController {
  CertificateData certificateData = CertificateData();
  Map<String, String>? session;
  bool isLoading = true;

  Future<void> getSessionInfo() async {
    isLoading = true;
    update();
    session = await getSession();
    isLoading = false;
    update();
  }

  @override
  void onInit() {
    certificateData = CertificateData();
    certificateData.certificateCompetency = [];
    certificateData.documents = [];

    getSessionInfo();
    super.onInit();
  }

  Future<bool> uploadData() async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer  ${session!['token']}'
      };
      var data = json.encode([certificateData.toJson()]);
      debugPrint(data);
      var dio = Dio();
      var response = await dio.request(
        '$baseRoute/CertificateData',
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
          title: 'هناك خطأ',
          icons: Icons.close,
          color: Colors.redAccent);
    }
    return false;
  }
}
