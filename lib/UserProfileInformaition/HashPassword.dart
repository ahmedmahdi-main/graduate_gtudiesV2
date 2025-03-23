import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';


String hashPasswordWithoutSalt(String password) {
  var bytes = utf8.encode(password);
  Digest sha256Result = sha256.convert(bytes);
  Digest sha512Result = sha512.convert(bytes);
   debugPrint(sha256Result.toString());
  return sha256Result.toString();
}
