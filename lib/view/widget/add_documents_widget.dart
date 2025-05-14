import 'package:flutter/material.dart';
import 'package:graduate_gtudiesV2/view/widget/titleandtextstyle.dart';

import '../../Models/super_data.dart';
import '../../ValidatorFunction/text_validator.dart';
import 'coustom_calender.dart';

class AddDocumentsTypesWidgets extends StatelessWidget {
  final List<ChannelsDataDocumentsTypes>? documents;
  final List<TextEditingController> numbersControllers;
  final List<TextEditingController> dateControllers;

  const AddDocumentsTypesWidgets(
      {super.key,
      this.documents,
      required this.numbersControllers,
      required this.dateControllers});

  @override
  Widget build(BuildContext context) {
    if (documents != null) {
      for (int i = 0; i < documents!.length; i++) {
        numbersControllers.add(TextEditingController());
        dateControllers.add(TextEditingController());
      }
    }
    debugPrint(" رقم كتاب${documents?.toString()}");
    return documents != null
        ? Column(children: [
            for (int index = 0; index < documents!.length; index++)
              Wrap(
                runSpacing: 15,
                children: [
                  TitleAndTextStyle(
                    title: "  رقم كتاب ${documents![index].name} ",
                    controller: numbersControllers[index],
                    validator: (value) => isTextValid(value),
                    width: 350,
                  ),
                  const SizedBox(
                    width: 100,
                  ),
                  CustomCalendar(
                    title: "  تاريخ كتاب  ${documents![index].name} ",
                    controller: dateControllers[index],
                    initialDate: DateTime.now(),
                    constrainWidth: 350,
                  ),
                ],
              ),
          ])
        : Container();
  }
}
