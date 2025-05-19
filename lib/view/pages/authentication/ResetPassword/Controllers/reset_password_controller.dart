import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:graduate_gtudiesV2/Models/user_info.dart';
import 'package:graduate_gtudiesV2/UserProfileInformaition/hash_password.dart';

import '../../../../../Services/session.dart';
import '../../../../../Services/base_route.dart';
import '../../../../../Services/session_error_handler.dart';

class ResetPasswordController extends GetxController with SessionErrorHandler {
  String email = '';

  Future<bool> passwordReset(String newPassword) async {
    var hashPassword = hashPasswordWithoutSalt(newPassword);
    var session = await getSession();
    var headers = {'Authorization': 'Bearer ${session['token']}'};
    var dio = Dio();
    var response = await dio.request(
      'https://postgrad.uokerbala.edu.iq/api/password-reset?password=$hashPassword',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<UserInfo?> otpChecker(String otp) async {
    try {
      var dio = Dio();

      var response = await dio.request(
        'https://postgrad.uokerbala.edu.iq/api/otp-check?email=$email&otp=$otp',
        options: Options(
          method: 'POST',
        ),
      );
      if (response.data['code'] == 200) {
        UserInfo user = UserInfo();
        user.fromJson(response.data);
        return user;
      } else {
        return null;
      }
    } on DioException catch (e){
      handleDioError(e);
      return null;
    }
    on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<int?> passwordResetCheck(String email) async {
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseRoute/pass-reset-check?email=$email',
        options: Options(
          method: 'POST',
        ),
      );

      if (response.statusCode == 200) {
        return response
            .statusCode; // Assumes response has data for DataInformation
      }
    } on DioException catch (e) {
     handleDioError(e);
      return null; // Returns default DataInformation on error
    } on Exception catch (e) {
      debugPrint('-----------------passwordResetCheck--------------------- $e');
      return null; // Returns default DataInformation on error
    }

    return null; // Returns default DataInformation if no successful response
  }
}
