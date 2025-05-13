import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduate_gtudiesV2/Enums/CertificateType.dart';
import 'package:graduate_gtudiesV2/Models/academic_information.dart';
import 'package:graduate_gtudiesV2/Models/full_student_data.dart';
import 'package:graduate_gtudiesV2/Models/super_data.dart';
import 'package:graduate_gtudiesV2/Services/DilogCostom.dart';
import '../../../Enums/DocumentsTypes.dart';
import '../../../ValidatorFunction/text_validator.dart';
import '../../../controller/AcademicInformationController.dart';
import '../../../controller/dropdown_filter_controllers.dart';
import '../../../controller/home_page_controller.dart';
import '../../../theme.dart';
import '../../pages/UploadImage/controller/UploadImageController.dart';
import '../GifImageCostom.dart';
import '../IconButtonostom.dart';
import '../buttonsyle.dart';
import '../coustom_calender.dart';
import '../custom switcher.dart';
import '../dropdownlistt.dart';
import '../titleandtextstyle.dart';

class Bachelors extends StatefulWidget {
  final int index;

  const Bachelors({super.key, required this.index});

  @override
  State<Bachelors> createState() => _BachelorsState();
}

class _BachelorsState extends State<Bachelors> {
  late final HomePageController homePageController;
  late final UploadingImagesController uploadingImagesController;
  late final AcademicInformationController academicInformationController;
  late final DropdownListController dropdownListController;
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController bachelorCalenderController;
  late final TextEditingController endorsementCalenderController;
  late final TextEditingController endorsementNumberController;
  late final TextEditingController bachelorDocumentNumberController;
  late final TextEditingController sequenceController;
  late final TextEditingController batchNumberController;
  late final TextEditingController averageController;
  late final Documents bachelorDegreeDocument;
  late final Documents endorsementLetter;
  late final AcademicInformation academicInformation;
  Documents? fullDataBachelorDegreeDocument;
  Documents? fullDataFirstStudentAverage;

  @override
  void initState() {
    super.initState();
    homePageController = Get.put(HomePageController());
    uploadingImagesController = Get.put(UploadingImagesController());
    academicInformationController = Get.find<AcademicInformationController>();
    dropdownListController = Get.put(DropdownListController());
    bachelorCalenderController = TextEditingController();
    endorsementCalenderController = TextEditingController();
    endorsementNumberController = TextEditingController();
    bachelorDocumentNumberController = TextEditingController();
    sequenceController = TextEditingController();
    batchNumberController = TextEditingController();
    averageController = TextEditingController();
    bachelorDegreeDocument = Documents();
    endorsementLetter = Documents();
    academicInformation = AcademicInformation();
  }

  @override
  void dispose() {
    bachelorCalenderController.dispose();
    endorsementCalenderController.dispose();
    endorsementNumberController.dispose();
    bachelorDocumentNumberController.dispose();
    sequenceController.dispose();
    batchNumberController.dispose();
    averageController.dispose();
    super.dispose();
  }

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
    int? isPublicStudy = fullDataAcademicInformation?.isPublicStudy;
    int? typeStudy = fullDataAcademicInformation?.typeStudy;
    var universityId = fullDataAcademicInformation?.universityId ?? '';
    var collegesId = fullDataAcademicInformation?.collegesId ?? '';
    var departmentId = fullDataAcademicInformation?.departmentId ?? '';
    // Removed unused variable departmentId
    var specializationId = fullDataAcademicInformation?.specializationId ?? '';

    return GetBuilder<DropdownListController>(
      builder: (controller) {
        if (controller.isLoading.value) {
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
          return LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth <= SizeR.MobileWidth;
              final isTablet = constraints.maxWidth > SizeR.MobileWidth &&
                  constraints.maxWidth <= SizeR.TabletWidth;

              final horizontalSpacing = isMobile
                  ? 20.0
                  : isTablet
                      ? 40.0
                      : 60.0;
              final verticalSpacing = isMobile ? 15.0 : 20.0;

              final formFieldWidth = isMobile
                  ? constraints.maxWidth - 40
                  : isTablet
                      ? (constraints.maxWidth - 80) / 2
                      : (constraints.maxWidth - 180) / 3;

              return Container(
                decoration: BoxDecoration(
                    color: KprimeryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(19))),
                margin: EdgeInsets.symmetric(
                  vertical: isMobile ? 8 : 12,
                  horizontal: isMobile ? 8 : 12,
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      spacing: horizontalSpacing,
                      runSpacing: verticalSpacing,
                      children: [
                        TitleAndTextStyle(
                          title: "نوع الشهادة ",
                          initialValue: "بكلوريوس",
                          readOnly: true,
                          width: formFieldWidth,
                        ),
                        GetBuilder<DropdownListController>(
                            builder: (controller) {
                          return DropDownList(
                            width: formFieldWidth,
                            title: "الجامعة",
                            DropdownMenuItems: (controller
                                    .superData?.universities
                                    ?.map((e) => DropdownMenuItem(
                                          value: e.universityName ?? '',
                                          child: Center(
                                              child:
                                                  Text(e.universityName ?? '')),
                                        ))
                                    .toList() ??
                                []),
                            onchange: (value) {
                              var university = controller
                                  .superData?.universities
                                  ?.firstWhere(
                                      (e) => e.universityName == value);
                              academicInformation.universityId =
                                  (university?.universityId ?? 0).toString();
                              academicInformation.universityName =
                                  university?.universityName;
                              controller.update();
                            },
                            initialValue: controller.superData?.universities
                                ?.firstWhere(
                                    (e) => e.universityId == universityId,
                                    orElse: () => Universities())
                                .universityName,
                          );
                        }),
                        // GetBuilder<DropdownListController>(builder: (controller) {
                        //   return DropDownList(
                        //     width: formFieldWidth,
                        //     title: "الكلية",
                        //     items: controller.superData?.colleges
                        //             ?.map((e) => e.name ?? '')
                        //             .toList() ??
                        //         [],
                        //     onChanged: (value) {
                        //       var college = controller.superData?.colleges
                        //           ?.firstWhere((e) => e.name == value);
                        //       academicInformation.collegesId = college?.id;
                        //       academicInformation.collegesName = college?.name;
                        //       controller.update();
                        //     },
                        //     selectedValue: controller.superData?.colleges
                        //         ?.firstWhere(
                        //             (e) => e.id == collegesId,
                        //             orElse: () => College())
                        //         .name,
                        //   );
                        // }),
                        // GetBuilder<DropdownListController>(builder: (controller) {
                        //   return DropDownList(
                        //     width: formFieldWidth,
                        //     title: "التخصص",
                        //     items: controller.superData?.specializations
                        //             ?.map((e) => e.name ?? '')
                        //             .toList() ??
                        //         [],
                        //     onChanged: (value) {
                        //       var specialization = controller
                        //           .superData?.specializations
                        //           ?.firstWhere((e) => e.name == value);
                        //       academicInformation.specializationId =
                        //           specialization?.id;
                        //       academicInformation.specializationName =
                        //           specialization?.name;
                        //       controller.update();
                        //     },
                        //     selectedValue: controller.superData?.specializations
                        //         ?.firstWhere(
                        //             (e) => e.id == specializationId,
                        //             orElse: () => Specialization())
                        //         .name,
                        //   );
                        // }),
                        TitleAndTextStyle(
                          initialValue: departmentId.toString(),
                          width: 350,
                          title: "القسم",
                          validator: (value) =>
                              validateTextWithoutAnyCharacterNumber(value),
                          onchange: (value) {
                            academicInformation.departmentId = value;
                          },
                        ),
                        TitleAndTextStyle(
                          width: formFieldWidth,
                          title: "السنة الدراسية",
                          initialValue: academicYear,
                          onchange: (value) {
                            academicInformation.academicYear = value;
                          },
                        ),
                        TitleAndTextStyle(
                          width: formFieldWidth,
                          title: "الجهة المانحة للشهادة",
                          initialValue: certificateIssuedBy,
                          onchange: (value) {
                            academicInformation.certificateIssuedBy = value;
                          },
                        ),
                        CustomSwitcher(
                          maxwidth: formFieldWidth,
                          onChanged: (value) {
                            academicInformation.isPublicStudy = value ? 1 : 0;
                            isPublicStudy = value ? 1 : 0;
                            controller.update();
                          },
                          title: "هل الدراسة حكومية؟ :",
                          initialValue: isPublicStudy == 1,
                        ),
                        CustomSwitcher(
                          maxwidth: formFieldWidth,
                          onChanged: (value) {
                            academicInformation.typeStudy = value ? 1 : 0;
                            typeStudy = value ? 1 : 0;
                            controller.update();
                          },
                          title: "هل الدراسة صباحية؟ :",
                          initialValue: typeStudy == 1,
                        ),
                        CustomSwitcher(
                          maxwidth: formFieldWidth,
                          onChanged: (value) {
                            academicInformation.isFirstStudent = value ? 1 : 0;
                            isFirstStudent = value ? 1 : 0;
                            checkFirstStudentAverage.value = value;
                            controller.update();
                          },
                          title: "هل انت الطالب الاول على الدفعة؟ :",
                          initialValue: isFirstStudent == 1,
                        ),
                        Obx(() => checkFirstStudentAverage.value
                            ? CustomCalendar(
                                width: formFieldWidth,
                                title: "تاريخ كتاب تأييد الطالب الاول",
                                controller: endorsementCalenderController,
                                onChange: (value) {},
                              )
                            : const SizedBox()),
                        CustomCalendar(
                          width: formFieldWidth,
                          title: "تاريخ وثيقة البكلوريوس",
                          controller: bachelorCalenderController,
                          onChange: (value) {},
                        ),
                        TitleAndTextStyle(
                          width: formFieldWidth,
                          title: "رقم وثيقة البكلوريوس",
                          controller: bachelorDocumentNumberController,
                          onchange: (value) {},
                        ),
                        TitleAndTextStyle(
                          width: formFieldWidth,
                          title: " تسلسل الطالب",
                          controller: sequenceController,
                          onchange: (value) {
                            academicInformation.sequence = int.tryParse(value);
                          },
                        ),
                        TitleAndTextStyle(
                          width: formFieldWidth,
                          title: "عدد الدفعة",
                          controller: batchNumberController,
                          onchange: (value) {
                            academicInformation.nOBatch = int.tryParse(value);
                          },
                        ),
                        TitleAndTextStyle(
                          initialValue: firstStudentAverage.toString(),
                          width: formFieldWidth,
                          validator: (value) =>
                              validateTextAsNumberLessThan100(value),
                          title: "معدل الطالب الاول : ",
                          onchange: (value) {
                            academicInformation.firstStudentAverage =
                                (double.tryParse(value) ?? 0).toInt();
                          },
                        ),
                        TitleAndTextStyle(
                          width: formFieldWidth,
                          title: "معدل البكلوريوس",
                          controller: averageController,
                          validator: (value) =>
                              validateTextAsNumberLessThan100(value),
                          onchange: (value) {
                            academicInformation.average =
                                double.tryParse(value);
                            homePageController.averageBachelors.value =
                                double.tryParse(value);
                          },
                        ),
                        CustomSwitcher(
                          maxwidth: formFieldWidth,
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
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButtonostom(
                                controller: homePageController,
                                index: 1,
                                dgree: "بكلوريوس",
                              ),
                              ButtonStyleS(
                                colorBorder: Colors.greenAccent,
                                containborder: true,
                                isleft: true,
                                icon: Icons.save_outlined,
                                title: 'حفظ الشهادة',
                                onTap: () async {
                                  if (_formKey.currentState!.validate()) {
                                    bachelorDegreeDocument.documentsDate =
                                        bachelorCalenderController.text;

                                    bachelorDegreeDocument.documentsNumber =
                                        bachelorDocumentNumberController.text;

                                    bachelorDegreeDocument.documentsTypeId =
                                        DocumentsType
                                            .bachelorDegreeCertificate.id;
                                    academicInformation.certificateTypeId =
                                        CertificateType.bachelors.id;
                                    if (academicInformation.documents != null) {
                                      academicInformation.documents!.clear();
                                    } else {
                                      academicInformation.documents = [];
                                    }
                                    academicInformation.documents!
                                        .add(bachelorDegreeDocument);
                                    if (checkFirstStudentAverage.value) {
                                      endorsementLetter.documentsDate =
                                          endorsementCalenderController.text;
                                      // endorsementLetter.documentsNumber =
                                      //     documentsNumberController.text;
                                      endorsementLetter.documentsTypeId =
                                          DocumentsType
                                              .firstStudentAverageConfirmationLetter
                                              .id;
                                      academicInformation.documents!
                                          .add(endorsementLetter);
                                    }
                                    academicInformationController
                                        .addOrUpdateAcademicInformation(
                                            academicInformation);
                                    homePageController
                                        .haveInsertBachelor.value = true;
                                    await DilogCostom.dilogSecss(
                                      isErorr: false,
                                      title: "تم حفظ الشهادة بنجاح",
                                      icons: Icons.close,
                                      color: Colors.greenAccent,
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
