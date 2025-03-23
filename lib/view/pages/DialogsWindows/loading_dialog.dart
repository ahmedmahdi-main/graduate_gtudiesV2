import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingDialog {
  static void showLoadingDialog({required String message}) {
    AwesomeDialog(
      context: Get.context!,
      dialogType: DialogType.noHeader,
      barrierColor: Colors.black.withOpacity(0.1),
      dismissOnTouchOutside: false,
      animType: AnimType.scale,
      width: GetPlatform.isWeb ? Get.width / 3.5 : GetPlatform.isMobile ? Get.width / 6 : Get.width / 3,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(
              width: 22,
            ),
            Text(
              message,
              style: Theme.of(Get.context!)
                  .textTheme
                  .headlineMedium!
                  .apply(color: Colors.black),
            ),
          ],
        ),
      ),
    ).show();
  }
}

