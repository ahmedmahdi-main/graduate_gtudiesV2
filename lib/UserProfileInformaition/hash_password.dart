import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';


String hashPasswordWithoutSalt(String password) {
  var bytes = utf8.encode(password);
  var sha256Result = sha256.convert(bytes);
  sha512.convert(bytes);
   debugPrint(sha256Result.toString());
  return sha256Result.toString();
}
