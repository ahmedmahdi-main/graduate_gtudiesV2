import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controllers/home_page_controller.dart';
import '../../../theme.dart';
import '../../widget/tabpar.dart';
import '../submission_form.dart';

class DesktopHomePage extends StatelessWidget {
  DesktopHomePage({super.key});
  final HomePageController _controller = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    // _controller.checkAndNavigate();
    var size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: KSecondryColor,
        body: const SubmissionForm(),
        drawer: size.width < SizeR.TabletWidth
            ? Container(
                constraints: const BoxConstraints(maxWidth: 300),
                child: const Drawer(
                  child: TabPar(),
                ),
              )
            : null,
      ),
    );
  }
}
