// ignore_for_file: non_constant_identifier_names

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../theme.dart';


class DilogCostom {


  static Future<void> dilogSecss({
    required String title,
    required IconData icons,
    required Color color,
    required bool isErorr,
  }) async {
    await AwesomeDialog(
      barrierColor: color.withOpacity(0.1),
      isDense: true,
      dismissOnTouchOutside: false,
      animType: AnimType.scale,
      width: GetPlatform.isWeb
          ? Get.width / 2
          : GetPlatform.isMobile
          ? Get.width / 6
          : Get.width / 2,
      context: Get.context!,
      customHeader: Lottie.asset(
        isErorr ? "lottie/erorrlogo.json" : "lottie/succsseslogo.json",
        errorBuilder: (context, error, stackTrace) => CircleAvatar(
          maxRadius: 40,
          minRadius: 10,
          backgroundColor: color,
          child: Icon(icons, size: 30),
        ),
      ),
      btnOkText: "تم",
      btnOkColor: color,
      btnOkOnPress: () {},
      buttonsTextStyle: headline3,
      enableEnterKey: true,
      title: isErorr ? "خطأ" : "تم",
      titleTextStyle: HeaderStyle.copyWith(color: color),
      desc: title,
      descTextStyle: headline3,
    ).show();
  }

  //------------------------------------------------------------------------------------------------
  static dynamic Confirmdelete({String? Name, required VoidCallback onsupmet}) {
    AwesomeDialog(
        barrierColor: Colors.redAccent.withOpacity(0.1),
        isDense: true,
        dismissOnTouchOutside: false,
        animType: AnimType.scale,
        width: GetPlatform.isWeb
            ? Get.width / 2
            : GetPlatform.isMobile
            ? Get.width / 6
            : Get.width / 2,
        context: Get.context!,
        customHeader: Lottie.asset(
            errorBuilder: (context, error, stackTrace) =>
            const CircleAvatar(
              maxRadius: 40,
              minRadius: 10,
              backgroundColor: Colors.redAccent,
              child: Icon(Icons.auto_fix_normal_outlined, size: 30),
            ),
            "lottie/erorrlogo.json"),
        btnCancelText: "كلا",
        btnCancelColor: Colors.redAccent,
        btnCancelOnPress: () => Get.back(),
        btnOkText: "نعم",
        btnOkColor: Colors.greenAccent,
        btnOkOnPress: onsupmet,
        buttonsTextStyle: headline3,
        enableEnterKey: true,
        title: "هل انت متأكد من حذف $Name",
        titleTextStyle: HeaderStyle.copyWith(color: Colors.black),
        desc: "",
        descTextStyle: headline3)
        .show();
  }

  static dynamic confirmFinishEditing({required Function onSubmit}) async {
    AwesomeDialog(
        barrierColor: Colors.blueAccent.withOpacity(0.1),
        isDense: true,
        dismissOnTouchOutside: false,
        animType: AnimType.scale,
        width: GetPlatform.isWeb
            ? Get.width / 2
            : GetPlatform.isMobile
            ? Get.width / 6
            : Get.width / 2,
        context: Get.context!,
        customHeader: Image.asset(
            errorBuilder: (context, error, stackTrace) =>
            const CircleAvatar(
              maxRadius: 40,
              minRadius: 10,
              backgroundColor: Colors.blueAccent,
              child: Icon(Icons.check_circle_outline, size: 30),
            ),
            "assets/icons/editing.gif" // Update this to your specific Lottie file if necessary
        ),
        btnCancelText: "كلا",
        btnCancelColor: Colors.redAccent,
        btnCancelOnPress: () => Get.back(),
        btnOkText: "نعم",
        btnOkColor: Colors.greenAccent,
        btnOkOnPress: () async {
          await onSubmit(); // Call the onSubmit function
          Get.offNamed('/DesktopHomePage');
        },
        buttonsTextStyle: headline3,
        enableEnterKey: true,
        title: "هل انهيت التعديل الاستمارة",
    titleTextStyle: HeaderStyle.copyWith(color: Colors.black),
    desc: "",
    descTextStyle: headline3
    ).show
    (
    );
  }

}
