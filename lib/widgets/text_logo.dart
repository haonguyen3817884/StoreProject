import 'package:flutter/material.dart';

class TextLogo extends StatelessWidget {
  const TextLogo({Key? key, this.textFontSize = 74.0}) : super(key: key);

  final double textFontSize;

  @override
  Widget build(BuildContext context) {
    return Text("W",
        style: TextStyle(
            fontSize: textFontSize,
            color: Colors.yellow,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal));
  }
}
