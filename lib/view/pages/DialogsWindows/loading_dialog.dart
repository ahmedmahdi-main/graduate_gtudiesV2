import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingDialog {
  static void showLoadingDialog({required String message}) {
    // Dismiss any existing dialogs first
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }

    // Show a modern, compact loading dialog
    Get.dialog(
      Dialog(
        elevation: 1,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 12,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Modern loading indicator
              SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.blue.shade700),
                ),
              ),
              const SizedBox(width: 16),
              // Message with modern typography
              Flexible(
                child: Text(
                  message,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
