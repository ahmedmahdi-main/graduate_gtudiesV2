import 'package:dio/dio.dart' as dioo;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduate_gtudiesV2/Services/base_route.dart';
import '../../../../Models/image_Information.dart';
import '../../../../Services/costom_dialog.dart';
import '../../../../Services/session.dart';
import '../../../../Services/session_error_handler.dart';
import '../../../../Controllers/home_page_controller.dart';

class UploadingImagesController extends GetxController with SessionErrorHandler{
  
  FilePickerResult? martyrsFoundation;
  FilePickerResult? peopleWithSpecialNeeds;
  FilePickerResult? cooperationMechanismOfNajafGovernorate;
  FilePickerResult? politicalPrisoners;
  FilePickerResult? graduationDocument;
  FilePickerResult? firstStudentAverage;
  FilePickerResult? universityOrderForTheMastersDegree;
  FilePickerResult? universityOrderForDiploma;
  FilePickerResult? universityOrderRegardingObtainingAnAcademicTitle;
  FilePickerResult? studyApproval;
  FilePickerResult? computerProficiencyCertificate;
  FilePickerResult? englishLanguageProficiencyCertificate;
  FilePickerResult? arabicLanguageProficiencyCertificate;
  FilePickerResult? iletsCertificate;
  FilePickerResult? olympicCommitteeBook;
  FilePickerResult? nationalCardFace1;
  FilePickerResult? nationalCardFace2;
  FilePickerResult? residenceCardFace1;
  FilePickerResult? residenceCardFace2;
  FilePickerResult? personalPhoto;
  FilePickerResult? serviceFeed;
  Map<String, String>? session;

  @override
  void onInit() async {
    super.onInit();
    session = await getSession();
    fileList = <ImageInformation>[];
  }

  List<ImageInformation> fileList = <ImageInformation>[];
  HomePageController homePageController = Get.put(HomePageController());

  void addFileToMultipartList(FilePickerResult? fileField, String fileName) {
    if (fileField != null) {
      dioo.MultipartFile image = dioo.MultipartFile.fromBytes(
        fileField.files.single.bytes as List<int>,
        filename: fileField.files.single.name,
      );
      fileList.add(ImageInformation(fileName, image));
    } else {
      fileList.add(ImageInformation(fileName, null));
    }
  }

  void fullFileList() {
    fileList = <ImageInformation>[];
    addFileToMultipartList(personalPhoto, 'personal_photo');
    addFileToMultipartList(nationalCardFace1, 'National_card_face_1');
    addFileToMultipartList(nationalCardFace2, 'National_card_face_2');
    addFileToMultipartList(residenceCardFace1, 'Residence_card_face_1');
    addFileToMultipartList(residenceCardFace2, 'Residence_card_face_2');
    addFileToMultipartList(martyrsFoundation, 'Martyrs_Foundation');
    addFileToMultipartList(
        peopleWithSpecialNeeds, 'People_with_special_needs');
    addFileToMultipartList(
        serviceFeed, 'serviceFeed');
    addFileToMultipartList(
        cooperationMechanismOfNajafGovernorate, 'CooperationMechanismOfNajafGovernorate');
    addFileToMultipartList(politicalPrisoners, 'Political_prisoners');
    addFileToMultipartList(graduationDocument, 'Graduation_document');
    addFileToMultipartList(firstStudentAverage, 'First_student_average');
    addFileToMultipartList(universityOrderForTheMastersDegree,
        'University_order_for_the_masters_degree');
    addFileToMultipartList(
        universityOrderForDiploma, 'University_order_for_diploma');
    addFileToMultipartList(
        universityOrderRegardingObtainingAnAcademicTitle,
        'University_order_regarding_obtaining_an_academic_title');
    addFileToMultipartList(
        computerProficiencyCertificate, 'Computer_proficiency_certificate');
    addFileToMultipartList(englishLanguageProficiencyCertificate,
        'English_language_proficiency_certificate');
    addFileToMultipartList(arabicLanguageProficiencyCertificate,
        'Arabic_language_proficiency_certificate');
    addFileToMultipartList(iletsCertificate, 'ilets_certificate');
    addFileToMultipartList(olympicCommitteeBook, 'Olympic_Committee_book');
    addFileToMultipartList(studyApproval, 'Study_approval');
  }

  Future<bool> uploadFiles() async {
    fullFileList();
    try {
      var dio = dioo.Dio();
      final formData = dioo.FormData.fromMap({
        fileList[0].imageName: fileList[0].image,
        fileList[1].imageName: fileList[1].image,
        fileList[2].imageName: fileList[2].image,
        fileList[3].imageName: fileList[3].image,
        fileList[4].imageName: fileList[4].image,
        fileList[5].imageName: fileList[5].image,
        fileList[6].imageName: fileList[6].image,
        fileList[7].imageName: fileList[7].image,
        fileList[8].imageName: fileList[8].image,
        fileList[9].imageName: fileList[9].image,
        fileList[10].imageName: fileList[10].image,
        fileList[11].imageName: fileList[11].image,
        fileList[12].imageName: fileList[12].image,
        fileList[13].imageName: fileList[13].image,
        fileList[14].imageName: fileList[14].image,
        fileList[15].imageName: fileList[15].image,
        fileList[16].imageName: fileList[16].image,
        fileList[17].imageName: fileList[17].image,
        fileList[18].imageName: fileList[18].image,
        'DepartmentId': '${homePageController.departmentId.value}' //TODO Department Id
      });

      final response = await dio.post(
        '$baseRoute/St_insertdataimage',
        data: formData,
        options: dioo.Options(
          headers: {
            'Authorization': 'Bearer ${session!['token']}',
            'Content-Type': 'multipart/form-data'
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        DilogCostom.dilogSecss(
            isErorr: false,
            title: response.data['message'].toString(),
            icons: Icons.check,
            color: Colors.greenAccent);
        return true;
      } else {
        DilogCostom.dilogSecss(
            isErorr: true,
            title: 'تم الرفع بنجاح',
            icons: Icons.close,
            color: Colors.redAccent);
      }
    } on dioo.DioException catch (e) {
      handleDioError(e);
    } catch (e) {
      DilogCostom.dilogSecss(
          isErorr: true,
          title: '$eهناك خطأ',
          icons: Icons.close,
          color: Colors.redAccent);
    }
    return false;
  }


  Future<FilePickerResult?> pickImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ["png", "jpg"],
        onFileLoading: (p0) {
          debugPrint(
              "---------------------------------------$p0--------------------------");
        },
      );

      //debugPrint(result?.files.single.name);
      if (result?.files != null) {
        if (result?.files.single.extension?.toLowerCase() != "png" &&
            result?.files.single.extension?.toLowerCase() != "jpg") {
          throw "يرجى رفع الصوره بنوع jpg او png";
        } else {
          return result;
        }
      }
    } catch (e) {
      debugPrint('----------------------$e');
      DilogCostom.dilogSecss(
          isErorr: true,
          title: e.toString(),
          icons: Icons.close,
          color: Colors.redAccent);
    }
    return null;
  }
}
