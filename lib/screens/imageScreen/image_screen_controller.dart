import 'package:get/get.dart';
import 'package:loadany/loadany.dart';
import "package:store_project/base/base_controller.dart";

import "package:store_project/models/customerImage.dart";
import "package:store_project/base/services/customer_image_api.dart";
import "package:store_project/config/constant_values.dart";

class ImageScreenController extends BaseController {
  dynamic data = Get.arguments;

  late CustomerImage customerImage;

  var imageInput = "".obs;

  var customerCategory = "".obs;

  List<CustomerImage> customerImages = <CustomerImage>[].obs;

  var index = 0.obs;

  var dataLength = 0.obs;
  var loadStatus = LoadStatus.normal.obs;

  final _customerImageApi = CustomerImageApi();

  void updateIndex(int indexValue) {
    index.value = indexValue;
  }

  void updateDataLength(int length) {
    dataLength.value = length;
  }

  void updateLoadStatus(LoadStatus placeStatus) {
    loadStatus.value = placeStatus;
  }

  void updateImageInput(String placeImage) {
    imageInput.value = placeImage;
  }

  void updateCustomerCategory(String category) {
    customerCategory.value = category;
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
      List<CustomerImage> images = await _customerImageApi.getImages(
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
      List<CustomerImage> images = await _customerImageApi.getImages(
          index.value,
          index.value + ConstantValues.maxItems,
          customerCategory.value);

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
  void onReady() {
    super.onReady();

    customerImage = CustomerImage.fromJson(data["customerImage"]);

    customerCategory.listen((value) async {
      updateLoadStatus(LoadStatus.loading);

      customerImages = <CustomerImage>[].obs;

      updateDataLength(0);

      return await Future.delayed(const Duration(milliseconds: 5000), () async {
        List<CustomerImage> images = await _customerImageApi.getImages(
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
    });

    updateImageInput(customerImage.getCustomerImageUrl());
    updateCustomerCategory(data["customerCategory"]);
  }
}
