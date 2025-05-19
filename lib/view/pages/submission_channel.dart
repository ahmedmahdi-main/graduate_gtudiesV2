import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Enums/certificate_type.dart';
import '../../Enums/channel_types.dart';
import '../../Models/academic_information.dart';
import '../../Models/full_student_data.dart';
import '../../Models/super_data.dart';
import '../../Services/costom_dialog.dart';
import '../../Services/base_route.dart';
import '../../Controllers/dropdown_filter_controllers.dart';
import '../../Controllers/submission_controller.dart';
import '../../Controllers/home_page_controller.dart';
import '../../theme.dart';
import '../widget/add_documents_widget.dart';
import '../widget/GifImageCostom.dart';
import '../widget/buttonsyle.dart';
import '../widget/dropdownlistt.dart';
import 'DialogsWindows/loading_dialog.dart';

class SubmissionChannel extends StatelessWidget {
  final SubmissionController submissionController =
      Get.put(SubmissionController());
  final HomePageController homePageController = Get.find<HomePageController>();
  final DropdownListController dropdownController =
      Get.put(DropdownListController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Rx<ChannelsData> _channelsData = ChannelsData().obs;
  final RxBool _hasRelativeRelations = false.obs;
  final List<TextEditingController> _numbersControllers = [];
  final List<TextEditingController> _dateControllers = [];

  SubmissionChannel({super.key});

  @override
  Widget build(BuildContext context) {
    _initializeFormData();

    return GetBuilder<DropdownListController>(
      builder: (controller) => _buildMainContent(context, controller),
    );
  }

  Widget _buildMainContent(
      BuildContext context, DropdownListController controller) {
    final size = MediaQuery.of(context).size;

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: controller.isLoading.value
            ? const Center(
                child:
                    GifImageCostom(Gif: "assets/icons/pencil.gif", width: 100))
            : _buildFormContent(context, size, controller),
      ),
    );
  }

  Widget _buildFormContent(
      BuildContext context, Size size, DropdownListController controller) {
    return Column(
      children: [
        Container(
          decoration: _mainContainerDecoration(size),
          margin: _containerMargin(size),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Wrap(
              alignment: WrapAlignment.start,
              spacing: 60,
              runSpacing: 20,
              children: [
                _buildCollegeDropdown(controller),
                _buildDepartmentDropdown(controller),
                _buildStudyTypeDropdown(controller),
                _buildScientificBackgroundDropdown(controller),
                _buildChannelDropdown(controller),
                _buildRelativeRelationsDropdown(),
                Obx(() => AddDocumentsTypesWidgets(
                      documents: _channelsData.value.documentstypes,
                      dateControllers: _dateControllers,
                      numbersControllers: _numbersControllers,
                    )),
                _buildSubmitButton(context),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _initializeFormData() {
    final personalInfo = homePageController
        .fullStudentData.value.personalInformation?.firstOrNull;
    final admissionChannel = personalInfo?.admissionChannel?.firstOrNull;

    submissionController.submission
      ..scientificBackgroundId = personalInfo?.scientificBackgroundId
      ..oSId = admissionChannel?.osId
      ..specializationId = personalInfo?.specializationId
      ..channelId = admissionChannel?.channelsId
      ..departmentId = personalInfo?.departmentId
      ..relativeId = admissionChannel?.relativeId;

    _handleSpecialCases(admissionChannel);
  }

  void _handleSpecialCases(AdmissionChannel? admissionChannel) {
    final avgFail = (homePageController.averageBachelors.value ?? 0) < 64.9 &&
        !homePageController.haveUniversityOrderForTheMastersDegree.value;
    final typeConsent = homePageController.typeConsentId.value == 2;

    if (avgFail || typeConsent) {
      submissionController.submission.channelId = 2;
      homePageController.privateAdmissionChannel.value = true;
    }
  }

  Widget _buildCollegeDropdown(DropdownListController controller) {
    return GetBuilder<DropdownListController>(
      id: 'الكلية المراد التقديم عليها',
      builder: (_) => DropDownList(
        value: controller.collegesValue,
        width: 400,
        title: "الكلية المراد التقديم عليها",
        onchange: (value) => _handleCollegeChange(controller, value),
        DropdownMenuItems: controller.colleges!
            .map((e) => DropdownMenuItem(
                value: e.collegesId,
                child: Center(child: Text(e.collegesName!))))
            .toList(),
      ),
    );
  }

  void _handleCollegeChange(DropdownListController controller, int? value) {
    controller
      ..collegesValue = value
      ..departmentValue = null
      ..update(['الكلية المراد التقديم عليها', 'القسم']);

    homePageController.departmentId.value = value;
    controller.departmentsData();
  }

  // Similar methods for other dropdowns (_buildDepartmentDropdown, _buildStudyTypeDropdown, etc.)

  Widget _buildSubmitButton(BuildContext context) {
    return ButtonStyleS(
      colorBorder: Colors.greenAccent,
      containborder: true,
      isleft: true,
      icon: Icons.arrow_forward_ios,
      title: 'حفظ وانتقال للصفحة التالية',
      onTap: () => _handleFormSubmission(context),
    );
  }

  Future<void> _handleFormSubmission(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;
    if (!_validateCertificateRequirements()) return;

    LoadingDialog.showLoadingDialog(message: loadingText);

    try {
      await _prepareSubmissionData();
      final status = await submissionController.uploadData();

      Get.back();
      if (status) _handleSuccessfulSubmission();
      Get.back();
    } catch (e) {
      Get.back();
      _showSubmissionError();
    }
  }

  bool _validateCertificateRequirements() {
    final certType = homePageController.certificateTypeId.value;
    if (certType == 5 && !homePageController.haveMaster.value) {
      DilogCostom.dilogSecss(
        isErorr: true,
        title: 'يرجى ادراج شهادة الماجستير أولا',
        icons: Icons.close,
        color: Colors.redAccent,
      );
      return false;
    }
    return true;
  }

  Future<void> _prepareSubmissionData() async {
    submissionController.submission.documents?.clear();
    submissionController.submission.documents = [];
    for (int i = 0; i < _channelsData.value.documentstypes!.length; i++) {
      submissionController.submission.documents!.add(Documents(
        documentsNumber: _numbersControllers[i].text,
        documentsDate: _dateControllers[i].text,
        documentsTypeId: _channelsData.value.documentstypes![i].id,
      ));
    }
  }

  void _handleSuccessfulSubmission() {
    homePageController.submissionChannel.isFull.value = true;
    homePageController.pageChange(homePageController.otherInformation.index);

    if (homePageController.fullStudentData.value.serial != null) {
      DilogCostom.confirmFinishEditing(
          onSubmit: homePageController.modifyComplete);
    }
  }

  void _showSubmissionError() {
    DilogCostom.dilogSecss(
      isErorr: true,
      title: "حدث خطأ أثناء معالجة البيانات، يرجى المحاولة مرة أخرى",
      icons: Icons.error,
      color: Colors.redAccent,
    );
  }

  Widget _buildDepartmentDropdown(DropdownListController controller) {
    return GetBuilder<DropdownListController>(
      id: 'القسم',
      builder: (_) => DropDownList(
        value: controller.departmentValue,
        width: 400,
        title: "القسم او الفرع",
        onchange: (value) {
          controller.departmentValue = value;
          controller.typeofStudyValue = null;
          controller.fillterOpenStudiesValue(value);
          submissionController.submission.departmentId = value;
          homePageController.departmentId.value = value;
          submissionController.submission.specializationId = value;
          controller.specializationsValue = value;
          controller.update();
        },
        DropdownMenuItems: controller.collegesValue != null
            ? controller.departments!
                .map((e) => DropdownMenuItem(
                      value: e.departmentId,
                      child: Text(e.departmentName ?? ""),
                    ))
                .toList()
            : [],
      ),
    );
  }

  Widget _buildStudyTypeDropdown(DropdownListController controller) {
    return GetBuilder<DropdownListController>(
      id: 'الدراسة المفتوحة',
      builder: (_) => DropDownList(
        value: submissionController.submission.oSId,
        width: 400,
        title: "نوع الدراسة المطلوبة",
        onchange: (value) {
          controller.typeofStudyValue = value;
          controller.update(['الدراسة المفتوحة']);
          submissionController.submission.oSId = value;
          homePageController.certificateTypeId.value =
              _getTypeOfStudy(controller, value);
          controller.scientificBackgroundsValue1 = null;
          controller.specializationsValue = null;
          controller.scientificBackgroundsData();
        },
        DropdownMenuItems: controller.departmentValue != null
            ? controller.openStudy!
                .map((e) => DropdownMenuItem(
                      value: e.osId,
                      child: Center(child: Text(e.typeofstudy!)),
                    ))
                .toList()
            : [],
      ),
    );
  }

  Widget _buildScientificBackgroundDropdown(DropdownListController controller) {
    return GetBuilder<DropdownListController>(
      id: 'الاختصاص الحاصل عليه (الخلفيةالعلمية)',
      builder: (_) => DropDownList(
        value: submissionController.submission.scientificBackgroundId,
        width: 400,
        title: "الاختصاص الحاصل عليه (الخلفيةالعلمية)",
        onchange: (val) {
          controller.scientificBackgroundsValue1 = val;
          submissionController.submission.scientificBackgroundId = val;
          controller.update(['الاختصاص الحاصل عليه (الخلفيةالعلمية)']);
        },
        DropdownMenuItems: controller.departmentValue != null
            ? controller.scientificBackgrounds!
                .map((e) => DropdownMenuItem(
                      value: e.scientificbackgroundId,
                      child: Text("${e.scientificbackgroundName}"),
                    ))
                .toList()
            : [],
      ),
    );
  }

  Widget _buildChannelDropdown(DropdownListController controller) {
    return GetBuilder<DropdownListController>(
      id: 'قناة التقديم',
      builder: (_) => DropDownList(
        value: submissionController.submission.channelId,
        width: 400,
        title: "قناة التقديم",
        onchange: (val) {
          controller.channelsDataValue = val;
          _channelsData.value = controller.channelsData!
              .firstWhere((element) => element.channelId == val);
          _hasRelativeRelations.value = _channelsData.value.status == 1;
          submissionController.submission.channelId = val;
          homePageController.privateAdmissionChannel.value = val == 2;
          controller.update(['قناة التقديم']);
        },
        DropdownMenuItems: _getChannelDropdownItems(controller),
      ),
    );
  }

  Widget _buildRelativeRelationsDropdown() {
    return Obx(() => _hasRelativeRelations.value
        ? GetBuilder<DropdownListController>(
            id: 'صلة القرابة',
            builder: (controller) => DropDownList(
              value: submissionController.submission.relativeId,
              width: 400,
              title: "صلة القرابة",
              onchange: (val) {
                submissionController.submission.relativeId = val;
                controller.update();
              },
              DropdownMenuItems: controller.superData!.relativeRelations!
                  .map((e) => DropdownMenuItem(
                        value: e.relativeId,
                        child: Center(child: Text(e.namerelation!)),
                      ))
                  .toList(),
            ),
          )
        : Container());
  }

  List<DropdownMenuItem<int>> _getChannelDropdownItems(
      DropdownListController controller) {
    final avgFail = (homePageController.averageBachelors.value ?? 0) < 64.9 &&
        !homePageController.haveUniversityOrderForTheMastersDegree.value;
    final typeConsent = homePageController.typeConsentId.value == 2;

    return controller.superData!.admissionchannel!
        .where((t) => t.osId == submissionController.submission.oSId)
        .map((channel) => controller.superData!.channelsData!
            .firstWhere((t) => t.channelId == channel.channelsId))
        .where((c) => _channelFilter(c, avgFail, typeConsent))
        .map((e) => DropdownMenuItem(
              value: e.channelId,
              child: Center(child: Text(e.name ?? '')),
            ))
        .toList();
  }

  bool _channelFilter(ChannelsData c, bool avgFail, bool typeConsent) {
    if (avgFail && typeConsent) return c.channelId == 2;
    if (avgFail) return c.channelId != 1 && c.channelId != 20;
    if (typeConsent) return c.channelId == 2;
    return true;
  }

  int _getTypeOfStudy(DropdownListController controller, int osId) {
    final typeOfStudyId = controller.superData!.openStudies!
        .firstWhere((t) => t.osId == osId)
        .typeofstudy;

    return CertificateType.values
        .firstWhere((c) =>
            c.name ==
            controller.superData!.typeofStudies!
                .firstWhere((t) => t.tSid == typeOfStudyId)
                .name)
        .id;
  }

  BoxDecoration _mainContainerDecoration(Size size) => BoxDecoration(
        color: KprimeryColor,
        borderRadius: size.width > SizeR.MobileWidth
            ? const BorderRadiusDirectional.all(Radius.circular(19))
            : null,
      );

  EdgeInsets? _containerMargin(Size size) => size.width > SizeR.MobileWidth
      ? const EdgeInsets.only(top: 12, right: 12, left: 12)
      : null;
}
