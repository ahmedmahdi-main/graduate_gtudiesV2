import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Enums/CertificateType.dart';
import '../../Enums/ChannelTypes.dart';
import '../../Models/academic_information.dart';
import '../../Models/full_student_data.dart';
import '../../Models/super_data.dart';
import '../../Services/DilogCostom.dart';
import '../../Services/base_route.dart';
import '../../controller/dropdown_filter_controllers.dart';
import '../../controller/submission_controller.dart';
import '../../controller/home_page_controller.dart';
import '../../theme.dart';
import '../widget/AddDocumentsWidget.dart';
import '../widget/GifImageCostom.dart';
import '../widget/buttonsyle.dart';
import '../widget/dropdownlistt.dart';
import 'DialogsWindows/loading_dialog.dart';

class SubmissionChannel extends StatelessWidget {
  SubmissionChannel({super.key});

  SubmissionController submissionController = Get.put(SubmissionController());

  HomePageController homePageController =
      Get.put(HomePageController(), permanent: false);
  bool isDateCommencementValid = false;

  var documents = Documents();
  Rx<ChannelsData> channelsData = ChannelsData().obs;
  List<ChannelsDataDocumentsTypes>? documentsTypes =
      <ChannelsDataDocumentsTypes>[];
  TextEditingController documentDateFoundation = TextEditingController();
  List<TextEditingController> numbersControllers = [];

  List<TextEditingController> dateControllers = [];

  @override
  Widget build(BuildContext context) {
    documents = Documents();
    Rx<bool> hasRelativeRelations = false.obs;
    int? scientificBackgroundId;
    int? specializationId;
    int? aCID;
    int? osId;
    int? channelsId;
    int? numberOfSeats;
    int? durationOfStudy;
    String? subjects = '';
    int? setOff;
    int? collegesId;
    int? departmentId;
    int? relativeId;
    RxList<AdmissionChannel> admissionChannels = <AdmissionChannel>[].obs;
    // Get the submission data from the controller
    if (homePageController
        .fullStudentData.value.personalInformation!.isNotEmpty) {
      FullDataPersonalInformation? fullDataPersonalInformation =
          homePageController
              .fullStudentData.value.personalInformation?.firstOrNull;
      AdmissionChannel? admissionChannel =
          fullDataPersonalInformation?.admissionChannel?.firstOrNull;
      if (admissionChannel != null) {
        aCID = admissionChannel.aCID;
        osId = admissionChannel.osId;
        channelsId = admissionChannel.channelsId;
        numberOfSeats = admissionChannel.numberOfSeats;
        durationOfStudy = admissionChannel.durationOfStudy;
        subjects = admissionChannel.subjects ?? '';
        setOff = admissionChannel.setOff ?? 0;
        relativeId = admissionChannel.relativeId;
      } else {
        debugPrint('AdmissionChannel is null');
      }

      if (fullDataPersonalInformation != null) {
        specializationId = fullDataPersonalInformation.specializationId;
        scientificBackgroundId =
            fullDataPersonalInformation.scientificBackgroundId;
        departmentId = fullDataPersonalInformation.departmentId;
      }
      submissionController.submission.scientificBackgroundId =
          scientificBackgroundId;
      submissionController.submission.oSId = osId;
      submissionController.submission.specializationId = specializationId;
      submissionController.submission.channelId = channelsId;
      submissionController.submission.departmentId = departmentId;
      submissionController.submission.documents = null;
      submissionController.submission.relativeId = relativeId;
    }
    bool averageBachelorsFail = false;
    if (homePageController.averageBachelors.value != null &&
        homePageController.averageBachelors.value! < 64.9 &&
        !homePageController.haveUniversityOrderForTheMastersDegree.value) {
      channelsId = 2;
      averageBachelorsFail = true;
    }
    bool typeConsent = false;
    if (homePageController.typeConsentId.value != null &&
        homePageController.typeConsentId.value == 2) {
      channelsId = 2;
      typeConsent = true;
    }
    {
      homePageController.privateAdmissionChannel.value = channelsId == 2;
    }
    submissionController.submission.documents = [];
    Size size = MediaQuery.of(context).size;
    final formKey = GlobalKey<FormState>();
    return GetBuilder<DropdownListController>(
      init: DropdownListController(),
      builder: (Controller) {
        if (departmentId != null) {
          var department = Controller.superData?.department
              ?.where((d) => d.departmentId == departmentId)
              .first;
          collegesId = Controller.superData?.colleges
              ?.where((c) => c.collegesId == department?.collegesId)
              .first
              .collegesId;
        }
        return Form(
          key: formKey,
          child: SingleChildScrollView(
              child: Controller.isLoading
                  ? const Center(
                      child: GifImageCostom(
                        Gif: "assets/icons/pencil.gif",
                        width: 100,
                      ),
                    )
                  : (Controller.superData == null)
                      ? const Center(
                          child: Text("No Data"),
                        )
                      : Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: KprimeryColor,
                                borderRadius: size.width > SizeR.MobileWidth
                                    ? const BorderRadiusDirectional.all(
                                        Radius.circular(19))
                                    : null,
                              ),
                              margin: size.width > SizeR.MobileWidth
                                  ? const EdgeInsets.only(
                                      top: 12, right: 12, left: 12)
                                  : null,
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Wrap(
                                  alignment: WrapAlignment.start,
                                  spacing: 60,
                                  runSpacing: 20,
                                  children: [
                                    GetBuilder<DropdownListController>(
                                        id: 'الكلية المراد التقديم عليها',
                                        builder: (controller) => DropDownList(
                                              value: collegesId,
                                              width: 400,
                                              title:
                                                  "الكلية المراد التقديم عليها",
                                              onchange: (value) {
                                                controller.collegesValue =
                                                    value;
                                                var college = controller
                                                    .superData?.colleges
                                                    ?.where((c) =>
                                                        c.collegesId == value)
                                                    .firstOrNull;
                                                if (college != null) {
                                                  homePageController
                                                          .maturityIelts.value =
                                                      college.status == 1;
                                                  homePageController
                                                      .sportCollage
                                                      .value = college
                                                          .status ==
                                                      2; // TODO maturityIelts
                                                }

                                                homePageController
                                                    .departmentId.value = value;
                                                controller.update([
                                                  'الكلية المراد التقديم عليها'
                                                ]);
                                                controller.departmentsData();
                                                controller.departmentValue =
                                                    null;
                                                collegesId = value;
                                                departmentId = null;
                                                controller.update(["القسم"]);
                                              },
                                              DropdownMenuItems: controller
                                                  .colleges!
                                                  .map((e) => DropdownMenuItem(
                                                        value: e.collegesId,
                                                        child: Center(
                                                            child: Text(e
                                                                .collegesName!)),
                                                      ))
                                                  .toList(),
                                            )),
                                    const SizedBox(
                                      width: double.infinity,
                                    ),
                                    GetBuilder<DropdownListController>(
                                        id: 'القسم',
                                        builder: (controller) => DropDownList(
                                              value: departmentId,
                                              width: 400,
                                              title: "القسم او الفرع",
                                              onchange: (value) {
                                                controller.departmentValue =
                                                    value;
                                                controller.typeofStudyValue =
                                                    null;
                                                controller
                                                    .fillterOpenStudiesValue(
                                                        value);
                                                controller.fillterDepartments(
                                                    value, 'التخصص');
                                                osId = null;
                                                controller.update(['القسم']);
                                                submissionController.submission
                                                    .departmentId = value;
                                                homePageController
                                                    .departmentId.value = value;
                                                scientificBackgroundId = null;
                                                specializationId = null;
                                                departmentId = value;
                                                controller.update(
                                                    ['الدراسة المفتوحة']);
                                                // controller.update(['القسم']);
                                              },
                                              DropdownMenuItems: collegesId !=
                                                      null
                                                  ? controller.departments!
                                                      .map(
                                                        (e) => DropdownMenuItem(
                                                          value: e.departmentId,
                                                          child: e.departmentName !=
                                                                  null
                                                              ? Text(e
                                                                  .departmentName!)
                                                              : const Text(""),
                                                        ),
                                                      )
                                                      .toList()
                                                  : [],
                                            )),
                                    GetBuilder<DropdownListController>(
                                        id: 'التخصص',
                                        builder: (controller) {
                                          return DropDownList(
                                            value: controller.specializations!
                                                .where((s) =>
                                                    s.specializationId ==
                                                    specializationId)
                                                .firstOrNull
                                                ?.specializationId,
                                            title: "التخصص",
                                            width: 400,
                                            onchange: (val) {
                                              submissionController.submission
                                                  .specializationId = val;
                                              controller.specializationsValue =
                                                  val;
                                              specializationId = val;
                                              controller.update();
                                            },
                                            DropdownMenuItems: departmentId !=
                                                    null
                                                ? controller.specializations!
                                                    .map(
                                                        (e) => DropdownMenuItem(
                                                              value: e
                                                                  .specializationId,
                                                              child: Center(
                                                                child: Text(
                                                                    '${e.specializationName}'),
                                                              ),
                                                            ))
                                                    .toList()
                                                : [],
                                          );
                                        }),
                                    GetBuilder<DropdownListController>(
                                      id: 'الدراسة المفتوحة',
                                      builder: (controller) => DropDownList(
                                          value: osId,
                                          width: 400,
                                          title: "نوع الدراسة المطلوبة",
                                          onchange: (value) {
                                            controller.typeofStudyValue = value;
                                            controller
                                                .update(['الدراسة المفتوحة']);
                                            controller
                                                    .scientificBackgroundsValue1 =
                                                null;
                                            controller.update();
                                            osId = value;
                                            submissionController
                                                .submission.oSId = value;

                                            homePageController
                                                    .certificateTypeId.value =
                                                getTypeOfStudy(
                                                    controller, value);

                                            isDateCommencementValid =
                                                homePageController
                                                    .checkDateCommencement();
                                            controller.specializationsValue =
                                                null;
                                            scientificBackgroundId = null;
                                            controller.update(['التخصص']);
                                            controller
                                                .scientificBackgroundsData();
                                            debugPrint(
                                                '-------------------نوع الدراسة المطلوبة---------------------- ${CertificateType.values.where((c) => c.id == homePageController.certificateTypeId.value).first.name}');
                                          },
                                          DropdownMenuItems:
                                              departmentId != null
                                                  ? controller.openStudy!
                                                      .map(
                                                        (e) => DropdownMenuItem(
                                                          value: e.osId,
                                                          child: Center(
                                                            child: Text(
                                                                e.typeofstudy!),
                                                          ),
                                                        ),
                                                      )
                                                      .toList()
                                                  : []),
                                    ),
                                    GetBuilder<DropdownListController>(
                                      id: 'الاختصاص الحاصل عليه (الخلفيةالعلمية)',
                                      builder: (controller) => DropDownList(
                                        value: scientificBackgroundId,
                                        width: 400,
                                        title:
                                            "الاختصاص الحاصل عليه (الخلفيةالعلمية)",
                                        onchange: (val) {
                                          controller
                                                  .scientificBackgroundsValue1 =
                                              val;
                                          controller.update([
                                            'الاختصاص الحاصل عليه (الخلفيةالعلمية)'
                                          ]);
                                          submissionController.submission
                                              .scientificBackgroundId = val;
                                          scientificBackgroundId = val;
                                          controller.update();
                                        },
                                        DropdownMenuItems: departmentId != null
                                            ? controller.scientificBackgrounds!
                                                .map(
                                                  (e) => DropdownMenuItem(
                                                    value: e
                                                        .scientificbackgroundId,
                                                    child: Text(
                                                        "${e.scientificbackgroundName}"),
                                                  ),
                                                )
                                                .toList()
                                            : [],
                                      ),
                                    ),
                                    GetBuilder<DropdownListController>(
                                        id: 'قناة التقديم',
                                        builder: (controller) {
                                          return DropDownList(
                                            value: channelsId,
                                            width: 400,
                                            title: "قناة التقديم",
                                            onchange: (val) {
                                              controller.channelsDataValue =
                                                  val;
                                              controller
                                                  .update(['قناة التقديم']);
                                              channelsData.value = controller
                                                  .channelsData!
                                                  .where((element) =>
                                                      element.channelId == val)
                                                  .first;
                                              //debugPrint(' channelsData.value.documentsTypes = ${ channelsData.value.toJson().toString()}');
                                              hasRelativeRelations.value =
                                                  channelsData.value.status ==
                                                      1;
                                              submissionController
                                                  .submission.channelId = val;
                                              documentsTypes = channelsData
                                                  .value.documentstypes;
                                              homePageController
                                                  .privateAdmissionChannel
                                                  .value = val == 2;
                                              channelsId = val;
                                              ChannelTypes? selectedChannel =
                                                  ChannelTypesExtension.fromId(
                                                      val);
                                              if (selectedChannel != null) {
                                                homePageController
                                                    .updateChannelState(
                                                        selectedChannel);
                                              }
                                              controller.update();
                                            },
                                            DropdownMenuItems: osId != null
                                                ? getDropdownItems(
                                                    controller,
                                                    averageBachelorsFail,
                                                    typeConsent,
                                                    osId ?? 0,
                                                  )
                                                : [],
                                          );
                                        }),
                                    Obx(() {
                                      return hasRelativeRelations.value
                                          ? GetBuilder<DropdownListController>(
                                              id: 'صلة القرابة',
                                              builder: (controller) {
                                                return DropDownList(
                                                  value: relativeId,
                                                  width: 400,
                                                  title: "صلة القرابة",
                                                  onchange: (val) {
                                                    relativeId = val;
                                                    submissionController
                                                        .submission
                                                        .relativeId = val;
                                                    controller.update();
                                                  },
                                                  DropdownMenuItems: controller
                                                      .superData!
                                                      .relativeRelations!
                                                      .map((e) =>
                                                          DropdownMenuItem(
                                                            value: e.relativeId,
                                                            child: Center(
                                                                child: Text(e
                                                                    .namerelation!)),
                                                          ))
                                                      .toList(),
                                                );
                                              })
                                          : Container();
                                    }),
                                    const SizedBox(
                                      width: double.infinity,
                                    ),
                                    Obx(() => AddDocumentsTypesWidgets(
                                          documents:
                                              channelsData.value.documentstypes,
                                          dateControllers: dateControllers,
                                          numbersControllers:
                                              numbersControllers,
                                        )),
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
                                          title: 'حفظ وانتقال للصفحة التالية',
                                          onTap: () async {
                                            if (!formKey.currentState!
                                                .validate()) {
                                              return;
                                            }

                                            // Check certificate requirements
                                            if (homePageController
                                                        .certificateTypeId
                                                        .value ==
                                                    5 &&
                                                !homePageController
                                                    .haveMaster.value) {
                                              DilogCostom.dilogSecss(
                                                isErorr: true,
                                                title:
                                                    'يرجى ادراج شهادة الماجستير أولا',
                                                icons: Icons.close,
                                                color: Colors.redAccent,
                                              );
                                              return;
                                            }

                                            // Validate date commencement
                                            isDateCommencementValid =
                                                homePageController
                                                    .checkDateCommencement();
                                            if (!isDateCommencementValid) {
                                              DilogCostom.dilogSecss(
                                                isErorr: true,
                                                title:
                                                    'هناك خطأ في تاريخ المباشرة بعد آخر شهادة',
                                                icons: Icons.close,
                                                color: Colors.redAccent,
                                              );
                                              return;
                                            }

                                            // Show loading dialog using AwesomeDialog
                                            LoadingDialog.showLoadingDialog(
                                                message: loadingText);

                                            try {
                                              // Clear previous documents and add new ones
                                              submissionController
                                                  .submission.documents!
                                                  .clear();
                                              for (int i = 0;
                                                  i < documentsTypes!.length;
                                                  i++) {
                                                var newDocument = Documents(
                                                  documentsNumber:
                                                      numbersControllers[i]
                                                          .text,
                                                  documentsDate:
                                                      dateControllers[i].text,
                                                  documentsTypeId:
                                                      documentsTypes![i].id,
                                                );
                                                submissionController
                                                    .submission.documents!
                                                    .add(newDocument);
                                              }

                                              // Upload the data
                                              var status =
                                                  await submissionController
                                                      .uploadData();
                                              homePageController
                                                  .submissionChannel
                                                  .isFull
                                                  .value = status;

                                              // Hide the loading dialog
                                              Get.back();

                                              if (status) {
                                                // Update student data with the new submission
                                                homePageController
                                                        .fullStudentData
                                                        .value
                                                        .personalInformation
                                                        ?.first
                                                        .submission =
                                                    FullDataSubmission
                                                        .fromSubmission(
                                                            submissionController
                                                                .submission);

                                                // Change to the next page
                                                homePageController.pageChange(
                                                    homePageController
                                                        .otherInformation
                                                        .index);

                                                // Optionally, show confirmation dialog if there's a serial number
                                                if (homePageController
                                                        .fullStudentData
                                                        .value
                                                        .serial !=
                                                    null) {
                                                  DilogCostom
                                                      .confirmFinishEditing(
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
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
        );
      },
    );
  }

  List<DropdownMenuItem<int>> buildDropdownItems(
      List<ChannelsData>? channels, bool Function(ChannelsData) filter) {
    return channels?.where(filter).map((e) {
          return DropdownMenuItem(
            value: e.channelId,
            child: Center(child: Text(e.name ?? '')),
          );
        }).toList() ??
        [];
  }

  List<DropdownMenuItem<int>> getDropdownItems(
    DropdownListController controller,
    bool averageBachelorsFail,
    bool typeConsent,
    int osId,
  ) {
    // Ensure 'averageBachelorsFail' is false if the first quarter is active
    averageBachelorsFail =
        homePageController.firstQuarter.value ? false : averageBachelorsFail;
    var channals =
        getChannals(controller, osId); // Get the channels based on osId
    // Build the dropdown items
    return buildDropdownItems(channals, (c) {
      if (averageBachelorsFail && typeConsent) {
        return c.channelId == 2; // Only allow channelId 2 when both are true
      } else if (averageBachelorsFail) {
        return c.channelId != 1 &&
            c.channelId !=
                20; // Exclude 1 and 20 when only averageBachelorsFail is true
      } else if (typeConsent) {
        return c.channelId ==
            2; // Only allow channelId 2 when typeConsent is true
      } else {
        return true; // Otherwise, include all
      }
    });
  }
}

List<ChannelsData>? getChannals(DropdownListController controller, int? osId) {
  return controller.superData!.admissionchannel!
          .where((t) => t.osId == osId)
          .map((channel) => controller.superData!.channelsData!
              .firstWhere((t) => t.channelId == channel.channelsId))
          .toList() ??
      controller.superData!.channelsData!;
}

int getTypeOfStudy(DropdownListController controller, int osId) {
  var typeOfStudyId = controller.superData!.openStudies!
      .where((t) => t.osId == osId)
      .first
      .typeofstudy;

  var typeOfStudyName = controller.superData!.typeofStudies!
      .where((t) => t.tSid == typeOfStudyId)
      .first
      .name;
  return CertificateType.values
      .where((c) => c.name == typeOfStudyName)
      .first
      .id;
}
