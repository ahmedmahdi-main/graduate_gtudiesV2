// ignore_for_file: non_constant_identifier_names

import 'package:dio/dio.dart';

class Failure {
  int? ErorrCode;
  String? Massage;
  Failure({this.ErorrCode, this.Massage});

  static String? dioexeptiontype(DioException? e) {
    switch (e?.type) {
      case DioExceptionType.connectionTimeout:
        return "تجاوز مهلة الانتظار";
      case DioExceptionType.sendTimeout:
        return "تجاوز مهلة الانتظار لارسال البيانات";
      case DioExceptionType.receiveTimeout:
        return "تجاوز مهلة استقبال البيانات";
      case DioExceptionType.badCertificate:
        return "عدم وجود شهادة عميل";
      case DioExceptionType.badResponse:
        print(
            "-------------------------------------------${e?.response?.statusCode}--------------------------------");
        return e?.message == null
            ? ""
            : e?.response?.statusCode == 404
                ? "not found"
                : e?.response?.statusCode == 500
                    ? "خطأ غير متوقع \n كود ${e!.response?.statusCode}"
                    : e?.response != null
                        ? e?.response?.data != null
                            ? e?.response?.data["errors"] != null
                                ? replasetext("${e?.response?.data?["errors"]}")
                                : "لم يستطع معالجة طلب هناك خطأ في Response"
                            : "لم يستطع معالجة طلب هناك خطأ في الداتا"
                        : "لم يستطع معالجة طلب هناك خطأ في الرساله";
      case DioExceptionType.cancel:
        return "تم الالغاء";
      case DioExceptionType.connectionError:
        return "هناك خطأ بالاتصال";
      case DioExceptionType.unknown:
        return "خطأ غير معروف";
      case null:
        return "لا اعلم ";
    }
  }

  static String replasetext(String Text) {
    String t;
    t = Text.replaceAll(RegExp(r"[\[\]]"), "");
    return t;
  }
}

enum OperationData { insert, delete, update }
