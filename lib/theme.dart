// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SizeR {
  static double MobileWidth = 600;
  static double TabletWidth = 1100;
}

class printingSizer {
  static double leftMargin = 20;
  static double righttMargin = 20;
  static double topttMargin = 10;
  static double buttomttMargin = 10;
}

Color KprimeryColor =
    Get.isDarkMode ? const Color(0xff000000) : const Color.fromARGB(255, 255, 255, 255);
const Color KSecondryColor = Color.fromARGB(178, 217, 217, 217);
const Color KBorderColor = Color(0xffF0394F);
const Color KTextColor = Color(0xff000000);

TextStyle get HeadLine => const TextStyle(
    color: KTextColor, fontWeight: FontWeight.w600, fontSize: 18);

TextStyle get HeadLine1 => const TextStyle(
    color: KTextColor, fontWeight: FontWeight.w100, fontSize: 16);

TextStyle get HeadLine2 => const TextStyle(
    color: KTextColor, fontWeight: FontWeight.w300, fontSize: 14);
TextStyle get authinticationColorText =>
    const TextStyle(color: Colors.white, fontFamily: "Cairo");

BoxDecoration get BoxDecorationForAuthintication => BoxDecoration(
    // image: const DecorationImage(
    //     opacity: 0.03, image: ExactAssetImage("assets/icons/Logo.png")),
    boxShadow: const [BoxShadow(blurRadius: 20)],
    color: KprimeryColor,
    borderRadius: BorderRadius.circular(12));

TextStyle get HeaderStyle =>
    GoogleFonts.cairo(fontWeight: FontWeight.w700, fontSize: 20, height: 1.5);

TextStyle get headline3 =>
    GoogleFonts.cairo(fontWeight: FontWeight.w700, fontSize: 15, height: 1.5);
