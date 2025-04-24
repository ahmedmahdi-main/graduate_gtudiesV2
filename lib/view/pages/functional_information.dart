// ignore_for_file: non_constant_identifier_names

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduate_gtudiesV2/Enums/DocumentsTypes.dart';
import 'package:graduate_gtudiesV2/Enums/scientific_titles.dart';
import 'package:graduate_gtudiesV2/Models/academic_information.dart';
import 'package:graduate_gtudiesV2/Models/career_Information.dart';
import 'package:graduate_gtudiesV2/Models/data_information.dart';
import 'package:graduate_gtudiesV2/Models/super_data.dart';
import '../../Models/full_student_data.dart';
import '../../Services/DilogCostom.dart';
import '../../Services/base_route.dart';
import '../../controller/CareerInformationController.dart';
import '../../controller/dropdown_filter_controllers.dart';
import '../../controller/home_page_controller.dart';
import '../../theme.dart';
import '../widget/coustom_calender.dart';
import '../widget/GifImageCostom.dart';
import '../widget/buttonsyle.dart';
import '../widget/custom switcher.dart';
import '../widget/dropdownlistt.dart';
import '../widget/titleandtextstyle.dart';
import 'DialogsWindows/loading_dialog.dart';

class FunctionalInformation extends StatefulWidget {
  const FunctionalInformation({super.key});

  @override
  State<FunctionalInformation> createState() => _FunctionalInformationState();
}

class _FunctionalInformationState extends State<FunctionalInformation> {
  Rx<String> functionl = "غير موظف".obs;
  Rx<bool> UniversityService = false.obs;
  TextEditingController PromotionOrderDate = TextEditingController();
  TextEditingController PromotionOrderNumber = TextEditingController();
  TextEditingController organizationNameController = TextEditingController();
  TextEditingController CommencementDate = TextEditingController();
  Documents promotionOrder = Documents();
  CareerInformationController careerInformationController =
      Get.put(CareerInformationController());
  HomePageController homePageController = Get.put(HomePageController());
  RxBool haveUniversityService = false.obs;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    careerInformationController.careerInformation.documents = [];
    var size = MediaQuery.of(context).size;
    int? careerInformationId;
    int? typeConsentId;
    int? employmentStatusId;
    String? dateCommencement;
    int? ministryId;
    int? scientificTitleId;
    int? fullDataUniversityService;
    String? studentUUID;
    List<Documents>? documents;
    if (homePageController.fullStudentData.value.careerInformation != null &&
        homePageController
            .fullStudentData.value.careerInformation!.isNotEmpty) {
      FullDataCareerInformation? fullDataCareerInformation =
          homePageController.fullStudentData.value.careerInformation?.first;
      careerInformationId = fullDataCareerInformation?.careerInformationId;
      typeConsentId = fullDataCareerInformation?.typeConsentId;
      if (fullDataCareerInformation?.typeConsentId != null) {
        homePageController.typeConsentId.value =
            fullDataCareerInformation?.typeConsentId;
      }
      careerInformationController.careerInformation =
          fullDataCareerInformation!.toCareerInformation();
      //dateCommencement = fullDataCareerInformation?.dateCommencement;
      employmentStatusId = fullDataCareerInformation.employmentStatusId;
      if (employmentStatusId != null) {
        if (employmentStatusId == 1) {
          functionl.value = "عقد 315";
          homePageController.haveStudyApproval.value = true;
        } else if (employmentStatusId == 2) {
          functionl.value = "موظف";
          homePageController.haveStudyApproval.value = true;
        } else {
          functionl.value = "غير موظف";
        }
      }
      CommencementDate.text =
          fullDataCareerInformation.dateCommencement?.replaceAll('-', '/') ??
              '';
      homePageController.dateCommencement = CommencementDate.text;
      ministryId = fullDataCareerInformation.ministryId;
      var dropDownController = Get.put(DropdownListController());
      if (ministryId != 0) {
        var filteredMinistries = dropDownController.ministry!
            .where((m) => m.ministryId == ministryId);

        if (filteredMinistries.isNotEmpty) {
          var ministry = filteredMinistries.first.heirghEduSevice == 1;
          haveUniversityService.value = ministry;
          homePageController.haveUniversityService?.value = ministry;
        } else {
          // Handle the case where no matching ministry is found
          debugPrint("No ministry found with the given ministryId.");
        }
      }
      scientificTitleId = fullDataCareerInformation.scientificTitleId;
      organizationNameController.text =
          fullDataCareerInformation.organizationName ?? '';
      fullDataUniversityService = fullDataCareerInformation.universityService;
      UniversityService.value = fullDataUniversityService == 1;
      documents = fullDataCareerInformation.documents;
      if (documents != null && documents.isNotEmpty) {
        var doc = documents.firstWhere(
          (d) => d.documentsTypeId == DocumentsType.promotionOrder.id,
          orElse: () => Documents(),
        );

        if (doc != null) {
          PromotionOrderDate.text =
              doc.documentsDate?.replaceAll('-', '/') ?? '';
          PromotionOrderNumber.text = doc.documentsNumber ?? '';
        }
      }
    }
    Rx<bool> isBachelor = (ScientificTitles.values
                .where((b) => b.id == scientificTitleId)
                .isNotEmpty &&
            ScientificTitles.values
                    .where((b) => b.id == scientificTitleId)
                    .first ==
                ScientificTitles.bachelor)
        .obs;

    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: GetBuilder<DropdownListController>(
            init: DropdownListController(),
            builder: (cont) {
              return cont.isLoading
                  ? const Center(
                      child: GifImageCostom(
                        Gif: "assets/icons/pencil.gif",
                        width: 100,
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                          color: KprimeryColor,
                          borderRadius: const BorderRadiusDirectional.all(
                              Radius.circular(19))),
                      margin:
                          const EdgeInsets.only(top: 12, right: 12, left: 12),
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GetBuilder<DropdownListController>(
                                //
                                id: 'الحالة الوظيفية',
                                builder: (controller) => DropDownList(
                                    value: employmentStatusId,
                                    title: "الحالة الوظيفية",
                                    onchange: (val) {
                                      if (val == 1) {
                                        functionl.value = "عقد 315";
                                        homePageController
                                            .haveStudyApproval.value = true;
                                      } else if (val == 2) {
                                        functionl.value = "موظف";
                                        homePageController
                                            .haveStudyApproval.value = true;
                                      } else {
                                        // careerInformationController
                                        //     .careerInformation = CareerInformation();

                                        functionl.value = "غير موظف";
                                        homePageController
                                            .haveStudyApproval.value = false;
                                      }
                                      careerInformationController
                                          .careerInformation
                                          .employmentStatusId = val;
                                      employmentStatusId = val;
                                      controller.update();
                                    },
                                    DropdownMenuItems:
                                        controller.employmentStatusData!
                                            .map((e) => DropdownMenuItem(
                                                  value: e.employmentStatusId,
                                                  child: Center(
                                                    child: Text(e.statusName!),
                                                  ),
                                                ))
                                            .toList()
                                    //items: const ["غير موظف", "موظف", "عقد 315"],
                                    )),
                            const SizedBox(
                              height: 10,
                            ),
                            Obx(
                              () => functionl.value == "غير موظف"
                                  ? Container()
                                  : Wrap(
                                      spacing: 60,
                                      runSpacing: 20,
                                      children: [
                                        GetBuilder<DropdownListController>(
                                            init: DropdownListController(),
                                            id: "loading",
                                            builder: (cont) {
                                              return cont.isLoading
                                                  ? const Center(
                                                      child: GifImageCostom(
                                                        Gif:
                                                            "assets/icons/pencil.gif",
                                                        width: 100,
                                                      ),
                                                    )
                                                  : GetBuilder<
                                                          DropdownListController>(
                                                      id: 'نوع الموافقة الدراسية',
                                                      builder: (controller) {
                                                        return DropDownList(
                                                          value: typeConsentId,
                                                          width: 550,
                                                          title:
                                                              "نوع الموافقة الدراسية ؟",
                                                          onchange: (val) {
                                                            careerInformationController
                                                                .careerInformation
                                                                .typeConsentId = val;
                                                            typeConsentId = val;
                                                            controller.update();
                                                          },
                                                          DropdownMenuItems:
                                                              controller!
                                                                  .typeConsentForStudy!
                                                                  .map((e) =>
                                                                      DropdownMenuItem(
                                                                        value: e
                                                                            .typeConsentId,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(e.typeConsentName!),
                                                                        ),
                                                                      ))
                                                                  .toList(),
                                                        );
                                                      });
                                            }),
                                        // const SizedBox(
                                        //   width: double.infinity,
                                        // ),
                                        CustomCalendar(
                                          controller: CommencementDate,
                                          width: 300,
                                          constrainWidth: 300,
                                          title:
                                              "تاريخ المباشرة بعد اخر شهادة :",
                                          onChange: (value) {
                                            homePageController
                                                    .dateCommencement =
                                                CommencementDate.text;
                                          },
                                        ),
                                        GetBuilder<DropdownListController>(
                                            id: 'اسم الوزارة',
                                            builder: (controller) {
                                              return DropDownList(
                                                value: ministryId,
                                                width: 500,
                                                title: "اسم الوزارة :",
                                                onchange: (val) {
                                                  careerInformationController
                                                      .careerInformation
                                                      .ministryId = val;
                                                  ministryId = val;
                                                  haveUniversityService
                                                      .value = controller
                                                          .ministry!
                                                          .where((m) =>
                                                              m.ministryId ==
                                                              val)
                                                          .first
                                                          .heirghEduSevice ==
                                                      1;
                                                  homePageController
                                                          .haveUniversityService
                                                          .value =
                                                      haveUniversityService
                                                          .value;

                                                  controller.update();
                                                },
                                                DropdownMenuItems: controller
                                                    .ministry!
                                                    .map((e) =>
                                                        DropdownMenuItem(
                                                          value: e.ministryId,
                                                          child: Center(
                                                            child:
                                                                Text(e.name!),
                                                          ),
                                                        ))
                                                    .toList(),
                                              );
                                            }),
                                        TitleAndTextStyle(
                                          controller:
                                              organizationNameController,
                                          onchange: (value) {
                                            careerInformationController
                                                .careerInformation
                                                .organizationName = value;
                                          },
                                          width: 550,
                                          title: "اسم الؤسسة :",
                                        ),
                                        const SizedBox(
                                          width: double.infinity,
                                        ),
                                        Obx(() {
                                          return haveUniversityService.value
                                              ? CustomSwitcher(
                                                  initialValue:
                                                      UniversityService.value,
                                                  onChanged: (p0) {
                                                    UniversityService.value =
                                                        p0;
                                                    careerInformationController
                                                            .careerInformation
                                                            .universityService =
                                                        p0 ? 1 : 0;
                                                    fullDataUniversityService =
                                                        p0 ? 1 : 0;
                                                    homePageController
                                                        .haveUniversityOrderRegardingObtainingAnAcademicTitle
                                                        .value = p0;
                                                  },
                                                  title:
                                                      "يخضع للخدمة الجامعية :")
                                              : Container();
                                        }),
                                        Obx(() => UniversityService.value
                                            ? Row(
                                                children: [
                                                  GetBuilder<
                                                          DropdownListController>(
                                                      id: 'اللقب العلمي',
                                                      builder: (controller) {
                                                        return DropDownList(
                                                          value:
                                                              scientificTitleId,
                                                          title:
                                                              "اللقب العلمي :",
                                                          onchange: (val) {
                                                            isBachelor = (ScientificTitles
                                                                        .values
                                                                        .where((b) =>
                                                                            b.id ==
                                                                            val)
                                                                        .first ==
                                                                    ScientificTitles
                                                                        .bachelor)
                                                                .obs;

                                                            careerInformationController
                                                                .careerInformation
                                                                .scientificTitleId = val;
                                                            scientificTitleId =
                                                                val;
                                                            controller.update();
                                                          },
                                                          DropdownMenuItems: controller
                                                              .scientificTitles!
                                                              .map((e) =>
                                                                  DropdownMenuItem(
                                                                    value: e
                                                                        .scientificTitleId,
                                                                    child:
                                                                        Center(
                                                                      child: Text(
                                                                          e.name!),
                                                                    ),
                                                                  ))
                                                              .toList(),
                                                        );
                                                      }),
                                                  const SizedBox(
                                                    width: 50,
                                                  ),
                                                  if (!isBachelor.value)
                                                    Row(
                                                      children: [
                                                        TitleAndTextStyle(
                                                          controller:
                                                              PromotionOrderNumber,
                                                          title:
                                                              "رقم امر الترقية :",
                                                          onchange: (value) {
                                                            promotionOrder
                                                                    .documentsNumber =
                                                                value;
                                                          },
                                                        ),
                                                        const SizedBox(
                                                          width: 50,
                                                        ),
                                                        CustomCalendar(
                                                          title:
                                                              "تاريخ امر الترقية :",
                                                          controller:
                                                              PromotionOrderDate,
                                                        ),
                                                      ],
                                                    ),
                                                ],
                                              )
                                            : Container()),
                                        // const SizedBox(
                                        //   width: double.infinity,
                                        // ),
                                      ],
                                    ),
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: size.width < SizeR.TabletWidth
                                        ? 20
                                        : 400,
                                  ),
                                  ButtonStyleS(
                                    colorBorder: Colors.greenAccent,
                                    containborder: true,
                                    isleft: true,
                                    icon: Icons.arrow_forward_ios,
                                    title: "حفظ وانتقال للصفحة التالية",
                                    onTap: () async {
                                      if (!formKey.currentState!.validate()) {
                                        return;
                                      }

                                      // Show loading dialog using AwesomeDialog
                                      LoadingDialog.showLoadingDialog(
                                          message: loadingText);

                                      try {
                                        debugPrint(careerInformationController
                                            .careerInformation
                                            .toJson()
                                            .toString());

                                        // Clear career information documents
                                        careerInformationController
                                            .careerInformation.documents
                                            ?.clear();

                                        // Check if UniversityService is active and add promotion order information
                                        if (UniversityService.value) {
                                          promotionOrder.documentsDate =
                                              PromotionOrderDate.text;
                                          promotionOrder.documentsNumber =
                                              PromotionOrderNumber.text;
                                          promotionOrder.documentsTypeId =
                                              DocumentsType.promotionOrder.id;
                                          careerInformationController
                                              .careerInformation.documents
                                              ?.add(promotionOrder);
                                        }

                                        // Set typeConsentId
                                        if (careerInformationController
                                                .careerInformation
                                                .typeConsentId !=
                                            null) {
                                          homePageController
                                                  .typeConsentId.value =
                                              careerInformationController
                                                  .careerInformation
                                                  .typeConsentId;
                                        }

                                        // Set dateCommencement
                                        careerInformationController
                                                .careerInformation
                                                .dateCommencement =
                                            CommencementDate.text;
                                        homePageController.dateCommencement =
                                            CommencementDate.text;

                                        // Upload data
                                        var status =
                                            await careerInformationController
                                                .uploadData();
                                        homePageController.functionalInformation
                                            .isFull.value = status;

                                        // Hide loading dialog
                                        Get.back();

                                        // Proceed after data upload
                                        if (status) {
                                          homePageController.fullStudentData
                                              .value.careerInformation
                                              ?.clear();
                                          homePageController.fullStudentData
                                              .value.careerInformation
                                              ?.add(
                                            FullDataCareerInformation
                                                .fromCareerInformation(
                                                    careerInformationController
                                                        .careerInformation),
                                          );

                                          homePageController.pageChange(
                                              homePageController
                                                  .academicInformation.index);

                                          // Show confirmation dialog if serial is not null
                                          if (homePageController.fullStudentData
                                                  .value.serial !=
                                              null) {
                                            DilogCostom.confirmFinishEditing(
                                              onSubmit: () async {
                                                await homePageController
                                                    .modifyComplete();
                                              },
                                            );
                                          }
                                        }
                                        Get.back();
                                      } catch (e) {
                                        // Hide loading dialog in case of error
                                        Get.back();

                                        // Handle exception by showing error dialog
                                        DilogCostom.dilogSecss(
                                          isErorr: true,
                                          title:
                                              "حدث خطأ أثناء معالجة البيانات، يرجى المحاولة مرة أخرى",
                                          icons: Icons.error,
                                          color: Colors.redAccent,
                                        );
                                      }
                                    },
                                  ),
                                ])
                          ],
                        ),
                      ),
                    );
            }),
      ),
    );
  }
}
