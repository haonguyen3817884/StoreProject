import 'package:flutter/material.dart';
import 'package:get/get.dart';

import "package:store_project/widgets/text_simple.dart";

import "package:store_project/widgets/button.dart";
import "package:store_project/widgets/text_many_styles.dart";
import "package:store_project/screens/ageScreen/age_screen_controller.dart";

class AgeTextPlace extends GetView<AgeScreenController> {
  const AgeTextPlace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
          child: const TextSimple(textValue: "place"),
          margin: const EdgeInsets.only(top: 15, bottom: 15)),
      Container(
          child: const TextSimple(
              textValue: "place",
              textFontWeight: FontWeight.w500,
              textColor: Color(0xFFFFFFFF),
              textFontSize: 27.4),
          margin: const EdgeInsets.only(top: 15, bottom: 15)),
      Container(
          child: const TextSimple(textValue: "place place"),
          margin: const EdgeInsets.only(top: 15, bottom: 0)),
      const SizedBox(
          child: TextSimple(textValue: "place place place place place")),
      const SizedBox(height: 74.0),
      Button(
          text: "place",
          buttonAction: () {
            controller.updateIsText();
          }),
      Container(
          child: const TextSimple(textValue: "place place place place"),
          margin: const EdgeInsets.only(top: 15, bottom: 0)),
      const TextManyStyles(textValues: [
        {
          "text": "place place",
          "style":
              TextStyle(color: Color.fromARGB(255, 98, 98, 98), fontSize: 17.4)
        },
        {
          "text": "place place place place place",
          "style": TextStyle(
              color: Color.fromARGB(255, 98, 98, 98),
              fontSize: 17.4,
              decoration: TextDecoration.underline)
        }
      ])
    ]);
  }
}
