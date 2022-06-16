import 'package:flutter/material.dart';
import 'package:get/get.dart';

import "package:store_project/screens/ageScreen/age_screen_controller.dart";
import "package:store_project/widgets/button.dart";
import "package:store_project/routes/route_name.dart";

import "package:store_project/widgets/text_simple.dart";
import 'package:wheel_chooser/wheel_chooser.dart';

class AgeInputPlace extends GetView<AgeScreenController> {
  const AgeInputPlace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
          child: const TextSimple(
              textValue: "place place place place place place place"),
          margin: const EdgeInsets.only(top: 7.4, bottom: 0)),
      Container(
          child: const TextSimple(textValue: "place place place place"),
          margin: const EdgeInsets.only(top: 0, bottom: 7.4)),
      Obx(() {
        return WheelChooser.integer(
            onValueChanged: (value) {
              controller.updateAgeValue(value);
            },
            maxValue: 100,
            minValue: 0,
            step: 1,
            initValue: controller.ageValue.value,
            horizontal: true,
            listWidth: 174.0,
            selectTextStyle:
                const TextStyle(color: Color.fromARGB(255, 98, 98, 98)),
            unSelectTextStyle:
                const TextStyle(color: Color.fromARGB(255, 98, 98, 98)));
      }),
      const SizedBox(height: 174.0),
      Button(
          text: "place",
          buttonAction: () {
            controller.placeIn(RouteName.confirmPlace, data: {
              "title": "place place place place place",
              "texts": [
                "place place place place",
                "place place place place place",
                "place place place place"
              ],
              "action": () {
                final ageController = Get.put(AgeScreenController());

                ageController.saveAge();
                ageController.placeIn(RouteName.placePlace);
              }
            });
          })
    ]);
  }
}
