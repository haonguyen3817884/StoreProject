import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:store_project/screens/mainScreen/main_screen_controller.dart';
import "package:store_project/models/category.dart";
import "package:store_project/widgets/text_simple.dart";

class CategoryItem extends GetView<MainScreenController> {
  const CategoryItem({Key? key, required this.itemIndex}) : super(key: key);

  final int itemIndex;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(child: Obx(() {
      return Container(
          child: Center(
              child: TextSimple(
                  textValue: controller.categories[itemIndex].getName(),
                  textFontWeight: (controller.customerCategory.value ==
                          controller.categories[itemIndex].getName())
                      ? FontWeight.w500
                      : FontWeight.normal)),
          padding: const EdgeInsets.only(bottom: 17.4),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      style: (controller.customerCategory.value ==
                              controller.categories[itemIndex].getName())
                          ? BorderStyle.solid
                          : BorderStyle.none,
                      color: const Color(0xFFFFFFFF),
                      width: 1.5))),
          width: 105.4);
    }), onTap: () {
      controller
          .updateCustomerCategory(controller.categories[itemIndex].getName());
      controller.goToCategoryPosition(
          itemIndex, MediaQuery.of(context).size.width);

      controller.pageController.jumpToPage(itemIndex);
    });
  }
}
