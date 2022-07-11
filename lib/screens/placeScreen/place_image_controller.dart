import 'package:get/get.dart';
import 'package:loadany/loadany.dart';
import "package:store_project/models/category.dart";

import "package:store_project/models/customerImage.dart";
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import "package:store_project/config/constant_values.dart";

class PlaceImageController extends GetxController {
  PlaceImageController(this.customerCategory);

  Category customerCategory;

  List<CustomerImage> customerImages = <CustomerImage>[].obs;

  var index = 0.obs;

  var dataLength = 0.obs;
  var loadStatus = LoadStatus.normal.obs;

  void updateIndex(int indexValue) {
    index.value = indexValue;
  }

  void updateDataLength(int length) {
    dataLength.value = length;
  }

  void updateLoadStatus(LoadStatus placeStatus) {
    loadStatus.value = placeStatus;
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
          customerCategory.getName());
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
          index.value + ConstantValues.maxItems, customerCategory.getName());

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

  @override
  void onReady() async {
    super.onReady();

    updateLoadStatus(LoadStatus.loading);

    customerImages = <CustomerImage>[].obs;

    updateDataLength(0);

    await Future.delayed(const Duration(milliseconds: 5000), () async {
      List<CustomerImage> images = await getCustomerImages(
          ConstantValues.startIndex,
          ConstantValues.startIndex + ConstantValues.maxItems,
          customerCategory.getName());
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
}
