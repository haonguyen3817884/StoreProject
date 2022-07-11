import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

abstract class BaseController extends GetxController {
  final storage = GetStorage();

  void placeIn(String placeName, {dynamic data}) {
    Get.offNamed(placeName, arguments: data);
  }
}
