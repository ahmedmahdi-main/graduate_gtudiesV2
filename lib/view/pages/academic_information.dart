import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduate_gtudiesV2/Enums/certificate_type.dart';

import '../../Models/full_student_data.dart';
import '../../Services/DilogCostom.dart';
import '../../controller/AcademicInformationController.dart';
import '../../controller/home_page_controller.dart';
import '../widget/acadmic information.dart/bachelors.dart';
import '../widget/acadmic information.dart/master.dart';
import '../widget/acadmic information.dart/diploma.dart';
import '../widget/buttonsyle.dart';
import '../widget/custom switcher.dart';

Map<int, dynamic> dgreem = {};
int indexx = 0;

class AcademicInformation extends StatefulWidget {
  const AcademicInformation({super.key});

  @override
  State<AcademicInformation> createState() => _AcademicInformationState();
}

class _AcademicInformationState extends State<AcademicInformation> {
  final HomePageController homePageController = Get.put(HomePageController());

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
    // debugPrint('masterDegree.value = ${masterDegree.value}');
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
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ButtonStyleS(
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
                    homePageController.academicInformation.isFull.value =
                        status;
                    if (status) {
                      homePageController
                              .fullStudentData.value.academicInformation =
                          convertAcademicInfoList(academicInformationController
                              .academicInformationModel?.academicInformation);
                      homePageController.pageChange(
                          homePageController.submissionChannel.index);
                      if (homePageController.fullStudentData.value.serial !=
                          null) {
                        DilogCostom.confirmFinishEditing(onSubmit: () async {
                          await homePageController.modifyComplete();
                        });
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
