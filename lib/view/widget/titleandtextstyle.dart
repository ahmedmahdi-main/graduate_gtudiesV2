import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../../theme.dart';

class TitleAndTextStyle extends StatefulWidget {
  final Widget? widget;
  final String title;
  final String? initialValue;
  final TextStyle? textStyle;
  final Function(String?)? validator;
  final TextEditingController? controller;
  final AutovalidateMode? autovalidateMode;
  final bool? readOnly, isPassword;
  final double? width;
  final MouseCursor? mouseCursor;
  final Function(String?)? onsave;
  final GestureTapCallback? onTap;
  final Function(String)? onchange;
  final bool? obscureText;
  final Future<void> Function()? onEnter; // Accept asynchronous callback
  final bool enabled;
  final FocusNode? focusNode;
  final bool? autofocus;

  const TitleAndTextStyle({
    super.key,
    required this.title,
    this.textStyle,
    this.widget,
    this.validator,
    this.controller,
    this.onchange,
    this.autovalidateMode,
    this.readOnly,
    this.initialValue,
    this.width,
    this.onsave,
    this.onTap,
    this.mouseCursor,
    this.obscureText,
    this.isPassword,
    this.onEnter,
    this.enabled = true,
    this.focusNode,
    this.autofocus = false,
  });

  @override
  State<TitleAndTextStyle> createState() => _TitleAndTextStyleState();
}

class _TitleAndTextStyleState extends State<TitleAndTextStyle> {
  TextEditingController textEditingController = TextEditingController();
  var erorr;
  bool isValid = false;
  late FocusNode _keyboardFocusNode;

  @override
  void initState() {
    super.initState();
    _keyboardFocusNode = widget.focusNode ?? FocusNode();
    if (widget.autofocus == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _keyboardFocusNode.requestFocus();
      });
    }
  }

  @override
  void dispose() {
    // Only dispose the focus node if it was created by this widget
    if (widget.focusNode == null) {
      _keyboardFocusNode.dispose();
    }
    super.dispose();
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
                    isValid
                        ? Text(
                            erorr,
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
                // margin: EdgeInsets.only(top: 10),
                constraints: BoxConstraints(
                    maxWidth: widget.width ??
                        (size.width < SizeR.MobileWidth
                            ? double.infinity
                            : 370),
                    maxHeight: 55),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(19),
                  color: isValid
                      ? Colors.redAccent.withOpacity(0.5)
                      : KSecondryColor,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        focusNode: _keyboardFocusNode,
                        autofocus: widget.autofocus ?? false,
                        enabled: widget.enabled,
                        style: widget.enabled
                            ? null
                            : const TextStyle(color: Colors.black),
                        obscuringCharacter: "*",
                        obscureText: widget.obscureText ?? false,
                        mouseCursor: widget.mouseCursor ??
                            WidgetStateMouseCursor.textable,
                        onTap: widget.onTap ?? () {},
                        onSaved: (newValue) {
                          widget.onsave;
                        },
                        initialValue: widget.initialValue,
                        readOnly: widget.readOnly ?? false,
                        autovalidateMode: widget.autovalidateMode ??
                            AutovalidateMode.disabled,
                        onChanged: widget.onchange,
                        controller: widget.controller,
                        validator: (value) {
                          var m = widget.validator?.call(value);
                          if (m == null ||
                              m.toString().toLowerCase() == "null" ||
                              m == "") {
                            setState(() {
                              isValid = false;
                              return;
                            });
                          } else {
                            setState(() {
                              erorr = m.toString();
                              isValid = true;
                            });
                          }

                          return m;
                        },
                        onFieldSubmitted: (value) {
                          if (!kIsWeb) {
                            widget.onEnter?.call();
                          }
                        },
                        decoration: InputDecoration(
                            disabledBorder: outlinecostom(),
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
                    widget.widget ?? Container(),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  OutlineInputBorder outlinecostom() {
    return const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent, width: 0),
        borderRadius: BorderRadius.all(Radius.circular(19)));
  }
}
