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

class PlaceScreenController extends BaseController {
  var isButtonOn = false.obs;

  var customerCategory = "".obs;

  List<Category> categories = <Category>[].obs;
  List<CustomerImage> customerImages = <CustomerImage>[].obs;

  var dataLength = 0.obs;

  var index = 1.obs;

  var loadStatus = LoadStatus.normal.obs;

  var isCategoriesUpdated = false.obs;
  var scrollPlace = 0.0.obs;

  final GlobalKey<SideMenuState> sideMenuKey = GlobalKey<SideMenuState>();
  ScrollController scrollController = ScrollController();

  void updateIsButtonOn(bool value) {
    isButtonOn.value = value;
  }

  void updateCustomerCategory(String category) {
    customerCategory.value = category;
  }

  void updateIndex(int indexValue) {
    index.value = indexValue;
  }

  void updateLoadStatus(LoadStatus placeStatus) {
    loadStatus.value = placeStatus;
  }

  void updateDataLength(int length) {
    dataLength.value = length;
  }

  void updateIsCategoriesUpdated(bool value) {
    isCategoriesUpdated.value = value;
  }

  void updateScrollPlace(double scrollPlaceValue) {
    scrollPlace.value = scrollPlaceValue;
  }

  Future<void> setCategories() async {
    var endPoint =
        "http://www.stuckwallpapers.com/GetCategoriesv3json.aspx?version=2.0.1";

    var uri = Uri.parse(endPoint);

    var response = await http.get(uri);

    List<dynamic> decodedData = convert.jsonDecode(response.body);

    for (int i = 0; i < decodedData.length; ++i) {
      Category category = Category(decodedData[i]);

      categories.add(category);
    }
  }

  Future<List<CustomerImage>> getCustomerImages(
      int startIndex, int endIndex, String category) async {
    List<CustomerImage> images = <CustomerImage>[];

    var endPoint =
        'http://www.stuckwallpapers.com/getcontents.aspx?category=$category&end=$endIndex&height=185&s=990D9D9084293CF4AFCE0EDEF9533CBB&scale=3&sort=alltime&start=$startIndex&width=186';

    var uri = Uri.parse(endPoint);

    var response = await http.get(uri);

    List<dynamic> decodedData = convert.jsonDecode(response.body);

    for (int i = 0; i < decodedData.length; ++i) {
      CustomerImage customerImage = CustomerImage.fromJson(decodedData[i]);

      images.add(customerImage);
    }

    return images;
  }

  Future<void> updateCustomerImages(List<CustomerImage> images) async {
    for (int i = 0; i < images.length; ++i) {
      CustomerImage customerImage = images[i];

      customerImages.add(customerImage);
    }
  }

  Future<void> getRefresh() async {
    customerImages = <CustomerImage>[].obs;

    updateDataLength(0);

    return await Future.delayed(const Duration(milliseconds: 400), () async {
      List<CustomerImage> images = await getCustomerImages(
          ConstantValues.startIndex,
          ConstantValues.startIndex + ConstantValues.maxItems,
          customerCategory.value);
      await updateCustomerImages(images);

      if (ConstantValues.maxItems + 1 != images.length) {
        updateLoadStatus(LoadStatus.completed);
      } else {
        updateIndex(ConstantValues.startIndex + ConstantValues.maxItems + 1);

        updateLoadStatus(LoadStatus.normal);
      }

      updateDataLength(customerImages.length);
    });
  }

  Future<void> getLoadMore() async {
    updateLoadStatus(LoadStatus.loading);

    return await Future.delayed(const Duration(milliseconds: 5000), () async {
      List<CustomerImage> images = await getCustomerImages(index.value,
          index.value + ConstantValues.maxItems, customerCategory.value);

      await updateCustomerImages(images);

      if (ConstantValues.maxItems + 1 != images.length) {
        updateLoadStatus(LoadStatus.completed);
      } else {
        updateIndex(index.value + ConstantValues.maxItems + 1);

        updateLoadStatus(LoadStatus.normal);
      }

      updateDataLength(customerImages.length);
    });
  }

  void placeMenu() {
    final state = sideMenuKey.currentState!;

    if (state.isOpened) {
      state.closeSideMenu();
    } else {
      state.openSideMenu();
    }
  }

  void nextCategory(double totalWidth) {
    if ("" != customerCategory.value) {
      int categoryIndex = 0;
      categoryIndex = categories
          .indexWhere((element) => customerCategory.value == element.getName());
      if (categories.length - 1 != categoryIndex) {
        updateCustomerCategory(categories[categoryIndex + 1].getName());
        goToIndex(categoryIndex + 1, totalWidth);
      }
    }
  }

  void previousCategory(double totalWidth) {
    if ("" != customerCategory.value) {
      int categoryIndex = 0;

      categoryIndex = categories
          .indexWhere((element) => customerCategory.value == element.getName());

      if (0 != categoryIndex) {
        updateCustomerCategory(categories[categoryIndex - 1].getName());

        goToIndex(categoryIndex - 1, totalWidth);
      }
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

  List<Widget> getMenuItems() {
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
                  color: Colors.transparent.withOpacity(0.9), width: 0.3)));

      items.add(item);
    }

    return items;
  }

  @override
  void onReady() {
    super.onReady();

    setCategories();

    updateIsCategoriesUpdated(true);

    customerCategory.listen((value) async {
      updateLoadStatus(LoadStatus.loading);

      customerImages = <CustomerImage>[].obs;

      updateDataLength(0);

      await Future.delayed(const Duration(milliseconds: 5000), () async {
        List<CustomerImage> images = await getCustomerImages(
            ConstantValues.startIndex,
            ConstantValues.startIndex + ConstantValues.maxItems,
            value);
        await updateCustomerImages(images);

        if (ConstantValues.maxItems + 1 != images.length) {
          updateLoadStatus(LoadStatus.completed);
        } else {
          updateIndex(ConstantValues.startIndex + ConstantValues.maxItems + 1);

          updateLoadStatus(LoadStatus.normal);
        }

        updateDataLength(customerImages.length);
      });
    });

    scrollController.addListener(() {
      updateScrollPlace(scrollController.position.pixels);
    });
  }
}
