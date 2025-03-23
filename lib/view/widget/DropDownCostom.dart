import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme.dart';


class DropDownCustom extends StatelessWidget {
  const DropDownCustom(
      {super.key,
        required this.items,
        this.value,
        this.onChanged,
        this.hint,
        this.maxWidth,
        this.isExpanded,
        this.disable = false,
        this.needValdate = false,
        this.validator,
        this.title,
        this.widthsizebox,
        this.dropdownSearchData});
  final bool disable;
  final String? title;
  final double? widthsizebox;
  final List<DropdownMenuItem<dynamic>> items;
  final bool needValdate;
  final dynamic value;
  final Function(dynamic)? onChanged;
  final String? hint;
  final double? maxWidth;
  final bool? isExpanded;
  final String? Function(dynamic)? validator;
  final DropdownSearchData<dynamic>? dropdownSearchData;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return FormField(validator: (value2) {
      String? StringVal = validator?.call(value2);
      if (needValdate == false) {
        return null;
      }
      // print(StringVal);
      // print("+++++++++++++++++++++++++++++++++++++++++");
      if (StringVal != null) {
        return StringVal;
      }
      if (value != null) {
        return null;
      }
      if (value2 == null) {
        return "الرجاء تحديد قيمة";
      }
      return null;
    }, builder: (FormFieldState<dynamic> state) {
      //  print(state.hasError);

      return SizedBox(
        width: widthsizebox,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title == null
                ? Container()
                : Padding(
              padding:
              EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                title!,
                style: context.textTheme.bodyMedium,
              ),
            ),
            Container(
              margin: title != null
                  ? null
                  : EdgeInsets.symmetric(vertical: 16),
              constraints:
              BoxConstraints(maxWidth: maxWidth ?? double.infinity),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 51,
                    width: double.infinity,
                    child: DropdownButtonHideUnderline(
                        child: DropdownButton2<dynamic>(
                            iconStyleData: IconStyleData(
                                iconEnabledColor: state.hasError
                                    ? context.theme.colorScheme.error
                                    : context.theme.colorScheme.secondary,
                                iconDisabledColor: state.hasError
                                    ? context.theme.colorScheme.error
                                    .withOpacity(0.5)
                                    : context.theme.colorScheme.onPrimary
                                    .withOpacity(0.5)),
                            dropdownSearchData: dropdownSearchData,
                            buttonStyleData: ButtonStyleData(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: context
                                            .theme
                                            .dropdownMenuTheme
                                            .inputDecorationTheme!
                                            .border!
                                            .borderSide
                                            .width,
                                        color: state.hasError
                                            ? context.theme.colorScheme.error
                                            : context
                                            .theme.colorScheme.secondary),
                                    borderRadius: BorderRadius.circular(
                                        16 * 2))),
                            dropdownStyleData: DropdownStyleData(
                                offset: const Offset(0, -4),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(16))),
                            style: context.textTheme.bodyMedium,
                            menuItemStyleData: MenuItemStyleData(
                              overlayColor: WidgetStatePropertyAll(
                                  context.theme.colorScheme.primary),
                              selectedMenuItemBuilder: (context, child) =>
                                  Container(
                                    color: context.theme.colorScheme.secondary,
                                    child: child,
                                  ),
                            ),
                            hint: Text(
                              hint ?? "",
                              style: context.textTheme.bodyMedium
                                  ?.copyWith(color: Colors.black45),
                            ),
                            value: value,
                            isExpanded: isExpanded ?? false,
                            items: items,
                            onChanged: disable
                                ? null
                                : (value) {
                              onChanged?.call(value);
                              if (needValdate == false) {
                                needValdate
                                    ? state.didChange(value)
                                    : null;
                              }
                            })),
                  ),
                  state.hasError
                      ? Padding(
                    padding: EdgeInsets.only(
                        right: 16,
                        left: 16),
                    child: Text(
                      state.errorText!,
                      style: context.textTheme.titleMedium?.copyWith(
                          fontSize: 8,
                          color: context.theme.colorScheme.error
                              .withOpacity(0.6)),
                    ),
                  )
                      : Container(),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
