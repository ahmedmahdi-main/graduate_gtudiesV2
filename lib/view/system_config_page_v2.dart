import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Services/Session.dart';
import '../controller/LogoutController.dart';
import '../controller/home_page_controller.dart';
import '../controller/serial_controller.dart';
import '../controller/SystemInformationController.dart';

class SystemConfigPageV2 extends StatelessWidget {
  SystemConfigPageV2({super.key});

  final HomePageController homePageController = Get.put(HomePageController());
  final LogoutController logoutController = Get.put(LogoutController());
  // System information controller
  final SystemInformationController systemInformationController =
      Get.put(SystemInformationController());
  final SerialController serialController = Get.put(SerialController());
  final TextEditingController messageController = TextEditingController();
  final RxBool dataStatus = false.obs;

  // Colors
  final Color primaryColor = const Color(0xFF2E7D32);
  final Color secondaryColor = const Color(0xFFE8F5E9);
  final Color accentColor = const Color(0xFF4CAF50);
  final Color textColor = Colors.grey[800]!;
  final Color errorColor = const Color(0xFFD32F2F);

  // Text validator function
  String? validateTextWithoutAnyCharacterNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'هذا الحقل مطلوب';
    }
    // Add your validation logic here
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 600;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: 800,
                  minHeight: size.height - kToolbarHeight - 24,
                ),
                margin: EdgeInsets.symmetric(
                  vertical: isSmallScreen ? 16 : 32,
                  horizontal: isSmallScreen ? 16 : 24,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    children: [
                      // Background pattern
                      Positioned.fill(
                        child: Opacity(
                          opacity: 0.03,
                          child: Image.asset(
                            "assets/icons/Logo.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      // Content
                      SingleChildScrollView(
                        padding: EdgeInsets.all(isSmallScreen ? 16.0 : 24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildHeaderSection(),
                            const SizedBox(height: 24),
                            _buildSystemStatusSection(),
                            const SizedBox(height: 24),
                            _buildFormMessagesSection(),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return GetBuilder<HomePageController>(builder: (controller) {
      final studentName =
          controller.fullStudentData.value.personalInformation?.isNotEmpty ==
                  true
              ? controller.fullStudentData.value.personalInformation!.first
                  .getFullName()
              : 'الاسم غير متوفر';
      final avatarUrl = controller
              .fullStudentData.value.imageInformation?.personalPhoto ??
          'https://th.bing.com/th/id/R.c09c979549603cf39105ff1ec8375fd7?rik=GZ12n01tDMaQTg&pid=ImgRaw&r=0';

      return Column(
        children: [
          // Profile Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: primaryColor,
                          width: 3,
                        ),
                      ),
                      child: ClipOval(
                        child: Image.network(
                          avatarUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.grey[400],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Icon(
                        Icons.check_circle,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  studentName ?? 'اسم الطالب غير متوفر',
                  style: GoogleFonts.tajawal(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  'لوحة التحكم',
                  style: GoogleFonts.tajawal(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 16),
                // Logout Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      await logoutController.logout();
                      await clearSession();
                      Get.offAllNamed("/");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: errorColor.withOpacity(0.9),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    icon: const Icon(Icons.logout, size: 20),
                    label: const Text('تسجيل خروج'),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget _buildSystemStatusSection() {
    return GetBuilder<HomePageController>(builder: (controller) {
      final systemConfig = controller.fullStudentData.value.systemConfig;
      final isOpen = systemConfig?.opensystem == 'on';

      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: isOpen
                ? Colors.green.withOpacity(0.3)
                : Colors.grey.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(
                  isOpen ? Icons.check_circle : Icons.info_outline,
                  color: isOpen ? Colors.green : Colors.orange,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  'حالة النظام',
                  style: GoogleFonts.tajawal(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildStatusCard(
              'حالة الاستمارة',
              isOpen ? 'مفتوحة' : 'مغلقة',
              isOpen ? Icons.lock_open : Icons.lock_outline,
              isOpen ? Colors.green : Colors.orange,
            ),
            if (systemConfig?.formmessage?.isNotEmpty == true) ...[
              const SizedBox(height: 12),
              _buildStatusCard(
                'عدد الرسائل',
                '${systemConfig?.formmessage?.length ?? 0} رسالة',
                Icons.message,
                primaryColor,
              ),
            ],
          ],
        ),
      );
    });
  }

  Widget _buildStatusCard(
      String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.tajawal(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: GoogleFonts.tajawal(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormMessagesSection() {
    return GetBuilder<HomePageController>(builder: (controller) {
      final systemConfig = controller.fullStudentData.value.systemConfig;
      final formMessages = systemConfig?.formmessage ?? [];

      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.notes, color: primaryColor, size: 24),
              ),
              const SizedBox(width: 12),
              Text(
                'معلومات الاستمارة',
                style: GoogleFonts.tajawal(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          if (formMessages.isEmpty)
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.inbox_outlined,
                    size: 48,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'لا توجد رسائل',
                    style: GoogleFonts.tajawal(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ...formMessages.map((message) {
            final hasAction =
                message.approveAt != null && message.modifiedAt == null;

            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(
                  color: Colors.grey[200]!,
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header with status
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey[200]!,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: hasAction
                                ? primaryColor.withOpacity(0.1)
                                : Colors.orange.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            message.audit ?? 'قيد المراجعة',
                            style: GoogleFonts.tajawal(
                              color: hasAction ? primaryColor : Colors.orange,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          'رقم الاستمارة: ${message.serial ?? 'N/A'}',
                          style: GoogleFonts.tajawal(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Message content
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (message.message?.isNotEmpty == true) ...[
                          Text(
                            message.message!,
                            style: GoogleFonts.tajawal(
                              fontSize: 14,
                              color: textColor,
                              height: 1.6,
                            ),
                            textAlign: TextAlign.right,
                          ),
                          const SizedBox(height: 16),
                        ],
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 16,
                              color: Colors.grey[500],
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'آخر تحديث: ${message.modifiedAt ?? 'غير محدد'}',
                              style: GoogleFonts.tajawal(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Action button
                  if (hasAction)
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        bottom: 16,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.offNamed('/DesktopHomePage');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'دخول الى الاستمارة',
                            style: GoogleFonts.tajawal(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          }).toList(),
          const SizedBox(height: 16),
          // Toggle switch section
          Obx(() {
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'طلب تعديل',
                      style: GoogleFonts.tajawal(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                  ),
                  Switch(
                    value: dataStatus.value,
                    onChanged: (value) {
                      dataStatus.value = value;
                    },
                    activeColor: primaryColor,
                    activeTrackColor: primaryColor.withOpacity(0.5),
                  ),
                ],
              ),
            );
          }),
          Obx(() {
            return dataStatus.value
                ? Column(
                    children: [
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller: messageController,
                          decoration: InputDecoration(
                            labelText: 'سبب التعديل',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: Colors.grey[50],
                          ),
                          validator: validateTextWithoutAnyCharacterNumber,
                          onChanged: (value) {},
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () async {
                          if (messageController.text.isNotEmpty) {
                            await serialController
                                .requestEdit(messageController.text);
                          } else {
                            Get.snackbar(
                              'خطأ',
                              'الرجاء إدخال سبب التعديل',
                              backgroundColor: errorColor,
                              colorText: Colors.white,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 24),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        icon: const Icon(Icons.send, size: 20),
                        label: const Text('ارسال طلب تعديل'),
                      ),
                    ],
                  )
                : Container();
          }),
        ],
      );
    });
  }
}
