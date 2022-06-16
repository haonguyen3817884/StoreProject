import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:loadany/loadany.dart';
import 'package:store_project/base/base_controller.dart';

import "package:store_project/sample_data.dart";
import 'package:store_project/config/index_loading.dart';
import "package:store_project/config/constant_values.dart";

import 'package:shrink_sidemenu/shrink_sidemenu.dart';

class PlaceScreenController extends BaseController {
  var isButtonOn = false.obs;

  var customerTitle = "".obs;

  List<dynamic> placeData = [].obs;
  List<String> places = <String>[].obs;

  var dataLength = 0.obs;

  var index = 1.obs;

  var loadStatus = LoadStatus.normal.obs;

  final GlobalKey<SideMenuState> sideMenuKey = GlobalKey<SideMenuState>();

  void updateIsButtonOn(bool value) {
    isButtonOn.value = value;
  }

  void updateCustomerTitle(String title) {
    customerTitle.value = title;
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

  void setPlaceData(List<dynamic> data) {
    for (int i = 0; i < data.length; ++i) {
      dynamic itemInData = data[i];
      placeData.add(itemInData);
    }
  }

  Future<void> getRefresh() async {
    return await Future.delayed(const Duration(milliseconds: 400), () {
      updateIndex(1);

      updateLoadStatus(LoadStatus.normal);
    });
  }

  Future<void> getLoadMore() async {
    updateLoadStatus(LoadStatus.loading);

    return await Future.delayed(const Duration(milliseconds: 5000), () {
      if (isIndexIn(
          index.value + 1, ConstantValues.maxItems, dataLength.value)) {
        updateLoadStatus(LoadStatus.normal);

        updateIndex(index.value + 1);
      } else {
        updateLoadStatus(LoadStatus.completed);
      }
    });
  }

  List<String> getDataByTitle(String title) {
    List<String> placesInPlaceData = <String>[];

    for (int i = 0; i < placeData.length; ++i) {
      if (title == placeData[i]["title"]) {
        placesInPlaceData = List.from(placeData[i]["places"]);
      }
    }

    return placesInPlaceData;
  }

  void placeMenu() {
    final state = sideMenuKey.currentState!;

    if (state.isOpened) {
      state.closeSideMenu();
    } else {
      state.openSideMenu();
    }
  }

  @override
  void onReady() {
    super.onReady();
    setPlaceData(getData()["data"]);
    customerTitle.listen((value) {
      List<String> placesInPlaceData = <String>[];
      placesInPlaceData = getDataByTitle(value);
      places = placesInPlaceData.obs;

      updateIndex(1);
      updateLoadStatus(LoadStatus.normal);
      updateDataLength(placesInPlaceData.length);
    });
  }
}
