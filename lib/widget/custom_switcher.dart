import 'package:flutter/material.dart';

class CustomSwitcher extends StatelessWidget {
  final bool initialValue;
  final Function(bool) onChanged;
  final String title;

  const CustomSwitcher({
    Key? key,
    required this.initialValue,
    required this.onChanged,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: initialValue,
      onChanged: onChanged,
      activeColor: Theme.of(context).primaryColor,
      activeTrackColor: Theme.of(context).primaryColor.withOpacity(0.5),
    );
  }
}
