import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "package:store_project/widgets/text_logo.dart";
import "package:store_project/widgets/text_simple.dart";

import "package:store_project/screens/placeScreen/place_screen_controller.dart";
import "dart:ui";

class PlaceMenu extends GetView<PlaceScreenController> {
  const PlaceMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: ListView(children: <Widget>[
          const ListTile(
              title: TextSimple(
                  textValue: "Wallcraft",
                  textFontSize: 24.3,
                  textFontWeight: FontWeight.w500,
                  textColor: Color(0xFFFFFFFF)),
              leading: TextLogo(textFontSize: 43.0)),
          Material(
              child: Container(
                  child: Obx(() {
                    return (controller.isCategoriesUpdated.value)
                        ? Column(children: controller.getMenuItems())
                        : Column();
                  }),
                  margin: const EdgeInsets.only(top: 7.4, bottom: 7.4)),
              color: Colors.transparent)
        ], padding: EdgeInsets.zero, shrinkWrap: true),
        height: MediaQuery.of(context).size.height -
            MediaQueryData.fromWindow(window).padding.top -
            kToolbarHeight);
  }
}
