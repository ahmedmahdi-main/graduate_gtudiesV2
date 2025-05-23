import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:graduate_gtudiesV2/Services/session_error_handler.dart';

import '../Models/exam_centers.dart';
import '../Services/base_route.dart';
import '../Services/costom_dialog.dart';
import '../Services/session.dart';

class ExamCentersController extends GetxController with SessionErrorHandler{
  bool isLoading = true;
  ExamCenters? examCenters;
  Map<String, String>? session;

  Future<void> getSessionInfo() async {
    session = await getSession();
  }

  @override
  void onInit() async {
    examCenters = ExamCenters();
    await getSessionInfo();
    await setExamCenter();
    super.onInit();
  }

  Future<void> setExamCenter() async {
    isLoading = true;
    update();
    examCenters = await getExamCenters();
    update(['الجهة المانحة لامتحان كفائة العربي']);
    update(['الجهة المانحة لامتحان كفائة الانكليزي']);
    update(['الجهة المانحة لامتحان كفائة الحاسوب']);
    update(['الجهة المانحة ielts']);
    isLoading = false;
    update();
    //'الجهة المانحة ILTS'
  }

  Future<ExamCenters?> getExamCenters() async {
    try {
      var headers = {'Authorization': 'Bearer ${session!['token']}'};
      var dio = Dio();
      var response = await dio.request(
        '$baseRoute/ExamCenters',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        return ExamCenters.fromJson(response.data);
      } else {
        debugPrint(response.statusMessage);
        return ExamCenters();
      }
    } on DioException catch (e) {
        handleDioError(e);

    } catch (e) {
      DilogCostom.dilogSecss(
          isErorr: true,
          title: 'هناك خطأ',
          icons: Icons.close,
          color: Colors.redAccent);
    }
    return null;
  }
}
