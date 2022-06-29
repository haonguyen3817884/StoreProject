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
          text: "CONTINUE",
          buttonAction: () {
            controller.placeIn(RouteName.confirmPlace, data: {
              "title":
                  "Allow access to your identifier for tracking and get rid of useless ads",
              "texts": [
                "Many people doesn't love ads. But intrusive and useless ads irritates much stronger",
                "Not a long ago Apple had changed their policies to boost up user control over information about their interests privacy",
                "This information is analyzed and applied when forming advertisments. As you know this process is called tracking. Tracking allows ad SDK to select ads with goods and services that might be interesting to you.",
                "Privacy is matters. Regardless of your choice, we still respect you"
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
