import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduate_gtudiesV2/Enums/documents_types.dart';
import 'package:graduate_gtudiesV2/Models/academic_information.dart';
import 'package:graduate_gtudiesV2/controller/dropdown_filter_controllers.dart';
import '../../Enums/certificate_competency.dart';
import '../../Models/certificate_data.dart';
import '../../Models/full_student_data.dart';
import '../../Services/DilogCostom.dart';
import '../../Services/base_route.dart';
import '../../ValidatorFunction/text_validator.dart';
import '../../controller/certificate_data_controller.dart';
import '../../controller/exam_centers_controller.dart';
import '../../controller/home_page_controller.dart';
import '../../theme.dart';
import '../widget/GifImageCostom.dart';
import '../widget/buttonsyle.dart';
import '../widget/coustom_calender.dart';
import '../widget/custom_switcher.dart';
import '../widget/dropdownlistt.dart';
import '../widget/titleandtextstyle.dart';
import 'DialogsWindows/loading_dialog.dart';

class OtherInformation extends StatelessWidget {
  OtherInformation({super.key});

  Rx<bool> olmped = false.obs;

  Rx<bool> haveIelts = false.obs;

  Rx<bool> olmpedValue = false.obs;

  CertificateDataController certificateDataController =
      Get.put(CertificateDataController());

  Rx<bool> isRegistrationUpgraded = false.obs;

  Documents sportDocument = Documents();

  TextEditingController sportDocumentDate = TextEditingController();

  TextEditingController sportDocumentNumber = TextEditingController();

  TextEditingController sportName = TextEditingController();

  HomePageController homePageController = Get.put(HomePageController());

  DropdownListController dropdownListController =
      Get.put(DropdownListController());

  Certificatecompetency certificateCompetencyEnglish = Certificatecompetency();

  Certificatecompetency certificateCompetencyArabic = Certificatecompetency();

  Certificatecompetency certificateCompetencyComputer = Certificatecompetency();

  Certificatecompetency certificateCompetencyIlits = Certificatecompetency();

  @override
  Widget build(BuildContext context) {
    List<FullDataCertificateCompetency>? certificateCompetency;
    FullDataCertificateCompetency? fullDataCertificateCompetencyEnglish =
        FullDataCertificateCompetency();
    FullDataCertificateCompetency? fullDataCertificateCompetencyArabic =
        FullDataCertificateCompetency();
    FullDataCertificateCompetency? fullDataCertificateCompetencyComputer =
        FullDataCertificateCompetency();
    FullDataCertificateCompetency? fullDataCertificateCompetencyIlits =
        FullDataCertificateCompetency();
    TextEditingController certificateCompetencyEnglishController =
        TextEditingController();
    TextEditingController certificateCompetencyArabicController =
        TextEditingController();
    TextEditingController certificateCompetencyComputerController =
        TextEditingController();
    TextEditingController certificateCompetencyIlitsController =
        TextEditingController();
    dynamic englishExamCenterId;
    dynamic arabicExamCenterId;
    dynamic computerExamCenterId;
    dynamic ilitsExamCenterId;
    dynamic medalTypeId;
    if (homePageController.fullStudentData.value.certificateCompetency !=
            null &&
        homePageController
            .fullStudentData.value.certificateCompetency!.isNotEmpty) {
      certificateCompetency =
          homePageController.fullStudentData.value.certificateCompetency;
      FullDataPersonalInformation? fullDataPersonalInformation =
          homePageController.fullStudentData.value.personalInformation?.first;
      Documents? documents;
      SportChampion? sportChampion;
      if (homePageController.fullStudentData.value.sportChampion != null) {
        sportChampion =
            homePageController.fullStudentData.value.sportChampion?.firstOrNull;
      }

      if (sportChampion != null) {
        olmpedValue.value = true;
        olmped.value = true;

        sportName.text = sportChampion.name ?? '';

        certificateDataController.certificateData.name = sportName.text;
        certificateDataController.certificateData.medalTypeId = medalTypeId;
        medalTypeId = sportChampion.medalTypeId;
        if (sportChampion.documents != null) {
          documents = sportChampion.documents;
        } else {
          documents = null;
        }
        if (documents != null) {
          sportDocumentDate.text = documents.documentsDate ?? '';
          sportDocumentNumber.text = documents.documentsNumber ?? '';
          certificateDataController.certificateData.documents?.add(documents);
        }
      } else {
        olmpedValue.value = false;
        olmped.value = false;
        // Reset or clear the relevant fields
        sportName.clear();
        sportDocumentDate.clear();
        sportDocumentNumber.clear();
      }

      isRegistrationUpgraded.value =
          fullDataPersonalInformation?.isRegistrationUpgraded == 1;

      if (certificateCompetency != null && certificateCompetency.isNotEmpty) {
        fullDataCertificateCompetencyIlits = certificateCompetency.firstWhere(
          (c) =>
              c.certificateCompetencyTypeId ==
              CertificateCompetencyTypes.certificateCompetencyIlits.id,
          orElse: () => FullDataCertificateCompetency(),
        );
        fullDataCertificateCompetencyComputer =
            certificateCompetency.firstWhere(
                (c) =>
                    c.certificateCompetencyTypeId ==
                    CertificateCompetencyTypes.certificateCompetencyComputer.id,
                orElse: () => FullDataCertificateCompetency());
        fullDataCertificateCompetencyEnglish = certificateCompetency.firstWhere(
            (c) =>
                c.certificateCompetencyTypeId ==
                CertificateCompetencyTypes.certificateCompetencyEnglish.id,
            orElse: () => FullDataCertificateCompetency());

        fullDataCertificateCompetencyArabic = certificateCompetency.firstWhere(
            (c) =>
                c.certificateCompetencyTypeId ==
                CertificateCompetencyTypes.certificateCompetencyArabic.id,
            orElse: () => FullDataCertificateCompetency());

        if (fullDataCertificateCompetencyIlits != null) {
          certificateCompetencyIlitsController.text =
              fullDataCertificateCompetencyIlits.appreciation.toString() ?? '';
          ilitsExamCenterId = fullDataCertificateCompetencyIlits.examCenter;
          certificateCompetencyIlits =
              fullDataCertificateCompetencyIlits.toCertificateCompetency();
        } else {
          certificateCompetencyIlitsController.text = '';
          ilitsExamCenterId = null;
        }
        if (fullDataCertificateCompetencyComputer != null) {
          certificateCompetencyComputerController.text =
              fullDataCertificateCompetencyComputer.appreciation.toString() ??
                  '';
          computerExamCenterId =
              fullDataCertificateCompetencyComputer.examCenter;
          certificateCompetencyComputer =
              fullDataCertificateCompetencyComputer.toCertificateCompetency();
        } else {
          certificateCompetencyComputerController.text = '';
          computerExamCenterId = null;
        }

        if (fullDataCertificateCompetencyEnglish != null) {
          certificateCompetencyEnglishController.text =
              fullDataCertificateCompetencyEnglish.appreciation.toString() ??
                  '';
          englishExamCenterId = fullDataCertificateCompetencyEnglish.examCenter;
          certificateCompetencyEnglish =
              fullDataCertificateCompetencyEnglish.toCertificateCompetency();
        } else {
          certificateCompetencyEnglishController.text = '';
          englishExamCenterId = null;
        }
        if (fullDataCertificateCompetencyArabic != null) {
          certificateCompetencyArabicController.text =
              fullDataCertificateCompetencyArabic.appreciation.toString() ?? '';
          arabicExamCenterId = fullDataCertificateCompetencyArabic.examCenter;
          certificateCompetencyArabic =
              fullDataCertificateCompetencyArabic.toCertificateCompetency();
        } else {
          certificateCompetencyArabicController.text = '';
          arabicExamCenterId = null;
        }
      }
    }

    certificateDataController.certificateData.isRegistrationUpgraded = 0;
    var size = MediaQuery.of(context).size;
    final formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: GetBuilder<ExamCentersController>(
            init: ExamCentersController(),
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
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(19))),
                      margin: const EdgeInsets.only(top: 12, right: 12),
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Wrap(
                          alignment: WrapAlignment.start,
                          spacing: 60,
                          runSpacing: 20,
                          children: [
                            Obx(() {
                              return CustomSwitcher(
                                  initialValue: isRegistrationUpgraded.value,
                                  onChanged: (value) {
                                    value
                                        ? certificateDataController
                                            .certificateData
                                            .isRegistrationUpgraded = 1
                                        : 0;
                                    isRegistrationUpgraded.value = value;
                                    homePageController.update();
                                  },
                                  maxwidth: 500,
                                  title:
                                      "هل تم ترقين قيدك او انهاء علاقتك اوالغاء قبول في الدراسات العليا سابقا ؟");
                            }),
                            const SizedBox(
                              width: double.infinity,
                            ),
                            TitleAndTextStyle(
                                validator: (value) =>
                                    validateTextAsNumberLessThan100(value),
                                controller:
                                    certificateCompetencyComputerController,
                                onchange: (value) {
                                  certificateCompetencyComputer.appreciation =
                                      double.parse(value);
                                  certificateCompetencyComputer
                                          .certificateCompetencyTypeId =
                                      CertificateCompetencyTypes
                                          .certificateCompetencyComputer.id;
                                },
                                width: 300,
                                title: "درجة امتحان الوطني الحاسوب :"),
                            TitleAndTextStyle(
                              width: 500,
                              initialValue: computerExamCenterId,
                              title: "اسم مركز الامتحاني",
                              validator: (value) =>
                                  validateTextWithoutAnyCharacterNumber(value),
                              onchange: (val) {
                                certificateCompetencyComputer.examCenter = val;
                                computerExamCenterId = val;
                                homePageController
                                    .haveComputerProficiencyCertificate
                                    .value = val != null || val.trim() != "";
                              },
                            ),
                            // GetBuilder<ExamCentersController>(
                            //     id: 'الجهة المانحة لامتحان كفائة الحاسوب',
                            //     builder: (controller) {
                            //       return DropDownList(
                            //         value: computerExamCenterId,
                            //         width: 500,
                            //         title:
                            //             "الجهة المانحة لامتحان كفائة الحاسوب ",
                            //         onchange: (val) {
                            //           certificateCompetencyComputer
                            //               .examCenter = val;
                            //           computerExamCenterId = val;
                            //           homePageController
                            //               .haveComputerProficiencyCertificate
                            //               .value = val != null;
                            //           controller.update();
                            //         },
                            //         DropdownMenuItems:
                            //             controller.examCenters!.centers!
                            //                 .map((e) => DropdownMenuItem(
                            //                       value: e.examCenter,
                            //                       child: Center(
                            //                         child: Text(e.name!),
                            //                       ),
                            //                     ))
                            //                 .toList(),
                            //       );
                            //     }),
                            const SizedBox(
                              width: double.infinity,
                            ),
                            TitleAndTextStyle(
                                validator: (value) =>
                                    validateTextAsNumberLessThan100(value),
                                controller:
                                    certificateCompetencyArabicController,
                                onchange: (value) {
                                  certificateCompetencyArabic.appreciation =
                                      double.parse(value);
                                  certificateCompetencyArabic
                                          .certificateCompetencyTypeId =
                                      CertificateCompetencyTypes
                                          .certificateCompetencyArabic.id;
                                },
                                width: 300,
                                title: "درجة امتحان الوطني اللغة العربية  :"),
                            TitleAndTextStyle(
                              width: 500,
                              initialValue: arabicExamCenterId,
                              title: "اسم مركز الامتحاني",
                              validator: (value) =>
                                  validateTextWithoutAnyCharacterNumber(value),
                              onchange: (val) {
                                certificateCompetencyArabic.examCenter = val;
                                arabicExamCenterId = val;
                                homePageController
                                    .haveArabicLanguageProficiencyCertificate
                                    .value = val != null || val.trim() != "";
                              },
                            ),
                            // GetBuilder<ExamCentersController>(
                            //     //id: 'الجهة المانحة لامتحان كفائة العربي',
                            //     builder: (controller) {
                            //   return DropDownList(
                            //       value: arabicExamCenterId,
                            //       width: 500,
                            //       title: "الجهة المانحة لامتحان كفائة العربي ",
                            //       onchange: (val) {
                            //         certificateCompetencyArabic.examCenter =
                            //             val;
                            //         arabicExamCenterId = val;
                            //         homePageController
                            //             .haveArabicLanguageProficiencyCertificate
                            //             .value = val != null;
                            //         controller.update();
                            //       },
                            //       DropdownMenuItems:
                            //           controller.examCenters!.centers!
                            //               .map((e) => DropdownMenuItem(
                            //                     value: e.examCenter,
                            //                     child: Center(
                            //                       child: Text(e.name!),
                            //                     ),
                            //                   ))
                            //               .toList());
                            // }),
                            const SizedBox(
                              width: double.infinity,
                            ),
                            if (homePageController.maturityIelts.value)
                              Obx(() {
                                return CustomSwitcher(
                                    initialValue: haveIelts.value,
                                    onChanged: (value) {
                                      haveIelts.value = value;
                                    },
                                    maxwidth: 500,
                                    title: "هل تمتلك شهادة Ielts  ؟");
                              }),
                            Obx(() {
                              return haveIelts.value
                                  ? Row(
                                      children: [
                                        TitleAndTextStyle(
                                            validator: (value) =>
                                                validateTextAsNumberLessThan100(
                                                    value),
                                            controller:
                                                certificateCompetencyIlitsController,
                                            onchange: (value) {
                                              certificateCompetencyIlits
                                                      .appreciation =
                                                  double.parse(value);
                                              certificateCompetencyIlits
                                                      .certificateCompetencyTypeId =
                                                  CertificateCompetencyTypes
                                                      .certificateCompetencyIlits
                                                      .id;
                                            },
                                            width: 300,
                                            title: "درجة امتحان ielts:"),
                                        const SizedBox(
                                          width: 35,
                                        ),
                                        TitleAndTextStyle(
                                          width: 500,
                                          initialValue: ilitsExamCenterId,
                                          title: "اسم مركز الامتحاني",
                                          validator: (value) =>
                                              validateTextWithoutAnyCharacterNumber(
                                                  value),
                                          onchange: (val) {
                                            certificateCompetencyIlits
                                                .examCenter = val;
                                            ilitsExamCenterId = val;
                                            homePageController
                                                    .haveIletsCertificate
                                                    .value =
                                                val != null || val.trim() != "";
                                          },
                                        ),
                                        // GetBuilder<ExamCentersController>(
                                        //     id: 'الجهة المانحة ielts',
                                        //     builder: (controller) {
                                        //       return DropDownList(
                                        //           value: ilitsExamCenterId,
                                        //           width: 500,
                                        //           title: "الجهة المانحة ielts ",
                                        //           onchange: (val) {
                                        //             certificateCompetencyIlits
                                        //                 .examCenter = val;
                                        //             ilitsExamCenterId = val;
                                        //             homePageController
                                        //                 .haveIletsCertificate
                                        //                 .value = val != null;
                                        //             controller.update();
                                        //           },
                                        //           DropdownMenuItems: controller
                                        //               .examCenters!.centers!
                                        //               .map((e) =>
                                        //                   DropdownMenuItem(
                                        //                     value:
                                        //                         e.examCenter,
                                        //                     child: Center(
                                        //                       child:
                                        //                           Text(e.name!),
                                        //                     ),
                                        //                   ))
                                        //               .toList());
                                        //     }),
                                      ],
                                    )
                                  : Container();
                            }),
                            Obx(() {
                              return !haveIelts.value
                                  ? Row(
                                      children: [
                                        TitleAndTextStyle(
                                            controller:
                                                certificateCompetencyEnglishController,
                                            validator: (value) =>
                                                validateTextAsNumberLessThan100(
                                                    value),
                                            onchange: (value) {
                                              certificateCompetencyEnglish
                                                      .appreciation =
                                                  double.parse(value);
                                              certificateCompetencyEnglish
                                                      .certificateCompetencyTypeId =
                                                  CertificateCompetencyTypes
                                                      .certificateCompetencyEnglish
                                                      .id;
                                            },
                                            width: 350,
                                            title:
                                                "درجة امتحان الوطني اللغة الانكليزية :"),
                                        const SizedBox(
                                          width: 35,
                                        ),
                                        TitleAndTextStyle(
                                          width: 500,
                                          initialValue: englishExamCenterId,
                                          title: "اسم مركز الامتحاني",
                                          validator: (value) =>
                                              validateTextWithoutAnyCharacterNumber(
                                                  value),
                                          onchange: (val) {
                                            certificateCompetencyEnglish
                                                .examCenter = val;
                                            englishExamCenterId = val;
                                            homePageController
                                                .haveEnglishLanguageProficiencyCertificate
                                                .value = val !=
                                                    null ||
                                                val.trim() != "";
                                          },
                                        ),
                                        // GetBuilder<ExamCentersController>(
                                        //     id: 'الجهة المانحة لامتحان كفائة الانكليزي',
                                        //     builder: (controller) {
                                        //       return DropDownList(
                                        //           value: englishExamCenterId,
                                        //           width: 500,
                                        //           title:
                                        //               "الجهة المانحة لامتحان كفائة الانكليزي ",
                                        //           onchange: (val) {
                                        //             certificateCompetencyEnglish
                                        //                 .examCenter = val;
                                        //             englishExamCenterId = val;
                                        //             homePageController
                                        //                 .haveEnglishLanguageProficiencyCertificate
                                        //                 .value = val != null;
                                        //             controller.update();
                                        //           },
                                        //           DropdownMenuItems: controller
                                        //               .examCenters!.centers!
                                        //               .map((e) =>
                                        //                   DropdownMenuItem(
                                        //                     value:
                                        //                         e.examCenter,
                                        //                     child: Center(
                                        //                       child:
                                        //                           Text(e.name!),
                                        //                     ),
                                        //                   ))
                                        //               .toList());
                                        //     })
                                      ],
                                    )
                                  : Container();
                            }),
                            const SizedBox(
                              width: double.infinity,
                            ),
                            Obx(() {
                              return homePageController.sportCollage.value
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomSwitcher(
                                            initialValue: olmpedValue.value,
                                            onChanged: (p0) {
                                              olmped.value = p0;
                                              olmpedValue.value = p0;
                                              homePageController
                                                  .haveOlympicCommitteeBook
                                                  .value = p0;
                                            },
                                            maxwidth: 500,
                                            title:
                                                "هل انت من الرياضيين الابطال ؟"),
                                        const SizedBox(
                                          height: 35,
                                        ),
                                        if (olmpedValue.value)
                                          Row(
                                            children: [
                                              GetBuilder<
                                                      DropdownListController>(
                                                  init:
                                                      DropdownListController(),
                                                  builder: (controller) {
                                                    return DropDownList(
                                                        value: medalTypeId,
                                                        width: 250,
                                                        title:
                                                            "حاصل على وسام؟ :",
                                                        onchange: (val) {
                                                          certificateDataController
                                                              .certificateData
                                                              .medalTypeId = val;
                                                          medalTypeId = val;
                                                          controller.update();
                                                        },
                                                        DropdownMenuItems:
                                                            controller
                                                                .superData!
                                                                .medalTypes!
                                                                .map((e) =>
                                                                    DropdownMenuItem(
                                                                      value: e
                                                                          .medalTypeId,
                                                                      child:
                                                                          Center(
                                                                        child: Text(
                                                                            e.name!),
                                                                      ),
                                                                    ))
                                                                .toList());
                                                  }),
                                              const SizedBox(
                                                width: 35,
                                              ),
                                              TitleAndTextStyle(
                                                  onchange: (value) {
                                                    certificateDataController
                                                        .certificateData
                                                        .name = value;
                                                  },
                                                  controller: sportName,
                                                  title: "حاصل على وسام؟ :"),
                                              const SizedBox(
                                                width: 35,
                                              ),
                                              TitleAndTextStyle(
                                                  onchange: (value) {
                                                    sportDocument
                                                            .documentsNumber =
                                                        value;
                                                    sportDocument
                                                            .documentsTypeId =
                                                        DocumentsType
                                                            .olympicCommitteeLetter
                                                            .id;
                                                  },
                                                  controller:
                                                      sportDocumentNumber,
                                                  title:
                                                      "رقم كتاب اللجنة الاولمبية"),
                                              const SizedBox(
                                                width: 35,
                                              ),
                                              CustomCalendar(
                                                  controller: sportDocumentDate,
                                                  title:
                                                      "تاريخ كتاب اللجنة الاولمبية")
                                            ],
                                          ),
                                      ],
                                    )
                                  : Container();
                            }),
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
                                        // Clear and add new certificate documents and competencies
                                        certificateDataController
                                            .certificateData.documents = [];
                                        certificateDataController
                                            .certificateData
                                            .certificateCompetency = [];

                                        if (olmped.value) {
                                          sportDocument.documentsDate =
                                              sportDocumentDate.text;
                                          certificateDataController
                                              .certificateData.documents!
                                              .add(sportDocument);
                                        }

                                        // Add certificate competencies
                                        certificateDataController
                                            .certificateData
                                            .certificateCompetency!
                                            .add(certificateCompetencyComputer);

                                        if (certificateCompetencyEnglish
                                                .examCenter !=
                                            null) {
                                          certificateDataController
                                              .certificateData
                                              .certificateCompetency!
                                              .add(
                                                  certificateCompetencyEnglish);
                                        }

                                        certificateDataController
                                            .certificateData
                                            .certificateCompetency!
                                            .add(certificateCompetencyArabic);

                                        if (certificateCompetencyIlits
                                                .examCenter !=
                                            null) {
                                          certificateDataController
                                              .certificateData
                                              .certificateCompetency!
                                              .add(certificateCompetencyIlits);
                                        }

                                        // Upload data
                                        var status =
                                            await certificateDataController
                                                .uploadData();
                                        homePageController.otherInformation
                                            .isFull.value = status;

                                        // Hide the loading dialog
                                        Get.back();

                                        if (status) {
                                    
                                          homePageController.pageChange(
                                              homePageController
                                                  .uploadImagePage.index);

                                          // Optionally show a confirmation dialog if there's a serial number
                                          if (homePageController.fullStudentData
                                                  .value.serial !=
                                              null) {
                                            DilogCostom.confirmFinishEditing(
                                                onSubmit: () async {
                                              await homePageController
                                                  .modifyComplete();
                                            });
                                          }
                                        }
                                        Get.back();
                                      } catch (e) {
                                        // Hide the loading dialog in case of an error
                                        Get.back();

                                        // Handle exception by showing an error dialog
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
