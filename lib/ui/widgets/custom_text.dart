import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final Alignment alignment;
  final EdgeInsets margin;
  final FontWeight fontWeight;

  const CustomText(
      {Key? key,
      this.text = '',
      this.color = Colors.black,
      this.fontSize = 16,
      this.alignment = Alignment.topLeft,
      this.margin = EdgeInsets.zero,
      this.fontWeight = FontWeight.normal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      margin: margin,
      child: Text(
        text,
        style:
            TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight),
      ),
    );
  }
}
