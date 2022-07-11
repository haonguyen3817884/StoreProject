import 'package:get/get.dart';
import 'package:loadany/loadany.dart';
import "package:store_project/base/list_controller.dart";

import "package:store_project/models/customerImage.dart";
import "package:store_project/base/services/customer_image_api.dart";
import "package:store_project/config/constant_values.dart";

import "package:store_project/routes/route_name.dart";

class ImageScreenController extends ListController<CustomerImage> {
  dynamic arguments = Get.arguments;

  late CustomerImage customerImage;

  var imageInput = "".obs;

  var customerCategory = "".obs;

  final _customerImageApi = CustomerImageApi();

  void updateImageInput(String placeImage) {
    imageInput.value = placeImage;
  }

  void updateCustomerCategory(String category) {
    customerCategory.value = category;
  }

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
          customerCategory.value);
    });
  }

  Future<void> getLoadMore() async {
    updateLoadStatus(LoadStatus.loading);

    return await Future.delayed(const Duration(milliseconds: 5000), () async {
      updateData(index.value, index.value + ConstantValues.maxItems,
          customerCategory.value);
    });
  }

  void onImagePressed(CustomerImage customerImage) {
    updateImageInput(customerImage.getCustomerImageUrl());
    customerImage = customerImage;
  }

  @override
  void onReady() {
    super.onReady();

    customerImage = CustomerImage.fromJson(arguments["customerImage"]);

    customerCategory.listen((value) async {
      updateLoadStatus(LoadStatus.loading);

      data = <CustomerImage>[].obs;

      updateDataLength(0);

      return await Future.delayed(const Duration(milliseconds: 5000), () async {
        updateData(
            ConstantValues.startIndex,
            ConstantValues.startIndex + ConstantValues.maxItems,
            customerCategory.value);
      });
    });

    updateImageInput(customerImage.getCustomerImageUrl());
    updateCustomerCategory(arguments["customerCategory"]);
  }
}
