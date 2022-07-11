import 'package:get/get.dart';
import 'package:loadany/loadany.dart';
import "package:store_project/base/base_controller.dart";

abstract class ListController<T> extends BaseController {
  List<T> data = <T>[];

  var index = 0.obs;
  var loadStatus = LoadStatus.normal.obs;

  var dataLength = 0.obs;

  void updateIndex(int indexValue) {
    index.value = indexValue;
  }

  void updateLoadStatus(LoadStatus status) {
    loadStatus.value = status;
  }

  void updateDataLength(int length) {
    dataLength.value = length;
  }

  Future<void> setData(List<T> dataList) async {
    for (int i = 0; i < dataList.length; ++i) {
      T itemInData = dataList[i];

      data.add(itemInData);
    }
  }
}
