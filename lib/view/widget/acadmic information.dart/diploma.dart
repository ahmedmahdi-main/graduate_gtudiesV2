import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduate_gtudiesV2/Enums/DocumentsTypes.dart';
import 'package:graduate_gtudiesV2/Services/DilogCostom.dart';
import '../../../Enums/CertificateType.dart';
import '../../../Models/academic_information.dart';
import '../../../Models/full_student_data.dart';
import '../../../ValidatorFunction/text_validator.dart';
import '../../../controller/AcademicInformationController.dart';
import '../../../controller/dropdown_filter_controllers.dart';
import '../../../controller/home_page_controller.dart';
import '../../../theme.dart';
import '../../pages/UploadImage/controller/UploadImageController.dart';
import '../coustom_calender.dart';
import '../GifImageCostom.dart';
import '../IconButtonostom.dart';
import '../buttonsyle.dart';
import '../custom switcher.dart';
import '../dropdownlistt.dart';
import '../titleandtextstyle.dart';

class Diploma extends StatefulWidget {
  final int index;

  const Diploma({super.key, required this.index});

  @override
  State<Diploma> createState() => _DiplomaState();
}

class _DiplomaState extends State<Diploma> {
  late final HomePageController homePageController;
  late final UploadingImagesController uploadingImagesController;
  late final AcademicInformationController academicInformationController;
  late final DropdownListController dropdownListController;
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController sequenceController;
  late final TextEditingController averageController;
  late final TextEditingController controllerDocumentsNumber;
  late final TextEditingController universityMatterController;
  late final Documents universityMatterDocument;
  late AcademicInformation diplomaInformation;
  Documents? diplomaDocument;

  @override
  void initState() {
    super.initState();
    homePageController = Get.put(HomePageController());
    uploadingImagesController = Get.put(UploadingImagesController());
    academicInformationController = Get.find<AcademicInformationController>();
    dropdownListController = Get.put(DropdownListController());
    sequenceController = TextEditingController();
    averageController = TextEditingController();
    controllerDocumentsNumber = TextEditingController();
    universityMatterController = TextEditingController();
    universityMatterDocument = Documents();
    diplomaInformation = AcademicInformation();
  }

  @override
  void dispose() {
    sequenceController.dispose();
    averageController.dispose();
    controllerDocumentsNumber.dispose();
    universityMatterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Rx<bool> diplomaMasterCountry = false.obs;
    diplomaInformation.documents = [];
    FullDataAcademicInformation? fullDataAcademicInformation;
    if (homePageController.fullStudentData.value.academicInformation != null &&
        homePageController
            .fullStudentData.value.academicInformation!.isNotEmpty) {
      fullDataAcademicInformation = homePageController
          .fullStudentData.value.academicInformation
          ?.firstWhere(
              (data) =>
                  data.certificateTypeId == CertificateType.diploma.id,
              orElse: () => FullDataAcademicInformation());
      if (fullDataAcademicInformation != null) {
        diplomaInformation =
            AcademicInformation.fromFullData(fullDataAcademicInformation);
      }
      if (fullDataAcademicInformation!.documents != null) {
        diplomaDocument = fullDataAcademicInformation.documents?.firstWhere(
            (e) => e.documentsTypeId == DocumentsType.diplomaOrder.id,
            orElse: () => Documents());
        controllerDocumentsNumber.text = diplomaDocument?.documentsNumber ?? '';
        universityMatterController.text = diplomaDocument?.documentsDate ?? '';
      }
    }
    String? certificateIssuedBy =
        fullDataAcademicInformation?.certificateIssuedBy;
    String? academicYear = fullDataAcademicInformation?.academicYear;
    double? average = fullDataAcademicInformation?.average;

    int? sequence = fullDataAcademicInformation?.sequence;
    sequenceController.text = (sequence ?? 0).toString();
    averageController.text = (average ?? 0).toString();
    // double? firstStudentAverage = fullDataAcademicInformation?.firstStudentAverage;
    // int? isFirstStudent = fullDataAcademicInformation?.isFirstStudent;
    var universityId = fullDataAcademicInformation?.universityId ?? '';
    var collegesId = fullDataAcademicInformation?.collegesId ?? '';
    var departmentId = fullDataAcademicInformation?.departmentId ?? '';
    var specializationId = fullDataAcademicInformation?.specializationId ?? '';

    var isDiplomaCompatible =
        fullDataAcademicInformation?.isDiplomaCompatible != null
            ? fullDataAcademicInformation?.isDiplomaCompatible == 0
            : false;
    var isDiplomaCompatibleObs = isDiplomaCompatible.obs;
    return GetBuilder<DropdownListController>(
        //init: DropdownListController(),
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
              : Form(
                  key: _formKey,
                  child: Container(
                    decoration: BoxDecoration(
                        color: KprimeryColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(19))),
                    margin: const EdgeInsets.only(top: 12, right: 12, left: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: GetBuilder<DropdownListController>(
                          id: "loading",
                          init: DropdownListController(),
                          builder: (cont) {
                            return cont.isLoading.value
                                ? const CircularProgressIndicator()
                                : Wrap(
                                    alignment: WrapAlignment.start,
                                    spacing: 60,
                                    runSpacing: 20,
                                    children: [
                                      const TitleAndTextStyle(
                                        title: "نوع الشهادة ",
                                        initialValue: "دبلوم",
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
                                            diplomaInformation
                                                .certificateIssuedBy = val;
                                            certificateIssuedBy = val;
                                            // diplomaMasterCountry.value =
                                            //     val != "خارج العراق";
                                            controller.fillterUniversity(val);
                                            controller.update();
                                          },
                                          DropdownMenuItems:
                                              ["خارج العراق", "داخل العراق"]
                                                  .map((e) => DropdownMenuItem(
                                                        value: e,
                                                        child: Center(
                                                          child: Text(e),
                                                        ),
                                                      ))
                                                  .toList(),
                                        );
                                      }),
                                      Obx(() => diplomaMasterCountry.value
                                          ? GetBuilder<DropdownListController>(
                                              builder: (controller) {
                                              return DropDownList(
                                                value: int.tryParse(
                                                    universityId.toString()),
                                                width: 450,
                                                title: "اسم الجامعة",
                                                onchange: (value) {
                                                  diplomaInformation
                                                          .universityId =
                                                      value.toString();
                                                  collegesId = null;
                                                  fullDataAcademicInformation
                                                      ?.collegesId = null;
                                                  controller.universityValue
                                                      .value = value;
                                                  controller.fillterColleges(
                                                      value, 'diplomaColleges');
                                                  fullDataAcademicInformation
                                                      ?.universityId = value;
                                                  universityId = value;
                                                  controller.update();
                                                },
                                                DropdownMenuItems: controller
                                                    .universities!
                                                    .map((e) =>
                                                        DropdownMenuItem(
                                                          value: e.universityId,
                                                          child: Center(
                                                            child: Text(
                                                                '${e.universityName}'),
                                                          ),
                                                        ))
                                                    .toList(),
                                              );
                                            })
                                          : TitleAndTextStyle(
                                              width: 300,
                                              initialValue:
                                                  universityId.toString(),
                                              title: "اسم الجامعة",
                                              validator: (value) =>
                                                  validateTextWithoutAnyCharacterNumber(
                                                      value),
                                              onchange: (value) {
                                                diplomaInformation
                                                    .universityId = value;
                                              },
                                            )),
                                      Obx(() => diplomaMasterCountry.value
                                          ? GetBuilder<DropdownListController>(
                                              id: 'diplomaColleges',
                                              builder: (controller) {
                                                return DropDownList(
                                                  value: int.tryParse(
                                                      collegesId.toString()),
                                                  title: "الكلية",
                                                  validator: (value) =>
                                                      isDropdownListValid(
                                                          value),
                                                  onchange: (val) {
                                                    diplomaInformation
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
                                                    controller.departmentValue =
                                                        null;
                                                    controller.update();
                                                  },
                                                  DropdownMenuItems: controller
                                                      .colleges!
                                                      .map((e) =>
                                                          DropdownMenuItem(
                                                            value: e.collegesId,
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
                                              width: 250,
                                              title: "الكلية",
                                              validator: (value) =>
                                                  validateTextWithoutAnyCharacterNumber(
                                                      value),
                                              onchange: (value) {
                                                diplomaInformation.collegesId =
                                                    value;
                                              },
                                            )),
                                      Obx(() => diplomaMasterCountry.value
                                          ? GetBuilder<DropdownListController>(
                                              builder: (controller) {
                                              return DropDownList(
                                                title: "القسم",
                                                value: int.tryParse(
                                                    departmentId.toString()),
                                                validator: (value) =>
                                                    isDropdownListValid(value),
                                                onchange: (val) {
                                                  diplomaInformation
                                                          .departmentId =
                                                      val.toString();
                                                  departmentId = val;
                                                  controller.update();
                                                },
                                                DropdownMenuItems: controller
                                                    .superData!.department!
                                                    .map((e) =>
                                                        DropdownMenuItem(
                                                          value: e.departmentId,
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
                                              width: 250,
                                              title: "القسم",
                                              validator: (value) =>
                                                  validateTextWithoutAnyCharacterNumber(
                                                      value),
                                              onchange: (value) {
                                                diplomaInformation
                                                    .departmentId = value;
                                              },
                                            )),
                                      // Obx(() => diplomaMasterCountry.value
                                      //     ? GetBuilder<DropdownListController>(
                                      //         builder: (controller) {
                                      //         return DropDownList(
                                      //           value: int.tryParse(
                                      //               specializationId
                                      //                   .toString()),
                                      //           title: "التخصص",
                                      //           onchange: (val) {
                                      //             diplomaInformation
                                      //                     .specializationId =
                                      //                 val.toString();
                                      //             specializationId = val;
                                      //             controller.update();
                                      //           },
                                      //           DropdownMenuItems: controller
                                      //               .specializations!
                                      //               .map(
                                      //                   (e) => DropdownMenuItem(
                                      //                         value: e
                                      //                             .specializationId,
                                      //                         child: Center(
                                      //                           child: Text(
                                      //                               '${e.specializationName}'),
                                      //                         ),
                                      //                       ))
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
                                      //           diplomaInformation
                                      //               .specializationId = value;
                                      //         },
                                      //       )),
                                      GetBuilder<DropdownListController>(
                                          builder: (controller) {
                                        return DropDownList(
                                          title: "العام الدراسي",
                                          value: academicYear,
                                          validator: (value) =>
                                              isDropdownListValid(value),
                                          onchange: (val) {
                                            diplomaInformation.academicYear =
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
                                          diplomaInformation.average =
                                              double.parse(value);
                                        },
                                        validator: (value) =>
                                            validateTextAsNumberLessThan100(
                                                value),
                                        width: 200,
                                        title: "معدل الدبلوم",
                                      ),
                                      TitleAndTextStyle(
                                        controller: controllerDocumentsNumber,
                                        // initialValue:
                                        //     diplomaDocument?.documentsNumber,
                                        onchange: (value) {
                                          universityMatterDocument
                                              .documentsNumber = value;
                                        },
                                        width: 350,
                                        title:
                                            " رقم الامر الجامعي الخاص بمنح الدبلوم ",
                                      ),
                                      CustomCalendar(
                                        constrainWidth: 350,
                                        title:
                                            "تاريخ الامر الجامعي الخاص بمنح الدبلوم :",
                                        controller: universityMatterController,
                                      ),
                                      SizedBox(
                                        width: 250,
                                        child: Obx(() {
                                          return CustomSwitcher(
                                            initialValue:
                                                isDiplomaCompatibleObs.value,
                                            onChanged: (value) {
                                              isDiplomaCompatibleObs.value =
                                                  value;
                                              diplomaInformation
                                                      .isDiplomaCompatible =
                                                  value ? 1 : 0;
                                            },
                                            title:
                                                "هل الدبلوم متوافق مع البكلوريوس؟ :",
                                          );
                                              isleft: true,
                                              icon: Icons.save_outlined,
                                              title: 'حفظ الشهادة',
                                              onTap: () async {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  diplomaInformation
                                                          .certificateTypeId =
                                                      CertificateType
                                                          .diploma.id;

                                                  if (diplomaInformation
                                                          .documents !=
                                                      null) {
                                                    diplomaInformation
                                                        .documents!
                                                        .clear();
                                                  } else {
                                                    diplomaInformation
                                                        .documents = [];
                                                  }
                                                  diplomaInformation.nOBatch =
                                                      0;
                                                  universityMatterDocument
                                                          .documentsNumber =
                                                      controllerDocumentsNumber
                                                          .text;
                                                  universityMatterDocument
                                                          .documentsDate =
                                                      universityMatterController
                                                          .text;
                                                  universityMatterDocument
                                                          .documentsTypeId =
                                                      DocumentsType
                                                          .diplomaOrder.id;
                                                  diplomaInformation.documents?.add(
                                                      universityMatterDocument);
                                                  // for (var cer
                                                  // in academicInformationController
                                                  //     .academicInformationModel!
                                                  //     .academicInformation!) {
                                                  //   if (cer.certificateTypeId ==
                                                  //       CertificateType
                                                  //           .diploma.id) {}
                                                  // }
                                                  academicInformationController
                                                      .addOrUpdateAcademicInformation(
                                                          diplomaInformation);
                                                }
                                                await DilogCostom.dilogSecss(
                                                  isErorr: false,
                                                  title: "تم حفظ الشهادة بنجاح",
                                                  icons: Icons.close,
                                                  color: Colors.greenAccent,
                                                );
                                                // academicInformationController
                                                //     .academicInformationModel!
                                                //     .academicInformation
                                                //     ?.add(academicInformation);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                          }),
                    ),
                  ),
                );
    });
    // });
  }
}
