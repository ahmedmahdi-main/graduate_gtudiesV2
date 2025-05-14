import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduate_gtudiesV2/Services/base_route.dart';

import '../../../../Services/DilogCostom.dart';
import '../../../../Services/Failure.dart';
import '../../../../Services/Session.dart';
import '../student_personal_information.dart';

class PersonalInformationController {
  static Future<bool> insertPersonalInformation(
      StudentPersonalInformation studentPersonalInformation) async {
    var session = await getSession();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${session['token']!}',
    };
    var data = json.encode(studentPersonalInformation.toJson());
    // debugPrint('data ===== ${data}');
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseRoute/personalinforminsert',
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
          color: Colors.greenAccent,
        );

        return true;
      } else {
        debugPrint("-------------------------");
        debugPrint(response?.data.toString());
        debugPrint("-------------------------");
        DilogCostom.dilogSecss(
            isErorr: false,
            title: response.data["message"],
            icons: Icons.close,
            color: Colors.redAccent);
      }
    } on DioException catch (e) {
      debugPrint("-------------------------");
      debugPrint(e.response?.data.toString());
      debugPrint("-------------------------");
      DilogCostom.dilogSecss(
          isErorr: false,
          title: Failure.dioexeptiontype(e)!,
          icons: Icons.close,
          color: Colors.redAccent);
    } catch (e) {
      debugPrint("-------------------------");
      debugPrint(e.toString());
      debugPrint("-------------------------");
      DilogCostom.dilogSecss(
          isErorr: false,
          title: "هناك خطأ",
          icons: Icons.close,
          color: Colors.redAccent);
    }
    return false;
  }
}
