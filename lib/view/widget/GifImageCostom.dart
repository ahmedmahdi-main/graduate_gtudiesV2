import 'package:flutter/material.dart';

class GifImageCostom extends StatefulWidget {
  const GifImageCostom({super.key, required this.Gif, this.width});
  final String Gif;
  final double? width;
  @override
  State<GifImageCostom> createState() => _GifImageCostomState();
}

class _GifImageCostomState extends State<GifImageCostom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        widget.Gif,
        fit: BoxFit.fitWidth,
        colorBlendMode: BlendMode.color,
        width: widget.width,
        color: Colors.transparent,
      ),
    );
  }
}
