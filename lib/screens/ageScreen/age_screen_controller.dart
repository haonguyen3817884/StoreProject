import 'package:get/get.dart';
import 'package:store_project/base/base_controller.dart';
import "package:store_project/routes/route_name.dart";

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

  void onAgeSubmit() {
    goToPage(RouteName.confirmScreen, data: {
      "title":
          "Allow access to your identifier for tracking and get rid of useless ads",
      "texts": [
        "Many people doesn't love ads. But intrusive and useless ads irritates much stronger",
        "Not a long ago Apple had changed their policies to boost up user control over information about their interests privacy",
        "This information is analyzed and applied when forming advertisments. As you know this process is called tracking. Tracking allows ad SDK to select ads with goods and services that might be interesting to you.",
        "Privacy is matters. Regardless of your choice, we still respect you"
      ],
      "action": () {
        saveAge();
        goToPage(RouteName.mainScreen);
      }
    });
  }
}
