import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:graduate_gtudiesV2/Models/full_student_data.dart';

import '../Models/data_information.dart';
import '../Models/exam_centers.dart';
import '../Models/super_data.dart';
import '../Services/Failure.dart';
import '../Services/session.dart';
import 'home_page_controller.dart';

class StudentDataController extends GetxController {
  HomePageController homePageController = Get.find();
  // DropdownListController dropdownListController =
  //     Get.put(DropdownListController());
  //
  // ExamCentersController examCentersController =
  //     Get.put(ExamCentersController());
  Map<String, String>? session;
  bool isloading = true;
  FullStudentData? studentSingleDataModule;
  SuperData? superData;
  Failure? failure;
  List<String> imageList = [];
  ExamCenters? examCentersModule;
  DataInformation? informationModule;
  String? studentid;
  RxBool printingLoading = false.obs;
  RxBool printingSave = false.obs;
  RxBool ShowImage = false.obs;



  Future<void> getDataToPrint() async {
    try {
      session = await getSession();
      await homePageController.getDataToPrint();
      superData = homePageController.superData;
      informationModule = homePageController.informationModule;
      examCentersModule =homePageController.examCentersModule;
      studentSingleDataModule = homePageController.fullStudentData.value;
      debugPrint('studentSingleDataModule = ${studentSingleDataModule?.toJson().toString()}');
    } catch (e) {
      debugPrint('Error loading data: $e');
      // Handle the error e.g., retrying, sending to error logging, showing a user message, etc.
    }
  }

  @override
  void onInit() async {
    // isloading = true;
    // update();
await getDataToPrint();
    // isloading = false;
    // update();
    super.onInit();
  }

  Future<Uint8List?> fetchImage(String? imageId) async {
    log("$imageId");
    var dio = Dio();
    if (imageId != null) {
      try {
        var response = await dio.get(
          imageId,
          options: Options(
            responseType: ResponseType.bytes,
          ),
        );

        if (response.statusCode == 200) {
          if (response.data is Uint8List) {
            return (response.data);
          }
        } else {
          print(response.statusMessage);
        }
      } catch (e) {
        print(e);
      }
    }

    return null;
  }

//الاختصاص العام
  Specializations? specializations({int? specializationsId}) {
    //log("${specializationsId}", name: "specializations Id");
    if (specializationsId == null) {
      return null;
    } else {
      Specializations? specializations;
      superData?.specializations?.forEach((element) {
        if (element.specializationId == specializationsId) {
          specializations = element;
        }
      });
      // log("${specializations?.specializationName}",
      //     name: "specializations Student");
      return specializations;
    }
//الاختصاص  الدقيق
  }

  //الخلفية العلمية

  Scientificbackgrounds? scientificBackgrounds({int? scientificbackgroundsId}) {
    if (scientificbackgroundsId == null) {
      return null;
    } else {
      Scientificbackgrounds? specializations;
      superData?.scientificBackgrounds?.forEach((element) {
        if (element.scientificbackgroundId == scientificbackgroundsId) {
          specializations = element;
        }
      });

      // log("${specializations?.scientificbackgroundName}",
      //     name: "specializations Student");
      return specializations;
    }
  }

  Universities? universities({int? universitiesId}) {
    if (universitiesId == null) {
      return null;
    } else {
      Universities? universities;
      superData?.universities?.forEach((element) {
        if (element.universityId == universitiesId) {
          universities = element;
        }
      });
      // log("${specializations?.specializationName}",
      //     name: "specializations Student");
      return universities;
    }
  }

  Colleges? colleges({int? collegesId}) {
    if (collegesId == null) {
      return null;
    } else {
      Colleges? colleges;
      superData?.colleges?.forEach((element) {
        if (element.collegesId == collegesId) {
          colleges = element;
        }
      });
      // log("${specializations?.specializationName}",
      //     name: "specializations Student");
      return colleges;
    }
  }

  Department? department({int? departmentId}) {
    if (departmentId == null) {
      return null;
    } else {
      Department? department;
      superData?.department?.forEach((element) {
        if (element.departmentId == departmentId) {
          department = element;
        }
      });
      // log("${specializations?.specializationName}",
      //     name: "specializations Student");
      return department;
    }
  }

  Typeconsentforstudys? typeconsentforstudys({int? typrofstudeid}) {
    if (typrofstudeid == null) {
      return null;
    } else {
      Typeconsentforstudys? typeconsentforstudy;
      informationModule?.typeconsentforstudys?.forEach((element) {
        if (element.typeConsentId == typrofstudeid) {
          typeconsentforstudy = element;
        }
      });
      // log("${specializations?.specializationName}",
      //     name: "specializations Student");
      return typeconsentforstudy;
    }
  }

  Scientifictitles? scientificTitles({int? scientifictitlesid}) {
    if (scientifictitlesid == null) {
      return null;
    } else {
      Scientifictitles? scientificTitle;
      informationModule?.scientifictitles?.forEach((element) {
        if (element.scientificTitleId == scientifictitlesid) {
          scientificTitle = element;
        }
      });
      // log("${specializations?.specializationName}",
      //     name: "specializations Student");
      return scientificTitle;
    }
  }

  Ministry? ministries({int? ministriesId}) {
    if (ministriesId == null) {
      return null;
    } else {
      Ministry? ministries;
      informationModule?.ministry?.forEach((element) {
        if (element.ministryId == ministriesId) {
          ministries = element;
        }
      });
      // log("${specializations?.specializationName}",
      //     name: "specializations Student");
      return ministries;
    }
  }

  EmploymentstatusData? employmentStatusData({int? employmentstatusDataid}) {
    if (employmentstatusDataid == null) {
      return null;
    } else {
      EmploymentstatusData? employmentStatusData;
      informationModule?.employmentstatusData?.forEach((element) {
        if (element.employmentStatusId == employmentstatusDataid) {
          employmentStatusData = element;
        }
      });
      // log("${specializations?.specializationName}",
      //     name: "specializations Student");
      return employmentStatusData;
    }
  }

  Centers? centers({int? centersId}) {
    if (centersId == null) {
      return null;
    } else {
      Centers? centers;
      examCentersModule?.centers?.forEach((element) {
        if (element.examCenterId == centersId) {
          centers = element;
        }
      });
      // log("${specializations?.specializationName}",
      //     name: "specializations Student");
      return centers;
    }
  }

  DocumentsTypes? documentstypes(int? documentstypesid) {
    if (documentstypesid == null) {
      return null;
    } else {
      DocumentsTypes? documentstype;
      superData?.documentsTypes?.forEach((element) {
        if (element.documentsTypeId == documentstypesid) {
          documentstype = element;
        }
      });

      return documentstype;
    }
  }

  ChannelsData? channelsData({int? channelsDataId}) {
    if (channelsDataId == null) {
      return null;
    } else {
      ChannelsData? channelsdata;
      superData?.channelsData?.forEach((element) {
        if (element.channelId == channelsDataId) {
          channelsdata = element;
        }
      });

      return channelsdata;
    }
  }

  Relativerelations? Relative({int? id}) {
    if (id == null) {
      return null;
    }
    Relativerelations? rel = superData?.relativeRelations
        ?.firstWhereOrNull((e) => e.relativeId == id);
    return rel;
  }
  // Future<SuperData?> getAllData() async {
  //   try {
  //     var headers = {'Authorization': 'Bearer ${session?['token']}'};
  //     var dio = Dio();
  //     var response = await dio.request(
  //       '$baseRoute/Superdata',
  //       options: Options(
  //         method: 'POST',
  //         headers: headers,
  //       ),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       debugPrint(
  //           '-----------------getAllData--------------------- ${response.data}');
  //       return SuperData.fromJson(response.data);
  //     }
  //   } on DioException catch (dioex) {
  //     debugPrint('----------------getAllData---------------------- $dioex');
  //     return null;
  //   } on Exception catch (e) {
  //     debugPrint('----------------getAllData---------------------- $e');
  //     return null;
  //   }
  //
  //   return null;
  // }
  //
  // Future<TypeofStudy?> getTypeofStudy() async {
  //   try {
  //     var dio = Dio();
  //     var response = await dio.request(
  //       '$baseRoute/typeofstudy',
  //       options: Options(
  //         method: 'POST',
  //       ),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       return TypeofStudy.fromJson(response.data);
  //     } else {
  //       //debugPrint('-------------------TypeofStudy.fromJson(response.data)-----------------${TypeofStudy.fromJson(response.data)}');
  //       return null;
  //     }
  //   } on DioException catch (dioex) {
  //     debugPrint('------------getTypeofStudy-------------------------- $dioex');
  //     return null;
  //   } on Exception catch (e) {
  //     debugPrint('-----------------getTypeofStudy--------------------- $e');
  //     return null;
  //   }
  // }
  //
  // Future<DataInformation> getDataInformation() async {
  //   try {
  //     var headers = {'Authorization': 'Bearer ${session?['token']}'};
  //     var dio = Dio();
  //     var response = await dio.request(
  //       '$baseRoute/information',
  //       options: Options(
  //         method: 'POST',
  //         headers: headers,
  //       ),
  //     );
  //     if (response.statusCode == 200) {
  //       return DataInformation.fromJson(response.data);
  //     }
  //   } on DioException catch (dioex) {
  //     debugPrint('------------getDataInformation-------------------------- ${dioex.message}');
  //     return DataInformation();
  //   } on Exception catch (e) {
  //     debugPrint('-----------------getDataInformation--------------------- $e');
  //     return DataInformation();
  //   }
  //
  //   return DataInformation();
  // }
  // Future<ExamCenters?> getExamCenters() async {
  //   try {
  //     var headers = {'Authorization': 'Bearer ${session!['token']}'};
  //     var dio = Dio();
  //     var response = await dio.request(
  //       '$baseRoute/ExamCenters',
  //       options: Options(
  //         method: 'GET',
  //         headers: headers,
  //       ),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       return ExamCenters.fromJson(response.data);
  //     } else {
  //       print(response.statusMessage);
  //       return ExamCenters();
  //     }
  //   } on DioException catch (e) {
  //     print("-------------------------");
  //     print(e.response?.data.toString());
  //     print("-------------------------");
  //     DilogCostom.dilogSecss(
  //         isErorr: true,
  //         title: Failure.dioexeptiontype(e)!,
  //         icons: Icons.close,
  //         color: Colors.redAccent);
  //   } catch (e) {
  //     DilogCostom.dilogSecss(
  //         isErorr: true,
  //         title: 'هناك خطأ',
  //         icons: Icons.close,
  //         color: Colors.redAccent);
  //   }
  //   return null;
  // }

}
