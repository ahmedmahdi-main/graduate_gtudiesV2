import 'dart:io';
import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduate_gtudiesV2/controller/serial_controller.dart';
import 'package:graduate_gtudiesV2/theme.dart';
import 'package:printing/printing.dart';

import '../../../Services/DilogCostom.dart';
import '../../../Services/base_route.dart';
import '../../../controller/home_page_controller.dart';
import '../../../controller/PrintDataController.dart';
import '../../widget/buttonsyle.dart';
import '../DialogsWindows/loading_dialog.dart';
import '../print_page.dart';

class PledgesPage extends StatelessWidget {
  PledgesPage({super.key});

  SerialController serial = Get.put(SerialController());
  RxBool value1 = false.obs;
  RxBool value2 = false.obs;
  RxBool value3 = false.obs;
  RxBool value4 = false.obs;
  HomePageController homePageController = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Obx(() {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              if (homePageController.haveStudyApproval.value)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                        value: value1.value,
                        onChanged: (value) {
                          value1.value = !value1.value;
                        }),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      "- اتعهد بالاستمرار في الخدمة الوظيفية بعد حصولي على الشهادة ضعف المدة الدراسية",
                      style: HeadLine,
                    )
                  ],
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                      value: value2.value,
                      onChanged: (value) {
                        value2.value = !value2.value;
                      }),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    "- اتعهد بعدم ترقين قيدي او الغاء قبولي او انهاء علاقتي في الدراسات العليا سابقا",
                    style: HeadLine,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                      value: value3.value,
                      onChanged: (value) {
                        value3.value = !value3.value;
                      }),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    "- اتعهد بصحة كافة المعلومات اعلاه وبخلاف ذلك اتحمل كافة المسؤولبة  القانونية",
                    style: HeadLine,
                  )
                ],
              ),
              if (homePageController.privateAdmissionChannel.value)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                        value: value4.value,
                        onChanged: (value) {
                          value4.value = !value4.value;
                        }),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      " - اتعهد بدفع  الاجور عن الدراسة عند القبول على دفعتين عند القبول",
                      style: HeadLine,
                    )
                  ],
                ),
              const Spacer(),
              ButtonStyleS(
                colorBorder: Colors.greenAccent,
                containborder: true,
                isleft: true,
                icon: Icons.arrow_forward_ios,
                title: "حفظ ورفع الاستمارة",
                onTap: () async {
                  final completer = Completer<bool>();
                  await AwesomeDialog(
                    context: context,
                    width: 600,
                    dialogType: DialogType.question,
                    animType: AnimType.scale,
                    title: 'تأكيد',
                    desc: 'هل أنت متأكد من رفع الاستمارة؟',
                    btnCancelOnPress: () => completer.complete(false),
                    btnOkText: 'نعم',
                    btnCancelText: 'لا',
                    btnOkIcon: Icons.check_circle,
                    btnCancelIcon: Icons.cancel,
                    btnOkOnPress: () => completer.complete(true),
                  ).show();

                  bool confirm = await completer.future;

                  if (confirm) {
                    try {
                      if (value2.value && value3.value) {
                        if (homePageController.haveStudyApproval.value) {
                          if (!value1.value) {
                            DilogCostom.dilogSecss(
                                isErorr: true,
                                title: 'يجب الموافقة على كل التعهدات',
                                icons: Icons.close,
                                color: Colors.redAccent);
                            return;
                          }
                        }
                        if (homePageController.privateAdmissionChannel.value) {
                          if (!value4.value) {
                            DilogCostom.dilogSecss(
                                isErorr: true,
                                title: 'يجب الموافقة على كل التعهدات',
                                icons: Icons.close,
                                color: Colors.redAccent);
                            return;
                          }
                        }
                        var status = await serial.setSerial();
                        if (status) {
                          // Show loading dialog using AwesomeDialog
                          LoadingDialog.showLoadingDialog(message: loadingText);

                          homePageController.pledgesPage.isFull.value = status;
                          try {
                            homePageController.fullStudentData.value =
                                await homePageController.fullStudent();

                            StudentDataController studentDataController =
                                Get.put(StudentDataController());
                            await studentDataController.getDataToPrint();

                            if (homePageController.pledgesPage.isFull.value) {
                              await Printing.layoutPdf(
                                  usePrinterSettings: true,
                                  onLayout: (pageFormat) async =>
                                      await PrintingUserPage()
                                          .printingPage(studentDataController));
                              debugPrint("PDF shared successfully!");
                            } else {
                              debugPrint(
                                  "PDF generation skipped, fullStudentData is null.");
                            }
                            Get.back();
                          } on FileSystemException catch (fsEx) {
                            debugPrint("File system error: ${fsEx.message}");
                          } on DioError catch (dioEx) {
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
                        }

                        print(
                            "-------------------------ok-------------------------------");
                        Get.offAllNamed('/SystemConfigPageRout');
                      } else {
                        DilogCostom.dilogSecss(
                            isErorr: true,
                            title: 'يجب الموافقة على كل التعهدات',
                            icons: Icons.close,
                            color: Colors.redAccent);

                        print(
                            "-------------------------Not-------------------------------");
                      }
                    } catch (ex) {
                      debugPrint(
                          'setSerial ----------------- \${ex.toString()}');
                    }
                  }
                },
              ),
              const Spacer(),
            ],
          );
        }),
      ),
    );
  }
}
