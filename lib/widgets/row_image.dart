import 'package:flutter/material.dart';
import 'package:get/get.dart';

import "package:store_project/config/constant_values.dart";

import "package:store_project/models/customerImage.dart";

import "dart:ui";

import 'package:store_project/screens/mainScreen/main_screen_controller.dart';

import "package:store_project/routes/route_name.dart";

class RowImage extends StatelessWidget {
  const RowImage({Key? key, required this.images, required this.onImagePressed})
      : super(key: key);

  final List<CustomerImage> images;

  final Function onImagePressed;

  List<Widget> getImages(BuildContext context) {
    List<Widget> imageWidgetArr = <Widget>[];

    for (int i = 0; i < images.length; ++i) {
      Widget imageWidget = GestureDetector(
          child: Container(
              child: Image.network(images[i].getCustomerImageUrl(),
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }, fit: BoxFit.fill),
              padding: const EdgeInsets.all(7.4),
              width: MediaQuery.of(context).size.width /
                  ConstantValues.maxItemsInOneLine,
              height: ((MediaQuery.of(context).size.height -
                          MediaQueryData.fromWindow(window).padding.top -
                          kToolbarHeight) *
                      0.8) /
                  ConstantValues.maxItemsInOneLine),
          onTap: () {
            onImagePressed(images[i]);
          });

      imageWidgetArr.add(imageWidget);
    }

    return imageWidgetArr;
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: getImages(context));
  }
}
