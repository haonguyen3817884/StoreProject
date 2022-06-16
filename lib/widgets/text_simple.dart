import 'package:flutter/material.dart';

class TextSimple extends StatelessWidget {
  const TextSimple(
      {Key? key,
      required this.textValue,
      this.textFontSize = 17.4,
      this.textFontWeight = FontWeight.normal,
      this.textFontFamily = "SF Pro Display",
      this.textColor = const Color.fromARGB(255, 98, 98, 98),
      this.textFontStyle = FontStyle.normal})
      : super(key: key);

  final String textValue;
  final double textFontSize;
  final FontWeight textFontWeight;
  final String textFontFamily;
  final Color textColor;
  final FontStyle textFontStyle;

  @override
  Widget build(BuildContext context) {
    return Text(textValue,
        style: TextStyle(
            fontSize: textFontSize,
            color: textColor,
            fontWeight: textFontWeight,
            fontStyle: textFontStyle,
            fontFamily: textFontFamily));
  }
}
