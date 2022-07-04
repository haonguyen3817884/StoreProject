import 'package:flutter/material.dart';
import 'package:get/get.dart';

import "package:store_project/config/constant_values.dart";

import "package:store_project/models/customerImage.dart";

import "dart:ui";

import "package:store_project/screens/placeScreen/place_screen_controller.dart";

import "package:store_project/routes/route_name.dart";

class PlaceImage extends GetView<PlaceScreenController> {
  const PlaceImage({Key? key, required this.places}) : super(key: key);

  final List<CustomerImage> places;

  List<Widget> getPlaces(BuildContext context) {
    List<Widget> placeArr = <Widget>[];

    for (int i = 0; i < places.length; ++i) {
      Widget place = GestureDetector(
          child: Container(
              child: Image.network(places[i].getCustomerImageUrl(),
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
            final PlaceScreenController placeScreenController =
                Get.put(PlaceScreenController());

            placeScreenController.placeIn(RouteName.imagePlace, data: {
              "customerCategory": controller.customerCategory.value,
              "customerImage": places[i].toJson()
            });
          });

      placeArr.add(place);
    }

    return placeArr;
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: getPlaces(context));
  }
}
