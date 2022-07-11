import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "package:store_project/screens/mainScreen/main_image_controller.dart";

import "package:store_project/widgets/images_list.dart";

class MainImagesList extends GetView<MainImageController> {
  const MainImagesList({Key? key, required this.tagName}) : super(key: key);

  @override
  String? get tag => tagName;

  final String tagName;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ImagesList(
          getRefresh: controller.getRefresh,
          getLoadMore: controller.getLoadMore,
          loadStatus: controller.loadStatus.value,
          customerImages: controller.data,
          onImagePressed: controller.onImagePressed,
          dataLength: controller.dataLength.value);
    });
  }
}
