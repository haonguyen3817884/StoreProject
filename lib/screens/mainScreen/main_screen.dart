import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:loadany/loadany.dart';

import "package:store_project/widgets/text_simple.dart";

import 'package:store_project/screens/mainScreen/main_screen_controller.dart';
import 'package:store_project/widgets/category_item.dart';

import 'package:store_project/widgets/row_image.dart';

import 'package:store_project/config/index_methods.dart';

import "package:store_project/config/constant_values.dart";

import "dart:ui";

import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:store_project/widgets/slider_menu.dart';
import 'package:store_project/screens/mainScreen/main_image_controller.dart';

import "package:store_project/routes/route_name.dart";
import "package:store_project/models/customerImage.dart";
import "package:store_project/widgets/images_list.dart";

import "package:store_project/widgets/main_images_list.dart";

class MainScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainScreenController());
  }
}

class MainScreen extends GetView<MainScreenController> {
  const MainScreen({Key? key}) : super(key: key);

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
                    controller.toggleMenu();
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
                        return CategoryItem(itemIndex: itemIndex);
                      },
                      controller: controller.scrollController,
                      scrollDirection: Axis.horizontal);
                }),
                height: (MediaQuery.of(context).size.height -
                        MediaQueryData.fromWindow(window).padding.top -
                        kToolbarHeight) *
                    0.1),
            Expanded(child: Obx(() {
              return (controller.isCategoriesUpdated.value)
                  ? PageView.builder(
                      itemCount: controller.categories.length,
                      itemBuilder: (context, index) {
                        return MainImagesList(
                            tagName: controller.categories[index].getName());
                      },
                      controller: controller.pageController,
                      onPageChanged: (int index) {
                        controller.changeCategoryPosition(
                            MediaQuery.of(context).size.width, index);
                      })
                  : const Center(child: CircularProgressIndicator());
            }))
          ]),
          backgroundColor: Colors.black,
          floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.yellow,
              child: const Icon(Icons.add),
              onPressed: () {},
              foregroundColor: Colors.black)),
      key: controller.sideMenuKey,
      type: SideMenuType.slide,
      inverse: false,
      menu: const SliderMenu(),
      closeIcon: null,
      background: Colors.black,
    );
  }
}
