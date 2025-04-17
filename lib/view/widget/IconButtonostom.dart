import 'package:flutter/material.dart';
import 'package:graduate_gtudiesV2/Services/DilogCostom.dart';

import '../../controller/home_page_controller.dart';
import 'buttonsyle.dart';

class IconButtonostom extends StatelessWidget {
  const IconButtonostom(
      {super.key,
      required HomePageController controller,
      required this.index,
      required this.dgree})
      : _controller = controller;
  final String dgree;
  final HomePageController _controller;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ButtonStyleS(
      SelectedbackgroundColorbefore: Colors.redAccent,
      colorBorder: Colors.redAccent,
      containborder: true,
      isleft: false,
      icon: Icons.delete_outline,
      title: 'حذف الشهادة',
      onTap: () async {
        _controller.removeDegree(index, dgree);
        _controller.haveInsertBachelor.value = false;
        await DilogCostom.dilogSecss(
          isErorr: false,
          title: " حذف الشهادة تم بنجاح",
          icons: Icons.close,
          color: Colors.greenAccent,
        );
      },
    );
    // Tooltip(
    //   message: "حذف",
    //   child: IconButton(
    //       onPressed: () {
    //

    //       },
    //       icon: Icon(Icons.playlist_remove)),
    // );
  }
}
