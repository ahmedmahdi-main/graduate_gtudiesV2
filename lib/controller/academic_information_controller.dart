import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dioo;
import '../Models/academic_information.dart';
import '../Services/base_route.dart';
import '../Services/DilogCostom.dart';
import '../Services/Failure.dart';
import '../Services/Session.dart';

class AcademicInformationController extends GetxController {
  AcademicInformationModel? academicInformationModel;

  AcademicInformation academicInformation = AcademicInformation();
  Map<String, String>? session;

  @override
  void onInit() {
    academicInformationModel = AcademicInformationModel();
    academicInformationModel?.academicInformation = <AcademicInformation>[];
    academicInformation = AcademicInformation();
    //getSessionInfo();
    getSessionInfo();
    super.onInit();
  }

  Future<void> getSessionInfo() async {
    session = await getSession();
  }
  void addOrUpdateAcademicInformation(AcademicInformation newAcademicInfo) {
    debugPrint('Adding/Updating Academic Info');
    if (academicInformationModel == null) {
      debugPrint('-----------academicInformationModel is null-----------');
      return;
    }

    var existingIndex = academicInformationModel!.academicInformation?.indexWhere(
            (info) => info.certificateTypeId == newAcademicInfo.certificateTypeId);

    if (existingIndex != null && existingIndex != -1) {
      // Replace existing AcademicInformation
      academicInformationModel!.academicInformation![existingIndex] = newAcademicInfo;
      debugPrint('Updated information at index $existingIndex');
    } else {
      // Add new AcademicInformation if it doesn't exist
      academicInformationModel!.academicInformation?.add(newAcademicInfo);
      debugPrint('Added new academic information');
    }
    debugPrint('Current list size: ${academicInformationModel!.academicInformation?.length}');
  }
  Future<bool> printAcademicInformation() async {
    getSessionInfo();
    debugPrint('academicInformationModel ===== ${academicInformationModel!.toJson()}');
    academicInformationModel?.academicInformation!.map((e) => e.documents!.map(
        (e) => debugPrint(
            '\n  documentsNumber = ${e.documentsNumber}  \n  documentsDate = ${e.documentsDate}')));
 return  await saveAcademicInformation(session!['token']!, academicInformationModel!);
  }

  Future<bool> saveAcademicInformation(
      String token, AcademicInformationModel academicInformation) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var data = academicInformation.toJson();
      debugPrint('academicInformation ${academicInformation.toJson()}');
      var dio = Dio();
      var response = await dio.request(
        '$baseRoute/document',
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
    return false;
  }
}
