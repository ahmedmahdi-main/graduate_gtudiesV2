import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduate_gtudiesV2/Enums/documents_types.dart';
import 'package:graduate_gtudiesV2/Services/session_error_handler.dart';
import '../Enums/certificate_type.dart';
import '../Enums/channel_types.dart';
import '../Enums/college_status.dart';
import '../Models/data_information.dart';
import '../Models/exam_centers.dart';
import '../Models/full_student_data.dart';
import '../Models/super_data.dart';
import '../Models/type_of_study.dart';
import '../Models/college_authorized.dart';
import '../Services/base_route.dart';
import '../Services/costom_dialog.dart';
import '../Services/Failure.dart';
import '../Services/page_status.dart';
import '../Services/session.dart';
import '../view/pages/PersonalInformation/student_personal_information.dart'
    as page;
import '../view/pages/academic_information.dart' as page;
import '../view/pages/academic_information.dart';
import '../view/pages/functional_information.dart' as page;
import '../view/pages/submission_channel.dart' as page;
import '../view/pages/other_information.dart' as page;
import '../view/pages/PersonalInformation/personal_information.dart' as page;
import 'package:graduate_gtudiesV2/view/pages/Pledges/pledges_page.dart'
    as page;
import 'package:graduate_gtudiesV2/view/pages/UploadImage/upload_image_page.dart'
    as page;

import 'dropdown_filter_controllers.dart';

class HomePageController extends GetxController with SessionErrorHandler {
  int counter = 0;
  int degreeIndex = 0;
  Map<String, String>? session;
  Rx<bool> isLoading = true.obs;
  Rx<FullStudentData> fullStudentData = FullStudentData().obs;
  Rx<bool> haveSerialNumber = false.obs;
  Rx<bool> haveAuditAt = false.obs;
  Rx<String> studentName = ''.obs;
  RxBool haveInsertBachelor = false.obs;
  RxBool haveInsertDiploma = false.obs;
  RxBool haveInsertMasters = false.obs;
  RxBool haveInsertHighDiploma = false.obs;
  RxBool isEmployee = false.obs;

  /// *************Images*****************

  RxBool haveMartyrsFoundation = false.obs;

  RxBool havePeopleWithSpecialNeeds = false.obs;
  RxBool havePoliticalPrisoners = false.obs;
  RxBool haveCooperationMechanismOfNajafGovernorate = false.obs;
  RxBool privateAdmissionChannel = false.obs;

  void updateChannelState(ChannelTypes selectedChannel) {
    selectedChannel.setChannelState(this);
  }

  RxBool haveFirstStudentAverage = false.obs;
  RxBool haveUniversityOrderForTheMastersDegree = false.obs;
  RxBool haveUniversityOrderForDiploma = false.obs;
  RxBool haveUniversityOrderRegardingObtainingAnAcademicTitle = false.obs;
  RxBool haveStudyApproval = false.obs;
  RxBool haveComputerProficiencyCertificate = false.obs;
  RxBool haveEnglishLanguageProficiencyCertificate = false.obs;
  RxBool haveArabicLanguageProficiencyCertificate = false.obs;
  RxBool haveIletsCertificate = false.obs;
  RxBool haveOlympicCommitteeBook = false.obs;
  RxBool haveServiceFeed = false.obs;

  /// *************Images*****************

  var personalInformation = PageStatus.fromType(
      type: page.PersonalInformationForm, index: 0, isFull: false);
  var submissionChannel = PageStatus.fromType(
      type: page.SubmissionChannel, index: 1, isFull: false);
  var academicInformation = PageStatus.fromType(
      type: page.AcademicInformation, index: 2, isFull: false);
  var functionalInformation = PageStatus.fromType(
      type: page.FunctionalInformation, index: 3, isFull: false);
  var otherInformation =
      PageStatus.fromType(type: page.OtherInformation, index: 4, isFull: false);
  var uploadImagePage =
      PageStatus.fromType(type: page.UploadImagePage, index: 5, isFull: false);
  var pledgesPage =
      PageStatus.fromType(type: page.PledgesPage, index: 6, isFull: false);

  void setPageStatus() {
    personalInformation.isFull.value =
        fullStudentData.value.personalInformation!.isNotEmpty;
    functionalInformation.isFull.value =
        fullStudentData.value.careerInformation!.isNotEmpty;
    uploadImagePage.isFull.value =
        fullStudentData.value.imageInformation?.personalPhoto != null;
    academicInformation.isFull.value =
        fullStudentData.value.academicInformation!.isNotEmpty;
    if (fullStudentData.value.personalInformation!.isNotEmpty) {
      if (fullStudentData.value.personalInformation?.first.submission != null) {
        submissionChannel.isFull.value =
            fullStudentData.value.personalInformation?.first.submission?.osId !=
                null;
      }
    }
    otherInformation.isFull.value =
        fullStudentData.value.certificateCompetency!.isNotEmpty;
    pledgesPage.isFull.value = fullStudentData.value.serial != null;
  }

  void setImagesValue() {
    var images = fullStudentData.value.imageInformation;
    if (images == null) {
      return;
    }
    //TODO change image data
    if (fullStudentData.value.academicInformation!.isNotEmpty) {
      haveUniversityOrderForTheMastersDegree.value = fullStudentData
          .value.academicInformation!
          .any((a) => a.certificateTypeId == CertificateType.masters.id);
      haveUniversityOrderForDiploma.value = fullStudentData
          .value.academicInformation!
          .any((a) => a.certificateTypeId == CertificateType.diploma.id);
      haveFirstStudentAverage.value = fullStudentData.value.academicInformation!
          .where((a) => a.certificateTypeId == CertificateType.bachelors.id)
          .first
          .documents!
          .any((d) =>
              d.documentsTypeId ==
              DocumentsType.firstStudentAverageConfirmationLetter.id);
    }
    if (fullStudentData.value.personalInformation!.isNotEmpty &&
        fullStudentData
            .value.personalInformation!.first.admissionChannel!.isNotEmpty) {
      var channelId = fullStudentData
          .value.personalInformation!.first.admissionChannel?.first.channelsId;
      if (channelId != null) {
        ChannelTypes? selectedChannel = ChannelTypesExtension.fromId(channelId);
        if (selectedChannel != null) {
          updateChannelState(selectedChannel);
        }
      }
    }
    havePeopleWithSpecialNeeds.value = images.peopleWithSpecialNeeds != null;
    havePoliticalPrisoners.value = images.politicalPrisoners != null;
    haveFirstStudentAverage.value = images.firstStudentAverage != null;
    haveUniversityOrderRegardingObtainingAnAcademicTitle.value =
        images.universityOrderRegardingObtainingAnAcademicTitle != null;
    haveComputerProficiencyCertificate.value =
        images.computerProficiencyCertificate != null;
    haveEnglishLanguageProficiencyCertificate.value =
        images.englishLanguageProficiencyCertificate != null;
    haveArabicLanguageProficiencyCertificate.value =
        images.arabicLanguageProficiencyCertificate != null;
    haveIletsCertificate.value = images.iletsCertificate != null;
    haveOlympicCommitteeBook.value = images.olympicCommitteeBook != null;
  }

  /// *********variables*****************
  CollegeAuthorized collegeAuthorized = CollegeAuthorized();
  Rx<int?> typeConsentId = 0.obs;
  Rx<int?> departmentId = 0.obs;
  Rx<int?> collageId = 0.obs;
  RxBool sportCollage = false.obs;
  RxBool firstQuarter = false.obs;

  RxBool haveUniversityService = false.obs;
  Rx<int?> certificateTypeId = 0.obs;
  RxBool haveMaster = false.obs;
  RxBool isMasterWithinPeriod = false.obs;
  RxBool isMasterInsideIraq = false.obs;
  String? dateCommencement;
  Rx<double?> averageMaster = 0.0.obs;

  bool checkDateCommencement() {
    if (!haveMaster.value) {
      return true;
    }
    if (dateCommencement == null || dateCommencement == '') {
      debugPrint('dateCommencement == null');
      return true;
    }
    var date = DateTime.parse(dateCommencement!.replaceAll('/', '-'));
    var newDate = DateTime(date.year + 2, date.month, date.day);
    var date1 = DateTime(DateTime.now().year, 10, 1);
    debugPrint('haveUniversityService.value = ${haveUniversityService.value}');
    if (haveUniversityService.value) {
      debugPrint('haveUniversityService.value');
      return true;
    }

    // Case for certificateTypeId 5
    if (certificateTypeId.value != 5) {
      debugPrint('!newDate.isAfter(date1)');
      return !newDate.isAfter(date1);
    }
    if (!isMasterInsideIraq.value) {
      debugPrint('isMasterInsideIraq');
      return false;
    }
    return (averageMaster.value! >= 80 && isMasterWithinPeriod.value);
  }

  RxBool maturityIelts = false.obs;

  Rx<double?> averageBachelors = 0.0.obs;

  Future<void> setVariablesValues() async {
    final dropdownListController = Get.put(DropdownListController());
    await dropdownListController.setSuperData();
    await dropdownListController.setDataInformation();
    try {
      debugPrint('${fullStudentData.value.personalInformation?.length}');
      if (fullStudentData.value.personalInformation!.isEmpty) {
        return;
      }
      final personalInfo = fullStudentData.value.personalInformation?.first;
      if (personalInfo?.submission != null &&
          personalInfo?.submission?.departmentId != null) {
        departmentId.value = personalInfo?.submission!.departmentId;
        final department = dropdownListController.superData?.department
            ?.firstWhereOrNull((d) => d.departmentId == departmentId.value);
        collageId.value = department?.collegesId;
        final college = dropdownListController.superData?.colleges
            ?.firstWhereOrNull((c) => c.collegesId == collageId.value);
        final collegeStatus =
            CollegeStatus.values[college?.status ?? 0]; // Default to `inactive`
        sportCollage.value = collegeStatus == CollegeStatus.activeSport;
        maturityIelts.value =
            collegeStatus == CollegeStatus.activeMaturityIelts;
        // debugPrint('tSId = ${personalInfo?.tSId}');
        //certificateTypeId.value = personalInfo?.tSId;
      }

      final careerInfo = fullStudentData.value.careerInformation?.firstOrNull;
      if (careerInfo != null && careerInfo.employmentStatusId != 3) {
        haveStudyApproval.value = true;
        debugPrint('haveStudyApproval.value = ${haveStudyApproval.value}');
        typeConsentId.value = careerInfo.typeConsentId;
        dateCommencement = careerInfo.dateCommencement;
        var filteredMinistries = dropdownListController.ministry!
            .where((m) => m.ministryId == careerInfo.ministryId);
        if (filteredMinistries.isNotEmpty) {
          var ministry = filteredMinistries.first.heirghEduSevice == 1;
          haveUniversityService.value = ministry;
        } else {
          // Handle the case where no matching ministry is found
          debugPrint("No ministry found with the given ministryId.");
        }
      }

      final bachelors =
          fullStudentData.value.academicInformation?.firstWhereOrNull(
        (a) => a.certificateTypeId == CertificateType.bachelors.id,
      );
      if (bachelors != null) {
        averageBachelors.value = bachelors.average;
      }
    } on Exception catch (e) {
      debugPrint('setVariablesValues Exception: $e');
    }
  }

  /// *********variables*****************
  @override
  void onReady() async {
    // TODO: implement onReady
    await setVariablesValues();
    setImagesValue();
    await checkAndNavigate();
    setPageStatus();
    super.onReady();
  }

  @override
  void onInit() async {
    debugPrint('onInit fullStudent');
    isLoading.value = true;
    update();
    //
    if (await checkSession()) {
      return;
    }
    fullStudentData.value = await fullStudent();
    isLoading.value = false;
    update();
    super.onInit();
  }

  Future<bool> checkSession() async {
    session = await getSession();
    if (session?['token'] == 'null') {
      Get.offAllNamed('/');
      return true;
    }
    return false;
  }

  Future<void> checkAndNavigate() async {
    var serial = fullStudentData.value.serial;
    bool hasSerialNumber = serial != null;
    bool haveAudit = false;
    haveSerialNumber.value = hasSerialNumber;

    // Check if the system is set to 'off'
    bool systemOpen = fullStudentData.value.systemConfig?.opensystem == 'off';

    // Ensure formmessage is not null or empty before accessing .first
    bool approveAt = false;
    var formMessage = fullStudentData.value.systemConfig?.formmessage;

    if (formMessage != null && formMessage.isNotEmpty) {
      var firstFormMessage = formMessage.first;
      var audit = firstFormMessage.audit;
      haveAudit = audit == 'تعديل' || audit == 'طلب تعديل';
      approveAt = (firstFormMessage.approveAt?.isNotEmpty ?? false) &&
          (firstFormMessage.modifiedAt?.isEmpty ?? true);
    }

    if (systemOpen || hasSerialNumber) {
      // Navigate to SystemConfigPageRout if system is 'off' or serial exists, and there's no audit
      // Get.offNamed('/DesktopHomePage');
      Get.offNamed('/SystemConfigPageRout');
    } else {
      // Otherwise, load the DesktopHomePage
      Get.offNamed('/DesktopHomePage');
    }
  }

  PageController pageController = PageController(initialPage: 0);
  var certificate = <String>['دبلوم', 'بكالوريوس', 'دبلوم عالي', 'ماجستير'];

  void pageChange(int index) {
    counter = index;
    pageController.animateToPage(counter,
        duration: const Duration(milliseconds: 1), curve: Curves.linear);
    update();
  }

  removeCertificateList(String val) {
    certificate.removeWhere((element) => element == val ? true : false);
  }

  void removeDegree(int index, String val) {
    certificate.addAll([val]);
    dgreem.remove(index);
    update();
  }

  void updatePersonalInfo(page.StudentPersonalInformation info) {
    fullStudentData.value.personalInformation?.clear();
    fullStudentData.value.personalInformation
        ?.add(FullDataPersonalInformation.fromStudentPersonalInformation(info));
    personalInformation.isFull.value = true;
  }

  Future<FullStudentData> fullStudent() async {
    debugPrint('fullStudent');
    if (session == null) {
      return FullStudentData();
    }
    try {
      var headers = {'Authorization': 'Bearer ${session?['token']}'};
      var dio = Dio();

      var response = await dio.request(
        '$baseRoute/FulldataController',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      debugPrint(
          'response.statusCode ------------------------ ${response.statusCode}');

      if (response.statusCode == 200) {
        var data = FullStudentData.fromJson(response.data);
        return data;
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 406) {
        await DilogCostom.dilogSecss(
          isErorr: true,
          title: 'يرجى تفعيل الايميل أولا',
          icons: Icons.close,
          color: Colors.redAccent,
        );
        Get.toNamed('/OTP', arguments: {'token': session?['token']});
      }
      if (e.response?.statusCode == 401) {
        DilogCostom.dilogSecss(
          isErorr: true,
          title: "انتهت صلاحية الجلسة، يرجى تسجيل الدخول مرة أخرى",
          icons: Icons.lock_clock,
          color: Colors.redAccent,
        );
        // Navigate to login page
        Get.offAllNamed('/login');
      } else {
        debugPrint("------------DioException FullStudentData-------------");
        debugPrint(e.message);
        await DilogCostom.dilogSecss(
          isErorr: true,
          title: Failure.dioexeptiontype(e)!,
          icons: Icons.close,
          color: Colors.redAccent,
        );
        // Redirect to the home page after showing the dialog
        Get.offAllNamed('/');
      }
    } catch (e) {
      debugPrint("-----------Exception FullStudentData--------------");
      debugPrint(e.toString());
      await DilogCostom.dilogSecss(
        isErorr: true,
        title: 'هناك خطأ',
        icons: Icons.close,
        color: Colors.redAccent,
      );
      // Redirect to the home page after showing the dialog
      Get.offAllNamed('/');
    }

    return FullStudentData();
  }

  /// ******* Print Page ***********
  SuperData? superData;
  Failure? failure;
  List<String> imageList = [];
  ExamCenters? examCentersModule;
  DataInformation? informationModule;

  Future<void> getDataToPrint() async {
    try {
      session = await getSession();
      superData = await getAllData();
      informationModule = await getDataInformation();
      examCentersModule = await getExamCenters();
    } catch (e) {
      debugPrint('Error loading data: $e');
      // Handle the error e.g., retrying, sending to error logging, showing a user message, etc.
    }
  }

  Future<SuperData?> getAllData() async {
    try {
      debugPrint('-----------------getAllData--------------------- ');
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
        debugPrint(
            '-----------------getAllData--------------------- ${response.data}');
        return SuperData.fromJson(response.data);
      }
    } on DioException catch (e) {
      handleDioError(e);
      // if (dioex.response?.statusCode == 401) {
      //   DilogCostom.dilogSecss(
      //     isErorr: true,
      //     title: "انتهت صلاحية الجلسة، يرجى تسجيل الدخول مرة أخرى",
      //     icons: Icons.lock_clock,
      //     color: Colors.redAccent,
      //   );
      //   // Navigate to login page
      //   Get.offAllNamed('/login');
      //   return null;
      // }
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
    } on DioException catch (e) {
      handleDioError(e);
      return null;
    } on Exception catch (e) {
      debugPrint('-----------------getTypeofStudy--------------------- $e');
      return null;
    }
  }

  Future<DataInformation> getDataInformation() async {
    try {
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
    } on DioException catch (e) {
      handleDioError(e);
      return DataInformation();
    } on Exception catch (e) {
      debugPrint('-----------------getDataInformation--------------------- $e');
      return DataInformation();
    }

    return DataInformation();
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
      return null;
    } catch (e) {
      DilogCostom.dilogSecss(
          isErorr: true,
          title: 'هناك خطأ',
          icons: Icons.close,
          color: Colors.redAccent);
    }
    return null;
  }

  Future<CollegeAuthorize?> getCollageAuth() async {
    var headers = {'Authorization': 'Bearer ${session!['token']}'};
    var dio = Dio();
    debugPrint('collageId.value = ${collageId.value}');
    if (collageId.value == 0) {
      return null;
    }
    try {
      var response = await dio.request(
        '$baseRoute/College_Authorized/${collageId.value}',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        //debugPrint(json.encode(response.data));
        return CollegeAuthorize.fromJson(response.data);
      } else {
        debugPrint(response.statusMessage);
      }
    } on DioException catch (e) {
      handleDioError(e);
      return null;
    } on Exception catch (e) {
      debugPrint('$e');
    }
  }

  /// ******* Print Page ***********
  ///
  Future<void> modifyComplete() async {
    var headers = {'Authorization': 'Bearer ${session!['token']}'};
    var dio = Dio();
    var response = await dio.request(
      '$baseRoute/modify_complete',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
    );

    if (response.statusCode == 200) {
      debugPrint(json.encode(response.data));
      Get.offNamed('/SystemConfigPageRout');
    } else {
      debugPrint(response.statusMessage);
    }
  }

  Future<bool> checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      // Further check if there is an actual internet connection
      try {
        final result = await InternetAddress.lookup(baseRoute);
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          return true; // Connected to the internet
        }
      } on SocketException catch (_) {
        return false; // No internet connection
      }
    }
    return false; // No internet connection
  }
}
