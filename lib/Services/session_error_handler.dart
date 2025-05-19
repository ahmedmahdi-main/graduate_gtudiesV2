import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'costom_dialog.dart';
import 'session.dart';

mixin SessionErrorHandler {
  static bool _isHandlingError = false;

  void handleDioError(DioException e) async {
    if (_isHandlingError) return;
    _isHandlingError = true;

    String errorMessage;
    try {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          errorMessage = "تجاوز وقت الاتصال، يرجى التحقق من اتصال الإنترنت";
          break;
        case DioExceptionType.connectionError:
          errorMessage = "خطأ في الاتصال، يرجى التحقق من اتصال الإنترنت";
          break;
        case DioExceptionType.badResponse:
          if (e.response?.statusCode == 401) {
            errorMessage = "انتهت صلاحية الجلسة، يرجى تسجيل الدخول مرة أخرى";
            await clearSession();
            if (Get.currentRoute != '/login') {
              await Get.offAllNamed('/login');
              return;
            }
            _isHandlingError = false;
            return;
          } else {
            errorMessage =
                e.response?.data?["message"] ?? "خطأ في الاستجابة من الخادم";
          }
          break;
        case DioExceptionType.cancel:
          errorMessage = "تم إلغاء الطلب";
          break;
        case DioExceptionType.unknown:
          if (e.error != null &&
              e.error.toString().contains("SocketException")) {
            errorMessage =
                "لا يمكن الاتصال بالخادم، يرجى التحقق من اتصال الإنترنت";
          } else {
            errorMessage = "حدث خطأ غير متوقع";
          }
          break;
        default:
          errorMessage = "حدث خطأ غير متوقع";
      }

      await DilogCostom.dilogSecss(
          isErorr: true,
          title: errorMessage,
          icons: Icons.error_outline,
          color: Colors.redAccent);
    } finally {
      _isHandlingError = false;
    }
  }
}
