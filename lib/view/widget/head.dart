import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduate_gtudiesV2/Services/session.dart';

import '../../Controllers/LogoutController.dart';
import '../../theme.dart';

class Head extends StatelessWidget {
  final LogoutController logoutController = Get.put(LogoutController());

  Head({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(right: 30, left: 8),
        width: double.infinity,
        color: KprimeryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            size.width > SizeR.TabletWidth
                ? Container()
                : IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: const Icon(Icons.menu)),
            size.width < SizeR.TabletWidth ? Container() : rightside(),
            leftSide()
          ],
        ),
      ),
    );
  }

  DropdownButtonHideUnderline leftSide() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        dropdownStyleData: const DropdownStyleData(
            width: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(19)))),
        customButton: Row(
          children: [
            Obx(() {
              return Text(
                logoutController.studentName.value ?? 'غير معروف',
                style: HeadLine1,
              );
            }),
            const SizedBox(
              width: 8,
            ),
            CircleAvatar(
              backgroundColor: KSecondryColor,
              radius: 20,
              child: Image.network(
                  'https://th.bing.com/th/id/R.c09c979549603cf39105ff1ec8375fd7?rik=GZ12n01tDMaQTg&pid=ImgRaw&r=0'),
            ),
          ],
        ),
        items: const [
          DropdownMenuItem(
            // onTap: () => Get.to(() => Login()),
            alignment: Alignment.center,
            // alignment: Alignment.bottomRight,
            value: "m",
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.logout),
                Text("تسجيل خروج"),
              ],
            ),
          )
        ],
        onChanged: (val) async {
          await logoutController.logout();
          await clearSession();
          Get.offAllNamed("/login");
        },
      ),
    );
  }

  Row rightside() {
    return Row(
      children: [
        Text(
          "منظومة التقديم للدراسات العليا 2023-2024",
          style: HeadLine,
        ),
        Text(
          " - ",
          style: HeadLine,
        ),
        Text(
          "قسم الدراسات العليا ",
          style: HeadLine.copyWith(color: KBorderColor),
        )
      ],
    );
  }
}
