import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../Services/base_route.dart';
import '../Services/Session.dart';

class LogoutController extends GetxController{
  Rx<String?> studentName = ''.obs;
  Map<String, String>? session;
  Future<void> getSessionInfo() async {
    session = await getSession();

  }
  @override
  void onReady() {
    studentName.value = session!['studentName'];
    // TODO: implement onReady
    super.onReady();
  }
  @override
  void onInit() async {
   await getSessionInfo();

    super.onInit();

  }

  Future<void> logout() async{
    var headers = {
      'Authorization': 'Bearer ${session?['token']}'
    };
    var dio = Dio();
    var response = await dio.request(
      '$baseRoute/logout',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
    }
    else {
      print(response.statusMessage);
    }

  }
}