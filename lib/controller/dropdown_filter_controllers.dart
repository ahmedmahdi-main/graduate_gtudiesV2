import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:graduate_gtudiesV2/Models/super_data.dart';

import '../Models/data_information.dart';
import '../Models/type_of_study.dart';
import '../Services/base_route.dart';
import '../Services/Session.dart';

class DropdownListController extends GetxController {
  SuperData? superData;
  Map<String, String>? session;
  final isLoading = false.obs;
  TypeofStudy? studyTypes;
  DataInformation? dataInformation;
  int? channelsDataValue;
  int? typeofStudyValue;
  int? scientificBackgroundsValue1;
  int? universityId = 1;
  Rx<int?> universityValue = 0.obs;
  //bool isLoading = true;
  bool hasDocuments = false;

  List<Colleges>? colleges;
  List<Department>? departments;
  List<Universities>? universities;
  List<Specializations>? specializations;
  List<Subspecializations>? subSpecializations;
  List<Scientificbackgrounds>? scientificBackgrounds;
  List<Relativerelations>? relativeRelations;
  List<Admissionchannel>? admissionChannel;
  List<ChannelsData>? channelsData;
  List<OpenStudies>? openStudies;
  List<OpenStudy>? openStudy;

  List<Ministry>? ministry;
  List<Typeconsentforstudys>? typeConsentForStudy;
  List<Scientifictitles>? scientificTitles;
  List<EmploymentstatusData>? employmentStatusData;
  int? collegesValue;
  int? departmentValue;

  int? specializationsValue;

  dynamic scientificBackgroundsValue;

  @override
  void onInit() async {
    openStudy = [];
    isLoading.value = true;
    update();
    session = await getSession();
    await setSuperData();
    await setDataInformation();
    isLoading.value = false;
    update();
    setOpenStudiesValue();
    super.onInit();
  }

  Future<void> setDataInformation() async {
    dataInformation = await getDataInformation();
    ministry = dataInformation?.ministry;
    typeConsentForStudy = dataInformation?.typeconsentforstudys;
    scientificTitles = dataInformation?.scientifictitles;
    employmentStatusData = dataInformation?.employmentstatusData;

    update(['الحالة الوظيفية']);
    update(['نوع الموافقة الدراسية']);
    update(['اللقب العلمي']);
    update(['اسم الوزارة']);
    //update(['القسم']);
  }

  void setOpenStudiesValue() {
    openStudy = [];
    for (var typeofStudy in superData!.typeofStudies!) {
      for (var openstudy in superData!.openStudies!) {
        if (typeofStudy.tSid == openstudy.typeofstudy) {
          openStudy?.add(OpenStudy(
              osId: openstudy.osId,
              departmentId: openstudy.departmentId,
              subjects: openstudy.subjects,
              durationOfStudy: openstudy.durationOfStudy,
              typeofstudy: typeofStudy.name));
        }
      }
    }
  }

  fillterOpenStudiesValue(int departmentId) {
    setOpenStudiesValue();
    openStudy = openStudy!
        .where((element) => element.departmentId == departmentId)
        .toList();
  }

  void fillterUniversity(String value) {
    universities = superData!.universities!.toList();
    String country = 'العراق';
    if (value == 'خارج العراق') {
      universities =
          universities!.where((element) => element.country != country).toList();
    } else {
      universities =
          universities!.where((element) => element.country == country).toList();
    }
    update();
  }

  void fillterColleges(int value, String id) {
    colleges = superData!.colleges!.toList();
    colleges = colleges!.where((element) => element.universityId == value).toList();

    var departmentId = superData!.openStudies!.map((e) => e.departmentId).toList();
    var collegesId = superData!.department!.where((e)=> departmentId.contains(e.departmentId)).map((e) => e.collegesId).toList();

    // Corrected line: filter colleges where their ID is in collegesId
    colleges = colleges?.where((e) => collegesId.contains(e.collegesId)).toList();

    update([id]);
  }

  void fillterDepartments(int value,String id) {
    specializations = superData!.specializations!.toList();
    specializations =
        specializations!.where((element) => element.departmentId == value).toList();
    update([id]);
  }

  Future<void> setSuperData() async {
    superData = await getAllData();
    //studyTypes = await getTypeofStudy();
    if (superData != null) {
      universityId = superData!.universities!
          .where((element) => element.status == 1)
          .first
          .universityId!;
      universities = superData?.universities;
      /*
      *
      * */

      colleges = superData?.colleges
          ?.where((element) => element.universityId == universityId)
          .toList();
      var departmentId = superData!.openStudies!.map((e) => e.departmentId).toList();
      var collegesId = superData!.department!.where((e)=> departmentId.contains(e.departmentId)).map((e) => e.collegesId).toList();

      // Corrected line: filter colleges where their ID is in collegesId
      colleges = colleges?.where((e) => collegesId.contains(e.collegesId)).toList();

      departments = superData?.department?.where((e)=> departmentId.contains(e.departmentId)).toList();
      specializations = superData?.specializations?.where((e)=> departmentId.contains(e.departmentId)).toList();
      subSpecializations = superData?.subSpecializations;
      admissionChannel = superData?.admissionchannel;
      channelsData = superData?.channelsData;
        scientificBackgrounds =superData!.scientificBackgrounds != null ? superData!.scientificBackgrounds!
          .where((element) => element.universityId == universityId)
          .toList() : [];

    }
    
    // universityId = superData!.universities!
    //     .where((element) => element.status == 1)
    //     .first
    //     .universityId!;

    // universities = superData!.universities!;
    // colleges = superData!.colleges!
    //     .where((element) => element.universityId == universityId)
    //     .toList();
    // specializations = superData!.specializations!
    //     .where((element) => element.universityId == universityId)
    //     .toList();

    // scientificBackgrounds = superData!.scientificBackgrounds!
    //     .where((element) => element.universityId == universityId)
    //     .toList();
    // admissionChannel = superData!.admissionchannel!;
    // channelsData = superData!.channelsData!;
    // update(['الكلية المراد التقديم عليها']);
    // update(['نوع الدراسة المطلوبة']);
    // update(['التخصص']);
    // update(['الاختصاص الحاصل عليه (الخلفيةالعلمية)']);

  }

  void specializationsData(int index) {
    specializations = superData!.specializations!
        .where((element) => element.universityId == universityId)
        .toList();
    specializationsValue = null;
    update(['التخصص']);
    specializations = specializations!
        .where((specialization) =>
            checkTypeOfStudy(specialization.typeofstudy, index))
        .toList();
    update([
      'التخصص',
    ]);
  }

  void departmentsData() {
    //specializations= null;
    departments = superData!.department;
    update(['القسم']);
    //TODO collegesFilter
    departments = superData!.department!
        .where((element) => element.collegesId == collegesValue)
        .toList();
    update(['القسم']);
  }

  // void openStudiesData() {
  //   //specializations= null;
  //   openStudies = superData!.openstudies;
  //   update(['الدراسة المفتوحة']);
  //   //TODO collegesFilter
  //   openStudies = superData!.openstudies!
  //       .where((element) => element.departmentId == departmentValue)
  //       .toList();
  //   update(['الدراسة المفتوحة']);
  // }

  void scientificBackgroundsData() {
    scientificBackgrounds = superData!.scientificBackgrounds!
        .where((element) => element.universityId == universityId)
        .toList();
    scientificBackgrounds = scientificBackgrounds!
        .where((element) =>
            element.departmentId == departmentValue )
        .toList();
    update(['الاختصاص الحاصل عليه (الخلفيةالعلمية)']);
  }

  bool checkTypeOfStudy(String? inputString, int index) {
    if (inputString == null) {
      return false;
    }
    List<dynamic> parsedList = jsonDecode(inputString);
    List<int> intList = List<int>.from(parsedList);
    // debugPrint(
    //     '-------------------نوع الدراسة المطلوبة---------------------- ${intList[index - 1] == 1}');
    return intList[index - 1] == 1;
  }

  Future<SuperData?> getAllData() async {
    try {
      session = await getSession();
      var headers = {'Authorization': 'Bearer ${session?['token']}'};
      var dio = Dio();
      var response = await dio.request(
        '$baseRoute/Superdata',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        return SuperData.fromJson(response.data);
      }
    } on DioException catch (dioex) {
      debugPrint('----------------getAllData---------------------- $dioex');
      return null;
    } on Exception catch (e) {
      debugPrint('----------------getAllData---------------------- $e');
      return null;
    }
    return null;
  }

  Future<TypeofStudy?> getTypeofStudy() async {
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseRoute/typeofstudy',
        options: Options(
          method: 'POST',
        ),
      );

      if (response.statusCode == 200) {
        return TypeofStudy.fromJson(response.data);
      } else {
        //debugPrint('-------------------TypeofStudy.fromJson(response.data)-----------------${TypeofStudy.fromJson(response.data)}');
        return null;
      }
    } on DioException catch (dioex) {
      debugPrint('------------getTypeofStudy-------------------------- $dioex');
      return null;
    } on Exception catch (e) {
      debugPrint('-----------------getTypeofStudy--------------------- $e');
      return null;
    }
  }

  Future<DataInformation> getDataInformation() async {
    try {
      debugPrint('session?[token] == ${session?['token']}');
      var headers = {'Authorization': 'Bearer ${session?['token']}'};
      var dio = Dio();
      var response = await dio.request(
        '$baseRoute/information',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        return DataInformation.fromJson(response.data);
      }
    } on DioException catch (dioex) {
      debugPrint('------------getDataInformation-------------------------- ${dioex.message}');
      return DataInformation();
    } on Exception catch (e) {
      debugPrint('-----------------getDataInformation--------------------- $e');
      return DataInformation();
    }

    return DataInformation();
  }
}
