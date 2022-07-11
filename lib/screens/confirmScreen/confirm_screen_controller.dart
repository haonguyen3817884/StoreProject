import 'package:get/get.dart';
import 'package:store_project/base/base_controller.dart';

import 'package:flutter/material.dart';
import "package:store_project/widgets/text_simple.dart";

class ConfirmScreenController extends BaseController {
  dynamic arguments = Get.arguments;

  Widget getTitle() {
    return TextSimple(
        textValue: arguments["title"],
        textColor: const Color(0xFFFFFFFF),
        textFontWeight: FontWeight.bold,
        textFontSize: 17.4);
  }

  List<Widget> getTexts() {
    List<Widget> texts = <Widget>[];

    for (int i = 0; i < arguments["texts"].length; ++i) {
      Widget text = Container(
          child: TextSimple(textValue: arguments["texts"][i]),
          margin: const EdgeInsets.only(top: 7.4, bottom: 7.4));

      texts.add(text);
    }

    return texts;
  }

  void getAction() {
    Function action = arguments["action"];

    action();
  }
}
