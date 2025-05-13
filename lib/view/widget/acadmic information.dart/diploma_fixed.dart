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
    
    var universityId = fullDataAcademicInformation?.universityId ?? '';
    var collegesId = fullDataAcademicInformation?.collegesId ?? '';
    var departmentId = fullDataAcademicInformation?.departmentId ?? '';
    int? isDiplomaCompatible = fullDataAcademicInformation?.isDiplomaCompatible;
    Rx<bool> isDiplomaCompatibleObs = (isDiplomaCompatible == 1).obs;

    return GetBuilder<DropdownListController>(
      init: DropdownListController(),
      builder: (cont) {
        return cont.isLoading.value
            ? const Center(
                child: GifImageCostom(
                  Gif: "assets/icons/pencil.gif",
                  height: 100,
                  width: 100,
                ),
              )
            : GetBuilder<DropdownListController>(
                builder: (controller) {
                  return Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            CustomSwitcher(
                              initialValue: diplomaMasterCountry.value,
                              onChanged: (value) {
                                diplomaMasterCountry.value = value;
                                diplomaInformation.certificateIssuedBy =
                                    value ? "داخل العراق" : "خارج العراق";
                              },
                              title: "هل الشهادة داخل العراق ؟",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Obx(() => diplomaMasterCountry.value
                                ? GetBuilder<DropdownListController>(
                                    builder: (controller) {
                                    return DropDownList(
                                      title: "الجامعة",
                                      value: int.tryParse(
                                          universityId.toString()),
                                      validator: (value) =>
                                          isDropdownListValid(value),
                                      onchange: (val) {
                                        diplomaInformation.universityId =
                                            val.toString();
                                        universityId = val;
                                        controller.collegesData();
                                        collegesId = null;
                                        departmentId = null;
                                        fullDataAcademicInformation
                                            ?.universityId = val;
                                        controller.collegesValue = null;
                                        controller.departmentValue = null;
                                        controller.update();
                                      },
                                      DropdownMenuItems: controller
                                          .superData!.universities!
                                          .map((e) => DropdownMenuItem(
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
                                    initialValue: universityId.toString(),
                                    width: 250,
                                    title: "الجامعة",
                                    validator: (value) =>
                                        validateTextWithoutAnyCharacterNumber(
                                            value),
                                    onchange: (value) {
                                      diplomaInformation.universityId = value;
                                    },
                                  )),
                            Obx(() => diplomaMasterCountry.value
                                ? GetBuilder<DropdownListController>(
                                    builder: (controller) {
                                    return DropDownList(
                                      title: "الكلية",
                                      value: int.tryParse(
                                          collegesId.toString()),
                                      validator: (value) =>
                                          isDropdownListValid(value),
                                      onchange: (val) {
                                        diplomaInformation.collegesId =
                                            val.toString();
                                        controller.departmentsData();
                                        collegesId = val;
                                        departmentId = null;
                                        fullDataAcademicInformation
                                            ?.collegesId = val;
                                        controller.collegesValue = val;
                                        controller.departmentValue = null;
                                        controller.update();
                                      },
                                      DropdownMenuItems: controller.colleges!
                                          .map((e) => DropdownMenuItem(
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
                                    initialValue: collegesId.toString(),
                                    width: 250,
                                    title: "الكلية",
                                    validator: (value) =>
                                        validateTextWithoutAnyCharacterNumber(
                                            value),
                                    onchange: (value) {
                                      diplomaInformation.collegesId = value;
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
                                        diplomaInformation.departmentId =
                                            val.toString();
                                        departmentId = val;
                                        controller.update();
                                      },
                                      DropdownMenuItems: controller
                                          .superData!.department!
                                          .map((e) => DropdownMenuItem(
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
                                    initialValue: departmentId.toString(),
                                    width: 250,
                                    title: "القسم",
                                    validator: (value) =>
                                        validateTextWithoutAnyCharacterNumber(
                                            value),
                                    onchange: (value) {
                                      diplomaInformation.departmentId = value;
                                    },
                                  )),
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
                                  validateTextAsNumberLessThan100(value),
                              width: 200,
                              title: "معدل الدبلوم",
                            ),
                            TitleAndTextStyle(
                              controller: controllerDocumentsNumber,
                              onchange: (value) {
                                universityMatterDocument.documentsNumber =
                                    value;
                              },
                              width: 350,
                              title: " رقم الامر الجامعي الخاص بمنح الدبلوم ",
                            ),
                            CustomCalendar(
                              constrainWidth: 350,
                              title: "تاريخ الامر الجامعي الخاص بمنح الدبلوم :",
                              controller: universityMatterController,
                            ),
                            SizedBox(
                              width: 250,
                              child: Obx(() {
                                return CustomSwitcher(
                                  initialValue: isDiplomaCompatibleObs.value,
                                  onChanged: (value) {
                                    isDiplomaCompatibleObs.value = value;
                                    diplomaInformation.isDiplomaCompatible =
                                        value ? 1 : 0;
                                  },
                                  title: "هل الدبلوم متوافق مع البكلوريوس؟ :",
                                );
                              }),
                            ),
                            const SizedBox(
                              width: double.infinity,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: IconButtonostom(
                                        controller: homePageController,
                                        index: widget.index,
                                        dgree: "دبلوم"),
                                  ),
                                  Flexible(
                                    child: ButtonStyleS(
                                      colorBorder: Colors.greenAccent,
                                      containborder: true,
                                      isleft: true,
                                      icon: Icons.save_outlined,
                                      title: 'حفظ الشهادة',
                                      onTap: () async {
                                        if (_formKey.currentState!.validate()) {
                                          diplomaInformation.certificateTypeId =
                                              CertificateType.diploma.id;

                                          if (diplomaInformation.documents !=
                                              null) {
                                            diplomaInformation.documents!
                                                .clear();
                                          } else {
                                            diplomaInformation.documents = [];
                                          }
                                          diplomaInformation.nOBatch = 0;
                                          universityMatterDocument
                                                  .documentsNumber =
                                              controllerDocumentsNumber.text;
                                          universityMatterDocument
                                                  .documentsDate =
                                              universityMatterController.text;
                                          universityMatterDocument
                                                  .documentsTypeId =
                                              DocumentsType.diplomaOrder.id;
                                          diplomaInformation.documents
                                              ?.add(universityMatterDocument);
                                          
                                          academicInformationController
                                              .addOrUpdateAcademicInformation(
                                                  diplomaInformation);
                                          
                                          await DilogCostom.dilogSecss(
                                            isErorr: false,
                                            title: "تم حفظ الشهادة بنجاح",
                                            icons: Icons.close,
                                            color: Colors.greenAccent,
                                          );
                                        }
                                      },
                                    ),
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
      },
    );
  }
}
