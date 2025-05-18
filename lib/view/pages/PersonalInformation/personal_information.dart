import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduate_gtudiesV2/Models/full_student_data.dart';
import 'package:graduate_gtudiesV2/view/pages/DialogsWindows/loading_dialog.dart';
import '../../../Models/cetiyclass.dart';
import '../../../Services/DilogCostom.dart';
import '../../../Services/base_route.dart';
import '../../../controller/home_page_controller.dart';
import '../../../Models/addresses.dart';
import '../../widget/GifImageCostom.dart';
import 'Controller/personal_information_controller.dart';
import 'student_personal_information.dart';

import '../../../theme.dart';
import '../../widget/coustom_calender.dart';
import '../../widget/buttonsyle.dart';
import '../../widget/custom_switcher.dart';
import '../../widget/dropdownlistt.dart';
import '../../widget/titleandtextstyle.dart';

// ignore_for_file: non_constant_identifier_names

class PersonalInformationForm extends StatefulWidget {
  const PersonalInformationForm({super.key});

  @override
  State<PersonalInformationForm> createState() =>
      _PersonalInformationFormState();
}

class _PersonalInformationFormState extends State<PersonalInformationForm> {
  // Controllers
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();
  final _fieldControllers = {
    'firstName': TextEditingController(),
    'secondName': TextEditingController(),
    'thirdName': TextEditingController(),
    'fourthName': TextEditingController(),
    'firstMothersName': TextEditingController(),
    'secondMothersName': TextEditingController(),
    'thirdMothersName': TextEditingController(),
    'phone': TextEditingController(),
    'nationality': TextEditingController(),
    'district': TextEditingController(),
    'neighborhood': TextEditingController(),
    'mahalla': TextEditingController(),
    'alley': TextEditingController(),
    'houseNumber': TextEditingController(),
    // 'dateOfBirth': _dateOfBirthController, // moved to initState
  };

  // State variables
  final _dateOfBirthController = TextEditingController();
  final _genderController = TextEditingController();
  final _stateController = TextEditingController();
  final _isBlind = false.obs;
  final _selectedState = Rx<String?>(null);
  final _selectedGender = Rx<String?>(null);

  // Dependencies
  final _homeController = Get.find<HomePageController>();
  // final _personalInfoController = PersonalInformationController();
  late final StudentPersonalInformation _personalInformation;
  Addresses _address =
      Addresses(); // Remove 'late final' and initialize directly

  @override
  void initState() {
    super.initState();
    _fieldControllers['dateOfBirth'] = _dateOfBirthController;

    // Initialize personal information and address objects
    _personalInformation = StudentPersonalInformation();
    _address = Addresses();

    // Add a listener to the fullStudentData observable
    // This will trigger whenever the data changes
    _homeController.fullStudentData.listen((data) {
      if (data.personalInformation != null &&
          data.personalInformation!.isNotEmpty) {
        _initializeFormData();
      }
    });

    // Initialize form data
    _initializeFormData();

    // Debug print to check if data is available
    // debugPrint(
    //     'Personal Info available: ${_homeController.fullStudentData.value.personalInformation?.isNotEmpty == true}');
  }

  @override
  void dispose() {
    _scrollController.dispose();
    for (var c in _fieldControllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  void _initializeFormData() {
    final studentData = _homeController.fullStudentData.value;
    final personalInfo = studentData.personalInformation?.first;

    if (personalInfo != null) {
      _isBlind.value = personalInfo.isBlind == 1;
      _updateControllersFromData(personalInfo);

      // Force UI update after loading data
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {}); // Trigger a rebuild after initialization
      });
    }
  }

  void _updateControllersFromData(FullDataPersonalInformation data) {
    // debugPrint('_updateControllersFromData ${data.toJson()}');
    // Update personal information fields
    _fieldControllers['firstName']!.text = data.firstName ?? '';
    _fieldControllers['secondName']!.text = data.secondName ?? '';
    _fieldControllers['thirdName']!.text = data.thirdName ?? '';
    _fieldControllers['fourthName']!.text = data.fourthName ?? '';
    _fieldControllers['firstMothersName']!.text = data.firstMothersName ?? '';
    _fieldControllers['secondMothersName']!.text = data.secondMothersName ?? '';
    _fieldControllers['thirdMothersName']!.text = data.thirdMothersName ?? '';
    _fieldControllers['phone']!.text = data.phone ?? '';
    _fieldControllers['nationality']!.text = data.nationality ?? '';
    _fieldControllers['dateOfBirth'] = _dateOfBirthController;
    // Handle date of birth formatting
    _dateOfBirthController.text = data.dateOfBirth?.replaceAll('-', '/') ?? '';

    // Update gender selection
    _genderController.text = data.gender ?? '';
    _selectedGender.value = data.gender;

    // Update address information if available
    if (data.addresses?.isNotEmpty ?? false) {
      final address = data.addresses!.first;
      _fieldControllers['district']!.text = address.district ?? '';
      _fieldControllers['neighborhood']!.text = address.neighborhood ?? '';
      _fieldControllers['mahalla']!.text = address.mahalla ?? '';
      _fieldControllers['alley']!.text = address.alley ?? '';
      _fieldControllers['houseNumber']!.text =
          address.houseNumber?.toString() ?? '';

      // Update state selection
      _stateController.text = address.state ?? '';
      _selectedState.value = address.state;
    }

    // Update disability status
    _isBlind.value = data.isBlind == 1;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => _homeController.isLoading.value
        ? _buildLoadingIndicator()
        : _buildFormContent());
  }

  Widget _buildLoadingIndicator() => const Center(
        child: GifImageCostom(
          Gif: "assets/icons/pencil.gif",
          width: 100,
        ),
      );

  Widget _buildFormContent() {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      controller: _scrollController,
      child: Container(
        decoration: _buildContainerDecoration(size),
        margin: _buildContainerMargin(size),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 60,
                  runSpacing: 20,
                  children: [
                    ..._buildNameFields(),
                    _buildPhoneField(),
                    _buildNationalityField(),
                    _buildDateOfBirthPicker(),
                    _buildGenderDropdown(),
                    _buildStateDropdown(),
                    ..._buildAddressFields(),
                    _buildBlindToggle(),
                    SizedBox(
                      width: 350,
                    ),
                    _buildSubmitButton(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper methods for building form components
  List<Widget> _buildNameFields() => [
        _buildTextField('اسم الطالب', 'firstName'),
        _buildTextField('اسم الاب', 'secondName'),
        _buildTextField('اسم الجد', 'thirdName'),
        _buildTextField('الاسم الرابع', 'fourthName'),
        _buildTextField('اسم الام', 'firstMothersName'),
        _buildTextField('اسم والد الام', 'secondMothersName'),
        _buildTextField('اسم جد الام', 'thirdMothersName'),
      ];

  Widget _buildTextField(String label, String key) => TitleAndTextStyle(
        title: label,
        controller: _fieldControllers[key]!,
        validator: _getValidatorForField(key),
      );

  String? Function(String?) _getValidatorForField(String key) {
    switch (key) {
      case 'phone':
        return Validators.phoneNumber;
      case 'houseNumber':
        return Validators.houseNumber;
      default:
        return Validators.requiredField;
    }
  }

  Widget _buildDateOfBirthPicker() => CustomCalendar(
        // constrainWidth: 250,
        title: "تاريخ الميلاد",
        controller: _dateOfBirthController,
        onChange: (date) {}, // Prevent null error
      );

  Widget _buildGenderDropdown() => Obx(() => DropDownList(
        title: "الجنس",
        value: _selectedGender.value,
        onchange: _handleGenderChange,
        DropdownMenuItems: const [
          DropdownMenuItem(value: 'ذكر', child: Center(child: Text('ذكر'))),
          DropdownMenuItem(value: 'انثى', child: Center(child: Text('انثى'))),
        ],
      ));

  // Similar methods for other dropdowns and fields

  Widget _buildSubmitButton() => ButtonStyleS(
      colorBorder: Colors.greenAccent,
      containborder: true,
      isleft: true,
      icon: Icons.arrow_forward_ios,
      title: "حفظ وانتقال للصفحة التالية",
      onTap: () async {
        await _handleFormSubmission();
      });

  Future<void> _handleFormSubmission() async {
    if (!_formKey.currentState!.validate()) return;
    try {
      LoadingDialog.showLoadingDialog(message: loadingText);
      await _savePersonalInformation();
      Get.back();
      _handleSuccess();
    } catch (e) {
      Get.back();
      _handleError(e);
    }
  }

  Future<void> _savePersonalInformation() async {
    _prepareDataModels();
    // debugPrint('${_personalInformation.toJson()}');
    final success =
        await PersonalInformationController.insertPersonalInformation(
            _personalInformation);

    if (success) {
      _homeController.updatePersonalInfo(_personalInformation);
      _homeController.pageChange(_homeController.functionalInformation.index);
    }
  }

  void _prepareDataModels() {
    final uuid = _homeController.session?['UUID'];

    _address
      ..state = _stateController.text
      ..district = _fieldControllers['district']!.text
      ..neighborhood = _fieldControllers['neighborhood']!.text
      ..mahalla = _fieldControllers['mahalla']!.text
      ..alley = _fieldControllers['alley']!.text
      ..houseNumber = int.tryParse(_fieldControllers['houseNumber']!.text) ?? 0;

    _personalInformation
      ..studentUUID = uuid
      ..firstName = _fieldControllers['firstName']?.text
      ..secondName = _fieldControllers['secondName']?.text
      ..thirdName = _fieldControllers['thirdName']?.text
      ..fourthName = _fieldControllers['fourthName']?.text
      ..firstMothersName = _fieldControllers['firstMothersName']?.text
      ..secondMothersName = _fieldControllers['secondMothersName']?.text
      ..thirdMothersName = _fieldControllers['thirdMothersName']!.text
      ..nationality = _fieldControllers['nationality']?.text
      ..dateOfBirth = _fieldControllers['dateOfBirth']?.text
      ..gender = _selectedGender.value
      ..Phone = _fieldControllers['phone']?.text
      ..isBlind = _isBlind.value
      ..addresses = [_address];
    debugPrint('Sending: ${jsonEncode(_personalInformation.toJson())}');
    // debugPrint('${_personalInformation.toJson()}');
    // _personalInformation = StudentPersonalInformation(
    //   studentUUID: _homeController.session?['UUID'],
    //   firstName: _fieldControllers['firstName']!.text,
    //   secondName: _fieldControllers['secondName']!.text,

    //   // ... other fields
    //   addresses: [_address],
    // );
  }

  void _handleSuccess() {
    if (_homeController.fullStudentData.value.serial != null) {
      DilogCostom.confirmFinishEditing(
          onSubmit: _homeController.modifyComplete);
    }
  }

  void _handleGenderChange(dynamic? val) {
    _genderController.text = val ?? '';
    _selectedGender.value = val;
  }

  void _handleStateChange(dynamic? val) {
    _stateController.text = val ?? '';
    _selectedState.value = val;
  }

  // Add missing UI component builders
  BoxDecoration _buildContainerDecoration(Size size) {
    return BoxDecoration(
      color: KprimeryColor,
      borderRadius: size.width > SizeR.MobileWidth
          ? const BorderRadius.only(topRight: Radius.circular(19))
          : null,
    );
  }

  EdgeInsets? _buildContainerMargin(Size size) {
    return size.width > SizeR.MobileWidth
        ? const EdgeInsets.only(top: 12, right: 12)
        : null;
  }

  Widget _buildPhoneField() {
    return TitleAndTextStyle(
      title: "رقم الهاتف :",
      controller: _fieldControllers['phone']!,
      validator: Validators.phoneNumber,
    );
  }

  Widget _buildNationalityField() {
    return TitleAndTextStyle(
      title: "الجنسية :",
      controller: _fieldControllers['nationality']!,
      validator: Validators.requiredField,
    );
  }

  Widget _buildStateDropdown() {
    return Obx(() => DropDownList(
          title: "المحافظة",
          value: _selectedState.value,
          onchange: _handleStateChange,
          DropdownMenuItems: Governorates.map((e) => DropdownMenuItem(
                value: e,
                child: Center(child: Text(e)),
              )).toList(),
        ));
  }

  List<Widget> _buildAddressFields() {
    return [
      TitleAndTextStyle(
        title: 'القضاء:',
        controller: _fieldControllers['district']!,
        validator: Validators.requiredField,
      ),
      TitleAndTextStyle(
        title: " الحي:",
        controller: _fieldControllers['neighborhood']!,
        validator: Validators.requiredField,
      ),
      TitleAndTextStyle(
        title: " المحلة:",
        controller: _fieldControllers['mahalla']!,
        validator: Validators.requiredField,
      ),
      TitleAndTextStyle(
        title: " الزقاق:",
        controller: _fieldControllers['alley']!,
        validator: Validators.requiredField,
      ),
      TitleAndTextStyle(
        title: " رقم الدار:",
        controller: _fieldControllers['houseNumber']!,
        validator: Validators.houseNumber,
      ),
    ];
  }

  Widget _buildBlindToggle() {
    return Obx(() => CustomSwitcher(
          initialValue: _isBlind.value,
          title: "هل المتقدم كفيف ..؟",
          onChanged: (value) => _isBlind.value = value,
        ));
  }

  void _handleError(dynamic error) {
    DilogCostom.dilogSecss(
      isErorr: true,
      title: error.toString(),
      icons: Icons.error,
      color: Colors.redAccent,
    );
  }
}

// Validation helpers
class Validators {
  static String? requiredField(String? value) =>
      value?.isEmpty ?? true ? 'هذا الحقل مطلوب' : null;

  static String? phoneNumber(String? value) =>
      RegExp(r'^\+?[0-9]{10,}$').hasMatch(value ?? '')
          ? null
          : 'رقم هاتف غير صالح';

  static String? houseNumber(String? value) =>
      int.tryParse(value ?? '') != null ? null : 'يجب إدخال رقم صحيح';
}

// class PersonalInformation extends StatefulWidget {
//   const PersonalInformation({super.key});
//
//   @override
//   State<PersonalInformation> createState() => _PersonalInformationState();
// }
//
// class _PersonalInformationState extends State<PersonalInformation> {
//   FullDataPersonalInformation? fullDataPersonalInformation =
//       FullDataPersonalInformation();
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   final _formKey = GlobalKey<FormState>();
//
//   ScrollController scrollController = ScrollController();
//
//   TextEditingController firstName = TextEditingController();
//   TextEditingController secondName = TextEditingController();
//   TextEditingController thirdName = TextEditingController();
//   TextEditingController fourthName = TextEditingController();
//   TextEditingController firstMothersName = TextEditingController();
//   TextEditingController secondMothersName = TextEditingController();
//   TextEditingController thirdMothersName = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController nationality = TextEditingController();
//   TextEditingController dateOfBirth = TextEditingController();
//   TextEditingController gender = TextEditingController();
//   TextEditingController state = TextEditingController();
//   TextEditingController district = TextEditingController();
//   TextEditingController neighborhood = TextEditingController();
//   TextEditingController mahalla = TextEditingController();
//   TextEditingController alley = TextEditingController();
//   TextEditingController houseNumber = TextEditingController();
//   var isBlind = false.obs;
//   Rx<String?> stateObx = Rx(null);
//   Rx<String?> genderObx = Rx(null);
//   StudentPersonalInformation personalInformation = StudentPersonalInformation();
//   adress.Addresses addresses = adress.Addresses();
//   HomePageController homePageController = Get.put(HomePageController());
//   var pageIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return GetBuilder(
//         init: HomePageController(),
//         builder: (controller) {
//           if (homePageController.fullStudentData.value.academicInformation !=
//                   null &&
//               homePageController
//                   .fullStudentData.value.personalInformation!.isNotEmpty) {
//             var fullStudentData = homePageController.fullStudentData.value;
//
//             fullDataPersonalInformation =
//                 fullStudentData.personalInformation?.first;
//             isBlind.value = fullDataPersonalInformation?.isBlind == 1;
//             firstName.text = fullDataPersonalInformation?.firstName ?? '';
//             secondName.text = fullDataPersonalInformation?.secondName ?? '';
//             thirdName.text = fullDataPersonalInformation?.thirdName ?? '';
//             fourthName.text = fullDataPersonalInformation?.fourthName ?? '';
//             firstMothersName.text =
//                 fullDataPersonalInformation?.firstMothersName ?? '';
//             secondMothersName.text =
//                 fullDataPersonalInformation?.secondMothersName ?? '';
//             thirdMothersName.text =
//                 fullDataPersonalInformation?.thirdMothersName ?? '';
//             phoneController.text = fullDataPersonalInformation?.phone ?? '';
//             nationality.text = fullDataPersonalInformation?.nationality ?? '';
//             dateOfBirth.text = fullDataPersonalInformation?.dateOfBirth
//                     ?.replaceAll('-', '/') ??
//                 '';
//             gender.text = fullDataPersonalInformation?.gender ?? '';
//             genderObx.value = gender.text;
//             if (fullDataPersonalInformation?.addresses != null) {
//               state.text =
//                   fullDataPersonalInformation?.addresses?.first.state ?? '';
//               stateObx.value = state.text;
//               district.text =
//                   fullDataPersonalInformation?.addresses?.first.district ?? '';
//               neighborhood.text =
//                   fullDataPersonalInformation?.addresses?.first.neighborhood ??
//                       '';
//               mahalla.text =
//                   fullDataPersonalInformation?.addresses?.first.mahalla ?? '';
//               alley.text =
//                   fullDataPersonalInformation?.addresses?.first.alley ?? '';
//               houseNumber.text = fullDataPersonalInformation
//                       ?.addresses?.first.houseNumber
//                       .toString() ??
//                   '';
//             }
//           }
//
//           return homePageController.isLoading.value
//               ? const Center(
//                   child: GifImageCostom(
//                     Gif: "assets/icons/pencil.gif",
//                     width: 100,
//                   ),
//                 )
//               : SingleChildScrollView(
//                   controller: scrollController,
//                   child: Container(
//                     decoration: BoxDecoration(
//                         color: KprimeryColor,
//                         borderRadius: size.width > SizeR.MobileWidth
//                             ? const BorderRadius.only(
//                                 topRight: Radius.circular(19))
//                             : null),
//                     margin: size.width > SizeR.MobileWidth
//                         ? const EdgeInsets.only(top: 12, right: 12)
//                         : null,
//                     width: double.infinity,
//                     child: Padding(
//                       padding: const EdgeInsets.all(12.0),
//                       child: Form(
//                         key: _formKey,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.stretch,
//                           children: [
//                             Wrap(
//                               alignment: WrapAlignment.start,
//                               spacing: 60,
//                               runSpacing: 20,
//                               children: [
//                                 Container(
//                                     padding: EdgeInsets.only(
//                                         top: (size.width > SizeR.MobileWidth
//                                             ? 0
//                                             : 10)),
//                                     child: TitleAndTextStyle(
//                                         title: "اسم الطالب :",
//                                         controller: firstName,
//                                         validator: (value) =>
//                                             isTextValid(value))),
//                                 TitleAndTextStyle(
//                                     title: "اسم الاب :",
//                                     controller: secondName,
//                                     validator: (value) => isTextValid(value!)),
//                                 TitleAndTextStyle(
//                                   title: "اسم الجد :",
//                                   controller: thirdName,
//                                   validator: (value) => isTextValid(value),
//                                 ),
//                                 TitleAndTextStyle(
//                                   title: "الاسم الرابع :",
//                                   controller: fourthName,
//                                   validator: (value) => isTextValid(value),
//                                 ),
//                                 TitleAndTextStyle(
//                                   title: "اسم الام :",
//                                   controller: firstMothersName,
//                                   validator: (value) => isTextValid(value),
//                                 ),
//                                 TitleAndTextStyle(
//                                   title: "اسم والد الام :",
//                                   controller: secondMothersName,
//                                   validator: (value) => isTextValid(value),
//                                 ),
//                                 TitleAndTextStyle(
//                                   title: "اسم جد الام :",
//                                   controller: thirdMothersName,
//                                   validator: (value) => isTextValid(value),
//                                 ),
//                                 Container(
//                                   width: double.infinity,
//                                 ),
//                                 TitleAndTextStyle(
//                                     //initialValue: personalinformation?.phone ?? '',
//                                     title: "رقم الهاتف :",
//                                     controller: phoneController,
//                                     validator: (value) =>
//                                         phoneNumberValidator(value)),
//                                 // TitleAndTextStyle(
//                                 //   title: "البريد الالكتروني :",
//                                 //   validator: (value) => isEmailValid(value),
//                                 // ),
//                                 TitleAndTextStyle(
//                                     title: "الجنسية :",
//                                     controller: nationality,
//                                     validator: (value) => isTextValid(value)),
//                                 Container(
//                                   width: double.infinity,
//                                 ),
//                                 CustomCalendar(
//                                   constrainWidth: 300,
//                                   title: "تاريخ الميلاد",
//                                   controller: dateOfBirth,
//                                 ),
//                                 Obx(() {
//                                   return DropDownList(
//                                     title: "الجنس",
//                                     value: genderObx.value,
//                                     onchange: (val) {
//                                       gender.text = val;
//                                       genderObx.value = val;
//                                     },
//                                     DropdownMenuItems: const [
//                                       DropdownMenuItem(
//                                         value: 'ذكر',
//                                         child: Center(child: Text('ذكر')),
//                                       ),
//                                       DropdownMenuItem(
//                                         value: 'انثى',
//                                         child: Center(child: Text('انثى')),
//                                       ),
//                                       // DropdownMenuItem(
//                                       //   value: '',
//                                       //   child: Center(child: Text('')),
//                                       // ),
//                                     ],
//                                   );
//                                 }),
//
//                                 Obx(() {
//                                   return DropDownList(
//                                     title: "المحافظة",
//                                     value: stateObx.value,
//                                     onchange: (val) {
//                                       state.text = val;
//                                       stateObx.value = val;
//                                     },
//                                     DropdownMenuItems: Governorates.map(
//                                         (e) => DropdownMenuItem(
//                                               value: e,
//                                               child: Center(child: Text(e)),
//                                             )).toList(),
//                                     // DropdownMenuItems:[DropdownMenuItem(child: Center(child: Text(),))],
//                                     // Governorates,
//                                   );
//                                 }),
//
//                                 TitleAndTextStyle(
//                                     title: 'القضاء:',
//                                     controller: district,
//                                     validator: (value) => isTextValid(value)),
//                                 TitleAndTextStyle(
//                                     title: " الحي:",
//                                     controller: neighborhood,
//                                     validator: (value) => isTextValid(value)),
//                                 TitleAndTextStyle(
//                                     title: " المحلة:",
//                                     controller: mahalla,
//                                     validator: (value) => isTextValid(value)),
//                                 TitleAndTextStyle(
//                                     title: " الزقاق:",
//                                     controller: alley,
//                                     validator: (value) => isTextValid(value)),
//                                 TitleAndTextStyle(
//                                   title: " رقم الدار:",
//                                   controller: houseNumber,
//                                   validator: (value) =>
//                                       houseNumberValidator(value),
//                                 ),
//                                 Container(
//                                   width: double.infinity,
//                                 ),
//                                 Obx(() {
//                                   return CustomSwitcher(
//                                     initialValue: isBlind.value,
//                                     title: "هل المتقدم كفيف ..؟",
//                                     onChanged: (value) => isBlind.value = value,
//                                   );
//                                 }),
//                                 Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       SizedBox(
//                                         width: size.width < SizeR.TabletWidth
//                                             ? 20
//                                             : 400,
//                                       ),
//                                       ButtonStyleS(
//                                         colorBorder: Colors.greenAccent,
//                                         containborder: true,
//                                         isleft: true,
//                                         icon: Icons.arrow_forward_ios,
//                                         title: "حفظ وانتقال للصفحة التالية",
//                                         onTap: () async {
//                                           if (!_formKey.currentState!
//                                               .validate()) {
//                                             return;
//                                           }
//
//                                           _formKey.currentState!.save();
//
//                                           // Show loading dialog using AwesomeDialog
//
//                                           try {
//                                             LoadingDialog.showLoadingDialog(
//                                                 message: loadingText);
//                                             // Save the personal information data
//                                             await savePersonalInformationData();
//                                             Get.back();
//                                           } catch (e) {
//                                             // Hide loading dialog in case of error
//                                             Get.back();
//
//                                             // Handle exception by showing error dialog
//                                             DilogCostom.dilogSecss(
//                                               isErorr: true,
//                                               title:
//                                                   "حدث خطأ أثناء حفظ المعلومات، يرجى المحاولة مرة أخرى",
//                                               icons: Icons.error,
//                                               color: Colors.redAccent,
//                                             );
//                                           }
//                                         },
//                                       ),
//                                     ])
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//         });
//   }
//
//   Future<void> _fullPersonalInformationData() async {
//     var session = await getSession();
//     addresses = adress.Addresses(
//         state: state.text,
//         neighborhood: neighborhood.text,
//         district: district.text,
//         alley: alley.text,
//         mahalla: mahalla.text,
//         houseNumber: int.parse(houseNumber.text));
//     List<adress.Addresses> addressess = [addresses];
//     personalInformation = StudentPersonalInformation(
//       studentUUID: session['UUID'],
//       firstName: firstName.text,
//       secondName: secondName.text,
//       thirdName: thirdName.text,
//       fourthName: fourthName.text,
//       firstMothersName: firstMothersName.text,
//       secondMothersName: secondMothersName.text,
//       thirdMothersName: thirdMothersName.text,
//       nationality: nationality.text,
//       dateOfBirth: dateOfBirth.text,
//       gender: gender.text,
//       Phone: phoneController.text,
//       isBlind: isBlind.value,
//       addresses: addressess,
//     );
//     debugPrint(personalInformation.toJson().toString());
//   }
//
//   Future<void> savePersonalInformationData() async {
//     await _fullPersonalInformationData();
//     var status = await PersonalInformationController.insertPersonalInformation(
//         personalInformation);
//     Get.back();
//     homePageController.personalInformation.isFull.value = status;
//     if (status) {
//       homePageController.fullStudentData.value.personalInformation?.clear();
//       homePageController.fullStudentData.value.personalInformation?.add(
//           FullDataPersonalInformation.fromStudentPersonalInformation(
//               personalInformation));
//       // debugPrint('personalInformation = ${personalInformation.toJson()}');
//       homePageController
//           .pageChange(homePageController.functionalInformation.index);
//       if (homePageController.fullStudentData.value.serial != null) {
//         DilogCostom.confirmFinishEditing(onSubmit: () async {
//           await homePageController.modifyComplete();
//         });
//       }
//     }
//   }
// }
