import 'package:flutter/material.dart';
import 'package:get/get.dart';

import "package:store_project/screens/placeScreen/place_screen_controller.dart";
import "package:store_project/models/category.dart";
import "package:store_project/widgets/text_many_styles.dart";

class PlaceItem extends GetView<PlaceScreenController> {
  const PlaceItem(
      {Key? key,
      required this.itemIndex,
      required this.category,
      required this.customerCategory})
      : super(key: key);

  final int itemIndex;

  final Category category;

  final String customerCategory;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
            child: Center(
                child: TextManyStyles(
                    textValues: category.getTexts(TextStyle(
                        fontSize: 17.4,
                        color: Color.fromARGB(255, 98, 98, 98),
                        fontStyle: FontStyle.normal,
                        fontWeight: (customerCategory == category.getName())
                            ? FontWeight.w500
                            : FontWeight.normal,
                        fontFamily: "SF Pro Display")))),
            padding: const EdgeInsets.only(bottom: 17.4),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        style: (customerCategory == category.getName())
                            ? BorderStyle.solid
                            : BorderStyle.none,
                        color: const Color(0xFFFFFFFF),
                        width: 1.5))),
            width: 105.4),
        onTap: () {
          controller.updateCustomerCategory(category.getName());
          controller.goToIndex(itemIndex, MediaQuery.of(context).size.width);
        });
  }
}
