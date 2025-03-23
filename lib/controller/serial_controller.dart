import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Services/base_route.dart';
import '../Services/DilogCostom.dart';
import '../Services/Failure.dart';
import '../Services/Session.dart';

class SerialController extends GetxController {
  Map<String, String>? session;
  bool isLoading = true;

  Future<void> getSessionInfo() async {
    update();
    session = await getSession();

    update();
  }

  @override
  void onInit() async {
    isLoading = true;
    update();
    session = await getSession();
    isLoading = false;
    update();
    super.onInit();
  }

  Future<bool> setSerial() async {
    debugPrint("session!['token'] ==============   ${session!['token']}");
    try {
      var headers = {'Authorization': 'Bearer ${session?['token']}'};
      var dio = Dio();
      var response = await dio.request(
        '$baseRoute/Serialcreate',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        DilogCostom.dilogSecss(
            isErorr: false,
            title: response.data["message"], //
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
      debugPrint(e.message);
      debugPrint("-------------------------");
      DilogCostom.dilogSecss(
          isErorr: true,
          title: Failure.dioexeptiontype(e)!,
          icons: Icons.close,
          color: Colors.redAccent);
    } catch (e) {
      DilogCostom.dilogSecss(
          isErorr: true,
          title: '$e',
          icons: Icons.close,
          color: Colors.redAccent);
    }
    return false;
  }

  Future<void> requestEdit(String message) async {
    try {
      var headers = {'Authorization': 'Bearer ${session?['token']}'};
      var data = json.encode({"msg": message});
      var dio = Dio();
      var response = await dio.request(
        '$baseRoute/requestEdit',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        DilogCostom.dilogSecss(
            isErorr: false,
            title: response.data["message"], //
            icons: Icons.check,
            color: Colors.greenAccent);
      } else {
        DilogCostom.dilogSecss(
            isErorr: true,
            title: response.data["message"],
            icons: Icons.close,
            color: Colors.redAccent);
      }
    } on DioException catch (e) {
      debugPrint("-------------------------");
      debugPrint(e.message);
      debugPrint("-------------------------");
      DilogCostom.dilogSecss(
          isErorr: true,
          title: Failure.dioexeptiontype(e)!,
          icons: Icons.close,
          color: Colors.redAccent);
    } catch (e) {
      DilogCostom.dilogSecss(
          isErorr: true,
          title: '$e',
          icons: Icons.close,
          color: Colors.redAccent);
    }
  }
}
