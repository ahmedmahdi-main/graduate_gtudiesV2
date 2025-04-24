import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/home_page_controller.dart';
import '../../module/pages.dart';
import '../../theme.dart';
import '../widget/head.dart';
import '../widget/tabpar.dart';

class SubmissionForm extends StatelessWidget {
  const SubmissionForm({super.key});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Row(
      children: [
        size.width > SizeR.TabletWidth
            ? const Expanded(flex: 17, child: TabPar())
            : Container(),
        Expanded(
          flex: 83,
          child: SizedBox(
            height: double.infinity,
            child: Column(
              children: [
                Expanded(
                    flex: size.width > SizeR.MobileWidth ? 9 : 11,
                    child: Head()),
                GetBuilder<HomePageController>(
                  init: HomePageController(),
                  builder: (controller) => Expanded(
                      flex: 91,
                      child: PageView(
                        controller: controller.pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: submission,
                      )),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
