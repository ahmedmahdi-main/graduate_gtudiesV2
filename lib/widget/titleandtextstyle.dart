import 'package:flutter/material.dart';

class TitleAndTextStyle extends StatelessWidget {
  final double width;
  final TextEditingController controller;
  final String title;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;

  const TitleAndTextStyle({
    Key? key,
    required this.width,
    required this.controller,
    required this.title,
    this.validator,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: title,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Colors.grey[100],
        ),
        validator: validator,
        onChanged: onChanged,
      ),
    );
  }
}
