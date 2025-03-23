import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:graduate_gtudiesV2/controller/serial_controller.dart';
import 'package:graduate_gtudiesV2/view/pages/DialogsWindows/loading_dialog.dart';
import 'package:graduate_gtudiesV2/view/pages/print_page.dart';
import 'package:graduate_gtudiesV2/view/widget/GifImageCostom.dart';
import 'package:graduate_gtudiesV2/view/widget/buttonsyle.dart';
import 'package:graduate_gtudiesV2/view/widget/custom%20switcher.dart';
import 'package:graduate_gtudiesV2/view/widget/titleandtextstyle.dart';
import 'package:printing/printing.dart';
import '../../theme.dart';
import '../Models/full_student_data.dart';
import '../Services/base_route.dart';
import '../ValidatorFunction/text_validator.dart';
import '../controller/home_page_controller.dart';
import '../controller/PrintDataController.dart';
import '../controller/SystemInformationController.dart';

class SystemConfigPage extends StatelessWidget {
  // var receivedData = Get.arguments;
  SystemConfig? systemConfig;
  String SystemConfigPageRout = 'SystemConfigPage';
  RxBool dataStatus = false.obs;

  SystemConfigPage({Key? key, this.systemConfig}) : super(key: key);
  HomePageController homePageController = Get.find();
  SystemInformationController systemInformationController =
      Get.put(SystemInformationController());
  SerialController serialController = Get.put(SerialController());
  TextEditingController message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SystemInformationController>(
        builder: (systemInformationController) {
      return systemInformationController.isLoading.value
          ? const Center(
              child: GifImageCostom(
                Gif: "assets/icons/pencil.gif",
                width: 100,
              ),
            )
          : GetBuilder<HomePageController>(builder: (controller) {
              systemConfig = controller.fullStudentData.value.systemConfig;
              var systemOpen =
                  controller.fullStudentData.value.systemConfig?.opensystem !=
                      'off';
              var AvatarUrl = controller
                      .fullStudentData.value.imageInformation?.personalPhoto ??
                  'https://th.bing.com/th/id/R.c09c979549603cf39105ff1ec8375fd7?rik=GZ12n01tDMaQTg&pid=ImgRaw&r=0';
              return Scaffold(
                body: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildSystemInfo(),
                            systemOpen
                                ? Column(
                                    children: [
                                      const SizedBox(height: 40),
                                      GFAvatar(
                                        radius: 75,
                                        backgroundImage:
                                            NetworkImage(AvatarUrl!),
                                      ),
                                      _buildFormMessages(),
                                    ],
                                  )
                                : Container(),
                          ],
                        ),
                      )),
                ),
              );
            });
    });
  }

  Widget _buildSystemInfo() {
    return Card(
      color: KSecondryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'معلومات النظام',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color:
                      KTextColor, // Assuming you have a text color defined in your theme
                ),
              ),
            ),
            const SizedBox(height: 10),
            _buildInfoRow(' حالة الاستمارة: ',
                systemConfig?.opensystem == 'on' ? 'مفتوحة' : 'مغلقة'),
          ],
        ),
      ),
    );
  }

  Widget _buildFormMessages() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'معلومات الاستمارة',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: KTextColor,
          ),
        ),
        const SizedBox(height: 10),
        ...systemConfig?.formmessage?.map((message) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildInfoRow('رقم الاستمارة  :  ', message.serial.toString()),
                  _buildInfoRow('الحالة : ', message.audit ?? 'N/A'),
                  _buildInfoRow('الرسالة : ', message.message ?? 'N/A'),
                  _buildInfoRow('تاريخ اخر تعديل: ', message.modifiedAt ?? 'لا يوجد'),
                 // _buildInfoRow('تاريخ اخر تعديل: ', message.auditAt ?? 'لا يوجد'),

                  // Conditionally display the button if auditAt is not null
                  if (message.approveAt != null && message.modifiedAt == null)
                    ElevatedButton(
                      onPressed: () {
                        Get.offNamed('/DesktopHomePage');
                      },
                      child: const Text('دخول الى الاستمارة'),
                    ),
                ],
              ),
            ),
          );
        }).toList() ??
            [const Center(child: Text('غير مدقق'))]
,

        Obx(() {
          return CustomSwitcher(
            initialValue: dataStatus.value,
            onChanged: (value) {
              dataStatus.value = value;
            },
            title: 'هل تريد ارسال طلب تعديل',
          );
        }),
        Obx(() {
          return dataStatus.value
              ? Column(
                  children: [
                    TitleAndTextStyle(
                      width: 300,
                      controller: message,
                      title: "سبب التعديل",
                      validator: (value) =>
                          validateTextWithoutAnyCharacterNumber(value),
                      onchange: (value) {},
                    ),
                    ButtonStyleS(
                      colorBorder: Colors.greenAccent,
                      containborder: true,
                      isleft: true,
                      icon: Icons.pending,
                      title: "ارسال طلب تعديل",
                      onTap: () async {
                        await serialController.requestEdit(message.text);
                      },
                    ),
                  ],
                )
              : Container();
        }),
        ButtonStyleS(
          colorBorder: Colors.greenAccent,
          containborder: true,
          isleft: true,
          icon: Icons.pending,
          title: "طباعة استمارة",
          onTap: () async {
            try {
              // Show loading dialog using AwesomeDialog
              LoadingDialog.showLoadingDialog(message: loadingText);

              // Initialize the StudentDataController and fetch data
              StudentDataController controller = Get.put(StudentDataController());
              await controller.getDataToPrint();

              if (homePageController.informationModule != null) {
                await Printing.layoutPdf(
                    usePrinterSettings: true,
                    onLayout: (pageFormat) async {
                      // Ensure this returns Uint8List for PDF data
                      return await PrintingUserPage().printingPage(controller);
                    }
                );
                debugPrint("PDF shared successfully!");
              } else {
                debugPrint("PDF generation skipped, fullStudentData is null.");
              }
            } on FileSystemException catch (fsEx) {
              debugPrint("File system error: ${fsEx.message}");
            } on DioException catch (dioEx) {
              debugPrint("Network error: ${dioEx.message}");
            } on FormatException catch (fmtEx) {
              debugPrint("Format error: ${fmtEx.message}");
            } catch (ex) {
              debugPrint("An unexpected error occurred: ${ex.toString()}");
            } finally {
              // Hide loading dialog
              Get.back(); // This will close the AwesomeDialog
            }
          }
,
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: KTextColor,
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                // color: KtextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
