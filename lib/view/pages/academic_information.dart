import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduate_gtudiesV2/Enums/CertificateType.dart';

import '../../Models/full_student_data.dart';
import '../../Services/DilogCostom.dart';
import '../../Services/base_route.dart';
import '../../controller/AcademicInformationController.dart';

import '../../controller/home_page_controller.dart';
import '../../theme.dart';
import '../widget/acadmic information.dart/Bachelors.dart';
import '../widget/acadmic information.dart/Master.dart';
import '../widget/acadmic information.dart/diploma.dart';
import '../widget/acadmic information.dart/higherDiploma.dart';
import '../widget/buttonsyle.dart';
import '../widget/custom switcher.dart';
import '../widget/dropdownlistt.dart';
import 'DialogsWindows/loading_dialog.dart';

Map<int, dynamic> dgreem = {};
int indexx = 0;

class AcademicInformation extends StatefulWidget {
  const AcademicInformation({super.key});

  @override
  State<AcademicInformation> createState() => _AcademicInformationState();
}

class _AcademicInformationState extends State<AcademicInformation> {
  final HomePageController homePageController = Get.put(HomePageController());
  final _formKey = GlobalKey<FormState>();

  String? selectedValue;
  Widget? selectedDegree;

  final AcademicInformationController academicInformationController =
      Get.put(AcademicInformationController());

  @override
  Widget build(BuildContext context) {
    Rx<bool> masterDegree = false.obs;
    Rx<bool> diplomaDegree = false.obs;

    List<FullDataAcademicInformation>? academicInformationList =
        homePageController.fullStudentData.value.academicInformation;

    if (academicInformationList != null && academicInformationList.isNotEmpty) {
      masterDegree.value = academicInformationList.any(
        (data) => data.certificateTypeId == CertificateType.masters.id,
      );
      homePageController.haveMaster.value = masterDegree.value;
      diplomaDegree.value = academicInformationList.any(
        (data) => data.certificateTypeId == CertificateType.diploma.id,
      );
    }
    debugPrint('masterDegree.value = ${masterDegree.value}');
    return GetBuilder<HomePageController>(builder: (controller) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Bachelors(
                index: 1,
              ),
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Obx(() {
                    return CustomSwitcher(
                      initialValue: diplomaDegree.value,
                      title: "هل لديك شهادة دبلوم عالي ..؟",
                      onChanged: (value) {
                        diplomaDegree.value = value;
                        homePageController.haveUniversityOrderForDiploma.value =
                            value;
                      },
                    );
                  }),
                  const SizedBox(
                    width: 25,
                  ),
                  Obx(() {
                    return CustomSwitcher(
                      initialValue: masterDegree.value,
                      title: "هل لديك شهادة ماجستير ..؟",
                      onChanged: (value) {
                        masterDegree.value = value;
                        homePageController.haveMaster.value = value;
                        homePageController
                            .haveUniversityOrderForTheMastersDegree
                            .value = value;
                      },
                    );
                  }),
                ],
              ),
              Obx(() => masterDegree.value
                  ? Column(
                      children: [
                        Master(
                          index: 3,
                        ),
                      ],
                    )
                  : Container()),
              Obx(() => diplomaDegree.value
                  ? Diploma(
                      index: 3,
                    )
                  : Container()),
              ButtonStyleS(
                colorBorder: Colors.greenAccent,
                containborder: true,
                isleft: true,
                icon: Icons.arrow_forward_ios,
                title: "حفظ وانتقال للصفحة التالية",
                onTap: () async {
                  debugPrint(
                      "homePageController.haveInsertBachelor.value = ${homePageController.haveInsertBachelor.value}");
                  if (!homePageController.haveInsertBachelor.value) {
                    await DilogCostom.dilogSecss(
                      isErorr: true,
                      title: "يرجى حفظ شهادة البكالوريوس اولا ",
                      icons: Icons.error,
                      color: Colors.redAccent,
                    );
                    return;
                  }

                  var status = await academicInformationController
                      .printAcademicInformation();
                  homePageController.academicInformation.isFull.value = status;
                  if (status) {
                    homePageController
                            .fullStudentData.value.academicInformation =
                        convertAcademicInfoList(academicInformationController
                            .academicInformationModel?.academicInformation);
                    homePageController
                        .pageChange(homePageController.submissionChannel.index);
                    if (homePageController.fullStudentData.value.serial !=
                        null) {
                      DilogCostom.confirmFinishEditing(onSubmit: () async {
                        await homePageController.modifyComplete();
                      });
                    }
                  }
                },
              ),
            ],
          ),
        ),
      );
    });
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Form(
            key: _formKey,
            child: SizedBox(
              height: 95,
              child: DropdownlistWithValedator(
                validator: (value) {
                  if (value == "null" || value!.isEmpty) {
                    return "قم بالاختيار";
                  }
                  return null;
                },

                title: 'اختر الشهادة',
                onChange: (val) {
                  homePageController.degreeIndex = indexx;
                  selectedValue = val;
                  val == CertificateType.higherDiploma.name
                      ? (
                          selectedDegree = Diploma(
                            index: homePageController.degreeIndex,
                          ),
                          homePageController.certificate.remove('دبلوم'),
                        )
                      : val == CertificateType.bachelors.name
                          ? (
                              selectedDegree = Bachelors(
                                index: homePageController.degreeIndex,
                              ),
                              homePageController.certificate.remove('بكلوريوس'),
                            )
                          : val == CertificateType.masters.name
                              ? {
                                  (
                                    selectedDegree = Master(
                                      index: homePageController.degreeIndex,
                                    ),
                                    homePageController.certificate
                                        .remove("ماجستير"),
                                  ),
                                }
                              : (
                                  // selectedDegree = HigherDiploma(
                                  //   index: _controller.degreeIndex,
                                  // ),
                                  // _controller.Certificate.remove('دبلوم عالي')
                                );
                },
                DropdownMenuItems: homePageController.certificate
                    .map((value) => DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        ))
                    .toList(),
                //items: _controller.Certificate,
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('الغاء'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('تم'),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  // Show loading dialog using AwesomeDialog
                  LoadingDialog.showLoadingDialog(message: loadingText);

                  try {
                    // Update degree and index values
                    dgreem.addAll({indexx: selectedDegree});
                    indexx++;

                    // Remove certificate from the list
                    homePageController
                        .removeCertificateList(selectedValue.toString());

                    // Perform the fullStudent action
                    await homePageController.fullStudent();

                    // Hide the loading dialog
                    Get.back();

                    // Optionally, close the current page or show success message
                    // Navigator.of(context).pop();
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
                }
              },
            ),
          ],
        );
      },
    );
  }
}
