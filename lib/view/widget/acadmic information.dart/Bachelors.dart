import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:graduate_gtudiesV2/Enums/CertificateType.dart';
import 'package:graduate_gtudiesV2/Models/Academicinformation.dart';
import 'package:graduate_gtudiesV2/Models/full_student_data.dart';
import '../../../Enums/DocumentsTypes.dart';
import '../../../ValidatorFunction/text_validator.dart';
import '../../../controller/AcademicInformationController.dart';
import '../../../controller/dropdown_filter_controllers.dart';
import '../../../controller/home_page_controller.dart';
import '../../../theme.dart';
import '../../pages/UploadImage/controller/UploadImageController.dart';
import '../coustom_calender.dart';
import '../DropDownCostom.dart';
import '../GifImageCostom.dart';
import '../IconButtonostom.dart';
import '../buttonsyle.dart';
import '../custom switcher.dart';
import '../dropdownlistt.dart';
import '../titleandtextstyle.dart';
// Import the new controllers

class Bachelors extends StatelessWidget {
  final int index;

  Bachelors({super.key, required this.index});

  final HomePageController homePageController = Get.put(HomePageController());
  final UploadingImagesController uploadingImagesController =
      Get.put(UploadingImagesController());
  final AcademicInformationController academicInformationController =
      Get.find<AcademicInformationController>();
  final DropdownListController dropdownListController =
      Get.put(DropdownListController());
  final _formKey = GlobalKey<FormState>();
  final TextEditingController bachelorCalenderController =
      TextEditingController();
  final TextEditingController endorsementCalenderController =
      TextEditingController();
  final TextEditingController endorsementNumberController =
      TextEditingController();
  final TextEditingController bachelorDocumentNumberController =
      TextEditingController();
  final TextEditingController sequenceController = TextEditingController();
  final TextEditingController batchNumberController = TextEditingController();
  final TextEditingController averageController = TextEditingController();
  final Documents bachelorDegreeDocument = Documents();
  final Documents endorsementLetter = Documents();
  AcademicInformation academicInformation = AcademicInformation();
  Documents? fullDataBachelorDegreeDocument;
  Documents? fullDataFirstStudentAverage;

  // Declaration and Initialization with default values
  // String? certificateIssuedBy;
  // String? academicYear;
  // int average = 0;
  // var specializationId;
  // int sequence = 0;
  // double firstStudentAverage = 0;
  // int isFirstStudent = 0;
  // var universityId;
  // var collegesId;
  // var departmentId;

  @override
  Widget build(BuildContext context) {
    Rx<bool> masterCountry = false.obs;
    Rx<bool> fullDataFirstStudentAverageObs =
        (fullDataFirstStudentAverage != null).obs;
    Rx<bool> checkFirstStudentAverage = false.obs;
    academicInformation.documents = [];
    FullDataAcademicInformation? fullDataAcademicInformation;
    if (homePageController.fullStudentData.value.academicInformation != null &&
        homePageController
            .fullStudentData.value.academicInformation!.isNotEmpty) {
      fullDataAcademicInformation = homePageController
          .fullStudentData.value.academicInformation
          ?.firstWhere(
              (data) => data.certificateTypeId == CertificateType.bachelors.id,
              orElse: () => FullDataAcademicInformation());
      if (fullDataAcademicInformation != null) {
        academicInformation =
            AcademicInformation.fromFullData(fullDataAcademicInformation);
      }
      fullDataBachelorDegreeDocument = fullDataAcademicInformation?.documents
          ?.firstWhere(
              (e) =>
                  e.documentsTypeId ==
                  DocumentsType.bachelorDegreeCertificate.id,
              orElse: () => Documents());
      if (fullDataBachelorDegreeDocument != null) {
        bachelorCalenderController.text =
            fullDataBachelorDegreeDocument!.documentsDate ?? '';

        bachelorDocumentNumberController.text =
            fullDataBachelorDegreeDocument!.documentsNumber ?? '';
      }
      fullDataFirstStudentAverage = fullDataAcademicInformation?.documents
          ?.firstWhere(
              (e) =>
                  e.documentsTypeId ==
                  DocumentsType.firstStudentAverageConfirmationLetter.id,
              orElse: () => Documents());
      if (fullDataFirstStudentAverage != null) {
        endorsementCalenderController.text =
            fullDataFirstStudentAverage?.documentsDate ?? '';

        endorsementNumberController.text =
            fullDataFirstStudentAverage?.documentsDate ?? '';
      }
    }
    String? certificateIssuedBy =
        fullDataAcademicInformation?.certificateIssuedBy;
    String? academicYear = fullDataAcademicInformation?.academicYear;
    double? average = fullDataAcademicInformation?.average ?? 0;

    int? sequence = fullDataAcademicInformation?.sequence ?? 0;
    sequenceController.text = (sequence ?? 0).toString();
    averageController.text = (average ?? 0).toString();
    homePageController.averageBachelors.value = average;
    batchNumberController.text =
        (fullDataAcademicInformation?.nOBatch ?? 0).toString();
    double? firstStudentAverage =
        fullDataAcademicInformation?.firstStudentAverage ?? 0;
    int? isFirstStudent = fullDataAcademicInformation?.isFirstStudent ?? 0;
    int? firstQuarter = fullDataAcademicInformation?.firstQuarter ?? 0;
    var universityId = fullDataAcademicInformation?.universityId ?? '';
    var collegesId = fullDataAcademicInformation?.collegesId ?? '';
    var departmentId = fullDataAcademicInformation?.departmentId ?? '';
    var specializationId = fullDataAcademicInformation?.specializationId ?? '';

    return GetBuilder<DropdownListController>(
      builder: (controller) {
        if (controller.isLoading) {
          return const Center(
            child: GifImageCostom(
              Gif: "assets/icons/pencil.gif",
              width: 100,
            ),
          );
        } else if (controller.superData == null) {
          return const Center(
            child: Text("No Data"),
          );
        } else {
          // return Obx(() {
          return Container(
            decoration: BoxDecoration(
                color: KprimeryColor,
                borderRadius: const BorderRadius.all(Radius.circular(19))),
            margin: const EdgeInsets.only(top: 12, right: 12, left: 12),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 60,
                  runSpacing: 20,
                  children: [
                    const TitleAndTextStyle(
                      title: "نوع الشهادة ",
                      initialValue: "بكلوريوس",
                      readOnly: true,
                    ),
                    GetBuilder<DropdownListController>(builder: (controller) {
                      return DropDownList(
                        value: certificateIssuedBy,
                        validator: (value) => isDropdownListValid(value),
                        title: "الشهادة صادرة من ؟",
                        onchange: (val) {
                          academicInformation.certificateIssuedBy = val;
                          certificateIssuedBy = val;
                          // masterCountry.value = val != "خارج العراق";
                          controller.fillterUniversity(val);
                          controller.update();
                        },
                        DropdownMenuItems: ["خارج العراق", "داخل العراق"]
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
                        ? GetBuilder<DropdownListController>(
                            builder: (controller) {
                            return DropDownList(
                              value: int.tryParse(universityId.toString()),
                              width: 450,
                              title: "اسم الجامعة",
                              onchange: (value) {
                                academicInformation.universityId =
                                    value.toString();
                                collegesId = null;
                                fullDataAcademicInformation?.collegesId = null;
                                controller.universityValue.value = value;
                                controller.fillterColleges(
                                    value, 'bachelorsColleges');
                                fullDataAcademicInformation?.universityId =
                                    value;
                                universityId = value;
                                controller.update();
                              },
                              DropdownMenuItems: controller.universities!
                                  .map((e) => DropdownMenuItem(
                                        value: e.universityId,
                                        child: Center(
                                          child: Text('${e.universityName}'),
                                        ),
                                      ))
                                  .toList(),
                            );
                          })
                        : TitleAndTextStyle(
                            width: 300,
                            initialValue: universityId.toString(),
                            title: "اسم الجامعة",
                            validator: (value) =>
                                validateTextWithoutAnyCharacterNumber(value),
                            onchange: (value) {
                              academicInformation.universityId = value;
                            },
                          )),
                    Obx(() => masterCountry.value
                        ? GetBuilder<DropdownListController>(
                            id: 'bachelorsColleges',
                            builder: (controller) {
                              return DropDownList(
                                value: int.tryParse(collegesId.toString()),
                                title: "الكلية",
                                validator: (value) =>
                                    isDropdownListValid(value),
                                onchange: (val) {
                                  academicInformation.collegesId =
                                      val.toString();
                                  controller.departmentsData();
                                  collegesId = val;
                                  departmentId = null;
                                  fullDataAcademicInformation?.collegesId = val;
                                  controller.collegesValue = val;
                                  controller.departmentValue = null;
                                  controller.update();
                                },
                                DropdownMenuItems: controller.colleges!
                                    .map((e) => DropdownMenuItem(
                                          value: e.collegesId,
                                          child: Center(
                                            child: Text('${e.collegesName}'),
                                          ),
                                        ))
                                    .toList(),
                              );
                            })
                        : TitleAndTextStyle(
                            initialValue: collegesId.toString(),
                            width: 250,
                            title: "الكلية",
                            validator: (value) =>
                                validateTextWithoutAnyCharacterNumber(value),
                            onchange: (value) {
                              academicInformation.collegesId = value;
                            },
                          )),
                    Obx(() => masterCountry.value
                        ? GetBuilder<DropdownListController>(
                            builder: (controller) {
                            return DropDownList(
                              title: "القسم",
                              value: int.tryParse(departmentId.toString()),
                              validator: (value) => isDropdownListValid(value),
                              onchange: (val) {
                                academicInformation.departmentId =
                                    val.toString();
                                departmentId = val;
                                controller.update();
                              },
                              DropdownMenuItems: controller
                                  .superData!.department!
                                  .map((e) => DropdownMenuItem(
                                        value: e.departmentId,
                                        child: Center(
                                          child: Text('${e.departmentName}'),
                                        ),
                                      ))
                                  .toList(),
                            );
                          })
                        : TitleAndTextStyle(
                            initialValue: departmentId.toString(),
                            width: 250,
                            title: "القسم",
                            validator: (value) =>
                                validateTextWithoutAnyCharacterNumber(value),
                            onchange: (value) {
                              academicInformation.departmentId = value;
                            },
                          )),
                    Obx(() => masterCountry.value
                        ? GetBuilder<DropdownListController>(
                            builder: (controller) {
                            return DropDownList(
                              value: int.tryParse(specializationId.toString()),
                              title: "التخصص",
                              onchange: (val) {
                                academicInformation.specializationId =
                                    val.toString();
                                specializationId = val;
                                controller.update();
                              },
                              DropdownMenuItems: controller.specializations!
                                  .map((e) => DropdownMenuItem(
                                        value: e.specializationId,
                                        child: Center(
                                          child:
                                              Text('${e.specializationName}'),
                                        ),
                                      ))
                                  .toList(),
                            );
                          })
                        : TitleAndTextStyle(
                            initialValue: specializationId.toString(),
                            width: 300,
                            title: "التخصص",
                            validator: (value) =>
                                validateTextWithoutAnyCharacterNumber(value),
                            onchange: (value) {
                              academicInformation.specializationId = value;
                            },
                          )),
                    GetBuilder<DropdownListController>(builder: (controller) {
                      return DropDownList(
                        title: "العام الدراسي",
                        value: academicYear,
                        validator: (value) => isDropdownListValid(value),
                        onchange: (val) {
                          academicInformation.academicYear = val.toString();
                          academicYear = val;
                          controller.update();
                        },
                        DropdownMenuItems: controller.superData!.years!.reversed
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
                      width: 200,
                      title: " تسلسل الطالب",
                      controller: sequenceController,
                      onchange: (value) {
                        academicInformation.sequence = int.tryParse(value);
                      },
                    ),
                    TitleAndTextStyle(
                      width: 200,
                      title: "عدد الدفعة",
                      controller: batchNumberController,
                      onchange: (value) {
                        academicInformation.nOBatch = int.tryParse(value);
                      },
                    ),
                    TitleAndTextStyle(
                      width: 250,
                      title: "معدل البكلوريوس",
                      controller: averageController,
                      validator: (value) =>
                          validateTextAsNumberLessThan100(value),
                      onchange: (value) {
                        academicInformation.average = double.tryParse(value);
                        homePageController.averageBachelors.value =
                            double.tryParse(value);
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(() {
                      return CustomSwitcher(
                        onChanged: (p0) {
                          checkFirstStudentAverage.value = p0;
                          firstStudentAverage = p0 ? 1 : 0;
                          fullDataFirstStudentAverageObs.value = p0;
                          homePageController.haveFirstStudentAverage.value = p0;
                          controller.update();
                        },
                        title: "هل لديك معدل الطالب الاول ؟ :",
                        initialValue: fullDataFirstStudentAverageObs.value,
                      );
                    }),
                    CustomSwitcher(
                      onChanged: (value) {
                        academicInformation.isFirstStudent = value ? 1 : 0;
                        isFirstStudent = value ? 1 : 0;
                        controller.update();
                      },
                      title: "هل انت الطالب الاول ؟ :",
                      initialValue: isFirstStudent == 1,
                    ),
                    CustomSwitcher(
                      onChanged: (value) {
                        academicInformation.firstQuarter = value ? 1 : 0;
                        homePageController.firstQuarter.value = value;
                        firstQuarter = value ? 1 : 0;
                        controller.update();
                      },
                      title:
                          "هل انت من الربع الاول بالنسبة للكليات الهندسية والطبية؟ :",
                      initialValue: firstQuarter == 1,
                    ),
                    TitleAndTextStyle(
                      // initialValue:
                      // fullDataBachelorDegreeDocument?.documentsNumber ?? '',
                      controller: bachelorDocumentNumberController,
                      width: 250,
                      title: " رقم وثيقة البكلوريوس",
                      onchange: (value) {
                        bachelorDegreeDocument.documentsNumber = value;
                      },
                    ),
                    CustomCalendar(
                      controller: bachelorCalenderController,
                      title: "تاريخ وثيقة البكلوريوس :",
                      constrainWidth: 250,
                      firstDate: DateTime(DateTime.now().year - 100),
                      initialDate: DateTime.now(),
                      lastDate: DateTime.now(),
                      onChange: (value) async {
                        debugPrint("value date = $value");
                      },
                    ),
                    Obx(() => checkFirstStudentAverage.value
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TitleAndTextStyle(
                                initialValue: firstStudentAverage.toString(),
                                width: 200,
                                validator: (value) =>
                                    validateTextAsNumberLessThan100(value),
                                title: "معدل الطالب الاول : ",
                                onchange: (value) {
                                  academicInformation.firstStudentAverage =
                                      int.parse(value);
                                },
                              ),
                              TitleAndTextStyle(
                                // initialValue: fullDataFirstStudentAverage
                                //     ?.documentsNumber ??
                                //     '',
                                controller: endorsementNumberController,
                                width: 500,
                                title:
                                    "رقم كتاب تأييد توفر او عدم توفر معدل الطالب الاول",
                                validator: (value) => isTextValid(value, 1),
                                onchange: (value) {
                                  endorsementLetter.documentsNumber = value;
                                },
                              ),
                              CustomCalendar(
                                controller: endorsementCalenderController,
                                constrainWidth: 500,
                                title:
                                    "تاريخ كتاب تأييد توفر او عدم توفر معدل الطالب الاول",
                              ),
                            ],
                          )
                        : Container()),
                    const SizedBox(
                      width: double.infinity,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButtonostom(
                            controller: homePageController,
                            index: 1,
                            dgree: "بكلوريوس"),
                        ButtonStyleS(
                          colorBorder: Colors.greenAccent,
                          containborder: true,
                          isleft: true,
                          icon: Icons.save_outlined,
                          title: 'حفظ الشهادة',
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              bachelorDegreeDocument.documentsDate =
                                  bachelorCalenderController.text;

                              bachelorDegreeDocument.documentsNumber =
                                  bachelorDocumentNumberController.text;

                              bachelorDegreeDocument.documentsTypeId =
                                  DocumentsType.bachelorDegreeCertificate.id;
                              academicInformation.certificateTypeId =
                                  CertificateType.bachelors.id;
                              if (academicInformation.documents != null) {
                                academicInformation.documents!.clear();
                              } else {
                                academicInformation.documents = [];
                              }
                              academicInformation.documents
                                  ?.add(bachelorDegreeDocument);
                              if (checkFirstStudentAverage.value) {
                                endorsementLetter.documentsDate =
                                    endorsementCalenderController.text;
                                // endorsementLetter.documentsNumber =
                                //     documentsNumberController.text;
                                endorsementLetter.documentsTypeId =
                                    DocumentsType
                                        .firstStudentAverageConfirmationLetter
                                        .id;
                                academicInformation.documents
                                    ?.add(endorsementLetter);
                              }
                              academicInformationController
                                  .addOrUpdateAcademicInformation(
                                      academicInformation);
                              // .academicInformationModel!.academicInformation
                              // ?.add(academicInformation);
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
          // });
        }
      },
    );
  }
}
