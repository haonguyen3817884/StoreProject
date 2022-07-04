import 'package:flutter/cupertino.dart';
import 'dart:convert' as convert;
import 'package:get/get.dart';
import 'package:loadany/loadany.dart';
import 'package:store_project/base/base_controller.dart';

import "package:store_project/config/constant_values.dart";

import 'package:shrink_sidemenu/shrink_sidemenu.dart';

import "package:store_project/models/category.dart";

import "package:store_project/models/customerImage.dart";
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import "package:store_project/widgets/text_simple.dart";

import "package:store_project/base/services/category_api.dart";

class PlaceScreenController extends BaseController {
  var isButtonOn = false.obs;

  var customerCategory = "".obs;

  List<Category> categories = <Category>[].obs;

  var isCategoriesUpdated = false.obs;

  final _categoryApi = CategoryApi();

  final GlobalKey<SideMenuState> sideMenuKey = GlobalKey<SideMenuState>();
  ScrollController scrollController = ScrollController();

  PageController pageController = PageController();

  void updateIsButtonOn(bool value) {
    isButtonOn.value = value;
  }

  void updateCustomerCategory(String category) {
    customerCategory.value = category;
  }

  void updateIsCategoriesUpdated(bool value) {
    isCategoriesUpdated.value = value;
  }

  Future<void> setCategories() async {
    List<Category> apiCategories = await _categoryApi.getCategories();

    for (int i = 0; i < apiCategories.length; ++i) {
      categories.add(apiCategories[i]);
    }

    updateIsCategoriesUpdated(true);
  }

  void placeMenu() {
    final state = sideMenuKey.currentState!;

    if (state.isOpened) {
      state.closeSideMenu();
    } else {
      state.openSideMenu();
    }
  }

  void changeCategoryPosition(double totalWidth, int indexValue) {
    if ("" != customerCategory.value) {
      updateCustomerCategory(categories[indexValue].getName());

      goToIndex(indexValue, totalWidth);
    }
  }

  void goToIndex(int indexValue, double totalWidth) {
    if (indexValue * 105.4 < scrollController.position.pixels) {
      scrollController.jumpTo(indexValue * 105.4);
    } else {
      if (((indexValue + 1) * 105.4) >
          (scrollController.position.pixels + totalWidth)) {
        scrollController.jumpTo(((indexValue + 1) * 105.4) - totalWidth);
      }
    }
  }

  void closeMenu() {
    final state = sideMenuKey.currentState!;

    state.closeSideMenu();
  }

  List<Widget> getMenuItems(double totalWidth) {
    List<Widget> items = <Widget>[];

    for (int i = 0; i < categories.length; ++i) {
      ListTile item = const ListTile();

      item = ListTile(
          title: TextSimple(
              textValue: categories[i].getName(),
              textColor: const Color(0xFFFFFFFF)),
          tileColor: Colors.transparent.withOpacity(0.2),
          shape: Border(
              bottom: BorderSide(
                  color: Colors.transparent.withOpacity(0.9), width: 0.3)),
          onTap: () {
            updateCustomerCategory(categories[i].getName());
            goToIndex(i, totalWidth);
            pageController.jumpToPage(i);

            closeMenu();
          });

      items.add(item);
    }

    return items;
  }

  @override
  void onReady() {
    super.onReady();

    setCategories();

    isCategoriesUpdated.listen((bool isUpdated) {
      if (isUpdated) {
        updateCustomerCategory(categories[0].getName());
      }
    });
  }
}
