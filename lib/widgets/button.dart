import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button(
      {Key? key,
      required this.text,
      required this.buttonAction,
      this.textColor = const Color(0xFFFFFFFF),
      this.buttonColor = Colors.yellow,
      this.textFontSize = 17.4})
      : super(key: key);

  final String text;

  final Color textColor;

  final Color buttonColor;
  final double textFontSize;

  final Function buttonAction;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        child: Text(text,
            style: TextStyle(color: textColor, fontSize: textFontSize)),
        onPressed: () {
          buttonAction();
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(buttonColor),
            fixedSize: MaterialStateProperty.all(const Size(243.0, 59.0))));
  }
}
