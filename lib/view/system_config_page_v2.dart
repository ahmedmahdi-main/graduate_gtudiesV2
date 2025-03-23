import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:graduate_gtudiesV2/view/pages/DialogsWindows/loading_dialog.dart';
import 'package:graduate_gtudiesV2/view/pages/print_page.dart';
import 'package:graduate_gtudiesV2/view/widget/buttonsyle.dart';
import 'package:graduate_gtudiesV2/view/widget/custom%20switcher.dart';
import 'package:graduate_gtudiesV2/view/widget/titleandtextstyle.dart';
import 'package:printing/printing.dart';

import '../Models/full_student_data.dart';
import '../Services/Session.dart';
import '../Services/base_route.dart';
import '../ValidatorFunction/text_validator.dart';
import '../controller/LogoutController.dart';
import '../controller/home_page_controller.dart';
import '../controller/PrintDataController.dart';
import '../controller/serial_controller.dart';
import '../controller/SystemInformationController.dart';
import '../theme.dart';

class SystemConfigPageV2 extends StatelessWidget {
  SystemConfigPageV2({super.key});

  final HomePageController homePageController = Get.put(HomePageController());
  final LogoutController logoutController = Get.put(LogoutController());
  final SystemInformationController systemInformationController =
      Get.put(SystemInformationController());
  final SerialController serialController = Get.put(SerialController());
  final TextEditingController messageController = TextEditingController();
  final RxBool dataStatus = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إعدادات النظام'),
        centerTitle: true,
      ),
      body: GetBuilder<HomePageController>(builder: (controller) {
        final systemConfig = controller.fullStudentData.value.systemConfig;
        final studentName = controller
            .fullStudentData.value.personalInformation?.first
            .getFullName();
        final avatarUrl = controller
                .fullStudentData.value.imageInformation?.personalPhoto ??
            'https://th.bing.com/th/id/R.c09c979549603cf39105ff1ec8375fd7?rik=GZ12n01tDMaQTg&pid=ImgRaw&r=0';

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildHeaderSection(avatarUrl, studentName),
            const SizedBox(height: 20),
            _buildSystemStatus(systemConfig),
            const SizedBox(height: 20),
            _buildFormMessages(systemConfig),
          ],
        );
      }),
    );
  }

  Widget _buildHeaderSection(String avatarUrl, String? studentName) {
    return Row(
      children: [
        GFAvatar(
          radius: 50,
          backgroundImage: NetworkImage(avatarUrl),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                studentName ?? 'اسم الطالب غير متوفر',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              ButtonStyleS(
                colorBorder: Colors.black,
                containborder: true,
                title: 'تسجيل خروج',
                icon: Icons.logout,
                iconColor: Colors.red,
                aliment: Alignment.center,
                SelectedbackgroundColorbefore: Colors.red,
                onTap: () async {
                  await logoutController.logout();
                  await clearSession();
                  Get.offAllNamed("/");
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSystemStatus(SystemConfig? systemConfig) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: _buildInfoRow(
        ' : حالة الاستمارة ',
        systemConfig?.opensystem == 'on' ? 'مفتوحة' : 'مغلقة',
      ),
    );
  }

  Widget _buildFormMessages(SystemConfig? systemConfig) {
    final formMessages = systemConfig?.formmessage ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text(
          'معلومات الاستمارة',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: KTextColor,
          ),
        ),
        const SizedBox(height: 20),
        if (formMessages.isEmpty) const Center(child: Text('لا توجد رسائل')),
        ...formMessages.map((message) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Colors.black),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildInfoRow(' :رقم الاستمارة ', message.serial.toString()),
                  _buildInfoRow(' : الحالة   ', message.audit ?? 'لا يوجد'),
                  _buildInfoRow('  : الرسالة   ', message.message ?? 'لا يوجد'),
                  _buildInfoRow(
                    ' : تاريخ اخر تعديل  ',
                    message.modifiedAt ?? 'لا يوجد',
                  ),
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
        }).toList(),
        const SizedBox(height: 20),
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
                      controller: messageController,
                      title: "سبب التعديل",
                      validator: (value) =>
                          validateTextWithoutAnyCharacterNumber(value),
                      onchange: (value) {},
                    ),
                    const SizedBox(height: 20),
                    ButtonStyleS(
                      colorBorder: Colors.black,
                      containborder: true,
                      isleft: true,
                      icon: Icons.send,
                      title: "ارسال طلب تعديل",
                      onTap: () async {
                        await serialController
                            .requestEdit(messageController.text);
                      },
                    ),
                  ],
                )
              : Container();
        }),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: KTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
