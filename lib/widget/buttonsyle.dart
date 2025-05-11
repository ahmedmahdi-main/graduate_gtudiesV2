import 'package:flutter/material.dart';

class ButtonStyleS extends StatelessWidget {
  final String title;
  final IconData? icon;
  final Color? iconColor;
  final Color? colorBorder;
  final bool containborder;
  final bool isleft;
  final Function()? onTap;
  final Color? SelectedbackgroundColorbefore;
  final AlignmentGeometry? aliment;

  const ButtonStyleS({
    Key? key,
    required this.title,
    this.icon,
    this.iconColor,
    this.colorBorder,
    this.containborder = false,
    this.isleft = false,
    this.onTap,
    this.SelectedbackgroundColorbefore,
    this.aliment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        decoration: BoxDecoration(
          color: SelectedbackgroundColorbefore ?? Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(8),
          border: containborder
              ? Border.all(color: colorBorder ?? Colors.black, width: 1)
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null && isleft)
              Icon(icon, color: iconColor),
            if (icon != null && isleft) const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: containborder
                    ? colorBorder ?? Colors.black
                    : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (icon != null && !isleft) const SizedBox(width: 8),
            if (icon != null && !isleft)
              Icon(icon, color: iconColor),
          ],
        ),
      ),
    );
  }
}
