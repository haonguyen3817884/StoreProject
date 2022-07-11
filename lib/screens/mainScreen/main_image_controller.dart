import 'package:get/get.dart';
import 'package:loadany/loadany.dart';
import "package:store_project/models/category.dart";

import "package:store_project/models/customerImage.dart";
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import "package:store_project/config/constant_values.dart";

import "package:store_project/base/services/customer_image_api.dart";

import "package:store_project/base/list_controller.dart";

import "package:store_project/routes/route_name.dart";

class MainImageController extends ListController<CustomerImage> {
  MainImageController(this.customerCategory);

  Category customerCategory;
  final _customerImageApi = CustomerImageApi();

  Future<void> updateData(
      int startIndex, int endIndex, String categoryName) async {
    List<CustomerImage> images =
        await _customerImageApi.getImages(startIndex, endIndex, categoryName);
    await setData(images);

    if (ConstantValues.maxItems + 1 != images.length) {
      updateLoadStatus(LoadStatus.completed);
    } else {
      updateIndex(endIndex + 1);

      updateLoadStatus(LoadStatus.normal);
    }

    updateDataLength(data.length);
  }

  Future<void> getRefresh() async {
    data = <CustomerImage>[].obs;

    updateDataLength(0);

    return await Future.delayed(const Duration(milliseconds: 400), () async {
      updateData(
          ConstantValues.startIndex,
          ConstantValues.startIndex + ConstantValues.maxItems,
          customerCategory.getName());
    });
  }

  Future<void> getLoadMore() async {
    updateLoadStatus(LoadStatus.loading);

    return await Future.delayed(const Duration(milliseconds: 5000), () async {
      updateData(index.value, index.value + ConstantValues.maxItems,
          customerCategory.getName());
    });
  }

  void onImagePressed(CustomerImage customerImage) {
    goToPage(RouteName.imageScreen, data: {
      "customerCategory": customerCategory.getName(),
      "customerImage": customerImage.toJson()
    });
  }

  @override
  void onReady() async {
    super.onReady();

    updateLoadStatus(LoadStatus.loading);

    data = <CustomerImage>[].obs;

    updateDataLength(0);

    await Future.delayed(const Duration(milliseconds: 5000), () async {
      updateData(
          ConstantValues.startIndex,
          ConstantValues.startIndex + ConstantValues.maxItems,
          customerCategory.getName());
    });
  }
}
