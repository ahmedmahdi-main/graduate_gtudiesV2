// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';

import 'titleandtextstyle.dart';

/// Class [WebDatePicker] help display date picker on web
class CustomCalendar extends StatefulWidget {
  CustomCalendar({
    Key? key,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.onChange,
    this.style,
    this.width = 100.0, // Default width provided
    this.height = 20.0,
    this.prefix,
    this.dateformat = 'yyyy/MM/dd',
    this.overlayVerticalPosition = 5.0,
    this.overlayHorizontalPosition = 0.0,
    this.inputDecoration,
    this.controller,
    required this.title,
    this.constrainWidth,
  }) : super(key: key);

  final String title;
  final double? constrainWidth;
  final TextEditingController? controller;

  /// The initial date shown in the calendar.
  final DateTime? initialDate;

  /// The earliest date the user is permitted to pick or input.
  final DateTime? firstDate;

  /// The latest date the user is permitted to pick or input.
  final DateTime? lastDate;

  /// Callback for when the user picks a date.
  final ValueChanged<DateTime?>? onChange;

  /// The text style of the date form field.
  final TextStyle? style;

  /// The width and height of the date form field.
  final double width;
  final double height;

  /// The vertical and horizontal position of the calendar popup overlay.
  final double overlayVerticalPosition;
  final double overlayHorizontalPosition;

  /// The decoration for the text form field.
  final InputDecoration? inputDecoration;

  /// The prefix widget for the date form field.
  final Widget? prefix;

  /// The date format displayed in the date form field.
  final String dateformat;

  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  bool isClicked = false;
  late DateTime? _selectedDate;
  late DateTime _firstDate;
  late DateTime _lastDate;

  bool _isEnterDateField = false;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _firstDate = DateTime(1900);
    _lastDate = DateTime(2100);
  }

  void onChange(DateTime? selectedDate) {
    _selectedDate = selectedDate;
    //  widget.onChange!.call(_selectedDate);
    // _controller.text = _selectedDate.parseToString(widget.dateformat);

    // _focusNode.unfocus();

    String m = selectedDate.parseToString('yyyy/MM/dd');
    setState(() {
      _effectiveController.text = m;
    });
  }

  TextEditingController textEditingController = TextEditingController();
  TextEditingController get _effectiveController {
    return widget.controller ?? textEditingController;
  }

  void _onTap() async {
    final DateTime? picked = await showDatePicker(
      // locale: const Locale('ar', 'AR'),
      context: Get.context!,
      initialDate: DateTime.now(),
      lastDate: DateTime.now(),
      firstDate: DateTime((DateTime.now().year - 100)),
      cancelText: 'إلغاء',
      confirmText: 'تم',
    );
    if (picked != null) {
      _effectiveController.text = formatDate(picked);

      widget.onChange!(picked);
    } else {
      _effectiveController.text = 'حدد التاريخ';
    }
  }

  String formatDate(DateTime picked) {
    return '${picked.year}-${picked.month < 10 ? '0${picked.month}' : '${picked.month}'}-${picked.day < 10 ? '0${picked.day}' : '${picked.day}'}';
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isEnterDateField = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isEnterDateField = false;
        });
      },
      child: Builder(
        builder: (context) {
          return GestureDetector(
            onTap: _onTap,
            child: TitleAndTextStyle(
              enabled: false,
              width: widget.constrainWidth,
              mouseCursor: WidgetStateMouseCursor.clickable,

              readOnly: true,
              // autovalidateMode: AutovalidateMode.always,
              validator: (value) {
                if (_effectiveController.text == '') {
                  return "خطأ بالتاريخ";
                }
                return null;
              },
              widget: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Icon(
                  Icons.calendar_month_outlined,
                ),
              ),
              controller: _effectiveController,
              title: widget.title,
            ),
          );
        },
      ),
    );
  }
}

//------------------------------------------------------------------------

extension DateTimeExtension on DateTime? {
  String parseToString(String dateFormat) {
    if (this == null) return '';
    return DateFormat(dateFormat).format(this!);
  }
}

//---------------------------------------------------------

extension StringExtension on String {
  DateTime parseToDateTime(String dateFormat) {
    if (length > dateFormat.length) return DateTime.now();
    try {
      return DateFormat(dateFormat).parse(this);
    } on FormatException catch (_) {
      return DateTime.now();
    }
  }
}


//-------------------------------------------------------------

//اذا اردت استدعائها يجب ان تكتب هكذا


//  WebDatePicker(
//           onChange: (DateTime? value) {
//             late String date;
//             date = value.parseToString('yyyy/MM/dd');
//             print(date.toString());
//           },
//         ),