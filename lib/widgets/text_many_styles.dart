import 'package:flutter/material.dart';

class TextManyStyles extends StatelessWidget {
  const TextManyStyles({Key? key, required this.textValues}) : super(key: key);

  final List<dynamic> textValues;

  List<TextSpan> getTextValues() {
    List<TextSpan> places = <TextSpan>[];

    for (int i = 0; i < textValues.length; ++i) {
      dynamic textValue = textValues[i];

      TextSpan place = TextSpan(
          text: textValue["text"] + ((textValues.length - 1 == i) ? "" : " "),
          style: textValue["style"]);

      places.add(place);
    }

    return places;
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            style: const TextStyle(
                color: Colors.black,
                fontFamily: "SF Pro Display",
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.normal,
                fontSize: 15),
            children: getTextValues()));
  }
}
