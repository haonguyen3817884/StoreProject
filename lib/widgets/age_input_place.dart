import 'package:flutter/material.dart';
import 'package:get/get.dart';

import "package:store_project/screens/ageScreen/age_screen_controller.dart";
import "package:store_project/widgets/button.dart";
import "package:store_project/routes/route_name.dart";

import "package:store_project/widgets/text_simple.dart";
import 'package:wheel_chooser/wheel_chooser.dart';

import "package:store_project/config/constant_values.dart";

class AgeInputPlace extends GetView<AgeScreenController> {
  const AgeInputPlace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
          child: const TextSimple(
              textValue: "To make the app content match your age, specify how"),
          margin: const EdgeInsets.only(top: 7.4, bottom: 0)),
      Container(
          child: const TextSimple(textValue: "old are you"),
          margin: const EdgeInsets.only(top: 0, bottom: 7.4)),
      Obx(() {
        return WheelChooser.integer(
            onValueChanged: (value) {
              controller.updateAgeValue(value);
            },
            maxValue: ConstantValues.maxAge,
            minValue: ConstantValues.minAge,
            step: ConstantValues.stepAge,
            initValue: controller.ageValue.value,
            horizontal: true,
            listWidth: MediaQuery.of(context).size.width * 0.4,
            selectTextStyle:
                const TextStyle(color: Color.fromARGB(255, 98, 98, 98)),
            unSelectTextStyle:
                const TextStyle(color: Color.fromARGB(255, 98, 98, 98)));
      }),
      const Expanded(child: SizedBox()),
      Button(
          text: "CONTINUE",
          buttonAction: () {
            controller.onAgeSubmit();
          })
    ]);
  }
}
