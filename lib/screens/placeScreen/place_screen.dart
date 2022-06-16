import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:loadany/loadany.dart';

import "package:store_project/widgets/text_simple.dart";

import "package:store_project/screens/placeScreen/place_screen_controller.dart";
import "package:store_project/widgets/place_item.dart";

import "package:store_project/widgets/place_image.dart";

import 'package:store_project/config/index_loading.dart';

import "package:store_project/config/constant_values.dart";

import "dart:ui";

import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import "package:store_project/widgets/place_menu.dart";

class PlaceScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PlaceScreenController());
  }
}

class PlaceScreen extends GetView<PlaceScreenController> {
  const PlaceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SideMenu(
        child: Scaffold(
            appBar: AppBar(
                elevation: 0.0,
                systemOverlayStyle: const SystemUiOverlayStyle(
                    statusBarColor: Colors.transparent),
                backgroundColor: Colors.transparent,
                title: const TextSimple(
                    textValue: "place",
                    textColor: Color(0xFFFFFFFF),
                    textFontWeight: FontWeight.w500,
                    textFontSize: 17.4),
                leading: IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      controller.placeMenu();
                    }),
                actions: <Widget>[
                  IconButton(icon: const Icon(Icons.search), onPressed: () {})
                ],
                centerTitle: true),
            body: Column(children: <Widget>[
              Container(
                  child: Row(children: <Widget>[
                    const TextSimple(textValue: "place place place"),
                    const Expanded(child: SizedBox()),
                    Obx(() {
                      return Switch(
                          value: controller.isButtonOn.value,
                          onChanged: (value) {
                            controller.updateIsButtonOn(value);
                          },
                          inactiveTrackColor:
                              const Color.fromARGB(255, 98, 98, 98),
                          activeTrackColor: Colors.yellow,
                          activeColor: const Color(0xFFFFFFFF));
                    })
                  ]),
                  padding: const EdgeInsets.only(left: 17.4, right: 17.4),
                  height: (MediaQuery.of(context).size.height -
                          MediaQueryData.fromWindow(window).padding.top -
                          kToolbarHeight) *
                      0.1),
              SizedBox(
                  child: Obx(() {
                    return ListView.builder(
                        itemCount: controller.placeData.length,
                        itemBuilder: (BuildContext context, int itemIndex) {
                          return Obx(() {
                            return PlaceItem(
                                textValue: controller.placeData[itemIndex]
                                    ["title"],
                                isIn: (controller.placeData[itemIndex]
                                        ["title"] ==
                                    controller.customerTitle.value));
                          });
                        },
                        scrollDirection: Axis.horizontal);
                  }),
                  height: (MediaQuery.of(context).size.height -
                          MediaQueryData.fromWindow(window).padding.top -
                          kToolbarHeight) *
                      0.1),
              Expanded(child: Obx(() {
                return RefreshIndicator(
                  onRefresh: controller.getRefresh,
                  child: LoadAny(
                    onLoadMore: controller.getLoadMore,
                    status: controller.loadStatus.value,
                    loadingMsg: 'loading',
                    errorMsg: 'error',
                    finishMsg: 'place',
                    child: CustomScrollView(
                      slivers: <Widget>[
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return PlaceImage(
                                  places: controller.places.sublist(
                                      index * ConstantValues.maxItemsInOneLine,
                                      index * ConstantValues.maxItemsInOneLine +
                                          ((isLengthValid(
                                                  index,
                                                  ConstantValues
                                                      .maxItemsInOneLine,
                                                  controller.dataLength.value))
                                              ? controller.dataLength.value %
                                                  ConstantValues
                                                      .maxItemsInOneLine
                                              : ConstantValues
                                                  .maxItemsInOneLine)));
                            },
                            childCount: (getLengthByIndex(
                                        controller.index.value,
                                        ConstantValues.maxItems,
                                        controller.dataLength.value) /
                                    ConstantValues.maxItemsInOneLine)
                                .ceil(),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }))
            ]),
            backgroundColor: Colors.black),
        key: controller.sideMenuKey,
        type: SideMenuType.slide,
        inverse: false,
        menu: const PlaceMenu(),
        closeIcon: null);
  }
}
