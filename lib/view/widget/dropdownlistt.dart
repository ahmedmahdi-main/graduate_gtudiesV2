// ignore_for_file: non_constant_identifier_names

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../theme.dart';

class DropdownlistWithValedator extends StatefulWidget {
  final Widget? widget;
  final String title;
  final String? initialValue;
  final TextStyle? textStyle;
  final Function(String?)? validator;

  final AutovalidateMode? autovalidateMode;
  final bool? readOnly;
  final double? width;
  // final List<dynamic> items;
  final List<DropdownMenuItem> DropdownMenuItems;

  dynamic? value;

  final Function(String?)? onsave;

  final Function(dynamic)? onChange;

  DropdownlistWithValedator({
    super.key,
    required this.title,
    this.textStyle,
    this.widget,
    this.validator,
    this.onChange,
    this.autovalidateMode,
    this.readOnly,
    this.initialValue,
    this.width,
    this.onsave,
    this.value,
    //required this.items,

    required this.DropdownMenuItems,
  });

  @override
  State<DropdownlistWithValedator> createState() =>
      _DropdownlistWithValedatorState();
}

class _DropdownlistWithValedatorState extends State<DropdownlistWithValedator> {
  TextEditingController textEditingController = TextEditingController();
  var error;
  bool isValidate = false;
  String? selectedValue;

  late TextEditingController searchController;
  @override
  void initState() {
    searchController = TextEditingController();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          constraints: BoxConstraints(
              maxWidth: widget.width ??
                  (size.width < SizeR.MobileWidth ? double.infinity : 250)),
          //padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          // height: size.height * 0.4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Text(
                      widget.title,
                      style: widget.textStyle ?? HeadLine1,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    isValidate
                        ? Text(
                            error,
                            style: HeadLine1.copyWith(color: Colors.red),
                          )
                        : Container()
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                constraints: BoxConstraints(
                  maxWidth: widget.width ??
                      (size.width < SizeR.MobileWidth ? double.infinity : 250),
                  maxHeight: size.width > SizeR.MobileWidth ? 54 : 62,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(19),
                  color: isValidate
                      ? Colors.redAccent.withOpacity(0.5)
                      : KSecondryColor,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButtonFormField2(
                          value: widget.value,
                          dropdownSearchData: DropDownSearchContained(),
                          onSaved: (newValue) {
                            widget.onsave;
                          },
                          items: widget.DropdownMenuItems,
                          // widget.items
                          //     .map((e) => DropdownMenuItem(
                          //           value: e,
                          //
                          //           child: Center(
                          //             child: Text(widget.ismap
                          //                 ? e[widget.keyselected].toString()
                          //                 : e.toString()),
                          //           ),
                          //         ))
                          //     .toList(),
                          autovalidateMode: widget.autovalidateMode ??
                              AutovalidateMode.disabled,
                          onChanged: widget.onChange,
                          //     (val) {
                          //   if (widget.ismap) {
                          //     Map<String, String>? z;
                          //     z = val as Map<String, String>?;
                          //     setState(() {
                          //       selectedValue =
                          //           z![widget.keyselected].toString();
                          //     });
                          //   } else {
                          //     setState(() {
                          //       selectedValue = val.toString();
                          //     });
                          //   }
                          //   widget.onchange?.call(selectedValue!);
                          //
                          //   // _onchange;
                          // },
                          validator: (value) {
                            var m = widget.validator?.call(value.toString());
                            if (m == null ||
                                m.toString().toLowerCase() == "null" ||
                                m == "") {
                              setState(() {
                                isValidate = false;
                                return;
                              });
                            } else {
                              setState(() {
                                error = m.toString();

                                isValidate = true;
                              });
                            }

                            return m;
                          },
                          decoration: InputDecoration(
                              focusedErrorBorder: outlinecostom(),
                              hoverColor: Colors.transparent,
                              filled: true,
                              fillColor: Colors.transparent,
                              border: outlinecostom(),
                              errorStyle:
                                  const TextStyle(height: null, fontSize: 0),
                              errorBorder: outlinecostom(),
                              enabledBorder: outlinecostom(),
                              focusedBorder: outlinecostom()),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  DropdownSearchData<dynamic> DropDownSearchContained() {
    return DropdownSearchData(
      searchController: searchController,
      searchInnerWidgetHeight: 50,
      searchInnerWidget: widget.DropdownMenuItems.length < 5
          ? Container()
          : Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
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
                  controller: searchController,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    hintText: 'البحث',
                    hintStyle: const TextStyle(fontSize: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  OutlineInputBorder outlinecostom() {
    return const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent, width: 0),
        borderRadius: BorderRadius.all(Radius.circular(19)));
  }
}

class DropDownList extends StatefulWidget {
  final Widget? widget;
  final String title;
  final String? initialValue;
  final TextStyle? textStyle;
  final Function(String?)? validator;
  final List<Widget> Function(BuildContext)? selectedItemBuilder;
  final AutovalidateMode? autovalidateMode;
  final bool? readOnly;
  final double? width;
  // final List<dynamic> items;
  final List<DropdownMenuItem> DropdownMenuItems;

  dynamic value;

  final Function(String?)? onsave;

  final Function(dynamic)? onchange;

  DropDownList({
    super.key,
    required this.title,
    this.textStyle,
    this.widget,
    this.validator,
    this.onchange,
    this.autovalidateMode,
    this.readOnly,
    this.initialValue,
    this.width,
    this.onsave,
    this.value,
    //required this.items,
    required this.DropdownMenuItems,
    this.selectedItemBuilder,
  });

  @override
  State<DropDownList> createState() => _DropDownListState();
}

class _DropDownListState extends State<DropDownList> {
  TextEditingController textEditingController = TextEditingController();
  var error;
  bool isValidate = false;
  String? selectedValue;

  late TextEditingController searchController;
  @override
  void initState() {
    searchController = TextEditingController();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: FormField(
          validator: (value2) {
            debugPrint('initialValue =========== ${widget.value}');
            if (widget.value != null) {
              return null;
            }
            String? StringVal = widget.validator?.call(value2.toString());
            if (StringVal != null) {
              return StringVal;
            }

            if (value2 == null) {
              return "الرجاء تحديد قيمة";
            }
            if (widget.value != null) {
              return null;
            }
            return null;
          },
          builder: (state) => Container(
            constraints: BoxConstraints(
                maxWidth: widget.width ??
                    (size.width < SizeR.MobileWidth ? double.infinity : 250)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Text(
                        widget.title,
                        style: widget.textStyle ?? HeadLine1,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      if (state.hasError)
                        Text(
                          '${state.errorText}',
                          style: HeadLine1.copyWith(color: Colors.red),
                        ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  constraints: BoxConstraints(
                    maxWidth: widget.width ??
                        (size.width < SizeR.MobileWidth
                            ? double.infinity
                            : 250),
                    maxHeight: size.width > SizeR.MobileWidth ? 54 : 62,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(19),
                    color: isValidate
                        ? Colors.redAccent.withOpacity(0.5)
                        : KSecondryColor,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            selectedItemBuilder: widget.selectedItemBuilder,
                            value: widget.value,
                            dropdownSearchData: DropDownSearchContained(),
                            // onSaved: (newValue) {
                            //   widget.onsave;
                            // },

                            items: widget.DropdownMenuItems,
                            // widget.items
                            //     .map((e) => DropdownMenuItem(
                            //           value: e,
                            //
                            //           child: Center(
                            //             child: Text(widget.ismap
                            //                 ? e[widget.keyselected].toString()
                            //                 : e.toString()),
                            //           ),
                            //         ))
                            //     .toList(),
                            // autovalidateMode: widget.autovalidateMode ??
                            //     AutovalidateMode.disabled,
                            onChanged: (value) {
                              widget.onchange?.call(value);
                              debugPrint('value =========== $value');

                              state.didChange(value);
                              state.activate();
                            },

                            // validator: (value) {
                            //   var m = widget.validator?.call(value.toString());
                            //   if (m == null ||
                            //       m.toString().toLowerCase() == "null" ||
                            //       m == "") {
                            //     setState(() {
                            //       isValidate = false;
                            //       return;
                            //     });
                            //   } else {
                            //     setState(() {
                            //       error = m.toString();

                            //       isValidate = true;
                            //     });
                            //   }

                            //   return m;
                            // },
                            // decoration: InputDecoration(
                            //     focusedErrorBorder: outlinecostom(),
                            //     hoverColor: Colors.transparent,
                            //     filled: true,
                            //     fillColor: Colors.transparent,
                            //     border: outlinecostom(),
                            //     errorStyle:
                            //         const TextStyle(height: null, fontSize: 0),
                            //     errorBorder: outlinecostom(),
                            //     enabledBorder: outlinecostom(),
                            //     focusedBorder: outlinecostom()),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  DropdownSearchData<dynamic> DropDownSearchContained() {
    return DropdownSearchData(
      searchController: searchController,
      searchInnerWidgetHeight: 50,
      searchInnerWidget: widget.DropdownMenuItems.length < 5
          ? Container()
          : Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
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
                  controller: searchController,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    hintText: 'البحث',
                    hintStyle: const TextStyle(fontSize: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  OutlineInputBorder outlinecostom() {
    return const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent, width: 0),
        borderRadius: BorderRadius.all(Radius.circular(19)));
  }
}
