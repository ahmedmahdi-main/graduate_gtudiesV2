// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

/// Class [WebDatePicker] help display date picker on web
class WebDatePicker extends StatefulWidget {
  const WebDatePicker({
    Key? key,
    this.initialDate,
    this.istaped,
    this.firstDate,
    this.lastDate,
    required this.onChange,
    this.style,
    this.width = 200,
    this.height = 36,
    this.prefix,
    this.dateformat = 'yyyy/MM/dd',
    this.overlayVerticalPosition = 5.0,
    this.overlayHorizontalPosiition = 0.0,
    this.inputDecoration,
  }) : super(key: key);

  final bool? istaped;

  /// The initial date first
  final DateTime? initialDate;

  /// The earliest date the user is permitted to pick or input.
  final DateTime? firstDate;

  /// The latest date the user is permitted to pick or input.
  final DateTime? lastDate;

  /// Called when the user picks a day.
  final ValueChanged<DateTime?> onChange;

  /// The text style of date form field
  final TextStyle? style;

  /// The width and height of date form field
  final double width;
  final double height;

  /// The position of calendar popup
  final double overlayVerticalPosition;
  final double overlayHorizontalPosiition;

  //The decoration of text form field
  final InputDecoration? inputDecoration;

  /// The prefix of date form field
  final Widget? prefix;

  /// The date format will be displayed in date form field
  final String dateformat;

  @override
  _WebDatePickerState createState() => _WebDatePickerState();
}

class _WebDatePickerState extends State<WebDatePicker> {
  bool get _istaped {
    return widget.istaped ?? false;
  }

  late OverlayEntry _overlayEntry;

  final LayerLink _layerLink = LayerLink();
  bool isclicked = false;
  late DateTime? _selectedDate;
  late DateTime _firstDate;
  late DateTime _lastDate;

  bool _isEnterDateField = false;

  @override
  void initState() {
    super.initState();
    if (_istaped == true) {
      isclicked
          ? () {}
          : () {
              _overlayEntry = _createOverlayEntry();
              Overlay.of(context).insert(_overlayEntry);
              setState(() {
                isclicked = true;
              });
              // _controller.clear();
              // _selectedDate = null;
            };
    }

    //print(widget.onTap!.toString()) ;
    _selectedDate = widget.initialDate;
    _firstDate = widget.firstDate ?? DateTime(1900);
    _lastDate = widget.lastDate ?? DateTime(2100);

    // if (_selectedDate != null) {
    //   _controller.text = _selectedDate?.parseToString(widget.dateformat) ?? '';
    // }

    // _focusNode.addListener(() {
    //   if (_focusNode.hasFocus) {
    //     _overlayEntry = _createOverlayEntry();
    //     Overlay.of(context).insert(_overlayEntry);
    //   } else {
    //     _controller.text = _selectedDate.parseToString(widget.dateformat);
    //     widget.onChange.call(_selectedDate);
    //     //_overlayEntry.remove();
    //   }
    // });
  }

  void onChange(DateTime? selectedDate) {
    _selectedDate = selectedDate;
    widget.onChange.call(_selectedDate);
    // _controller.text = _selectedDate.parseToString(widget.dateformat);

    // _focusNode.unfocus();
    _overlayEntry.remove();
    isclicked = false;
  }

  OverlayEntry _createOverlayEntry() {
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    // final offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Positioned(
        bottom: MediaQuery.maybeViewInsetsOf(context)?.bottom ?? 0.0,
        width: 300,
        child: CompositedTransformFollower(
          followerAnchor: Alignment.topLeft,
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(
              0,
              MediaQuery.of(context).size.height >
                      MediaQuery.of(context).size.height - 350
                  ? -250
                  : widget.overlayVerticalPosition + size.height),
          child: Material(
            elevation: 5,
            child: SizedBox(
              height: 250,
              child: Builder(
                builder: (BuildContext context) => Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: const ColorScheme.light(
                      primary: Color.fromARGB(255, 26, 215, 108),
                      onPrimary: Colors.black,
                    ),
                    textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                      ),
                    ),
                  ),
                  child: CalendarDatePicker(
                    firstDate: _firstDate,
                    lastDate: _lastDate,
                    initialDate: _selectedDate ?? DateTime.now(),
                    onDateChanged: onChange,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: MouseRegion(
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
        child: Center(
          child: IconButton(
            icon: const Icon(Icons.calendar_month_outlined),
            onPressed: isclicked
                ? () {}
                : () {
                    _overlayEntry = _createOverlayEntry();
                    Overlay.of(context).insert(_overlayEntry);
                    setState(() {
                      isclicked = true;
                    });
                    // _controller.clear();
                    // _selectedDate = null;
                  },
            splashRadius: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildPrefixIcon() {
    if (_isEnterDateField) {
      return IconButton(
        icon: const Icon(Icons.calendar_month_outlined),
        onPressed: () {
          _overlayEntry.remove();
          // _controller.clear();
          // _selectedDate = null;
        },
        splashRadius: 16,
      );
    } else {
      return widget.prefix ??
          IconButton(
              onPressed: () {
                _overlayEntry = _createOverlayEntry();
                Overlay.of(context).insert(_overlayEntry);
              },
              icon: const Icon(Icons.calendar_month));
    }
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