// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduate_gtudiesV2/Enums/documents_types.dart';
import 'package:graduate_gtudiesV2/Enums/scientific_titles.dart';
import 'package:graduate_gtudiesV2/Models/academic_information.dart';
import '../../Services/costom_dialog.dart';
import '../../Services/base_route.dart';
import '../../Controllers/career_information_controller.dart';
import '../../Controllers/dropdown_filter_controllers.dart';
import '../../Controllers/home_page_controller.dart';
import '../../theme.dart';
import '../widget/coustom_calender.dart';
import '../widget/GifImageCostom.dart';
import '../widget/buttonsyle.dart';
import '../widget/custom_switcher.dart';
import '../widget/dropdownlistt.dart';
import '../widget/titleandtextstyle.dart';
import 'DialogsWindows/loading_dialog.dart';

class FunctionalInformation extends StatefulWidget {
  const FunctionalInformation({super.key});

  @override
  State<FunctionalInformation> createState() => _FunctionalInformationState();
}

class _FunctionalInformationState extends State<FunctionalInformation> {
  final _formKey = GlobalKey<FormState>();
  final _careerController = Get.put(CareerInformationController());
  final _homeController = Get.find<HomePageController>();
  final _dropdownController = Get.find<DropdownListController>();

  // Controllers
  final _organizationNameController = TextEditingController();
  final _commencementDateController = TextEditingController();
  final _promotionOrderDateController = TextEditingController();
  final _promotionOrderNumberController = TextEditingController();

  // State observables
  final _functionalStatus = "غير موظف".obs;
  final _hasUniversityService = false.obs;
  final _isBachelor = false.obs;
  final _universityService = false.obs;

  // Document handling
  final _promotionOrderDoc = Documents();

  @override
  void initState() {
    super.initState();

    // Add listeners to update the model when text changes
    _organizationNameController.addListener(() {
      _careerController.careerInformation.organizationName =
          _organizationNameController.text;
    });

    _promotionOrderNumberController.addListener(() {
      _promotionOrderDoc.documentsNumber = _promotionOrderNumberController.text;
    });

    _initializeFormData();
  }

  void _initializeFormData() {
    // Check if career information exists
    if (_homeController.fullStudentData.value.careerInformation != null &&
        _homeController.fullStudentData.value.careerInformation!.isNotEmpty) {
      final careerInfo =
          _homeController.fullStudentData.value.careerInformation!.first;

      // Set the career information in the Controllers
      _careerController.careerInformation = careerInfo.toCareerInformation();

      // Update employment status
      if (careerInfo.employmentStatusId != null) {
        _functionalStatus.value =
            _getFunctionalStatusLabel(careerInfo.employmentStatusId);
        _homeController.haveStudyApproval.value =
            careerInfo.employmentStatusId != null;
      }

      // Update type consent ID
      if (careerInfo.typeConsentId != null) {
        _homeController.typeConsentId.value = careerInfo.typeConsentId;
      }

      // Update date fields
      if (careerInfo.dateCommencement != null &&
          careerInfo.dateCommencement!.isNotEmpty) {
        // Keep the original format (with dashes) as that's what the CustomCalendar expects
        _commencementDateController.text = careerInfo.dateCommencement!;
        _homeController.dateCommencement = careerInfo.dateCommencement!;

        // Force UI update for the date field
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {}); // Trigger a rebuild after initialization
        });
      }

      // Update organization name
      if (careerInfo.organizationName != null) {
        _organizationNameController.text = careerInfo.organizationName ?? '';
      }

      // Update university service
      if (careerInfo.universityService != null) {
        _universityService.value = careerInfo.universityService == 1;
      }

      // Update scientific title
      if (careerInfo.scientificTitleId != null) {
        _isBachelor.value = _checkIfBachelor(careerInfo.scientificTitleId);
      }

      // Update documents if available
      if (careerInfo.documents != null && careerInfo.documents!.isNotEmpty) {
        for (final doc in careerInfo.documents!) {
          if (doc.documentsTypeId == DocumentsType.promotionOrder.id) {
            // Copy values from the document instead of replacing the _promotionOrderDoc object
            _promotionOrderDoc.documentsDate = doc.documentsDate;
            _promotionOrderDoc.documentsNumber = doc.documentsNumber;
            _promotionOrderDoc.documentsTypeId = doc.documentsTypeId;

            _promotionOrderDateController.text = doc.documentsDate ?? '';
            _promotionOrderNumberController.text = doc.documentsNumber ?? '';
          }
        }
      }

      // Update the UI
      _dropdownController.update([
        'employment-status',
        'study-approval',
        'ministry',
        'scientific-title'
      ]);
    }
  }

  @override
  void dispose() {
    _organizationNameController.dispose();
    _commencementDateController.dispose();
    _promotionOrderDateController.dispose();
    _promotionOrderNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Obx(() => _dropdownController.isLoading.value
            ? _buildLoadingIndicator()
            : _buildFormContent()),
      ),
    );
  }

  Widget _buildLoadingIndicator() => const Center(
        child: GifImageCostom(
          Gif: "assets/icons/pencil.gif",
          width: 100,
        ),
      );

  Widget _buildFormContent() {
    return Container(
      decoration: _buildContainerDecoration(),
      margin: _buildContainerMargin(),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Wrap(
              alignment: WrapAlignment.start,
              spacing: 60,
              runSpacing: 20,
              children: [
                _buildEmploymentStatusDropdown(),

                // Conditional fields based on employment status
                Obx(() => _functionalStatus.value == "غير موظف"
                    ? const SizedBox.shrink()
                    : Wrap(
                        alignment: WrapAlignment.start,
                        spacing: 60,
                        runSpacing: 20,
                        children: [
                          _buildStudyApprovalDropdown(),
                          _buildCommencementDatePicker(),
                          _buildMinistryDropdown(),
                          _buildOrganizationNameField(),
                          _buildUniversityServiceToggle(),

                          // Conditional fields based on university service
                          Obx(() => _universityService.value
                              ? _buildScientificTitleSection()
                              : const SizedBox.shrink()),
                        ],
                      )),

                // Add some space before the submit button
                SizedBox(width: 350),
                _buildSubmitButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Form component builders
  Widget _buildEmploymentStatusDropdown() {
    return GetBuilder<DropdownListController>(
      id: 'employment-status',
      builder: (controller) => DropDownList(
        value: _careerController.careerInformation.employmentStatusId,
        title: "الحالة الوظيفية",
        onchange: _handleEmploymentStatusChange,
        DropdownMenuItems: controller.employmentStatusData!
            .map((e) => DropdownMenuItem(
                  value: e.employmentStatusId,
                  child: Center(child: Text(e.statusName!)),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildStudyApprovalDropdown() {
    return GetBuilder<DropdownListController>(
      id: 'study-approval',
      builder: (controller) => DropDownList(
        value: _careerController.careerInformation.typeConsentId,
        title: "نوع الموافقة الدراسية ؟",
        onchange: _handleStudyApprovalChange,
        DropdownMenuItems: controller.typeConsentForStudy!
            .map((e) => DropdownMenuItem(
                  value: e.typeConsentId,
                  child: Center(child: Text(e.typeConsentName!)),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildCommencementDatePicker() {
    return CustomCalendar(
      controller: _commencementDateController,
      title: "تاريخ المباشرة بعد اخر شهادة :",
      onChange: _handleCommencementDateChange,
    );
  }

  Widget _buildMinistryDropdown() {
    return GetBuilder<DropdownListController>(
      id: 'ministry',
      builder: (controller) => DropDownList(
        width: 450,
        value: _careerController.careerInformation.ministryId,
        title: "اسم الوزارة :",
        onchange: _handleMinistryChange,
        DropdownMenuItems: controller.ministry!
            .map((e) => DropdownMenuItem(
                  value: e.ministryId,
                  child: Center(child: Text(e.name!)),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildOrganizationNameField() {
    return TitleAndTextStyle(
      controller: _organizationNameController,
      title: "اسم الؤسسة :",
      // Don't use onchange here, let the Controllers handle the text
    );
  }

  Widget _buildUniversityServiceToggle() {
    return Obx(() => CustomSwitcher(
          initialValue: _universityService.value,
          title: "يخضع للخدمة الجامعية :",
          onChanged: _handleUniversityServiceChange,
        ));
  }

  Widget _buildScientificTitleSection() {
    return Column(
      children: [
        Wrap(
          children: [
            _buildScientificTitleDropdown(),
            const SizedBox(width: 20),
            Obx(() => !_isBachelor.value
                ? Wrap(
                    children: [
                      _buildPromotionNumberField(),
                      const SizedBox(width: 20),
                      _buildPromotionDatePicker(),
                    ],
                  )
                : const SizedBox.shrink()),
          ],
        ),
      ],
    );
  }

  Widget _buildScientificTitleDropdown() {
    return GetBuilder<DropdownListController>(
      id: 'scientific-title',
      builder: (controller) => DropDownList(
        value: _careerController.careerInformation.scientificTitleId,
        title: "اللقب العلمي :",
        onchange: _handleScientificTitleChange,
        DropdownMenuItems: controller.scientificTitles!
            .map((e) => DropdownMenuItem(
                  value: e.scientificTitleId,
                  child: Center(child: Text(e.name!)),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildPromotionNumberField() {
    return TitleAndTextStyle(
      controller: _promotionOrderNumberController,
      title: "رقم امر الترقية :",
      // Don't use onchange here, let the Controllers handle the text
    );
  }

  Widget _buildPromotionDatePicker() {
    return CustomCalendar(
      controller: _promotionOrderDateController,
      title: "تاريخ امر الترقية :",
    );
  }

  Widget _buildSubmitButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: ButtonStyleS(
        colorBorder: Colors.greenAccent,
        containborder: true,
        isleft: true,
        icon: Icons.arrow_forward_ios,
        title: "حفظ وانتقال للصفحة التالية",
        onTap: _handleFormSubmission,
      ),
    );
  }

  // Event handlers
  void _handleEmploymentStatusChange(dynamic val) {
    _careerController.careerInformation.employmentStatusId = val;
    _functionalStatus.value = _getFunctionalStatusLabel(val);
    _homeController.haveStudyApproval.value = val != null;
    _dropdownController.update(['employment-status']);
    // con
  }

  void _handleStudyApprovalChange(dynamic val) {
    _careerController.careerInformation.typeConsentId = val;
    _homeController.typeConsentId.value = val;
    _dropdownController.update(['study-approval']);
  }

  void _handleMinistryChange(dynamic val) {
    _careerController.careerInformation.ministryId = val;
    _updateUniversityServiceStatus(val);
    _dropdownController.update(['ministry']);
  }

  void _handleUniversityServiceChange(bool value) {
    _universityService.value = value;
    _careerController.careerInformation.universityService = value ? 1 : 0;
  }

  void _handleScientificTitleChange(dynamic val) {
    _careerController.careerInformation.scientificTitleId = val;
    _isBachelor.value = _checkIfBachelor(val);
    _dropdownController.update(['scientific-title']);
  }
// Add these methods inside the _FunctionalInformationState class

  // These methods are no longer needed since we're using Controllers listeners
  // void _handlePromotionNumberChange(dynamic value) {
  //   _promotionOrderNumberController.text = value ?? '';
  //   _promotionOrderDoc.documentsNumber = value;
  // }
  //
  // void _handleOrganizationNameChange(dynamic value) {
  //   _organizationNameController.text = value ?? '';
  //   _careerController.careerInformation.organizationName = value;
  // }

  void _handleCommencementDateChange(dynamic value) {
    _commencementDateController.text = value ?? '';
    _careerController.careerInformation.dateCommencement = value;
    _homeController.dateCommencement = value;
  }

  // Helper methods
  String _getFunctionalStatusLabel(dynamic val) {
    switch (val) {
      case 1:
        return "عقد 315";
      case 2:
        return "موظف";
      default:
        return "غير موظف";
    }
  }

  void _updateUniversityServiceStatus(int? ministryId) {
    final ministry = _dropdownController.ministry!
        .firstWhere((m) => m.ministryId == ministryId);
    _hasUniversityService.value = ministry.heirghEduSevice == 1;
    _homeController.haveUniversityService?.value = _hasUniversityService.value;
  }

  bool _checkIfBachelor(dynamic val) {
    return ScientificTitles.values
        .any((t) => t.id == val && t == ScientificTitles.bachelor);
  }

  Future<void> _handleFormSubmission() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      LoadingDialog.showLoadingDialog(message: loadingText);
      await _prepareAndSubmitData();
      // debugPrint('${_careerController.careerInformation.toJson()}');
      Get.back();
      Get.back();
      _handleSubmissionSuccess();
    } catch (e) {
      Get.back();
      _handleSubmissionError(e);
    }
  }

  Future<void> _prepareAndSubmitData() async {
    // Always initialize documents as an empty array
    _careerController.careerInformation.documents = [];

    // Ensure the commencement date is set from the Controllers
    if (_commencementDateController.text.isNotEmpty) {
      _careerController.careerInformation.dateCommencement =
          _commencementDateController.text;
      _homeController.dateCommencement = _commencementDateController.text;
    }

    // Ensure organization name is set from the Controllers
    if (_organizationNameController.text.isNotEmpty) {
      _careerController.careerInformation.organizationName =
          _organizationNameController.text;
    }

    if (_universityService.value) {
      _promotionOrderDoc
        ..documentsDate = _promotionOrderDateController.text
        ..documentsNumber = _promotionOrderNumberController.text
        ..documentsTypeId = DocumentsType.promotionOrder.id;

      // Now we can safely add to the list since we know it's not null
      _careerController.careerInformation.documents!.add(_promotionOrderDoc);
    }

    // Debug print to verify data before upload
    // debugPrint(
    //     'Career Info before upload: ${_careerController.careerInformation.toJson()}');

    final success = await _careerController.uploadData();
    _homeController.functionalInformation.isFull.value = success;
  }

  void _handleSubmissionSuccess() {
    if (_homeController.fullStudentData.value.serial != null) {
      DilogCostom.confirmFinishEditing(
        onSubmit: () async => await _homeController.modifyComplete(),
      );
    }
    _homeController.pageChange(_homeController.academicInformation.index);
  }

  void _handleSubmissionError(dynamic error) {
    DilogCostom.dilogSecss(
      isErorr: true,
      title: "حدث خطأ أثناء معالجة البيانات، يرجى المحاولة مرة أخرى",
      icons: Icons.error,
      color: Colors.redAccent,
    );
  }

  BoxDecoration _buildContainerDecoration() => BoxDecoration(
        color: KprimeryColor,
        borderRadius: const BorderRadius.all(Radius.circular(19)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      );

  EdgeInsets _buildContainerMargin() => const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      );
}
//***************************************************
// class FunctionalInformation extends StatefulWidget {
//   const FunctionalInformation({super.key});
//
//   @override
//   State<FunctionalInformation> createState() => _FunctionalInformationState();
// }
//
// class _FunctionalInformationState extends State<FunctionalInformation> {
//   Rx<String> functionl = "غير موظف".obs;
//   Rx<bool> UniversityService = false.obs;
//   TextEditingController PromotionOrderDate = TextEditingController();
//   TextEditingController PromotionOrderNumber = TextEditingController();
//   TextEditingController organizationNameController = TextEditingController();
//   TextEditingController CommencementDate = TextEditingController();
//   Documents promotionOrder = Documents();
//   CareerInformationController careerInformationController =
//       Get.put(CareerInformationController());
//   HomePageController homePageController = Get.put(HomePageController());
//   RxBool haveUniversityService = false.obs;
//   final formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     careerInformationController.careerInformation.documents = [];
//     var size = MediaQuery.of(context).size;
//     int? careerInformationId;
//     int? typeConsentId;
//     int? employmentStatusId;
//     String? dateCommencement;
//     int? ministryId;
//     int? scientificTitleId;
//     int? fullDataUniversityService;
//     String? studentUUID;
//     List<Documents>? documents;
//     if (homePageController.fullStudentData.value.careerInformation != null &&
//         homePageController
//             .fullStudentData.value.careerInformation!.isNotEmpty) {
//       FullDataCareerInformation? fullDataCareerInformation =
//           homePageController.fullStudentData.value.careerInformation?.first;
//       careerInformationId = fullDataCareerInformation?.careerInformationId;
//       typeConsentId = fullDataCareerInformation?.typeConsentId;
//       if (fullDataCareerInformation?.typeConsentId != null) {
//         homePageController.typeConsentId.value =
//             fullDataCareerInformation?.typeConsentId;
//       }
//       careerInformationController.careerInformation =
//           fullDataCareerInformation!.toCareerInformation();
//       //dateCommencement = fullDataCareerInformation?.dateCommencement;
//       employmentStatusId = fullDataCareerInformation.employmentStatusId;
//       if (employmentStatusId != null) {
//         if (employmentStatusId == 1) {
//           functionl.value = "عقد 315";
//           homePageController.haveStudyApproval.value = true;
//         } else if (employmentStatusId == 2) {
//           functionl.value = "موظف";
//           homePageController.haveStudyApproval.value = true;
//         } else {
//           functionl.value = "غير موظف";
//         }
//       }
//       CommencementDate.text =
//           fullDataCareerInformation.dateCommencement?.replaceAll('-', '/') ??
//               '';
//       homePageController.dateCommencement = CommencementDate.text;
//       ministryId = fullDataCareerInformation.ministryId;
//       var dropDownController = Get.put(DropdownListController());
//       if (ministryId != 0) {
//         var filteredMinistries = dropDownController.ministry!
//             .where((m) => m.ministryId == ministryId);
//
//         if (filteredMinistries.isNotEmpty) {
//           var ministry = filteredMinistries.first.heirghEduSevice == 1;
//           haveUniversityService.value = ministry;
//           homePageController.haveUniversityService?.value = ministry;
//         } else {
//           // Handle the case where no matching ministry is found
//           debugPrint("No ministry found with the given ministryId.");
//         }
//       }
//       scientificTitleId = fullDataCareerInformation.scientificTitleId;
//       organizationNameController.text =
//           fullDataCareerInformation.organizationName ?? '';
//       fullDataUniversityService = fullDataCareerInformation.universityService;
//       UniversityService.value = fullDataUniversityService == 1;
//       documents = fullDataCareerInformation.documents;
//       if (documents != null && documents.isNotEmpty) {
//         var doc = documents.firstWhere(
//           (d) => d.documentsTypeId == DocumentsType.promotionOrder.id,
//           orElse: () => Documents(),
//         );
//
//         if (doc != null) {
//           PromotionOrderDate.text =
//               doc.documentsDate?.replaceAll('-', '/') ?? '';
//           PromotionOrderNumber.text = doc.documentsNumber ?? '';
//         }
//       }
//     }
//     Rx<bool> isBachelor = (ScientificTitles.values
//                 .where((b) => b.id == scientificTitleId)
//                 .isNotEmpty &&
//             ScientificTitles.values
//                     .where((b) => b.id == scientificTitleId)
//                     .first ==
//                 ScientificTitles.bachelor)
//         .obs;
//
//     return Form(
//       key: formKey,
//       child: SingleChildScrollView(
//         child: GetBuilder<DropdownListController>(
//             init: DropdownListController(),
//             builder: (cont) {
//               return cont.isLoading
//                   ? const Center(
//                       child: GifImageCostom(
//                         Gif: "assets/icons/pencil.gif",
//                         width: 100,
//                       ),
//                     )
//                   : Container(
//                       decoration: BoxDecoration(
//                           color: KprimeryColor,
//                           borderRadius: const BorderRadiusDirectional.all(
//                               Radius.circular(19))),
//                       margin:
//                           const EdgeInsets.only(top: 12, right: 12, left: 12),
//                       width: double.infinity,
//                       child: Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             GetBuilder<DropdownListController>(
//                                 //
//                                 id: 'الحالة الوظيفية',
//                                 builder: (Controllers) => DropDownList(
//                                     value: employmentStatusId,
//                                     title: "الحالة الوظيفية",
//                                     onchange: (val) {
//                                       if (val == 1) {
//                                         functionl.value = "عقد 315";
//                                         homePageController
//                                             .haveStudyApproval.value = true;
//                                       } else if (val == 2) {
//                                         functionl.value = "موظف";
//                                         homePageController
//                                             .haveStudyApproval.value = true;
//                                       } else {
//                                         // careerInformationController
//                                         //     .careerInformation = CareerInformation();
//
//                                         functionl.value = "غير موظف";
//                                         homePageController
//                                             .haveStudyApproval.value = false;
//                                       }
//                                       careerInformationController
//                                           .careerInformation
//                                           .employmentStatusId = val;
//                                       employmentStatusId = val;
//                                       Controllers.update();
//                                     },
//                                     DropdownMenuItems:
//                                         Controllers.employmentStatusData!
//                                             .map((e) => DropdownMenuItem(
//                                                   value: e.employmentStatusId,
//                                                   child: Center(
//                                                     child: Text(e.statusName!),
//                                                   ),
//                                                 ))
//                                             .toList()
//                                     //items: const ["غير موظف", "موظف", "عقد 315"],
//                                     )),
//                             const SizedBox(
//                               height: 10,
//                             ),
//                             Obx(
//                               () => functionl.value == "غير موظف"
//                                   ? Container()
//                                   : Wrap(
//                                       spacing: 60,
//                                       runSpacing: 20,
//                                       children: [
//                                         GetBuilder<DropdownListController>(
//                                             init: DropdownListController(),
//                                             id: "loading",
//                                             builder: (cont) {
//                                               return cont.isLoading
//                                                   ? const Center(
//                                                       child: GifImageCostom(
//                                                         Gif:
//                                                             "assets/icons/pencil.gif",
//                                                         width: 100,
//                                                       ),
//                                                     )
//                                                   : GetBuilder<
//                                                           DropdownListController>(
//                                                       id: 'نوع الموافقة الدراسية',
//                                                       builder: (Controllers) {
//                                                         return DropDownList(
//                                                           value: typeConsentId,
//                                                           width: 550,
//                                                           title:
//                                                               "نوع الموافقة الدراسية ؟",
//                                                           onchange: (val) {
//                                                             careerInformationController
//                                                                 .careerInformation
//                                                                 .typeConsentId = val;
//                                                             typeConsentId = val;
//                                                             Controllers.update();
//                                                           },
//                                                           DropdownMenuItems:
//                                                               Controllers!
//                                                                   .typeConsentForStudy!
//                                                                   .map((e) =>
//                                                                       DropdownMenuItem(
//                                                                         value: e
//                                                                             .typeConsentId,
//                                                                         child:
//                                                                             Center(
//                                                                           child:
//                                                                               Text(e.typeConsentName!),
//                                                                         ),
//                                                                       ))
//                                                                   .toList(),
//                                                         );
//                                                       });
//                                             }),
//                                         // const SizedBox(
//                                         //   width: double.infinity,
//                                         // ),
//                                         CustomCalendar(
//                                           Controllers: CommencementDate,
//                                           width: 300,
//                                           constrainWidth: 300,
//                                           title:
//                                               "تاريخ المباشرة بعد اخر شهادة :",
//                                           onChange: (value) {
//                                             homePageController
//                                                     .dateCommencement =
//                                                 CommencementDate.text;
//                                           },
//                                         ),
//                                         GetBuilder<DropdownListController>(
//                                             id: 'اسم الوزارة',
//                                             builder: (Controllers) {
//                                               return DropDownList(
//                                                 value: ministryId,
//                                                 width: 500,
//                                                 title: "اسم الوزارة :",
//                                                 onchange: (val) {
//                                                   careerInformationController
//                                                       .careerInformation
//                                                       .ministryId = val;
//                                                   ministryId = val;
//                                                   haveUniversityService
//                                                       .value = Controllers
//                                                           .ministry!
//                                                           .where((m) =>
//                                                               m.ministryId ==
//                                                               val)
//                                                           .first
//                                                           .heirghEduSevice ==
//                                                       1;
//                                                   homePageController
//                                                           .haveUniversityService
//                                                           .value =
//                                                       haveUniversityService
//                                                           .value;
//
//                                                   Controllers.update();
//                                                 },
//                                                 DropdownMenuItems: Controllers
//                                                     .ministry!
//                                                     .map((e) =>
//                                                         DropdownMenuItem(
//                                                           value: e.ministryId,
//                                                           child: Center(
//                                                             child:
//                                                                 Text(e.name!),
//                                                           ),
//                                                         ))
//                                                     .toList(),
//                                               );
//                                             }),
//                                         TitleAndTextStyle(
//                                           Controllers:
//                                               organizationNameController,
//                                           onchange: (value) {
//                                             careerInformationController
//                                                 .careerInformation
//                                                 .organizationName = value;
//                                           },
//                                           width: 550,
//                                           title: "اسم الؤسسة :",
//                                         ),
//                                         const SizedBox(
//                                           width: double.infinity,
//                                         ),
//                                         Obx(() {
//                                           return haveUniversityService.value
//                                               ? CustomSwitcher(
//                                                   initialValue:
//                                                       UniversityService.value,
//                                                   onChanged: (p0) {
//                                                     UniversityService.value =
//                                                         p0;
//                                                     careerInformationController
//                                                             .careerInformation
//                                                             .universityService =
//                                                         p0 ? 1 : 0;
//                                                     fullDataUniversityService =
//                                                         p0 ? 1 : 0;
//                                                     homePageController
//                                                         .haveUniversityOrderRegardingObtainingAnAcademicTitle
//                                                         .value = p0;
//                                                   },
//                                                   title:
//                                                       "يخضع للخدمة الجامعية :")
//                                               : Container();
//                                         }),
//                                         Obx(() => UniversityService.value
//                                             ? Row(
//                                                 children: [
//                                                   GetBuilder<
//                                                           DropdownListController>(
//                                                       id: 'اللقب العلمي',
//                                                       builder: (Controllers) {
//                                                         return DropDownList(
//                                                           value:
//                                                               scientificTitleId,
//                                                           title:
//                                                               "اللقب العلمي :",
//                                                           onchange: (val) {
//                                                             isBachelor = (ScientificTitles
//                                                                         .values
//                                                                         .where((b) =>
//                                                                             b.id ==
//                                                                             val)
//                                                                         .first ==
//                                                                     ScientificTitles
//                                                                         .bachelor)
//                                                                 .obs;
//
//                                                             careerInformationController
//                                                                 .careerInformation
//                                                                 .scientificTitleId = val;
//                                                             scientificTitleId =
//                                                                 val;
//                                                             Controllers.update();
//                                                           },
//                                                           DropdownMenuItems: Controllers
//                                                               .scientificTitles!
//                                                               .map((e) =>
//                                                                   DropdownMenuItem(
//                                                                     value: e
//                                                                         .scientificTitleId,
//                                                                     child:
//                                                                         Center(
//                                                                       child: Text(
//                                                                           e.name!),
//                                                                     ),
//                                                                   ))
//                                                               .toList(),
//                                                         );
//                                                       }),
//                                                   const SizedBox(
//                                                     width: 50,
//                                                   ),
//                                                   if (!isBachelor.value)
//                                                     Row(
//                                                       children: [
//                                                         TitleAndTextStyle(
//                                                           Controllers:
//                                                               PromotionOrderNumber,
//                                                           title:
//                                                               "رقم امر الترقية :",
//                                                           onchange: (value) {
//                                                             promotionOrder
//                                                                     .documentsNumber =
//                                                                 value;
//                                                           },
//                                                         ),
//                                                         const SizedBox(
//                                                           width: 50,
//                                                         ),
//                                                         CustomCalendar(
//                                                           title:
//                                                               "تاريخ امر الترقية :",
//                                                           Controllers:
//                                                               PromotionOrderDate,
//                                                         ),
//                                                       ],
//                                                     ),
//                                                 ],
//                                               )
//                                             : Container()),
//                                         // const SizedBox(
//                                         //   width: double.infinity,
//                                         // ),
//                                       ],
//                                     ),
//                             ),
//                             Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   SizedBox(
//                                     width: size.width < SizeR.TabletWidth
//                                         ? 20
//                                         : 400,
//                                   ),
//                                   ButtonStyleS(
//                                     colorBorder: Colors.greenAccent,
//                                     containborder: true,
//                                     isleft: true,
//                                     icon: Icons.arrow_forward_ios,
//                                     title: "حفظ وانتقال للصفحة التالية",
//                                     onTap: () async {
//                                       if (!formKey.currentState!.validate()) {
//                                         return;
//                                       }
//
//                                       // Show loading dialog using AwesomeDialog
//                                       LoadingDialog.showLoadingDialog(
//                                           message: loadingText);
//
//                                       try {
//                                         debugPrint(careerInformationController
//                                             .careerInformation
//                                             .toJson()
//                                             .toString());
//
//                                         // Clear career information documents
//                                         careerInformationController
//                                             .careerInformation.documents
//                                             ?.clear();
//
//                                         // Check if UniversityService is active and add promotion order information
//                                         if (UniversityService.value) {
//                                           promotionOrder.documentsDate =
//                                               PromotionOrderDate.text;
//                                           promotionOrder.documentsNumber =
//                                               PromotionOrderNumber.text;
//                                           promotionOrder.documentsTypeId =
//                                               DocumentsType.promotionOrder.id;
//                                           careerInformationController
//                                               .careerInformation.documents
//                                               ?.add(promotionOrder);
//                                         }
//
//                                         // Set typeConsentId
//                                         if (careerInformationController
//                                                 .careerInformation
//                                                 .typeConsentId !=
//                                             null) {
//                                           homePageController
//                                                   .typeConsentId.value =
//                                               careerInformationController
//                                                   .careerInformation
//                                                   .typeConsentId;
//                                         }
//
//                                         // Set dateCommencement
//                                         careerInformationController
//                                                 .careerInformation
//                                                 .dateCommencement =
//                                             CommencementDate.text;
//                                         homePageController.dateCommencement =
//                                             CommencementDate.text;
//
//                                         // Upload data
//                                         var status =
//                                             await careerInformationController
//                                                 .uploadData();
//                                         homePageController.functionalInformation
//                                             .isFull.value = status;
//
//                                         // Hide loading dialog
//                                         Get.back();
//
//                                         // Proceed after data upload
//                                         if (status) {
//                                           homePageController.fullStudentData
//                                               .value.careerInformation
//                                               ?.clear();
//                                           homePageController.fullStudentData
//                                               .value.careerInformation
//                                               ?.add(
//                                             FullDataCareerInformation
//                                                 .fromCareerInformation(
//                                                     careerInformationController
//                                                         .careerInformation),
//                                           );
//
//                                           homePageController.pageChange(
//                                               homePageController
//                                                   .academicInformation.index);
//
//                                           // Show confirmation dialog if serial is not null
//                                           if (homePageController.fullStudentData
//                                                   .value.serial !=
//                                               null) {
//                                             DilogCostom.confirmFinishEditing(
//                                               onSubmit: () async {
//                                                 await homePageController
//                                                     .modifyComplete();
//                                               },
//                                             );
//                                           }
//                                         }
//                                         Get.back();
//                                       } catch (e) {
//                                         // Hide loading dialog in case of error
//                                         Get.back();
//
//                                         // Handle exception by showing error dialog
//                                         DilogCostom.dilogSecss(
//                                           isErorr: true,
//                                           title:
//                                               "حدث خطأ أثناء معالجة البيانات، يرجى المحاولة مرة أخرى",
//                                           icons: Icons.error,
//                                           color: Colors.redAccent,
//                                         );
//                                       }
//                                     },
//                                   ),
//                                 ])
//                           ],
//                         ),
//                       ),
//                     );
//             }),
//       ),
//     );
//   }
// }
