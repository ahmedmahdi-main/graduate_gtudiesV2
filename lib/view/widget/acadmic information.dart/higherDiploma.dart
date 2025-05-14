// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../Enums/certificate_type.dart';
// import '../../../Models/academic_information.dart';
// import '../../../Models/super_data.dart';
// import '../../../controllers/AcademicInformationController.dart';
// import '../../../controllers/dropdown_filter_controllers.dart';
//
// import '../../../controllers/home_page_controller.dart';
// import '../../../theme.dart';
// import '../coustom_calender.dart';
// import '../GifImageCostom.dart';
// import '../IconButtonostom.dart';
// import '../buttonsyle.dart';
// import '../custom switcher.dart';
// import '../dropdownlistt.dart';
// import '../titleandtextstyle.dart';
//
// class HigherDiploma extends StatelessWidget {
//   final int index;
//   final HomePageController _controller = Get.find();
//
//   HigherDiploma({super.key, required this.index});
//
//   // final SuperDataController _superController = Get.put(SuperDataController());
//   // SuperData? _superData;
//   //
//   // Future<void> setSuperData() async {
//   //   _superData = await _superController.getAllData();
//   // }
//
//   final AcademicInformationController academicInformationController =
//       Get.find();
//   AcademicInformation academicInformation = AcademicInformation();
//   Documents universityMatterDocument = Documents();
//   TextEditingController universityMatterController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     academicInformation.documents = [];
//     return FutureBuilder(
//         future: setSuperData(),
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           switch (snapshot.connectionState) {
//             case ConnectionState.none:
//               return const Text('Press button to start.');
//             case ConnectionState.active:
//             case ConnectionState.waiting:
//               return const Center(
//                 child: GifImageCostom(
//                   Gif: "assets/icons/pencil.gif",
//                   width: 100,
//                 ),
//               );
//             case ConnectionState.done:
//               if (snapshot.hasError) return Text('Error: ${snapshot.error}');
//               return Container(
//                 decoration: BoxDecoration(
//                     color: KprimeryColor,
//                     borderRadius: const BorderRadius.all(Radius.circular(19))),
//                 margin: const EdgeInsets.only(top: 12, right: 12, left: 12),
//                 child: Padding(
//                   padding: const EdgeInsets.all(12),
//                   child: GetBuilder<DropdownListController>(
//                       id: "loading",
//                       init: DropdownListController(),
//                       builder: (cont) {
//                         return cont.isLoading
//                             ? CircularProgressIndicator()
//                             : Wrap(
//                                 alignment: WrapAlignment.start,
//                                 spacing: 60,
//                                 runSpacing: 20,
//                                 children: [
//                                   const TitleAndTextStyle(
//                                     title: "نوع الشهادة ",
//                                     initialValue: "دبلوم العالي",
//                                     readOnly: true,
//                                   ),
//                                   DropdownlistWithValedator(
//                                     keyselected: "name",
//                                     title: "الشهادة صادرة من ؟",
//                                     onchange: (value) {
//                                       academicInformation.certificateIssuedBy =
//                                           value;
//
//
//                                     },
//                                     DropdownMenuItems:
//                                         ["خارج العراق", "داخل العراق"]
//                                             .map((e) => DropdownMenuItem(
//                                                 value: e,
//                                                 child: Center(
//                                                   child: Text(e),
//                                                 )))
//                                             .toList(),
//                                     // items: ["خارج العراق", "داخل العراق"],
//                                   ),
//                                   DropdownlistWithValedator(
//                                     keyselected: "name",
//                                     title: "اسم الجامعة",
//                                     onchange: (value) {
//                                       academicInformation.universityId = value;
//                                     },
//                                     DropdownMenuItems: _superData!.universities!
//                                         .map((e) => DropdownMenuItem(
//                                               value: e.universityId,
//                                               child: Center(
//                                                 child: Text(e.universityName!),
//                                               ),
//                                             ))
//                                         .toList(),
//                                   ),
//                                   DropdownlistWithValedator(
//                                     keyselected: "name",
//                                     title: "الكلية",
//                                     onchange: (value) {
//                                       academicInformation.collegesId = value;
//                                     },
//                                     DropdownMenuItems: _superData!.colleges!
//                                         .map((e) => DropdownMenuItem(
//                                               value: e.collegesId,
//                                               child: Center(
//                                                 child: Text(e.collegesName!),
//                                               ),
//                                             ))
//                                         .toList(),
//                                   ),
//                                   DropdownlistWithValedator(
//                                     keyselected: "name",
//                                     title: "القسم",
//                                     onchange: (value) {
//                                       academicInformation.departmentId = value;
//                                     },
//                                     DropdownMenuItems: _superData!.department!
//                                         .map((e) => DropdownMenuItem(
//                                               value: e.departmentId,
//                                               child: Center(
//                                                 child: Text(e.departmentName!),
//                                               ),
//                                             ))
//                                         .toList(),
//                                   ),
//                                   DropdownlistWithValedator(
//                                     keyselected: "name",
//                                     title: "العام الدراسي",
//                                     onchange: (value) {
//                                       academicInformation.academicYear = value;
//                                     },
//                                     DropdownMenuItems: _superData!.years!
//                                         .map((e) => DropdownMenuItem(
//                                               value: e,
//                                               child: Center(
//                                                 child: Text(e),
//                                               ),
//                                             ))
//                                         .toList(),
//                                   ),
//                                   TitleAndTextStyle(
//                                     onchange: (value) {
//                                       academicInformation.average =
//                                           int.parse(value);
//                                     },
//                                     width: 200,
//                                     title: "معدل الدبلوم العالي",
//                                   ),
//                                   GetBuilder<DropdownListController>(
//                                       id: 'التخصص',
//                                       builder: (controllers) =>
//                                           DropdownlistWithValedator(
//                                             value:
//                                                 controllers.specializationsValue,
//                                             keyselected: "name",
//                                             title: "دبلوم العالي في التخصص",
//                                             onchange: (val) {
//                                               academicInformation
//                                                   .specializationId = val;
//                                             },
//                                             DropdownMenuItems: controllers
//                                                 .specializations!
//                                                 .map(
//                                                   (e) => DropdownMenuItem(
//                                                     value: e.specializationId,
//                                                     child: e.specializationName !=
//                                                             null
//                                                         ? Text(e
//                                                             .specializationName!)
//                                                         : const Text(""),
//                                                   ),
//                                                 )
//                                                 .toList(),
//                                           )),
//                                   TitleAndTextStyle(
//                                     onchange: (value) {
//                                       universityMatterDocument.documentsNumber =
//                                           value;
//                                     },
//                                     width: 200,
//                                     title: " رقم الامر الجامعي الخاص بالدبلوم ",
//                                   ),
//                                   Coustomcaleender(
//                                     title:
//                                         "تاريخ الامر الجامعي الخاص بالدبلوم :",
//                                     controllers: universityMatterController,
//                                   ),
//                                   CustomSwitcher(
//                                     onChanged: (value) {
//                                       academicInformation.isDiplomaCompatible =
//                                           value ? 1 : 0;
//                                     },
//                                     title: "هل الدبلوم متوافق مع البكلوريوس؟ :",
//                                   ),
//                                   const SizedBox(
//                                     width: double.infinity,
//                                   ),
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       IconButtonostom(
//                                           controllers: _controller,
//                                           index: index,
//                                           dgree: "دبلوم"),
//                                       ButtonStyleS(
//                                         colorBorder: Colors.greenAccent,
//                                         containborder: true,
//                                         isleft: true,
//                                         icon: Icons.save_outlined,
//                                         title: 'حفظ الشهادة',
//                                         onTap: () {
//                                           academicInformation
//                                               .certificateTypeId =  CertificateType.diploma.id;
//                                           universityMatterDocument
//                                                   .documentsDate =
//                                               universityMatterController.text;
//                                           universityMatterDocument
//                                                   .documentsTypeId =
//                                               3; // TODO documentsType
//                                           academicInformation.documents!
//                                               .clear();
//                                           academicInformation.documents
//                                               ?.add(universityMatterDocument);
//                                           academicInformationController
//                                               .academicInformationModel!
//                                               .academicInformation
//                                               ?.add(academicInformation);
//                                         },
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               );
//                       }),
//                 ),
//               );
//           }
//         });
//   }
// }
