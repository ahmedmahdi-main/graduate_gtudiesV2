// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../Models/full_student_data.dart';
// import '../../../Controllers/home_page_controller.dart';
// import '../../widget/buttonsyle.dart';
// import '../DialogsWindows/loading_dialog.dart';
// import 'controller/UploadImageController.dart';
// import 'widget/upload_image_widget.dart';

// class UploadImagePage extends StatefulWidget {
//   const UploadImagePage({super.key});

//   @override
//   State<UploadImagePage> createState() => _UploadImagePageState();
// }

// class _UploadImagePageState extends State<UploadImagePage> {
//   final HomePageController homePageController = Get.put(HomePageController());
//   late final UploadingImagesController _uploadController;
//   final _formKey = GlobalKey<FormState>();
//   bool _isLoading = true;
//   ImageInformation? _imageInfo;

//   @override
//   void initState() {
//     super.initState();
//     _initController();
//   }

//   Future<void> _initController() async {
//     try {
//       _uploadController = UploadingImagesController();
//       await _loadInitialData();
//     } catch (e) {
//       debugPrint('Error initializing upload page: $e');
//       // Show error to user
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('حدث خطأ في تحميل الصفحة'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     } finally {
//       if (mounted) {
//         setState(() => _isLoading = false);
//       }
//     }
//   }

//   Future<void> _loadInitialData() async {
//     if (homePageController.fullStudentData.value.imageInformation != null) {
//       _imageInfo = homePageController.fullStudentData.value.imageInformation;
//       // You might want to update the controller with initial images here
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_isLoading) {
//       return const Center(child: CircularProgressIndicator());
//     }

//     return Container(
//       color: Colors.white,
//       padding: const EdgeInsets.all(16),
//       child: GetBuilder<UploadingImagesController>(
//         init: _uploadController,
//         builder: (controller) {
//             return SingleChildScrollView(
//               child: ConstrainedBox(
//                 constraints: BoxConstraints(minHeight: context.height - 150),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Form(
//                       key: _formKey,
//                       child: Wrap(
//                         spacing: 16,
//                         runSpacing: 16,
//                         children: [
//                           UploadImageWidget(
//                             title: "اضافة صورة شخصية",
//                             image: controller.personalPhoto,
//                             initialImage: _imageInfo?.personalPhoto,
//                             onTap: () async {
//                               try {
//                                 final result = await controller.pickImage();
//                                 if (result != null) {
//                                   controller.personalPhoto = result;
//                                   controller.update();
//                                 }
//                               } catch (e) {
//                                 debugPrint('Error picking image: $e');
//                                 // Optionally show an error message to the user
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(
//                                     content: Text('حدث خطأ أثناء تحميل الصورة'),
//                                     backgroundColor: Colors.red,
//                                   ),
//                                 );
//                               }
//                               return controller.personalPhoto;
//                             },
//                           ),
//                           UploadImageWidget(
//                             title: "اضافة بطاقة وطنية وجه",
//                             image: controller.nationalCardFace1,
//                             initialImage: _imageInfo?.nationalCardFace1,
//                             onTap: () async {
//                               try {
//                                 final result = await controller.pickImage();
//                                 if (result != null) {
//                                   controller.nationalCardFace1 = result;
//                                   controller.update();
//                                 }
//                               } catch (e) {
//                                 debugPrint('Error picking image: $e');
//                                 // Handle error
//                               }
//                               return controller.nationalCardFace1;
//                             },
//                           ),
//                           UploadImageWidget(
//                             title: "اضافة بطاقة وطنية ظهر",
//                             image: controller.nationalCardFace2,
//                             initialImage: _imageInfo?.nationalCardFace2,
//                             onTap: () async {
//                               try {
//                                 final result = await controller.pickImage();
//                                 if (result != null) {
//                                   controller.nationalCardFace2 = result;
//                                   controller.update();
//                                 }
//                               } catch (e) {
//                                 debugPrint('Error picking image: $e');
//                                 // Handle error
//                               }
//                               return controller.nationalCardFace2;
//                             },
//                           ),
//                           UploadImageWidget(
//                             title: "اضافة بطاقة سكن وجه",
//                             image: controller.residenceCardFace1,
//                             initialImage: _imageInfo?.residenceCardFace1,
//                             onTap: () async {
//                               try {
//                                 final result = await controller.pickImage();
//                                 if (result != null) {
//                                   controller.residenceCardFace1 = result;
//                                   controller.update();
//                                 }
//                               } catch (e) {
//                                 debugPrint('Error picking image: $e');
//                                 // Handle error
//                               }
//                               return controller.residenceCardFace1;
//                             },
//                           ),
//                           UploadImageWidget(
//                             title: "اضافة بطاقة سكن ظهر",
//                             image: controller.residenceCardFace2,
//                             initialImage: _imageInfo?.residenceCardFace2,
//                             onTap: () async {
//                               try {
//                                 final result = await controller.pickImage();
//                                 if (result != null) {
//                                   controller.residenceCardFace2 = result;
//                                   controller.update();
//                                 }
//                               } catch (e) {
//                                 debugPrint('Error picking image: $e');
//                                 // Handle error
//                               }
//                               return controller.residenceCardFace2;
//                             },
//                           ),
//                           UploadImageWidget(
//                             title: "اضافة وثيقة تخرج البكالوريوس",
//                             image: controller.graduationDocument,
//                             initialImage: _imageInfo?.graduationDocument,
//                             onTap: () async {
//                               controller.graduationDocument =
//                                   await controller.pickImage();
//                               controller.update();
//                               return controller.graduationDocument;
//                             },
//                           ),
//                           if (homePageController.haveFirstStudentAverage.value)
//                             UploadImageWidget(
//                               title: "اضافة كتاب معدل الطالب الاول ",
//                               image: controller.firstStudentAverage,
//                               initialImage: imageInfo?.firstStudentAverage,
//                               onTap: () async {
//                                 controller.firstStudentAverage =
//                                     await controller.pickImage();
//                                 controller.update();
//                                 return controller.firstStudentAverage;
//                               },
//                             ),
//                           if (homePageController
//                               .haveUniversityOrderForDiploma.value)
//                             UploadImageWidget(
//                               title: "اضافة الامر الجامعي الخاص بالدبلوم",
//                               image: controller.universityOrderForDiploma,
//                               initialImage:
//                                   imageInfo?.universityOrderForDiploma,
//                               onTap: () async {
//                                 controller.universityOrderForDiploma =
//                                     await controller.pickImage();
//                                 controller.update();
//                                 return controller.universityOrderForDiploma;
//                               },
//                             ),
//                           if (homePageController
//                               .haveUniversityOrderForTheMastersDegree.value)
//                             UploadImageWidget(
//                               title: "اضافة الامر الجامعي الخاص بالماجستير",
//                               image:
//                                   controller.universityOrderForTheMastersDegree,
//                               initialImage:
//                                   imageInfo?.universityOrderForTheMastersDegree,
//                               onTap: () async {
//                                 controller.universityOrderForTheMastersDegree =
//                                     await controller.pickImage();
//                                 controller.update();
//                                 return controller
//                                     .universityOrderForTheMastersDegree;
//                               },
//                             ),
//                           if (homePageController
//                               .havePeopleWithSpecialNeeds.value)
//                             UploadImageWidget(
//                               title: "اضافة كتاب ذوي الاحتياجات الخاصة",
//                               image: controller.peopleWithSpecialNeeds,
//                               initialImage: imageInfo?.peopleWithSpecialNeeds,
//                               onTap: () async {
//                                 controller.peopleWithSpecialNeeds =
//                                     await controller.pickImage();
//                                 controller.update();
//                                 return controller.peopleWithSpecialNeeds;
//                               },
//                             ),
//                           if (homePageController.havePoliticalPrisoners.value)
//                             UploadImageWidget(
//                               title: "اضافة كتاب السجناء السياسين",
//                               image: controller.politicalPrisoners,
//                               initialImage: imageInfo?.politicalPrisoners,
//                               onTap: () async {
//                                 controller.politicalPrisoners =
//                                     await controller.pickImage();
//                                 controller.update();
//                                 return controller.politicalPrisoners;
//                               },
//                             ),
//                           if (homePageController.haveMartyrsFoundation.value)
//                             UploadImageWidget(
//                               title: "اضافة كتاب مؤسسة الشهداء",
//                               image: controller.martyrsFoundation,
//                               initialImage: imageInfo?.martyrsFoundation,
//                               onTap: () async {
//                                 controller.martyrsFoundation =
//                                     await controller.pickImage();
//                                 controller.update();
//                                 return controller.martyrsFoundation;
//                               },
//                             ),
//                           if (homePageController
//                               .haveUniversityOrderRegardingObtainingAnAcademicTitle
//                               .value)
//                             UploadImageWidget(
//                               title: "أمر جامعي بالحصول على لقب العلمي",
//                               image: controller
//                                   .universityOrderRegardingObtainingAnAcademicTitle,
//                               initialImage: imageInfo
//                                   ?.universityOrderRegardingObtainingAnAcademicTitle,
//                               onTap: () async {
//                                 controller
//                                         .universityOrderRegardingObtainingAnAcademicTitle =
//                                     await controller.pickImage();
//                                 controller.update();
//                                 return controller
//                                     .universityOrderRegardingObtainingAnAcademicTitle;
//                               },
//                             ),
//                           if (homePageController.haveStudyApproval.value)
//                             UploadImageWidget(
//                               title: "كتاب عدم ممانعة",
//                               image: controller.studyApproval,
//                               initialImage: imageInfo?.studyApproval,
//                               onTap: () async {
//                                 controller.studyApproval =
//                                     await controller.pickImage();
//                                 controller.update();
//                                 return controller.studyApproval;
//                               },
//                             ),
//                           if (homePageController
//                               .haveComputerProficiencyCertificate.value)
//                             UploadImageWidget(
//                               title: "شهادة كفاءة الحاسوب",
//                               image: controller.computerProficiencyCertificate,
//                               initialImage:
//                                   imageInfo?.computerProficiencyCertificate,
//                               onTap: () async {
//                                 controller.computerProficiencyCertificate =
//                                     await controller.pickImage();
//                                 controller.update();
//                                 return controller
//                                     .computerProficiencyCertificate;
//                               },
//                             ),
//                           if (homePageController
//                               .haveEnglishLanguageProficiencyCertificate.value)
//                             UploadImageWidget(
//                               title: "شهادة الامتحان الوطني  ",
//                               image: controller
//                                   .englishLanguageProficiencyCertificate,
//                               initialImage: imageInfo
//                                   ?.englishLanguageProficiencyCertificate,
//                               onTap: () async {
//                                 controller
//                                         .englishLanguageProficiencyCertificate =
//                                     await controller.pickImage();
//                                 controller.update();
//                                 return controller
//                                     .englishLanguageProficiencyCertificate;
//                               },
//                             ),
//                           if (homePageController
//                               .haveArabicLanguageProficiencyCertificate.value)
//                             UploadImageWidget(
//                               title: "شهادة كفاءة اللغة العربية",
//                               image: controller
//                                   .arabicLanguageProficiencyCertificate,
//                               initialImage: imageInfo
//                                   ?.arabicLanguageProficiencyCertificate,
//                               onTap: () async {
//                                 controller
//                                         .arabicLanguageProficiencyCertificate =
//                                     await controller.pickImage();
//                                 controller.update();
//                                 return controller
//                                     .arabicLanguageProficiencyCertificate;
//                               },
//                             ),
//                           if (homePageController.haveIletsCertificate.value)
//                             UploadImageWidget(
//                               title: "شهادة ايلتس",
//                               image: controller.iletsCertificate,
//                               initialImage: imageInfo?.iletsCertificate,
//                               onTap: () async {
//                                 controller.iletsCertificate =
//                                     await controller.pickImage();
//                                 controller.update();
//                                 return controller.iletsCertificate;
//                               },
//                             ),
//                           if (homePageController.haveOlympicCommitteeBook.value)
//                             UploadImageWidget(
//                               title: "كتاب اللجنة الأولمبية",
//                               image: controller.olympicCommitteeBook,
//                               initialImage: imageInfo?.olympicCommitteeBook,
//                               onTap: () async {
//                                 controller.olympicCommitteeBook =
//                                     await controller.pickImage();
//                                 controller.update();
//                                 return controller.olympicCommitteeBook;
//                               },
//                             ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 16,
//                     ),
//                     Row(
//                       children: [
//                         const Spacer(),
//                         ButtonStyleS(
//                           colorBorder: Colors.greenAccent,
//                           containborder: true,
//                           isleft: true,
//                           icon: Icons.arrow_forward_ios,
//                           title: "حفظ وانتقال للصفحة التالية",
//                           onTap: () async {
//                             if (!_formKey.currentState!.validate()) {
//                               return;
//                             }
//                             debugPrint(
//                                 'homePageController.departmentId.value ===== ${homePageController.departmentId.value}');
//                             // Show loading dialog using AwesomeDialog
//                             LoadingDialog.showLoadingDialog(
//                                 message: 'جاري الرفع');

//                             // Perform the async operation
//                             try {
//                               var status = await controller.uploadFiles();
//                               Get.back();
//                               homePageController.uploadImagePage.isFull.value =
//                                   status;
//                             } on Exception catch (e) {
//                               debugPrint('uploadFiles ===== $e');
//                             } finally {
//                               // Hide loading dialog
//                               Get.back(); // This will close the AwesomeDialog
//                             }

//                             // Navigate to the next page if the operation was successful
//                             if (homePageController
//                                 .uploadImagePage.isFull.value) {
//                               homePageController.pageChange(
//                                   homePageController.pledgesPage.index);
//                             }
//                           },
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }),
//                             onTap: () async {
//                               try {
//                                 final result = await controller.pickImage();
//                                 if (result != null) {
//                                   controller.graduationDocument = result;
//                                   controller.update();
//                                 }
//                               } catch (e) {
//                                 debugPrint('Error picking image: $e');
//                                 // Handle error
//                               }
//                               return controller.graduationDocument;
//                             },
