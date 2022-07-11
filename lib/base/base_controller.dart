import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

abstract class BaseController extends GetxController {
  final storage = GetStorage();

  void goToPage(String pageName, {dynamic data}) {
    Get.offNamed(pageName, arguments: data);
  }
}
