import 'package:flutter/material.dart';
import 'package:graduate_gtudiesV2/view/pages/Pledges/pledges_page.dart';
import 'package:graduate_gtudiesV2/view/pages/UploadImage/upload_image_page.dart';

import '../view/pages/academic_information.dart';
import '../view/pages/functional_information.dart';
import '../view/pages/submission_channel.dart';
import '../view/pages/other_information.dart';
import '../view/pages/PersonalInformation/personal_information.dart';

List<Widget> submission = [
  const PersonalInformation(),
  SubmissionChannel(),
  const AcademicInformation(),
  const FunctionalInformation(),
  OtherInformation(),
  UploadImagePage(),
  PledgesPage(),
];
