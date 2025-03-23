import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../Models/SystemInformation.dart';
import '../Services/base_route.dart';
import '../Services/Session.dart';

class SystemInformationController extends GetxController {
  var systemInformation = SystemInformation();
  Map<String, String>? session;
  Rx<bool> isLoading = true.obs;

  @override
  void onInit() async {
    isLoading.value = true;
    update();
    session = await getSession();
    systemInformation = await getSystemInformation();
    isLoading.value = false;
    update();
    super.onInit();
  }
   Future<SystemInformation> getSystemInformation() async {
    try {
      var headers = {'Authorization': 'Bearer ${session?['token']}'};
      var dio = Dio();
      var response = await dio.request(
        '$baseRoute/configsystem',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        return SystemInformation.fromJson(response.data);
      }
    } on DioException catch (dioex) {
      debugPrint(
          '------------getSystemInformation-------------------------- ${dioex.message}');
    } on Exception catch (e) {
      debugPrint(
          '-----------------getSystemInformation--------------------- $e');
    }
    return SystemInformation();
  }
}
