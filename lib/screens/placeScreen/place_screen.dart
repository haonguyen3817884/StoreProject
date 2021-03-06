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
import "package:store_project/screens/placeScreen/place_image_controller.dart";

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
                    textValue: "Wallcraft",
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
                    const TextSimple(textValue: "Disable ads"),
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
                        itemCount: controller.categories.length,
                        itemBuilder: (BuildContext context, int itemIndex) {
                          return Obx(() {
                            return PlaceItem(
                                category: controller.categories[itemIndex],
                                customerCategory:
                                    controller.customerCategory.value,
                                itemIndex: itemIndex);
                          });
                        },
                        controller: controller.scrollController,
                        scrollDirection: Axis.horizontal);
                  }),
                  height: (MediaQuery.of(context).size.height -
                          MediaQueryData.fromWindow(window).padding.top -
                          kToolbarHeight) *
                      0.1),
              Expanded(child: Obx(() {
                return PageView.builder(
                    itemCount: controller.categories.length,
                    itemBuilder: (context, index) {
                      PlaceImageController placeImageController = Get.put(
                          PlaceImageController(controller.categories[index]),
                          tag: controller.categories[index].getName());

                      return Obx(() {
                        return RefreshIndicator(
                          onRefresh: placeImageController.getRefresh,
                          child: LoadAny(
                            onLoadMore: placeImageController.getLoadMore,
                            status: placeImageController.loadStatus.value,
                            loadingMsg: ConstantValues.loading,
                            errorMsg: ConstantValues.loadingError,
                            finishMsg: ConstantValues.loadingFinish,
                            child: CustomScrollView(
                              slivers: <Widget>[
                                SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    (BuildContext context, int index) {
                                      return PlaceImage(
                                          places: placeImageController.customerImages.sublist(
                                              index *
                                                  ConstantValues
                                                      .maxItemsInOneLine,
                                              index *
                                                      ConstantValues
                                                          .maxItemsInOneLine +
                                                  ((isLengthValid(
                                                          index,
                                                          ConstantValues
                                                              .maxItemsInOneLine,
                                                          placeImageController
                                                              .dataLength
                                                              .value))
                                                      ? placeImageController
                                                              .dataLength
                                                              .value %
                                                          ConstantValues
                                                              .maxItemsInOneLine
                                                      : ConstantValues
                                                          .maxItemsInOneLine)));
                                    },
                                    childCount: (placeImageController
                                                .dataLength.value /
                                            ConstantValues.maxItemsInOneLine)
                                        .ceil(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                    },
                    controller: controller.pageController,
                    onPageChanged: (int index) {
                      controller.changeCategoryPosition(
                          MediaQuery.of(context).size.width, index);
                    });
              }))
            ]),
            backgroundColor: Colors.black,
            floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.yellow,
                child: Icon(Icons.add),
                onPressed: () {},
                foregroundColor: Colors.black)),
        key: controller.sideMenuKey,
        type: SideMenuType.slide,
        inverse: false,
        menu: const PlaceMenu(),
        closeIcon: null);
  }
}
