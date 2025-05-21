// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:graduate_gtudiesV2/Controllers/home_page_controller.dart';
// import 'package:graduate_gtudiesV2/Models/full_student_data.dart';
// import 'package:graduate_gtudiesV2/view/pages/UploadImage/controller/UploadImageController.dart';
// import 'package:graduate_gtudiesV2/view/pages/UploadImage/widget/upload_image_widget.dart';
// // import 'package:graduate_gtudies/controllers/HomePageController.dart';
// // import 'package:graduate_gtudies/models/ImageInformationModel.dart';
// // import 'package:graduate_gtudies/view/pages/UploadImage/controller/UploadingImagesController.dart';
// // import 'package:graduate_gtudies/view/widgets/UploadImageWidget.dart';

// class UploadImagePage extends StatefulWidget {
//   const UploadImagePage({Key? key}) : super(key: key);

//   @override
//   _UploadImagePageState createState() => _UploadImagePageState();
// }

// class _UploadImagePageState extends State<UploadImagePage> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final HomePageController homePageController = Get.find<HomePageController>();
//   late UploadingImagesController _uploadController;
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
//       _showError('حدث خطأ أثناء تهيئة الصفحة');
//     } finally {
//       if (mounted) {
//         setState(() => _isLoading = false);
//       }
//     }
//   }

//   Future<void> _loadInitialData() async {
//     if (homePageController.fullStudentData.value.imageInformation != null) {
//       setState(() {
//         _imageInfo = homePageController.fullStudentData.value.imageInformation;
//       });
//     }
//   }

//   void _showError(String message) {
//     if (mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(message),
//           backgroundColor: Colors.red,
//           duration: const Duration(seconds: 3),
//         ),
//       );
//     }
//   }

//   void _showSuccess(String message) {
//     if (mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(message),
//           backgroundColor: Colors.green,
//           duration: const Duration(seconds: 2),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('رفع المستندات'),
//           centerTitle: true,
//         ),
//         body: _isLoading
//             ? const Center(child: CircularProgressIndicator())
//             : SingleChildScrollView(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       // Personal Photo
//                       _buildImageUpload(
//                         'إضافة صورة شخصية',
//                         _uploadController.personalPhoto,
//                         _imageInfo?.personalPhoto,
//                         (file) => _uploadController.personalPhoto = file,
//                       ),

//                       // Nationality Card - Front
//                       _buildImageUpload(
//                         'إضافة البطاقة الوطنية (الوجه الأمامي)',
//                         _uploadController.nationalCardFace1,
//                         _imageInfo?.nationalCardFace1,
//                         (file) => _uploadController.nationalCardFace1 = file,
//                       ),

//                       // Nationality Card - Back
//                       _buildImageUpload(
//                         'إضافة البطاقة الوطنية (الوجه الخلفي)',
//                         _uploadController.nationalCardFace2,
//                         _imageInfo?.nationalCardFace2,
//                         (file) => _uploadController.nationalCardFace2 = file,
//                       ),

//                       // Residence Card - Front
//                       _buildImageUpload(
//                         'إضافة بطاقة سكن (الوجه الأمامي)',
//                         _uploadController.residenceCardFace1,
//                         _imageInfo?.residenceCardFace1,
//                         (file) => _uploadController.residenceCardFace1 = file,
//                       ),

//                       // Residence Card - Back
//                       _buildImageUpload(
//                         'إضافة بطاقة سكن (الوجه الخلفي)',
//                         _uploadController.residenceCardFace2,
//                         _imageInfo?.residenceCardFace2,
//                         (file) => _uploadController.residenceCardFace2 = file,
//                       ),

//                       // Graduation Document
//                       _buildImageUpload(
//                         'إضافة وثيقة التخرج',
//                         _uploadController.graduationDocument,
//                         _imageInfo?.graduationDocument,
//                         (file) => _uploadController.graduationDocument = file,
//                       ),

//                       // Conditional fields based on user type/status
//                       if (homePageController.haveFirstStudentAverage.value)
//                         _buildImageUpload(
//                           'إضافة كتاب معدل الطالب الأول',
//                           _uploadController.firstStudentAverage,
//                           _imageInfo?.firstStudentAverage,
//                           (file) =>
//                               _uploadController.firstStudentAverage = file,
//                         ),

//                       if (homePageController
//                           .haveUniversityOrderForDiploma.value)
//                         _buildImageUpload(
//                           'إضافة الأمر الجامعي للدبلوم',
//                           _uploadController.universityOrderForDiploma,
//                           _imageInfo?.universityOrderForDiploma,
//                           (file) => _uploadController
//                               .universityOrderForDiploma = file,
//                         ),

//                       if (homePageController
//                           .haveUniversityOrderForTheMastersDegree.value)
//                         _buildImageUpload(
//                           'إضافة الأمر الجامعي للماجستير',
//                           _uploadController.universityOrderForTheMastersDegree,
//                           _imageInfo?.universityOrderForTheMastersDegree,
//                           (file) => _uploadController
//                               .universityOrderForTheMastersDegree = file,
//                         ),

//                       if (homePageController.havePeopleWithSpecialNeeds.value)
//                         _buildImageUpload(
//                           'إضافة كتاب ذوي الاحتياجات الخاصة',
//                           _uploadController.peopleWithSpecialNeeds,
//                           _imageInfo?.peopleWithSpecialNeeds,
//                           (file) =>
//                               _uploadController.peopleWithSpecialNeeds = file,
//                         ),

//                       if (homePageController.haveMartyrsFoundation.value)
//                         _buildImageUpload(
//                           'إضافة كتاب شهداء المؤسسة',
//                           _uploadController.martyrsFoundation,
//                           _imageInfo?.martyrsFoundation,
//                           (file) => _uploadController.martyrsFoundation = file,
//                         ),

//                       if (homePageController.haveStudyApproval.value)
//                         _buildImageUpload(
//                           'إضافة الموافقة الدراسية',
//                           _uploadController.studyApproval,
//                           _imageInfo?.studyApproval,
//                           (file) => _uploadController.studyApproval = file,
//                         ),

//                       if (homePageController
//                           .haveComputerProficiencyCertificate.value)
//                         _buildImageUpload(
//                           'إضافة شهادة الكفاءة في الحاسوب',
//                           _uploadController.computerProficiencyCertificate,
//                           _imageInfo?.computerProficiencyCertificate,
//                           (file) => _uploadController
//                               .computerProficiencyCertificate = file,
//                         ),

//                       if (homePageController
//                           .haveEnglishLanguageProficiencyCertificate.value)
//                         _buildImageUpload(
//                           'إضافة شهادة الكفاءة في اللغة الإنجليزية',
//                           _uploadController
//                               .englishLanguageProficiencyCertificate,
//                           _imageInfo?.englishLanguageProficiencyCertificate,
//                           (file) => _uploadController
//                               .englishLanguageProficiencyCertificate = file,
//                         ),

//                       if (homePageController
//                           .haveArabicLanguageProficiencyCertificate.value)
//                         _buildImageUpload(
//                           'إضافة شهادة الكفاءة في اللغة العربية',
//                           _uploadController
//                               .arabicLanguageProficiencyCertificate,
//                           _imageInfo?.arabicLanguageProficiencyCertificate,
//                           (file) => _uploadController
//                               .arabicLanguageProficiencyCertificate = file,
//                         ),

//                       if (homePageController.haveIletsCertificate.value)
//                         _buildImageUpload(
//                           'إضافة شهادة الآيلتس',
//                           _uploadController.iletsCertificate,
//                           _imageInfo?.iletsCertificate,
//                           (file) => _uploadController.iletsCertificate = file,
//                         ),

//                       if (homePageController.haveOlympicCommitteeBook.value)
//                         _buildImageUpload(
//                           'إضافة كتاب اللجنة الأولمبية',
//                           _uploadController.olympicCommitteeBook,
//                           _imageInfo?.olympicCommitteeBook,
//                           (file) =>
//                               _uploadController.olympicCommitteeBook = file,
//                         ),

//                       if (homePageController
//                           .haveCooperationMechanismOfNajafGovernorate.value)
//                         _buildImageUpload(
//                           'إضافة آلية تعاون محافظة النجف',
//                           _uploadController
//                               .cooperationMechanismOfNajafGovernorate,
//                           _imageInfo?.cooperationMechanismOfNajafGovernorate,
//                           (file) => _uploadController
//                               .cooperationMechanismOfNajafGovernorate = file,
//                         ),

//                       const SizedBox(height: 20),

//                       // Submit Button
//                       ElevatedButton(
//                         onPressed: _submitForm,
//                         child: const Text('حفظ التغييرات'),
//                         style: ElevatedButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(vertical: 12),
//                         ),
//                       ),
//                       const SizedBox(height: 40),
//                     ],
//                   ),
//                 ),
//               ),
//       ),
//     );
//   }

//   Widget _buildImageUpload(
//     String title,
//     FilePickerResult? currentImage,
//     String? initialImageUrl,
//     Function(FilePickerResult?) onImagePicked,
//   ) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16.0),
//       child: UploadImageWidget(
//         title: title,
//         image: currentImage,
//         initialImage: initialImageUrl,
//         onTap: () async {
//           final result = await _uploadController.pickImage();
//           if (result != null) {
//             onImagePicked(result);
//             if (mounted) {
//               setState(() {});
//             }
//           }
//           return result;
//         },
//       ),
//     );
//   }

//   Future<void> _submitForm() async {
//     if (!_formKey.currentState!.validate()) return;

//     try {
//       setState(() => _isLoading = true);

//       // Call the API to upload all images
//       final success = await _uploadController.uploadFiles();

//       if (success) {
//         _showSuccess('تم حفظ التغييرات بنجاح');
//       } else {
//         _showError('حدث خطأ أثناء حفظ التغييرات');
//       }
//     } catch (e) {
//       debugPrint('Error submitting form: $e');
//       _showError('حدث خطأ غير متوقع');
//     } finally {
//       if (mounted) {
//         setState(() => _isLoading = false);
//       }
//     }
//   }

//   @override
//   void dispose() {
//     Get.delete<UploadingImagesController>();
//     super.dispose();
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Models/full_student_data.dart';
import '../../../Controllers/home_page_controller.dart';
import '../../widget/buttonsyle.dart';
import '../DialogsWindows/loading_dialog.dart';
import 'controller/UploadImageController.dart';
import 'widget/upload_image_widget.dart';

class UploadImagePage extends StatefulWidget {
  const UploadImagePage({super.key});

  @override
  State<UploadImagePage> createState() => _UploadImagePageState();
}

class _UploadImagePageState extends State<UploadImagePage> {
  final HomePageController homePageController = Get.put(HomePageController());
  late final UploadingImagesController _uploadController;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = true;
  ImageInformation? imageInfo;

  @override
  void initState() {
    super.initState();
    _initController();
  }

  Future<void> _initController() async {
    try {
      _uploadController = UploadingImagesController();
      await _loadInitialData();
    } catch (e) {
      debugPrint('Error initializing upload page: $e');
      // Show error to user
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('حدث خطأ في تحميل الصفحة'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _loadInitialData() async {
    if (homePageController.fullStudentData.value.imageInformation != null) {
      imageInfo = homePageController.fullStudentData.value.imageInformation;
      // You might want to update the controller with initial images here
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: GetBuilder<UploadingImagesController>(
        init: _uploadController,
        builder: (controller) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: context.height - 150),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Form(
                    key: _formKey,
                    child: Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        UploadImageWidget(
                          title: "اضافة صورة شخصية",
                          image: controller.personalPhoto,
                          initialImage: imageInfo?.personalPhoto,
                          onTap: () async {
                            try {
                              final result = await controller.pickImage();
                              if (result != null) {
                                controller.personalPhoto = result;
                                controller.update();
                              }
                            } catch (e) {
                              debugPrint('Error picking image: $e');
                              // Optionally show an error message to the user
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('حدث خطأ أثناء تحميل الصورة'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                            return controller.personalPhoto;
                          },
                        ),
                        UploadImageWidget(
                          title: "اضافة بطاقة وطنية وجه",
                          image: controller.nationalCardFace1,
                          initialImage: imageInfo?.nationalCardFace1,
                          onTap: () async {
                            try {
                              final result = await controller.pickImage();
                              if (result != null) {
                                controller.nationalCardFace1 = result;
                                controller.update();
                              }
                            } catch (e) {
                              debugPrint('Error picking image: $e');
                              // Handle error
                            }
                            return controller.nationalCardFace1;
                          },
                        ),
                        UploadImageWidget(
                          title: "اضافة بطاقة وطنية ظهر",
                          image: controller.nationalCardFace2,
                          initialImage: imageInfo?.nationalCardFace2,
                          onTap: () async {
                            try {
                              final result = await controller.pickImage();
                              if (result != null) {
                                controller.nationalCardFace2 = result;
                                controller.update();
                              }
                            } catch (e) {
                              debugPrint('Error picking image: $e');
                              // Handle error
                            }
                            return controller.nationalCardFace2;
                          },
                        ),
                        UploadImageWidget(
                          title: "اضافة بطاقة سكن وجه",
                          image: controller.residenceCardFace1,
                          initialImage: imageInfo?.residenceCardFace1,
                          onTap: () async {
                            try {
                              final result = await controller.pickImage();
                              if (result != null) {
                                controller.residenceCardFace1 = result;
                                controller.update();
                              }
                            } catch (e) {
                              debugPrint('Error picking image: $e');
                              // Handle error
                            }
                            return controller.residenceCardFace1;
                          },
                        ),
                        UploadImageWidget(
                          title: "اضافة بطاقة سكن ظهر",
                          image: controller.residenceCardFace2,
                          initialImage: imageInfo?.residenceCardFace2,
                          onTap: () async {
                            try {
                              final result = await controller.pickImage();
                              if (result != null) {
                                controller.residenceCardFace2 = result;
                                controller.update();
                              }
                            } catch (e) {
                              debugPrint('Error picking image: $e');
                              // Handle error
                            }
                            return controller.residenceCardFace2;
                          },
                        ),
                        UploadImageWidget(
                          title: "اضافة وثيقة تخرج البكالوريوس",
                          image: controller.graduationDocument,
                          initialImage: imageInfo?.graduationDocument,
                          onTap: () async {
                            controller.graduationDocument =
                                await controller.pickImage();
                            controller.update();
                            return controller.graduationDocument;
                          },
                        ),
                        if (homePageController.haveFirstStudentAverage.value)
                          UploadImageWidget(
                            title: "اضافة كتاب معدل الطالب الاول ",
                            image: controller.firstStudentAverage,
                            initialImage: imageInfo?.firstStudentAverage,
                            onTap: () async {
                              controller.firstStudentAverage =
                                  await controller.pickImage();
                              controller.update();
                              return controller.firstStudentAverage;
                            },
                          ),
                        if (homePageController
                            .haveUniversityOrderForDiploma.value)
                          UploadImageWidget(
                            title: "اضافة الامر الجامعي الخاص بالدبلوم",
                            image: controller.universityOrderForDiploma,
                            initialImage: imageInfo?.universityOrderForDiploma,
                            onTap: () async {
                              controller.universityOrderForDiploma =
                                  await controller.pickImage();
                              controller.update();
                              return controller.universityOrderForDiploma;
                            },
                          ),
                        if (homePageController
                            .haveUniversityOrderForTheMastersDegree.value)
                          UploadImageWidget(
                            title: "اضافة الامر الجامعي الخاص بالماجستير",
                            image:
                                controller.universityOrderForTheMastersDegree,
                            initialImage:
                                imageInfo?.universityOrderForTheMastersDegree,
                            onTap: () async {
                              controller.universityOrderForTheMastersDegree =
                                  await controller.pickImage();
                              controller.update();
                              return controller
                                  .universityOrderForTheMastersDegree;
                            },
                          ),
                        if (homePageController.havePeopleWithSpecialNeeds.value)
                          UploadImageWidget(
                            title: "اضافة كتاب ذوي الاحتياجات الخاصة",
                            image: controller.peopleWithSpecialNeeds,
                            initialImage: imageInfo?.peopleWithSpecialNeeds,
                            onTap: () async {
                              controller.peopleWithSpecialNeeds =
                                  await controller.pickImage();
                              controller.update();
                              return controller.peopleWithSpecialNeeds;
                            },
                          ),
                        if (homePageController.havePoliticalPrisoners.value)
                          UploadImageWidget(
                            title: "اضافة كتاب السجناء السياسين",
                            image: controller.politicalPrisoners,
                            initialImage: imageInfo?.politicalPrisoners,
                            onTap: () async {
                              controller.politicalPrisoners =
                                  await controller.pickImage();
                              controller.update();
                              return controller.politicalPrisoners;
                            },
                          ),
                        if (homePageController.haveMartyrsFoundation.value)
                          UploadImageWidget(
                            title: "اضافة كتاب مؤسسة الشهداء",
                            image: controller.martyrsFoundation,
                            initialImage: imageInfo?.martyrsFoundation,
                            onTap: () async {
                              controller.martyrsFoundation =
                                  await controller.pickImage();
                              controller.update();
                              return controller.martyrsFoundation;
                            },
                          ),
                        if (homePageController
                            .haveUniversityOrderRegardingObtainingAnAcademicTitle
                            .value)
                          UploadImageWidget(
                            title: "أمر جامعي بالحصول على لقب العلمي",
                            image: controller
                                .universityOrderRegardingObtainingAnAcademicTitle,
                            initialImage: imageInfo
                                ?.universityOrderRegardingObtainingAnAcademicTitle,
                            onTap: () async {
                              controller
                                      .universityOrderRegardingObtainingAnAcademicTitle =
                                  await controller.pickImage();
                              controller.update();
                              return controller
                                  .universityOrderRegardingObtainingAnAcademicTitle;
                            },
                          ),
                        if (homePageController.haveStudyApproval.value)
                          UploadImageWidget(
                            title: "كتاب عدم ممانعة",
                            image: controller.studyApproval,
                            initialImage: imageInfo?.studyApproval,
                            onTap: () async {
                              controller.studyApproval =
                                  await controller.pickImage();
                              controller.update();
                              return controller.studyApproval;
                            },
                          ),
                        if (homePageController
                            .haveComputerProficiencyCertificate.value)
                          UploadImageWidget(
                            title: "شهادة كفاءة الحاسوب",
                            image: controller.computerProficiencyCertificate,
                            initialImage:
                                imageInfo?.computerProficiencyCertificate,
                            onTap: () async {
                              controller.computerProficiencyCertificate =
                                  await controller.pickImage();
                              controller.update();
                              return controller.computerProficiencyCertificate;
                            },
                          ),
                        if (homePageController
                            .haveEnglishLanguageProficiencyCertificate.value)
                          UploadImageWidget(
                            title: "شهادة الامتحان الوطني  ",
                            image: controller
                                .englishLanguageProficiencyCertificate,
                            initialImage: imageInfo
                                ?.englishLanguageProficiencyCertificate,
                            onTap: () async {
                              controller.englishLanguageProficiencyCertificate =
                                  await controller.pickImage();
                              controller.update();
                              return controller
                                  .englishLanguageProficiencyCertificate;
                            },
                          ),
                        if (homePageController
                            .haveArabicLanguageProficiencyCertificate.value)
                          UploadImageWidget(
                            title: "شهادة كفاءة اللغة العربية",
                            image:
                                controller.arabicLanguageProficiencyCertificate,
                            initialImage:
                                imageInfo?.arabicLanguageProficiencyCertificate,
                            onTap: () async {
                              controller.arabicLanguageProficiencyCertificate =
                                  await controller.pickImage();
                              controller.update();
                              return controller
                                  .arabicLanguageProficiencyCertificate;
                            },
                          ),
                        if (homePageController.haveIletsCertificate.value)
                          UploadImageWidget(
                            title: "شهادة ايلتس",
                            image: controller.iletsCertificate,
                            initialImage: imageInfo?.iletsCertificate,
                            onTap: () async {
                              controller.iletsCertificate =
                                  await controller.pickImage();
                              controller.update();
                              return controller.iletsCertificate;
                            },
                          ),
                        if (homePageController.haveOlympicCommitteeBook.value)
                          UploadImageWidget(
                            title: "كتاب اللجنة الأولمبية",
                            image: controller.olympicCommitteeBook,
                            initialImage: imageInfo?.olympicCommitteeBook,
                            onTap: () async {
                              controller.olympicCommitteeBook =
                                  await controller.pickImage();
                              controller.update();
                              return controller.olympicCommitteeBook;
                            },
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      ButtonStyleS(
                        colorBorder: Colors.greenAccent,
                        containborder: true,
                        isleft: true,
                        icon: Icons.arrow_forward_ios,
                        title: "حفظ وانتقال للصفحة التالية",
                        onTap: () async {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          debugPrint(
                              'homePageController.departmentId.value ===== ${homePageController.departmentId.value}');
                          // Show loading dialog using AwesomeDialog
                          LoadingDialog.showLoadingDialog(
                              message: 'جاري الرفع');

                          // Perform the async operation
                          try {
                            var status = await controller.uploadFiles();
                            Get.back();
                            homePageController.uploadImagePage.isFull.value =
                                status;
                          } on Exception catch (e) {
                            debugPrint('uploadFiles ===== $e');
                          } finally {
                            // Hide loading dialog
                            Get.back(); // This will close the AwesomeDialog
                          }

                          // Navigate to the next page if the operation was successful
                          if (homePageController.uploadImagePage.isFull.value) {
                            homePageController.pageChange(
                                homePageController.pledgesPage.index);
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
