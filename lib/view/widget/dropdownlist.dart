// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../theme.dart';
import 'titleandtextstyle.dart';

class DropDownListT extends StatefulWidget {
  final List<dynamic> items;
  final String title;
  final String keyselected;
  final bool ismap;
  final double? width;
  final TextEditingController? controller;

  final Function(Object) onchange;
  DropDownListT(
      {super.key,
      required this.onchange,
      required this.items,
      required this.keyselected,
      required this.title,
      required this.ismap,
      this.width,
      this.controller});

  @override
  State<DropDownListT> createState() => _DropDownListT();
}

class _DropDownListT extends State<DropDownListT> {
  TextEditingController textEditingController = TextEditingController();
  late TextEditingController serchcontroler;
  TextEditingController get _effectiveController {
    return widget.controller ?? textEditingController;
  }

  @override
  void initState() {
    serchcontroler = TextEditingController();
    // TODO: implement initState
    super.initState();
  }

  late final GlobalKey _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return TitleAndTextStyle(
      onTap: () {
        print("taped");
      },
      width: widget.width ??
          (size.width < SizeR.MobileWidth ? double.infinity : 250),
      key: _key,
      readOnly: true,
      controller: _effectiveController,
      title: widget.title,
      widget: Expanded(
        child: DropdownButtonHideUnderline(
            child: DropdownButtonFormField2(
                isExpanded: true,
                iconStyleData: const IconStyleData(),
                onMenuStateChange: (isOpen) {
                  if (!isOpen) {
                    serchcontroler.clear();
                  }
                },
                dropdownSearchData: DropDownSerchContainer(),
                dropdownStyleData:
                    const DropdownStyleData(offset: Offset(0, 8)),
                items: widget.items
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Center(
                            child: Text(widget.ismap
                                ? e[widget.keyselected].toString()
                                : e.toString()),
                          ),
                        ))
                    .toList(),
                onChanged: (val) {
                  if (widget.ismap) {
                    Map<String, String>? z;
                    z = val as Map<String, String>?;
                    setState(() {
                      _effectiveController.text =
                          z![widget.keyselected].toString();
                    });
                  } else {
                    setState(() {
                      _effectiveController.text = val.toString();
                    });
                  }

                  widget.onchange(val!);
                })),
      ),
    );
  }

  DropdownSearchData<dynamic> DropDownSerchContainer() {
    return DropdownSearchData(
      searchController: serchcontroler,
      searchInnerWidgetHeight: 50,
      searchInnerWidget: widget.items.length < 5
          ? Container()
          : Container(
              height: 50,
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 4,
                right: 8,
                left: 8,
              ),
              child: TextFormField(
                expands: true,
                maxLines: null,
                controller: serchcontroler,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  hintText: 'Search for an item...',
                  hintStyle: const TextStyle(fontSize: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
    );
  }
}
