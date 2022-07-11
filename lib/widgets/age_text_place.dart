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
          child: const TextSimple(textValue: "Your device"),
          margin: const EdgeInsets.only(top: 15, bottom: 15)),
      Container(
          child: const TextSimple(
              textValue: "Iphone 12",
              textFontWeight: FontWeight.w500,
              textColor: Color(0xFFFFFFFF),
              textFontSize: 27.4),
          margin: const EdgeInsets.only(top: 15, bottom: 15)),
      Container(
          child: const TextSimple(textValue: "All wallpapers"),
          margin: const EdgeInsets.only(top: 15, bottom: 0)),
      const SizedBox(
          child: TextSimple(textValue: "are adapted to your screen")),
      SizedBox(height: MediaQuery.of(context).size.height * 0.1),
      Button(
          text: "CONTINUE",
          buttonAction: () {
            controller.updateIsText();
          }),
      Container(
          child: const TextSimple(textValue: "Running the application"),
          margin: const EdgeInsets.only(top: 15, bottom: 0)),
      const TextManyStyles(textValues: [
        {
          "text": "I agree to",
          "style":
              TextStyle(color: Color.fromARGB(255, 98, 98, 98), fontSize: 15.3)
        },
        {
          "text": "the terms of the user agreement",
          "style": TextStyle(
              color: Color.fromARGB(255, 98, 98, 98),
              fontSize: 15.3,
              decoration: TextDecoration.underline)
        }
      ])
    ]);
  }
}
