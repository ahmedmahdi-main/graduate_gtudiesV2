import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduate_gtudiesV2/Services/base_route.dart';

import '../../../../Services/DilogCostom.dart';
import '../../../../Services/Session.dart';
import '../student_personal_information.dart';

class PersonalInformationController {
  static Future<bool> insertPersonalInformation(
      StudentPersonalInformation studentPersonalInformation) async {
    try {
      var session = await getSession();
      // Validate session and token
      if (session['token'] == null) {
        throw Exception('Session token is missing');
      }
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${session['token']}',
      };
      var data = studentPersonalInformation.toJson();
      if (session['token'] == null) throw Exception('Token missing');

      var dio = Dio();
      dio.options.connectTimeout = Duration(seconds: 10); // Timeout added

      var response = await dio.request(
        '$baseRoute/personalinforminsert',
        options: Options(method: 'POST', headers: headers),
        data: data,
      );

      debugPrint('Response Status: ${response.statusCode}'); // Log status code
      debugPrint('Response Data: ${response.data}'); // Log full response

      if (response.statusCode! == 200 ) {
        // Success case
       await DilogCostom.dilogSecss(
            isErorr: false,
            title: '${response.data['message']}',
            icons: Icons.check,
            color: Colors.greenAccent);
        return true;
      } else {
        // Explicit handling of HTTP errors
        final errorMsg = response.data?['message'] ?? 'Unknown server error (Status: ${response.statusCode})';
      await  DilogCostom.dilogSecss(
          isErorr: true,
          title: errorMsg, // Show server's error message
          icons: Icons.close,
          color: Colors.redAccent,
        );
      }
    } on DioException catch (e) {
      // Handle specific Dio errors (timeout, connection, etc.)
      String errorMessage = 'Network error';
      if (e.type == DioExceptionType.connectionTimeout) {
        errorMessage = 'Connection timeout';
      } else if (e.response != null) {
        errorMessage = 'Server error: ${e.response?.statusCode}';
      }
    await  DilogCostom.dilogSecss(
        isErorr: true,
        title: errorMessage, // Show server's error message
        icons: Icons.close,
        color: Colors.redAccent,
      );
    } catch (e) {
      debugPrint('Unexpected error: $e');
    }    return false;
  }}
