// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import '../../theme.dart';

class ButtonStyleS extends StatefulWidget {
  final bool? isleft;
  final AlignmentGeometry? aliment;
  final void Function()? onTap;
  final IconData? icon;
  final String? title;
  final TextStyle? style;
  final Decoration? decoration;
  final bool? containborder;
  final Color? SelectedbackgroundColorbefore;
  final Color? SelectedbackgroundColorafter;
  final EdgeInsetsGeometry? padding;
  final Color? colorBorder;
  final Color iconColor;
  const ButtonStyleS(
      {super.key,
      this.onTap,
      this.icon,
      required this.title,
      this.style,
      this.decoration,
      this.isleft,
      this.containborder,
      this.aliment,
      this.SelectedbackgroundColorbefore,
      this.SelectedbackgroundColorafter,
      this.padding,
      this.colorBorder,
      this.iconColor = Colors.black});

  @override
  State<ButtonStyleS> createState() => _ButtonStyleState();
}

class _ButtonStyleState extends State<ButtonStyleS> {
  bool isselcted = false;
  bool? isleft;
  bool? containborder;
  @override
  Widget build(BuildContext context) {
    isleft = widget.isleft ?? false;
    containborder = widget.containborder ?? false;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: MouseRegion(
          onEnter: (event) => setState(() {
                isselcted = true;
              }),
          onExit: (event) => setState(() {
                isselcted = false;
              }),
          child: InkWell(
              hoverColor: Colors.transparent,
              borderRadius: BorderRadius.circular(19),
              splashColor: Colors.transparent,
              onTap: widget.onTap,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 250),
                margin: const EdgeInsets.all(5),
                padding: widget.padding ??
                    (widget.icon != null
                        ? const EdgeInsets.only(right: 12)
                        : null),
                height: 50,
                decoration: widget.decoration ??
                    BoxDecoration(
                        color: isselcted
                            ? (widget.SelectedbackgroundColorbefore ??
                                Colors.greenAccent)
                            : (widget.SelectedbackgroundColorafter ??
                                Colors.transparent),
                        borderRadius: BorderRadius.circular(15),
                        border: containborder!
                            ? Border.all(
                                color: isselcted
                                    ? Colors.transparent
                                    : (widget.colorBorder ?? KBorderColor),
                                width: 2)
                            : Border.all(
                                color: Colors.transparent,
                              )),
                alignment: widget.aliment ?? Alignment.centerRight,
                child: widget.icon != null
                    ? Row(
                        children: [
                          isleft!
                              ? Container()
                              : Icon(
                                  widget.icon,
                                  color: widget.iconColor,
                                ),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(
                            widget.title!,
                            style: widget.style,
                          ),
                          Expanded(child: Container()),
                          isleft! ? Icon(widget.icon) : Container(),
                        ],
                      )
                    : Text(
                        widget.title!,
                        style: widget.style,
                      ),
              ))),
    );
  }
}
