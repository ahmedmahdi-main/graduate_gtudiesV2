import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduate_gtudiesV2/Models/full_student_data.dart';
import 'package:graduate_gtudiesV2/view/pages/DialogsWindows/loading_dialog.dart';
import '../../../Services/DilogCostom.dart';
import '../../../Services/Session.dart';
import '../../../Services/base_route.dart';
import '../../../ValidatorFunction/text_validator.dart';
import '../../../controller/home_page_controller.dart';
import '../../../module/Addresses.dart' as adress;
import '../../widget/GifImageCostom.dart';
import 'Controller/PersonalInformationController.dart';
import 'StudentPersonalInformation.dart';
import '../../../module/cetiyclass.dart';
import '../../../theme.dart';
import '../../widget/Coustom Calender.dart';
import '../../widget/buttonsyle.dart';
import '../../widget/custom switcher.dart';
import '../../widget/dropdownlistt.dart';
import '../../widget/titleandtextstyle.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({super.key});

  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  FullDataPersonalInformation? fullDataPersonalInformation =
      FullDataPersonalInformation();

  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  ScrollController scrollController = ScrollController();

  TextEditingController firstName = TextEditingController();
  TextEditingController secondName = TextEditingController();
  TextEditingController thirdName = TextEditingController();
  TextEditingController fourthName = TextEditingController();
  TextEditingController firstMothersName = TextEditingController();
  TextEditingController secondMothersName = TextEditingController();
  TextEditingController thirdMothersName = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nationality = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController district = TextEditingController();
  TextEditingController neighborhood = TextEditingController();
  TextEditingController mahalla = TextEditingController();
  TextEditingController alley = TextEditingController();
  TextEditingController houseNumber = TextEditingController();
  var isBlind = false.obs;
  Rx<String?> stateObx = Rx(null);
  Rx<String?> genderObx = Rx(null);
  StudentPersonalInformation personalInformation = StudentPersonalInformation();
  adress.Addresses addresses = adress.Addresses();
  HomePageController homePageController = Get.put(HomePageController());
  var pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder(
        init: HomePageController(),
        builder: (controller) {
          if (homePageController.fullStudentData.value.academicInformation !=
                  null &&
              homePageController
                  .fullStudentData.value.personalInformation!.isNotEmpty) {
            var fullStudentData = homePageController.fullStudentData.value;

            fullDataPersonalInformation =
                fullStudentData.personalInformation?.first;
            isBlind.value = fullDataPersonalInformation?.isBlind == 1;
            firstName.text = fullDataPersonalInformation?.firstName ?? '';
            secondName.text = fullDataPersonalInformation?.secondName ?? '';
            thirdName.text = fullDataPersonalInformation?.thirdName ?? '';
            fourthName.text = fullDataPersonalInformation?.fourthName ?? '';
            firstMothersName.text =
                fullDataPersonalInformation?.firstMothersName ?? '';
            secondMothersName.text =
                fullDataPersonalInformation?.secondMothersName ?? '';
            thirdMothersName.text =
                fullDataPersonalInformation?.thirdMothersName ?? '';
            phoneController.text = fullDataPersonalInformation?.phone ?? '';
            nationality.text = fullDataPersonalInformation?.nationality ?? '';
            dateOfBirth.text = fullDataPersonalInformation?.dateOfBirth
                    ?.replaceAll('-', '/') ??
                '';
            gender.text = fullDataPersonalInformation?.gender ?? '';
            genderObx.value = gender.text;
            if (fullDataPersonalInformation?.addresses != null) {
              state.text =
                  fullDataPersonalInformation?.addresses?.first.state ?? '';
              stateObx.value = state.text;
              district.text =
                  fullDataPersonalInformation?.addresses?.first.district ?? '';
              neighborhood.text =
                  fullDataPersonalInformation?.addresses?.first.neighborhood ??
                      '';
              mahalla.text =
                  fullDataPersonalInformation?.addresses?.first.mahalla ?? '';
              alley.text =
                  fullDataPersonalInformation?.addresses?.first.alley ?? '';
              houseNumber.text = fullDataPersonalInformation
                      ?.addresses?.first.houseNumber
                      .toString() ??
                  '';
            }
          }

          return homePageController.isLoading.value
              ? const Center(
                  child: GifImageCostom(
                    Gif: "assets/icons/pencil.gif",
                    width: 100,
                  ),
                )
              : SingleChildScrollView(
                  controller: scrollController,
                  child: Container(
                    decoration: BoxDecoration(
                        color: KprimeryColor,
                        borderRadius: size.width > SizeR.MobileWidth
                            ? const BorderRadius.only(
                                topRight: Radius.circular(19))
                            : null),
                    margin: size.width > SizeR.MobileWidth
                        ? const EdgeInsets.only(top: 12, right: 12)
                        : null,
                    width: double.infinity,
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
                                Container(
                                    padding: EdgeInsets.only(
                                        top: (size.width > SizeR.MobileWidth
                                            ? 0
                                            : 10)),
                                    child: TitleAndTextStyle(
                                        title: "اسم الطالب :",
                                        controller: firstName,
                                        validator: (value) =>
                                            isTextValid(value, 1))),
                                TitleAndTextStyle(
                                    title: "اسم الاب :",
                                    controller: secondName,
                                    validator: (value) =>
                                        isTextValid(value!, 1)),
                                TitleAndTextStyle(
                                  title: "اسم الجد :",
                                  controller: thirdName,
                                  validator: (value) => isTextValid(value, 1),
                                ),
                                TitleAndTextStyle(
                                  title: "الاسم الرابع :",
                                  controller: fourthName,
                                  validator: (value) => isTextValid(value, 1),
                                ),
                                TitleAndTextStyle(
                                  title: "اسم الام :",
                                  controller: firstMothersName,
                                  validator: (value) => isTextValid(value, 1),
                                ),
                                TitleAndTextStyle(
                                  title: "اسم والد الام :",
                                  controller: secondMothersName,
                                  validator: (value) => isTextValid(value, 1),
                                ),
                                TitleAndTextStyle(
                                  title: "اسم جد الام :",
                                  controller: thirdMothersName,
                                  validator: (value) => isTextValid(value, 1),
                                ),
                                Container(
                                  width: double.infinity,
                                ),
                                TitleAndTextStyle(
                                    //initialValue: personalinformation?.phone ?? '',
                                    title: "رقم الهاتف :",
                                    controller: phoneController,
                                    validator: (value) =>
                                        phoneNumberValidator(value)),
                                // TitleAndTextStyle(
                                //   title: "البريد الالكتروني :",
                                //   validator: (value) => isEmailValid(value),
                                // ),
                                TitleAndTextStyle(
                                    title: "الجنسية :",
                                    controller: nationality,
                                    validator: (value) =>
                                        isTextValid(value, 1)),
                                Container(
                                  width: double.infinity,
                                ),
                                CustomCalendar(
                                  constrainWidth: 300,
                                  title: "تاريخ الميلاد",
                                  controller: dateOfBirth,
                                ),
                                Obx(() {
                                  return DropDownList(
                                    title: "الجنس",
                                    value: genderObx.value,
                                    onchange: (val) {
                                      gender.text = val;
                                      genderObx.value = val;
                                    },
                                    DropdownMenuItems: const [
                                      DropdownMenuItem(
                                        value: 'ذكر',
                                        child: Center(child: Text('ذكر')),
                                      ),
                                      DropdownMenuItem(
                                        value: 'انثى',
                                        child: Center(child: Text('انثى')),
                                      ),
                                      // DropdownMenuItem(
                                      //   value: '',
                                      //   child: Center(child: Text('')),
                                      // ),
                                    ],
                                  );
                                }),

                                Obx(() {
                                  return DropDownList(
                                    title: "المحافظة",
                                    value: stateObx.value,
                                    onchange: (val) {
                                      state.text = val;
                                      stateObx.value = val;
                                    },
                                    DropdownMenuItems: Governorates.map(
                                        (e) => DropdownMenuItem(
                                              value: e,
                                              child: Center(child: Text(e)),
                                            )).toList(),
                                    // DropdownMenuItems:[DropdownMenuItem(child: Center(child: Text(),))],
                                    // Governorates,
                                  );
                                }),

                                TitleAndTextStyle(
                                    title: 'القضاء:',
                                    controller: district,
                                    validator: (value) =>
                                        isTextValid(value, 1)),
                                TitleAndTextStyle(
                                    title: " الحي:",
                                    controller: neighborhood,
                                    validator: (value) =>
                                        isTextValid(value, 1)),
                                TitleAndTextStyle(
                                    title: " المحلة:",
                                    controller: mahalla,
                                    validator: (value) =>
                                        isTextValid(value, 1)),
                                TitleAndTextStyle(
                                    title: " الزقاق:",
                                    controller: alley,
                                    validator: (value) =>
                                        isTextValid(value, 1)),
                                TitleAndTextStyle(
                                  title: " رقم الدار:",
                                  controller: houseNumber,
                                  validator: (value) =>
                                      houseNumberValidator(value),
                                ),
                                Container(
                                  width: double.infinity,
                                ),
                                Obx(() {
                                  return CustomSwitcher(
                                    initialValue: isBlind.value,
                                    title: "هل المتقدم كفيف ..؟",
                                    onChanged: (value) => isBlind.value = value,
                                  );
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
                                          if (!_formKey.currentState!
                                              .validate()) {
                                            return;
                                          }

                                          _formKey.currentState!.save();

                                          // Show loading dialog using AwesomeDialog

                                          try {
                                            LoadingDialog.showLoadingDialog(
                                                message: loadingText);
                                            // Save the personal information data
                                            await savePersonalInformationData();
                                            Get.back();
                                          } catch (e) {
                                            // Hide loading dialog in case of error
                                            Get.back();

                                            // Handle exception by showing error dialog
                                            DilogCostom.dilogSecss(
                                              isErorr: true,
                                              title:
                                                  "حدث خطأ أثناء حفظ المعلومات، يرجى المحاولة مرة أخرى",
                                              icons: Icons.error,
                                              color: Colors.redAccent,
                                            );
                                          }
                                        },
                                      ),
                                    ])
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
        });
  }

  Future<void> _fullPersonalInformationData() async {
    var session = await getSession();
    addresses = adress.Addresses(
        state: state.text,
        neighborhood: neighborhood.text,
        district: district.text,
        alley: alley.text,
        mahalla: mahalla.text,
        houseNumber: int.parse(houseNumber.text));
    List<adress.Addresses> addressess = [addresses];
    personalInformation = StudentPersonalInformation(
      studentUUID: session['UUID'],
      firstName: firstName.text,
      secondName: secondName.text,
      thirdName: thirdName.text,
      fourthName: fourthName.text,
      firstMothersName: firstMothersName.text,
      secondMothersName: secondMothersName.text,
      thirdMothersName: thirdMothersName.text,
      nationality: nationality.text,
      dateOfBirth: dateOfBirth.text,
      gender: gender.text,
      Phone: phoneController.text,
      isBlind: isBlind.value,
      addresses: addressess,
    );
    debugPrint(personalInformation.toJson().toString());
  }

  Future<void> savePersonalInformationData() async {
    await _fullPersonalInformationData();
    var status = await PersonalInformationController.insertPersonalInformation(
        personalInformation);
    Get.back();
    homePageController.personalInformation.isFull.value = status;
    if (status) {
      homePageController.fullStudentData.value.personalInformation?.clear();
      homePageController.fullStudentData.value.personalInformation?.add(
          FullDataPersonalInformation.fromStudentPersonalInformation(
              personalInformation));
      // debugPrint('personalInformation = ${personalInformation.toJson()}');
      homePageController
          .pageChange(homePageController.functionalInformation.index);
      if (homePageController.fullStudentData.value.serial != null) {
        DilogCostom.confirmFinishEditing(onSubmit: () async {
          await homePageController.modifyComplete();
        });
      }
    }
  }
}
