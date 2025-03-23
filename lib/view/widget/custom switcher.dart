import 'package:flutter/material.dart';

import '../../theme.dart';

class CustomSwitcher extends StatefulWidget {
  final void Function(bool)? onChanged;
  final String title;
  final TextStyle? textStyle;
  final double? maxwidth;
  final bool? initialValue;
  const CustomSwitcher(
      {super.key,
      required this.title,
      this.textStyle,
      this.onChanged,
      this.maxwidth,
      this.initialValue});

  @override
  State<CustomSwitcher> createState() => _CustomSwitcherState();
}

class _CustomSwitcherState extends State<CustomSwitcher> {
  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );

  void Function(bool) get _onchange => widget.onChanged ?? (_) {};
  @override
  Widget build(BuildContext context) {
    bool value = widget.initialValue ?? false;
    return Container(
      constraints: BoxConstraints(maxWidth: widget.maxwidth ?? 250),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: widget.textStyle ?? HeadLine1,
          ),
          const SizedBox(
            width: 12,
          ),
          Switch(
              activeColor: Colors.greenAccent,
              // focusColor: Colors.redAccent,
              inactiveThumbColor: Colors.redAccent,
              inactiveTrackColor: Colors.redAccent.shade100,
              thumbIcon: thumbIcon,
              value: value,
              onChanged: (val) {
                _onchange.call(val);
                setState(() {
                  value = val;
                });
              })
        ],
      ),
    );
  }
}
