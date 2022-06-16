import 'package:get/get.dart';
import 'package:store_project/base/base_controller.dart';

class AgeScreenController extends BaseController {
  var isText = true.obs;

  var ageValue = 0.obs;

  void updateIsText() {
    if (isText.value) {
      isText.value = false;
    } else {
      isText.value = true;
    }
  }

  void updateAgeValue(int placeValue) {
    ageValue.value = placeValue;
  }

  void saveAge() {
    storage.write("customerAge", ageValue.value.toString());
  }
}
