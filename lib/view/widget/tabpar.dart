import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:printing/printing.dart';

import '../../Services/base_route.dart';
import '../../Controllers/home_page_controller.dart';
import '../../Controllers/PrintDataController.dart';
import '../../theme.dart';
import '../pages/DialogsWindows/loading_dialog.dart';
import '../pages/print_page.dart';
import 'buttonsyle.dart';

class TabPar extends StatelessWidget {
  const TabPar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      color: KprimeryColor,
      child: Theme(
        data: ThemeData(
            scrollbarTheme: const ScrollbarThemeData(
          trackBorderColor: WidgetStatePropertyAll(Colors.transparent),
          trackColor: WidgetStatePropertyAll(Colors.transparent),
          thumbColor: WidgetStatePropertyAll(Colors.transparent),
        )),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              LogoAndText(),
              GetBuilder<HomePageController>(builder: (homePageController) {
                return Column(
                  children: [
                    ButtonStyleS(
                      containborder:
                          homePageController.counter == 0 ? true : false,
                      icon: Icons.person,
                      iconColor:
                          homePageController.personalInformation.isFull.value
                              ? Colors.green
                              : Colors.black,
                      colorBorder:
                          homePageController.personalInformation.isFull.value
                              ? Colors.green
                              : Colors.red,
                      title: "المعلومات الشخصية",
                      onTap: () {
                        homePageController.pageChange(0);
                      },
                    ),
                    ButtonStyleS(
                      containborder:
                          homePageController.counter == 3 ? true : false,
                      icon: Icons.badge,
                      iconColor:
                          homePageController.functionalInformation.isFull.value
                              ? Colors.green
                              : Colors.black,
                      title: "المعلومات الوظيفية",
                      onTap: () {
                        if (homePageController
                            .personalInformation.isFull.value) {
                          homePageController.pageChange(
                              homePageController.functionalInformation.index);
                        }
                      },
                    ),
                    ButtonStyleS(
                      containborder:
                          homePageController.counter == 2 ? true : false,
                      icon: Icons.card_membership,
                      title: "المعلومات الاكاديمية",
                      iconColor:
                          homePageController.academicInformation.isFull.value
                              ? Colors.green
                              : Colors.black,
                      onTap: () {
                        if (homePageController
                            .functionalInformation.isFull.value) {
                          homePageController.pageChange(
                              homePageController.academicInformation.index);
                        }
                      },
                    ),
                    ButtonStyleS(
                      containborder:
                          homePageController.counter == 1 ? true : false,
                      icon: Icons.login,
                      iconColor:
                          homePageController.submissionChannel.isFull.value
                              ? Colors.green
                              : Colors.black,
                      title: "قناة التقديم",
                      onTap: () {
                        if (homePageController
                            .academicInformation.isFull.value) {
                          homePageController.pageChange(
                              homePageController.submissionChannel.index);
                        }
                      },
                    ),
                    ButtonStyleS(
                      containborder:
                          homePageController.counter == 4 ? true : false,
                      icon: Icons.medical_information,
                      title: "معلومات اخرى",
                      iconColor:
                          homePageController.otherInformation.isFull.value
                              ? Colors.green
                              : Colors.black,
                      onTap: () {
                        if (homePageController
                            .academicInformation.isFull.value) {
                          homePageController.pageChange(
                              homePageController.otherInformation.index);
                        }
                      },
                    ),
                    ButtonStyleS(
                      containborder:
                          homePageController.counter == 5 ? true : false,
                      icon: Icons.upload_file,
                      title: "تحميل المستمسكات",
                      iconColor: homePageController.uploadImagePage.isFull.value
                          ? Colors.green
                          : Colors.black,
                      onTap: () {
                        if (homePageController.otherInformation.isFull.value) {
                          homePageController.pageChange(
                              homePageController.uploadImagePage.index);
                        }
                      },
                    ),
                    ButtonStyleS(
                      containborder:
                          homePageController.counter == 6 ? true : false,
                      icon: Icons.plagiarism_rounded,
                      title: "التعهد",
                      iconColor: homePageController.pledgesPage.isFull.value
                          ? Colors.green
                          : Colors.black,
                      onTap: () {
                        if (homePageController.uploadImagePage.isFull.value) {
                          homePageController
                              .pageChange(homePageController.pledgesPage.index);
                        }
                      },
                    ),
                    ButtonStyleS(
                      icon: Icons.print,
                      title: "معاينة",
                      onTap: () async {
                        try {
                          // Show loading dialog using AwesomeDialog
                          LoadingDialog.showLoadingDialog(message: loadingText);
                          StudentDataController controller =
                              Get.put(StudentDataController());
                          await controller.getDataToPrint();
                          if (homePageController.informationModule != null) {
                            await Printing.sharePdf(
                                filename:
                                    '${controller.homePageController.fullStudentData.value.serial ?? 'document'}',
                                bytes: await PrintingUserPage()
                                    .printingPage(controller));
                            debugPrint("PDF shared successfully!");
                          } else {
                            debugPrint(
                                "PDF generation skipped, fullStudentData is null.");
                          }
                        } on FileSystemException catch (fsEx) {
                          debugPrint("File system error: ${fsEx.message}");
                        } on DioException catch (dioEx) {
                          debugPrint("Network error: ${dioEx.message}");
                        } on FormatException catch (fmtEx) {
                          debugPrint("Format error: ${fmtEx.message}");
                        } catch (ex) {
                          debugPrint(
                              "An unexpected error occurred: ${ex.toString()}");
                        } finally {
                          // Hide loading dialog
                          Get.back(); // This will close the AwesomeDialog
                        }
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.15,
                    ),
                    const Text("© وحدة الحوكمة الالكترونية"),
                  ],
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Column LogoAndText() {
    return Column(
      children: [
        Container(
            constraints: const BoxConstraints(maxHeight: 100),
            child:
                const Image(image: ExactAssetImage("assets/icons/Logo.png"))),
        const SizedBox(
          height: 2,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: const Color.fromARGB(44, 137, 137, 137),
              borderRadius: BorderRadius.circular(7)),
          child: Text(
            "استمارة التعهد والتعليمات للقبول للدراسات العليا",
            style: HeadLine1,
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
