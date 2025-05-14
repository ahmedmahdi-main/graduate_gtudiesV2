// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduate_gtudiesV2/Services/DilogCostom.dart' show DilogCostom;
import '../../../Enums/certificate_type.dart';
import '../../../Enums/documents_types.dart';
import '../../../Models/academic_information.dart';
import '../../../Models/full_student_data.dart';
import '../../../ValidatorFunction/text_validator.dart';
import '../../../controller/AcademicInformationController.dart';
import '../../../controller/dropdown_filter_controllers.dart';

import '../../../controller/home_page_controller.dart';
import '../../../theme.dart';
import '../coustom_calender.dart';
import '../GifImageCostom.dart';
import '../IconButtonostom.dart';
import '../buttonsyle.dart';
import '../custom switcher.dart';
import '../dropdownlistt.dart';
import '../titleandtextstyle.dart';

class Master extends StatelessWidget {
  final int index;
  final HomePageController _controller = Get.find();

  Master({super.key, required this.index});

  final AcademicInformationController academicInformationController =
      Get.find();
  AcademicInformation academicInformation = AcademicInformation();
  Documents universityMatterDocument = Documents();
  Documents? fullDataMasterDegreeDocument = Documents();
  TextEditingController universityMatterController = TextEditingController();
  TextEditingController masterCalenderController = TextEditingController();
  TextEditingController masterNumberController = TextEditingController();
  TextEditingController averageController = TextEditingController();
  final HomePageController homePageController = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    Rx<bool> masterCountry = false.obs;

    academicInformation.documents = [];
    FullDataAcademicInformation? fullDataAcademicInformation;
    if (homePageController.fullStudentData.value.academicInformation != null &&
        homePageController
            .fullStudentData.value.academicInformation!.isNotEmpty) {
      fullDataAcademicInformation = homePageController
          .fullStudentData.value.academicInformation
          ?.firstWhere(
              (data) => data.certificateTypeId == CertificateType.masters.id,
              orElse: () => FullDataAcademicInformation());
      if (fullDataAcademicInformation != null) {
        academicInformation =
            AcademicInformation.fromFullData(fullDataAcademicInformation);
      }
      fullDataMasterDegreeDocument = fullDataAcademicInformation?.documents
          ?.firstWhere(
              (e) => e.documentsTypeId == DocumentsType.masterDegreeOrder.id,
              orElse: () => Documents());
      if (fullDataMasterDegreeDocument != null) {
        universityMatterController.text =
            fullDataMasterDegreeDocument!.documentsDate ?? '';
        masterNumberController.text =
            fullDataMasterDegreeDocument?.documentsNumber ?? '';
      }
    }
    String? certificateIssuedBy =
        fullDataAcademicInformation?.certificateIssuedBy;
    // masterCountry.value =
    //     certificateIssuedBy != "خارج العراق";
    String? academicYear = fullDataAcademicInformation?.academicYear;
    double? average = fullDataAcademicInformation?.average ?? 0;

    averageController.text = (average ?? 0).toString();

    var universityId = fullDataAcademicInformation?.universityId ?? '';
    var collegesId = fullDataAcademicInformation?.collegesId ?? '';
    var departmentId = fullDataAcademicInformation?.departmentId ?? '';
    var specializationId = fullDataAcademicInformation?.specializationId ?? '';
    var fullIsMasterWithinPeriod =
        fullDataAcademicInformation?.isMasterWithinPeriod == 1;
    Rx<bool> fullIsMasterWithinPeriodObs = (fullIsMasterWithinPeriod).obs;
    homePageController.isMasterWithinPeriod.value = fullIsMasterWithinPeriod;
    homePageController.averageMaster.value = average;
    if (certificateIssuedBy != null) {
      homePageController.isMasterInsideIraq.value =
          certificateIssuedBy == "داخل العراق";
    }
    return GetBuilder<DropdownListController>(
        init: DropdownListController(),
        builder: (cont) {
          return cont.isLoading.value
              ? const Center(
                  child: GifImageCostom(
                    Gif: "assets/icons/pencil.gif",
                    width: 100,
                  ),
                )
              : (cont.superData == null)
                  ? const Center(
                      child: Text("No Data"),
                    )
                  : Container(
                      decoration: BoxDecoration(
                          color: KprimeryColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(19))),
                      margin:
                          const EdgeInsets.only(top: 12, right: 12, left: 12),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: GetBuilder<DropdownListController>(
                            id: "loading",
                            init: DropdownListController(),
                            builder: (cont) {
                              return cont.isLoading.value
                                  ? const Center(
                                      child: GifImageCostom(
                                        Gif: "assets/icons/pencil.gif",
                                        width: 100,
                                      ),
                                    )
                                  : Wrap(
                                      alignment: WrapAlignment.start,
                                      spacing: 60,
                                      runSpacing: 20,
                                      children: [
                                        const TitleAndTextStyle(
                                          title: "نوع الشهادة ",
                                          initialValue: "ماجستير",
                                          readOnly: true,
                                        ),
                                        GetBuilder<DropdownListController>(
                                            builder: (controller) {
                                          return DropDownList(
                                            value: certificateIssuedBy,
                                            validator: (value) =>
                                                isDropdownListValid(value),
                                            title: "الشهادة صادرة من ؟",
                                            onchange: (val) {
                                              academicInformation
                                                  .certificateIssuedBy = val;

                                              homePageController
                                                  .isMasterInsideIraq
                                                  .value = val == "داخل العراق";
                                              certificateIssuedBy = val;
                                              controller.fillterUniversity(val);
                                              controller.update();
                                            },
                                            DropdownMenuItems: [
                                              "خارج العراق",
                                              "داخل العراق"
                                            ]
                                                .map((e) => DropdownMenuItem(
                                                      value: e,
                                                      child: Center(
                                                        child: Text(e),
                                                      ),
                                                    ))
                                                .toList(),
                                          );
                                        }),
                                        Obx(() => masterCountry.value
                                            ? GetBuilder<
                                                    DropdownListController>(
                                                // id: 'masterUniversity',
                                                builder: (controller) {
                                                return DropDownList(
                                                  value: int.tryParse(
                                                      universityId.toString()),
                                                  // width: 450,
                                                  title: "اسم الجامعة",
                                                  onchange: (value) {
                                                    academicInformation
                                                            .universityId =
                                                        value.toString();
                                                    collegesId = null;
                                                    fullDataAcademicInformation
                                                        ?.collegesId = null;
                                                    controller.universityValue
                                                        .value = value;
                                                    controller.fillterColleges(
                                                        value,
                                                        'masterColleges');
                                                    fullDataAcademicInformation
                                                        ?.universityId = value;
                                                    universityId = value;
                                                    controller.update();
                                                  },
                                                  DropdownMenuItems: controller
                                                      .universities!
                                                      .map((e) =>
                                                          DropdownMenuItem(
                                                            value:
                                                                e.universityId,
                                                            child: Center(
                                                              child: Text(
                                                                  '${e.universityName}'),
                                                            ),
                                                          ))
                                                      .toList(),
                                                );
                                              })
                                            : TitleAndTextStyle(
                                                // width: 300,
                                                initialValue:
                                                    universityId.toString(),
                                                title: "اسم الجامعة",
                                                validator: (value) =>
                                                    validateTextWithoutAnyCharacterNumber(
                                                        value),
                                                onchange: (value) {
                                                  academicInformation
                                                      .universityId = value;
                                                },
                                              )),
                                        Obx(() => masterCountry.value
                                            ? GetBuilder<
                                                    DropdownListController>(
                                                id: 'masterColleges',
                                                builder: (controller) {
                                                  return DropDownList(
                                                    value: int.tryParse(
                                                        collegesId.toString()),
                                                    title: "الكلية",
                                                    validator: (value) =>
                                                        isDropdownListValid(
                                                            value),
                                                    onchange: (val) {
                                                      academicInformation
                                                              .collegesId =
                                                          val.toString();
                                                      controller
                                                          .departmentsData();
                                                      collegesId = val;
                                                      departmentId = null;
                                                      fullDataAcademicInformation
                                                          ?.collegesId = val;
                                                      controller.collegesValue =
                                                          val;
                                                      controller
                                                              .departmentValue =
                                                          null;
                                                      controller.update();
                                                    },
                                                    DropdownMenuItems: controller
                                                        .colleges!
                                                        .map((e) =>
                                                            DropdownMenuItem(
                                                              value:
                                                                  e.collegesId,
                                                              child: Center(
                                                                child: Text(
                                                                    '${e.collegesName}'),
                                                              ),
                                                            ))
                                                        .toList(),
                                                  );
                                                })
                                            : TitleAndTextStyle(
                                                initialValue:
                                                    collegesId.toString(),
                                                // width: 250,
                                                title: "الكلية",
                                                validator: (value) =>
                                                    validateTextWithoutAnyCharacterNumber(
                                                        value),
                                                onchange: (value) {
                                                  academicInformation
                                                      .collegesId = value;
                                                },
                                              )),
                                        Obx(() => masterCountry.value
                                            ? GetBuilder<
                                                    DropdownListController>(
                                                // id: 'masterDepartment',
                                                builder: (controller) {
                                                return DropDownList(
                                                  title: "القسم",
                                                  value: int.tryParse(
                                                      departmentId.toString()),
                                                  validator: (value) =>
                                                      isDropdownListValid(
                                                          value),
                                                  onchange: (val) {
                                                    academicInformation
                                                            .departmentId =
                                                        val.toString();
                                                    departmentId = val;
                                                    controller.update();
                                                  },
                                                  DropdownMenuItems: controller
                                                      .superData!.department!
                                                      .map((e) =>
                                                          DropdownMenuItem(
                                                            value:
                                                                e.departmentId,
                                                            child: Center(
                                                              child: Text(
                                                                  '${e.departmentName}'),
                                                            ),
                                                          ))
                                                      .toList(),
                                                );
                                              })
                                            : TitleAndTextStyle(
                                                initialValue:
                                                    departmentId.toString(),
                                                // width: 250,
                                                title: "القسم",
                                                validator: (value) =>
                                                    validateTextWithoutAnyCharacterNumber(
                                                        value),
                                                onchange: (value) {
                                                  academicInformation
                                                      .departmentId = value;
                                                },
                                              )),
                                        // Obx(() => masterCountry.value
                                        //     ? GetBuilder<
                                        //             DropdownListController>(
                                        //         builder: (controller) {
                                        //         return DropDownList(
                                        //           value: int.tryParse(
                                        //               specializationId
                                        //                   .toString()),
                                        //           title: "التخصص",
                                        //           onchange: (val) {
                                        //             academicInformation
                                        //                     .specializationId =
                                        //                 val.toString();
                                        //             specializationId = val;
                                        //             controller.update();
                                        //           },
                                        //           DropdownMenuItems: controller
                                        //               .specializations!
                                        //               .map((e) =>
                                        //                   DropdownMenuItem(
                                        //                     value: e
                                        //                         .specializationId,
                                        //                     child: Center(
                                        //                       child: Text(
                                        //                           '${e.specializationName}'),
                                        //                     ),
                                        //                   ))
                                        //               .toList(),
                                        //         );
                                        //       })
                                        //     : TitleAndTextStyle(
                                        //         initialValue:
                                        //             specializationId.toString(),
                                        //         width: 300,
                                        //         title: "التخصص",
                                        //         validator: (value) =>
                                        //             validateTextWithoutAnyCharacterNumber(
                                        //                 value),
                                        //         onchange: (value) {
                                        //           academicInformation
                                        //               .specializationId = value;
                                        //         },
                                        //       )),
                                        GetBuilder<DropdownListController>(
                                            // id: 'masterDepartment',
                                            builder: (controller) {
                                          return DropDownList(
                                            title: "العام الدراسي",
                                            value: academicYear,
                                            validator: (value) =>
                                                isDropdownListValid(value),
                                            onchange: (val) {
                                              academicInformation.academicYear =
                                                  val.toString();
                                              academicYear = val;
                                              controller.update();
                                            },
                                            DropdownMenuItems: controller
                                                .superData!.years!.reversed
                                                .map((e) => DropdownMenuItem(
                                                      value: e,
                                                      child: Center(
                                                        child: Text(e),
                                                      ),
                                                    ))
                                                .toList(),
                                          );
                                        }),
                                        TitleAndTextStyle(
                                          controller: averageController,
                                          onchange: (value) {
                                            double? parsedValue =
                                                double.tryParse(value);
                                            if (parsedValue != null) {
                                              academicInformation.average =
                                                  parsedValue;
                                              homePageController.averageMaster
                                                  .value = parsedValue;
                                            } else {
                                              academicInformation.average = 0;
                                              homePageController
                                                  .averageMaster.value = 0;
                                            }
                                          },
                                          validator: (value) =>
                                              validateTextAsNumberLessThan100(
                                                  value),
                                          // width: 350,
                                          title: "معدل ماجستير",
                                        ),
                                        TitleAndTextStyle(
                                          controller: masterNumberController,
                                          onchange: (value) {
                                            universityMatterDocument
                                                .documentsNumber = value;
                                          },
                                          // width: 460,
                                          title:
                                              " رقم الامر الجامعي الخاص\n بالماجستير او كتاب المعادلة",
                                        ),
                                        CustomCalendar(
                                          // constrainWidth: 460,
                                          controller:
                                              universityMatterController,
                                          title:
                                              "تاريخ لامر الجامعي الخاص\n بالماجستير او كتاب المعادلة:",
                                          // width: 460,
                                        ),
                                        Obx(() {
                                          return CustomSwitcher(
                                            initialValue:
                                                fullIsMasterWithinPeriodObs
                                                    .value,
                                            onChanged: (value) {
                                              academicInformation
                                                      .isMasterWithinPeriod =
                                                  value ? 1 : 0;
                                              fullIsMasterWithinPeriodObs
                                                  .value = value;
                                              homePageController
                                                  .isMasterWithinPeriod
                                                  .value = value;
                                            },
                                            title:
                                                "هل اكملت الماجستير ضمن الفترة المحددة؟ :",
                                          );
                                        }),
                                        const SizedBox(
                                          width: double.infinity,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: IconButtonostom(
                                                  controller: _controller,
                                                  index: index,
                                                  dgree: "ماجستير"),
                                            ),
                                            Flexible(
                                              child: ButtonStyleS(
                                                colorBorder: Colors.greenAccent,
                                                containborder: true,
                                                isleft: true,
                                                icon: Icons.save_outlined,
                                                title: 'حفظ الشهادة',
                                                onTap: () async {
                                                  academicInformation
                                                      .documents = [];
                                                  // Assign relevant certificate type and document details
                                                  academicInformation
                                                          .certificateTypeId =
                                                      CertificateType
                                                          .masters.id;
                                                  universityMatterDocument
                                                          .documentsNumber =
                                                      masterNumberController
                                                          .text;
                                                  universityMatterDocument
                                                          .documentsDate =
                                                      universityMatterController
                                                          .text;
                                                  universityMatterDocument
                                                          .documentsTypeId =
                                                      DocumentsType
                                                          .masterDegreeOrder.id;
                                                  academicInformation.nOBatch =
                                                      0;
                                                  // Clear existing documents and add the updated document
                                                  academicInformation.documents
                                                      ?.clear();
                                                  academicInformation.documents
                                                      ?.add(
                                                          universityMatterDocument);

                                                  // Add or update academic information
                                                  academicInformationController
                                                      .addOrUpdateAcademicInformation(
                                                          academicInformation);
                                                  await DilogCostom.dilogSecss(
                                                    isErorr: false,
                                                    title:
                                                        "تم حفظ الشهادة بنجاح",
                                                    icons: Icons.close,
                                                    color: Colors.greenAccent,
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    );
                            }),
                      ),
                    );
        });
  }
}
